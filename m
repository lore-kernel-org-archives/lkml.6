Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924C6C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4750C2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4750C2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeJCF33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:29:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59282 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeJCF33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:29:29 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E46CACBC;
        Tue,  2 Oct 2018 22:43:48 +0000 (UTC)
Date:   Tue, 2 Oct 2018 15:43:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     mark@fasheh.com, jlbec@evilplan.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: ocfs2: dlm: Fix a sleep-in-atomic-context bug in
 dlm_print_one_mle()
Message-Id: <20181002154347.01e026b4e644d6b7efc76180@linux-foundation.org>
In-Reply-To: <20180901112528.27025-1-baijiaju1990@gmail.com>
References: <20180901112528.27025-1-baijiaju1990@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  1 Sep 2018 19:25:28 +0800 Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> The kernel module may sleep with holding a spinlock.
> 
> The function call paths (from bottom to top) in Linux-4.16 are:
> 
> [FUNC] get_zeroed_page(GFP_NOFS)
> fs/ocfs2/dlm/dlmdebug.c, 332: get_zeroed_page in dlm_print_one_mle
> fs/ocfs2/dlm/dlmmaster.c, 240: dlm_print_one_mle in __dlm_put_mle
> fs/ocfs2/dlm/dlmmaster.c, 255: __dlm_put_mle in dlm_put_mle
> fs/ocfs2/dlm/dlmmaster.c, 254: spin_lock in dlm_put_ml
> 
> [FUNC] get_zeroed_page(GFP_NOFS)
> fs/ocfs2/dlm/dlmdebug.c, 332: get_zeroed_page in dlm_print_one_mle
> fs/ocfs2/dlm/dlmmaster.c, 240: dlm_print_one_mle in __dlm_put_mle
> fs/ocfs2/dlm/dlmmaster.c, 222: __dlm_put_mle in dlm_put_mle_inuse
> fs/ocfs2/dlm/dlmmaster.c, 219: spin_lock in dlm_put_mle_inuse
> 
> To fix this bug, GFP_NOFS is replaced with GFP_ATOMIC.
> 
> This bug is found by my static analysis tool DSAC.
> 
> ...
>
> --- a/fs/ocfs2/dlm/dlmdebug.c
> +++ b/fs/ocfs2/dlm/dlmdebug.c
> @@ -329,7 +329,7 @@ void dlm_print_one_mle(struct dlm_master_list_entry *mle)
>  {
>  	char *buf;
>  
> -	buf = (char *) get_zeroed_page(GFP_NOFS);
> +	buf = (char *) get_zeroed_page(GFP_ATOMIC);
>  	if (buf) {
>  		dump_mle(mle, buf, PAGE_SIZE - 1);
>  		free_page((unsigned long)buf);

Fair enough.  It's pretty sad code here, replying on the page allocator
in this situation.  But it's only debug stuff so nobody is likely to
care much.

(And that page didn't need to be zeroed!)
