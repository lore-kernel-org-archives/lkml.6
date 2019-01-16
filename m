Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC440C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BE9206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404382AbfAPNo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:44:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404370AbfAPNoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:44:55 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5FF1206C2;
        Wed, 16 Jan 2019 13:44:53 +0000 (UTC)
Date:   Wed, 16 Jan 2019 08:44:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com, akpm@linux-foundation.org,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] uprobes: convert uprobe.ref to refcount_t
Message-ID: <20190116084452.773833d4@gandalf.local.home>
In-Reply-To: <1547637627-29526-1-git-send-email-elena.reshetova@intel.com>
References: <1547637627-29526-1-git-send-email-elena.reshetova@intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Cc'ing Masami as he maintains uprobes (we need to add uprobes to
  the MAINTAINERS file ]

-- Steve

On Wed, 16 Jan 2019 13:20:27 +0200
Elena Reshetova <elena.reshetova@intel.com> wrote:

> atomic_t variables are currently used to implement reference
> counters with the following properties:
>  - counter is initialized to 1 using atomic_set()
>  - a resource is freed upon counter reaching zero
>  - once counter reaches zero, its further
>    increments aren't allowed
>  - counter schema uses basic atomic operations
>    (set, inc, inc_not_zero, dec_and_test, etc.)
> 
> Such atomic variables should be converted to a newly provided
> refcount_t type and API that prevents accidental counter overflows
> and underflows. This is important since overflows and underflows
> can lead to use-after-free situation and be exploitable.
> 
> The variable uprobe.ref is used as pure reference counter.
> Convert it to refcount_t and fix up the operations.
> 
> **Important note for maintainers:
> 
> Some functions from refcount_t API defined in lib/refcount.c
> have different memory ordering guarantees than their atomic
> counterparts.
> The full comparison can be seen in
> https://lkml.org/lkml/2017/11/15/57 and it is hopefully soon
> in state to be merged to the documentation tree.
> Normally the differences should not matter since refcount_t provides
> enough guarantees to satisfy the refcounting use cases, but in
> some rare cases it might matter.
> Please double check that you don't have some undocumented
> memory guarantees for this variable usage.
> 
> For the uprobe.ref it might make a difference
> in following places:
>  - put_uprobe(): decrement in refcount_dec_and_test() only
>    provides RELEASE ordering and control dependency on success
>    vs. fully ordered atomic counterpart
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: David Windsor <dwindsor@gmail.com>
> Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> ---
>  kernel/events/uprobes.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index ad415f7..750aece 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -66,7 +66,7 @@ static struct percpu_rw_semaphore dup_mmap_sem;
>  
>  struct uprobe {
>  	struct rb_node		rb_node;	/* node in the rb tree */
> -	atomic_t		ref;
> +	refcount_t		ref;
>  	struct rw_semaphore	register_rwsem;
>  	struct rw_semaphore	consumer_rwsem;
>  	struct list_head	pending_list;
> @@ -561,13 +561,13 @@ set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long v
>  
>  static struct uprobe *get_uprobe(struct uprobe *uprobe)
>  {
> -	atomic_inc(&uprobe->ref);
> +	refcount_inc(&uprobe->ref);
>  	return uprobe;
>  }
>  
>  static void put_uprobe(struct uprobe *uprobe)
>  {
> -	if (atomic_dec_and_test(&uprobe->ref)) {
> +	if (refcount_dec_and_test(&uprobe->ref)) {
>  		/*
>  		 * If application munmap(exec_vma) before uprobe_unregister()
>  		 * gets called, we don't get a chance to remove uprobe from
> @@ -658,7 +658,7 @@ static struct uprobe *__insert_uprobe(struct uprobe *uprobe)
>  	rb_link_node(&uprobe->rb_node, parent, p);
>  	rb_insert_color(&uprobe->rb_node, &uprobes_tree);
>  	/* get access + creation ref */
> -	atomic_set(&uprobe->ref, 2);
> +	refcount_set(&uprobe->ref, 2);
>  
>  	return u;
>  }

