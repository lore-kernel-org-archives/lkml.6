Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4146C282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7336F20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548056281;
	bh=XoWXVEff0N0Es0WH64+yM8SQAwzjbwWOP5nYX709aF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kAgldp+s/JnTsO5NOnR8nVZoY06hI0mSl9T/uciEjWice25h25Ov+buhRJMBf6cE9
	 Hqhfej5isYtNcksDdv92BZeMb7S2rhHguHDAsipjpMC9kJldzxoLGuaoLHTil8SF7+
	 gP388c3XGtH8nuaAH/AXqkReOQNR4n8arWI9rY20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfAUHh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:37:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfAUHh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:37:59 -0500
Received: from devbox (unknown [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DFCC20855;
        Mon, 21 Jan 2019 03:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548043081;
        bh=XoWXVEff0N0Es0WH64+yM8SQAwzjbwWOP5nYX709aF4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rgjZrhwdYbf86tjfRguycgCS1B3N3ws0/FPcPa2s6+Db2tSKPdU43erasTbtO5rM+
         tQgKBLo9LTygz/+bEsflSYLu4ZDlrOf35/q7bk256IXxEsQEw8OEQVVNRipLj01sRW
         2VFwjT0qcoH773Ljclu6wPtE5cPL6TzXe9DR3xM4=
Date:   Mon, 21 Jan 2019 12:57:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Elena Reshetova <elena.reshetova@intel.com>, peterz@infradead.org,
        mingo@redhat.com, akpm@linux-foundation.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] uprobes: convert uprobe.ref to refcount_t
Message-Id: <20190121125756.b06de37c0c52b1b882b3df67@kernel.org>
In-Reply-To: <20190116084452.773833d4@gandalf.local.home>
References: <1547637627-29526-1-git-send-email-elena.reshetova@intel.com>
        <20190116084452.773833d4@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 08:44:52 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> [ Cc'ing Masami as he maintains uprobes (we need to add uprobes to
>   the MAINTAINERS file ]

Thanks Steve, I think it is maintained mainly by Srikar and Oleg.
Srikar, Oleg, could you update MAINTAINERS file to add UPROBES entry?
And ack this change?

Thank you,

> 
> -- Steve
> 
> On Wed, 16 Jan 2019 13:20:27 +0200
> Elena Reshetova <elena.reshetova@intel.com> wrote:
> 
> > atomic_t variables are currently used to implement reference
> > counters with the following properties:
> >  - counter is initialized to 1 using atomic_set()
> >  - a resource is freed upon counter reaching zero
> >  - once counter reaches zero, its further
> >    increments aren't allowed
> >  - counter schema uses basic atomic operations
> >    (set, inc, inc_not_zero, dec_and_test, etc.)
> > 
> > Such atomic variables should be converted to a newly provided
> > refcount_t type and API that prevents accidental counter overflows
> > and underflows. This is important since overflows and underflows
> > can lead to use-after-free situation and be exploitable.
> > 
> > The variable uprobe.ref is used as pure reference counter.
> > Convert it to refcount_t and fix up the operations.
> > 
> > **Important note for maintainers:
> > 
> > Some functions from refcount_t API defined in lib/refcount.c
> > have different memory ordering guarantees than their atomic
> > counterparts.
> > The full comparison can be seen in
> > https://lkml.org/lkml/2017/11/15/57 and it is hopefully soon
> > in state to be merged to the documentation tree.
> > Normally the differences should not matter since refcount_t provides
> > enough guarantees to satisfy the refcounting use cases, but in
> > some rare cases it might matter.
> > Please double check that you don't have some undocumented
> > memory guarantees for this variable usage.
> > 
> > For the uprobe.ref it might make a difference
> > in following places:
> >  - put_uprobe(): decrement in refcount_dec_and_test() only
> >    provides RELEASE ordering and control dependency on success
> >    vs. fully ordered atomic counterpart
> > 
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: David Windsor <dwindsor@gmail.com>
> > Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
> > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> > ---
> >  kernel/events/uprobes.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index ad415f7..750aece 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -66,7 +66,7 @@ static struct percpu_rw_semaphore dup_mmap_sem;
> >  
> >  struct uprobe {
> >  	struct rb_node		rb_node;	/* node in the rb tree */
> > -	atomic_t		ref;
> > +	refcount_t		ref;
> >  	struct rw_semaphore	register_rwsem;
> >  	struct rw_semaphore	consumer_rwsem;
> >  	struct list_head	pending_list;
> > @@ -561,13 +561,13 @@ set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long v
> >  
> >  static struct uprobe *get_uprobe(struct uprobe *uprobe)
> >  {
> > -	atomic_inc(&uprobe->ref);
> > +	refcount_inc(&uprobe->ref);
> >  	return uprobe;
> >  }
> >  
> >  static void put_uprobe(struct uprobe *uprobe)
> >  {
> > -	if (atomic_dec_and_test(&uprobe->ref)) {
> > +	if (refcount_dec_and_test(&uprobe->ref)) {
> >  		/*
> >  		 * If application munmap(exec_vma) before uprobe_unregister()
> >  		 * gets called, we don't get a chance to remove uprobe from
> > @@ -658,7 +658,7 @@ static struct uprobe *__insert_uprobe(struct uprobe *uprobe)
> >  	rb_link_node(&uprobe->rb_node, parent, p);
> >  	rb_insert_color(&uprobe->rb_node, &uprobes_tree);
> >  	/* get access + creation ref */
> > -	atomic_set(&uprobe->ref, 2);
> > +	refcount_set(&uprobe->ref, 2);
> >  
> >  	return u;
> >  }
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
