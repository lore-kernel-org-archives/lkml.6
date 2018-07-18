Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA070ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9AF20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9AF20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbeGRDKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:10:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730614AbeGRDKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:10:39 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E6F08BDB;
        Wed, 18 Jul 2018 02:35:05 +0000 (UTC)
Date:   Tue, 17 Jul 2018 19:35:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: Re: [PATCH v2 1/7] proc/kcore: don't grab lock for kclist_add()
Message-Id: <20180717193504.1d76fb1a43d0c8687d969143@linux-foundation.org>
In-Reply-To: <ddbe991f42b8d49e50645878ad8c1a8168db2e82.1531440458.git.osandov@fb.com>
References: <cover.1531440458.git.osandov@fb.com>
        <ddbe991f42b8d49e50645878ad8c1a8168db2e82.1531440458.git.osandov@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 17:09:33 -0700 Omar Sandoval <osandov@osandov.com> wrote:

> From: Omar Sandoval <osandov@fb.com>
> 
> kclist_add() is only called at init time, so there's no point in
> grabbing any locks. We're also going to replace the rwlock with a rwsem,
> which we don't want to try grabbing during early boot.
> 
> ...
>
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -62,6 +62,7 @@ static LIST_HEAD(kclist_head);
>  static DEFINE_RWLOCK(kclist_lock);
>  static int kcore_need_update = 1;
>  
> +/* This doesn't grab kclist_lock, so it should only be used at init time. */
>  void
>  kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
>  {
> @@ -69,9 +70,7 @@ kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
>  	new->size = size;
>  	new->type = type;
>  
> -	write_lock(&kclist_lock);
>  	list_add_tail(&new->list, &kclist_head);
> -	write_unlock(&kclist_lock);
>  }

So we can mark kclist_add() as __init, yes?

That way we save a scrap of ram and if someone starts calling
kclist_add() from non-__init code we get a build-time warning.

--- a/fs/proc/kcore.c~proc-kcore-dont-grab-lock-for-kclist_add-fix
+++ a/fs/proc/kcore.c
@@ -63,7 +63,7 @@ static DEFINE_RWLOCK(kclist_lock);
 static int kcore_need_update = 1;
 
 /* This doesn't grab kclist_lock, so it should only be used at init time. */
-void
+void __init
 kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
 {
 	new->addr = (unsigned long)addr;
--- a/include/linux/kcore.h~proc-kcore-dont-grab-lock-for-kclist_add-fix
+++ a/include/linux/kcore.h
@@ -35,7 +35,7 @@ struct vmcoredd_node {
 };
 
 #ifdef CONFIG_PROC_KCORE
-extern void kclist_add(struct kcore_list *, void *, size_t, int type);
+extern void __init kclist_add(struct kcore_list *, void *, size_t, int type);
 #else
 static inline
 void kclist_add(struct kcore_list *new, void *addr, size_t size, int type)


