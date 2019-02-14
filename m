Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB38C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD47222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NpGnKFlg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XhTDONbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437322AbfBNHqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:46:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55568 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfBNHqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:46:36 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5DA1E60886; Thu, 14 Feb 2019 07:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550130395;
        bh=4UWOZAHo8P5HQluG58zpa1sMTmgdpcRHGQVkuLn1LPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NpGnKFlg6T005Y7+SZYnTnq6nPwYgHVFOpULaAZqMoYJBh0NN3NZPppxly+mKrwA2
         LeHkmkLvSW/Xa5RFqDGJBnmv45zVZbVsaMIl/sfMi39FxS3679UJZlBoasDTWzsrtl
         oBJ0r6Qx4FJ9124PCosNYxV4Nzxatecxvh1OUii8=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E2DDD605A0;
        Thu, 14 Feb 2019 07:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550130394;
        bh=4UWOZAHo8P5HQluG58zpa1sMTmgdpcRHGQVkuLn1LPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XhTDONbpT7oTsDWWBRzzBxU7ROS2IhorXaPvPhySTWE6tc9GEVRsU25V2cpFf6k+H
         cPmf0NJPqverwcXF8/xotYJs4MgH+9JbZr/687M7bTZ0w6NqtbnjivJzuFIIpcBVo+
         0tBNQxlPhG+cxI8V/eHA8Wrbw27CS3j5kNXt2Qsc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2DDD605A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Thu, 14 Feb 2019 13:16:28 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: do not use mutex lock in atomic context
Message-ID: <20190214074628.GD7308@codeaurora.org>
References: <1549267613-9288-1-git-send-email-stummala@codeaurora.org>
 <c98cbfcb-f45d-e9a9-5c2e-6730d0448e82@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c98cbfcb-f45d-e9a9-5c2e-6730d0448e82@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:25:31AM +0800, Chao Yu wrote:
> On 2019/2/4 16:06, Sahitya Tummala wrote:
> > Fix below warning coming because of using mutex lock in atomic context.
> > 
> > BUG: sleeping function called from invalid context at kernel/locking/mutex.c:98
> > in_atomic(): 1, irqs_disabled(): 0, pid: 585, name: sh
> > Preemption disabled at: __radix_tree_preload+0x28/0x130
> > Call trace:
> >  dump_backtrace+0x0/0x2b4
> >  show_stack+0x20/0x28
> >  dump_stack+0xa8/0xe0
> >  ___might_sleep+0x144/0x194
> >  __might_sleep+0x58/0x8c
> >  mutex_lock+0x2c/0x48
> >  f2fs_trace_pid+0x88/0x14c
> >  f2fs_set_node_page_dirty+0xd0/0x184
> > 
> > Do not use f2fs_radix_tree_insert() to avoid doing cond_resched() with
> > spin_lock() acquired.
> > 
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > ---
> >  fs/f2fs/trace.c | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
> > index ce2a5eb..d0ab533 100644
> > --- a/fs/f2fs/trace.c
> > +++ b/fs/f2fs/trace.c
> > @@ -14,7 +14,7 @@
> >  #include "trace.h"
> >  
> >  static RADIX_TREE(pids, GFP_ATOMIC);
> > -static struct mutex pids_lock;
> > +static spinlock_t pids_lock;
> >  static struct last_io_info last_io;
> >  
> >  static inline void __print_last_io(void)
> > @@ -58,23 +58,29 @@ void f2fs_trace_pid(struct page *page)
> >  
> >  	set_page_private(page, (unsigned long)pid);
> >  
> > +retry:
> >  	if (radix_tree_preload(GFP_NOFS))
> >  		return;
> >  
> > -	mutex_lock(&pids_lock);
> > +	spin_lock(&pids_lock);
> >  	p = radix_tree_lookup(&pids, pid);
> >  	if (p == current)
> >  		goto out;
> >  	if (p)
> >  		radix_tree_delete(&pids, pid);
> >  
> > -	f2fs_radix_tree_insert(&pids, pid, current);
> > +	if (radix_tree_insert(&pids, pid, current)) {
> > +		spin_unlock(&pids_lock);
> > +		radix_tree_preload_end();
> > +		cond_resched();
> > +		goto retry;
> > +	}
> >  
> >  	trace_printk("%3x:%3x %4x %-16s\n",
> >  			MAJOR(inode->i_sb->s_dev), MINOR(inode->i_sb->s_dev),
> >  			pid, current->comm);
> 
> Hi Sahitya,
> 
> Can trace_printk sleep? For safety, how about moving it out of spinlock?
> 
Hi Chao,

Yes, trace_printk() is safe to use in atomic context (unlike printk).

Thanks,
Sahitya.

> Thanks,
> 
> >  out:
> > -	mutex_unlock(&pids_lock);
> > +	spin_unlock(&pids_lock);
> >  	radix_tree_preload_end();
> >  }
> >  
> > @@ -119,7 +125,7 @@ void f2fs_trace_ios(struct f2fs_io_info *fio, int flush)
> >  
> >  void f2fs_build_trace_ios(void)
> >  {
> > -	mutex_init(&pids_lock);
> > +	spin_lock_init(&pids_lock);
> >  }
> >  
> >  #define PIDVEC_SIZE	128
> > @@ -147,7 +153,7 @@ void f2fs_destroy_trace_ios(void)
> >  	pid_t next_pid = 0;
> >  	unsigned int found;
> >  
> > -	mutex_lock(&pids_lock);
> > +	spin_lock(&pids_lock);
> >  	while ((found = gang_lookup_pids(pid, next_pid, PIDVEC_SIZE))) {
> >  		unsigned idx;
> >  
> > @@ -155,5 +161,5 @@ void f2fs_destroy_trace_ios(void)
> >  		for (idx = 0; idx < found; idx++)
> >  			radix_tree_delete(&pids, pid[idx]);
> >  	}
> > -	mutex_unlock(&pids_lock);
> > +	spin_unlock(&pids_lock);
> >  }
> > 
> 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
