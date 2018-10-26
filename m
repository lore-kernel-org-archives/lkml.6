Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DB3C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB0420834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB0420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeJZR06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:26:58 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:29302 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726348AbeJZR06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:26:58 -0400
X-UUID: 75866f457ae5466484c6153097eda7aa-20181026
X-UUID: 75866f457ae5466484c6153097eda7aa-20181026
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 210528792; Fri, 26 Oct 2018 16:50:35 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 26 Oct 2018 16:50:34 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 26 Oct 2018 16:50:34 +0800
Message-ID: <1540543834.21297.14.camel@mtkswgap22>
Subject: Re: [PATCH] mm/page_owner: use vmalloc instead of kmalloc
From:   Miles Chen <miles.chen@mediatek.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <wsd_upstream@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 26 Oct 2018 16:50:34 +0800
In-Reply-To: <20181025192701.GK25444@bombadil.infradead.org>
References: <1540492481-4144-1-git-send-email-miles.chen@mediatek.com>
         <20181025192701.GK25444@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 12:27 -0700, Matthew Wilcox wrote:
> On Fri, Oct 26, 2018 at 02:34:41AM +0800, miles.chen@mediatek.com wrote:
> > The kbuf used by page owner is allocated by kmalloc(),
> > which means it can use only normal memory and there might
> > be a "out of memory" issue when we're out of normal memory.
> > 
> > Use vmalloc() so we can also allocate kbuf from highmem
> > on 32bit kernel.
> 
> ... hang on, there's a bigger problem here.
> 
> static const struct file_operations proc_page_owner_operations = {
>         .read           = read_page_owner,
> };
> 
> read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> {
> ...
>                 return print_page_owner(buf, count, pfn, page,
>                                 page_owner, handle);
> }
> 
> static ssize_t
> print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>                 struct page *page, struct page_owner *page_owner,
>                 depot_stack_handle_t handle)
> {mount -t debugfs none /sys/kernel/debug/
> ...
>       kbuf = kmalloc(count, GFP_KERNEL);
> 
> So I can force the kernel to make an arbitrary size allocation, triggering
> OOMs and forcing swapping if I can get a file handle to this file.
> The only saving grace is that (a) this is a debugfs file and (b) it's
> root-only (mode 0400).  Nevertheless, I feel some clamping is called
> for here.  Do we really need to output more than 4kB worth of text here?
> 
I did a test on my device, the allocation count is 4096 and around 6xx
bytes are used each print_page_owner() is called. It looks like that
clamping the reading count to PAGE_SIZE is ok.

The following output from print_page_owner() is 660 bytes long, I think
PAGE_SIZE should be enough to print the information we need.

Page allocated via order 0, mask 0x6200ca(GFP_HIGHUSER_MOVABLE)
PFN 262199 type Movable Block 512 type Movable Flags 0x4003c(referenced|
uptodate|dirty|lru|swapbacked)
 get_page_from_freelist+0x1580/0x1650
 __alloc_pages_nodemask+0xcc/0xfa4
 shmem_alloc_page+0xa4/0xc8
 shmem_alloc_and_acct_page+0x138/0x2b8
 shmem_getpage_gfp.isra.54+0x164/0xfc8
 shmem_write_begin+0x84/0xcc
 generic_perform_write+0xe8/0x210
 __generic_file_write_iter+0x1d4/0x230
 generic_file_write_iter+0x184/0x2e8
 new_sync_write+0x144/0x1c4
 vfs_write+0x194/0x278
 ksys_write+0x64/0xd4
 xwrite+0x34/0x84
 do_copy+0xf4/0x168
 flush_buffer+0x68/0xec
 __gunzip+0x370/0x448


