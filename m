Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F56C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C717820856
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbeL1VJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 16:09:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59840 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeL1VJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 16:09:42 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F3193B1D;
        Fri, 28 Dec 2018 21:09:39 +0000 (UTC)
Date:   Fri, 28 Dec 2018 13:09:38 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+b437b5a429d680cf2217@syzkaller.appspotmail.com>
Cc:     darrick.wong@oracle.com, hannes@cmpxchg.org, hughd@google.com,
        jack@suse.cz, josef@toxicpanda.com, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: KASAN: use-after-free Read in filemap_fault
Message-Id: <20181228130938.c9e42c213cdcc35a93dd0dac@linux-foundation.org>
In-Reply-To: <000000000000b57d19057e1b383d@google.com>
References: <000000000000b57d19057e1b383d@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018 12:51:04 -0800 syzbot <syzbot+b437b5a429d680cf2217@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following crash on:

uh-oh.  Josef, could you please take a look?

:	page = find_get_page(mapping, offset);
: 	if (likely(page) && !(vmf->flags & FAULT_FLAG_TRIED)) {
: 		/*
: 		 * We found the page, so try async readahead before
: 		 * waiting for the lock.
: 		 */
: 		fpin = do_async_mmap_readahead(vmf, page);
: 	} else if (!page) {
: 		/* No page in the page cache at all */
: 		fpin = do_sync_mmap_readahead(vmf);
: 		count_vm_event(PGMAJFAULT);
: 		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);

vmf->vma has been freed at this point.

: 		ret = VM_FAULT_MAJOR;
: retry_find:
: 		page = pagecache_get_page(mapping, offset,
: 					  FGP_CREAT|FGP_FOR_MMAP,
: 					  vmf->gfp_mask);
: 		if (!page) {
: 			if (fpin)
: 				goto out_retry;
: 			return vmf_error(-ENOMEM);
: 		}
: 	}

