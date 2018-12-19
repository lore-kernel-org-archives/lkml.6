Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AE0C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A6421850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545210623;
	bh=RABkT2F8t+V5lL908Xy/6Oc6dFOdhfBIE1glCBZdMbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FZ5qhBnq/VLuJtqbscw/LH3eH1tggS5q+26PU0dEFDPY5hkzQM1l8MuhMurqlaPfw
	 f0P8Tq2nhOYbGz/xB3RPf01E3UejaYoErCFScC28LCT+HmtKBjc/beCNKC6uhtRtsG
	 e+gHew1pG4/QMGp4rVYgEVksNBJIb9bP2KSp0iTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeLSJKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbeLSJKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:10:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49B0620874;
        Wed, 19 Dec 2018 09:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545210620;
        bh=RABkT2F8t+V5lL908Xy/6Oc6dFOdhfBIE1glCBZdMbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0wUBLA4lzb8HntpdfEBmmrmEJGBsauiEC44EcEa0tMFsVuR8skNuo5s1L/78Q2AB
         +oHBi8A9u6pkbuYf5Jw7K9Kx3HFFUbuZHdcOJ9bRF7qmJwvl5Pybj2ac5Jog8YYt4o
         8jdrLdHbrQsCm/xXpJu59dcFspIIj/zoUj1yHDWk=
Date:   Wed, 19 Dec 2018 10:10:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     haver <haver@linux.vnet.ibm.com>,
        "Guilherme G . Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genwqe: Fix size check
Message-ID: <20181219091018.GC28855@kroah.com>
References: <20181212134518.4587-1-borntraeger@de.ibm.com>
 <64f068a535ab7bfe15f04ba86fb067b0@linux.vnet.ibm.com>
 <cdcfbeed-9e33-0d50-02e4-5b5b6d61660e@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdcfbeed-9e33-0d50-02e4-5b5b6d61660e@de.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 03:36:57PM +0100, Christian Borntraeger wrote:
> On 12.12.2018 15:18, haver wrote:
> > Hi Christian,
> > 
> > On 2018-12-12 14:45, Christian Borntraeger wrote:
> >> Calling the test program genwqe_cksum with the default buffer size of
> >> 2MB triggers the following kernel warning on s390:
> >>
> >> WARNING: CPU: 30 PID: 9311 at mm/page_alloc.c:3189
> >> __alloc_pages_nodemask+0x45c/0xbe0
> >> CPU: 30 PID: 9311 Comm: genwqe_cksum Kdump: loaded Not tainted
> >> 3.10.0-957.el7.s390x #1
> >> task: 00000005e5d13980 ti: 00000005e7c6c000 task.ti: 00000005e7c6c000
> >> Krnl PSW : 0704c00180000000 00000000002780ac
> >> (__alloc_pages_nodemask+0x45c/0xbe0)
> >>            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 EA:3
> >> Krnl GPRS: 00000000002932b8 0000000000b73d7c 0000000000000010 0000000000000009
> >>            0000000000000041 00000005e7c6f9b8 0000000000000001 00000000000080d0
> >>            0000000000000000 0000000000b70500 0000000000000001 0000000000000000
> >>            0000000000b70528 00000000007682c0 0000000000277df2 00000005e7c6f9a0
> >> Krnl Code: 000000000027809e: de7195001000    ed    1280(114,%r9),0(%r1)
> >>        00000000002780a4: a774fead        brc    7,277dfe
> >>       #00000000002780a8: a7f40001        brc    15,2780aa
> >>       >00000000002780ac: 92011000        mvi    0(%r1),1
> >>        00000000002780b0: a7f4fea7        brc    15,277dfe
> >>        00000000002780b4: 9101c6b6        tm    1718(%r12),1
> >>        00000000002780b8: a784ff3a        brc    8,277f2c
> >>        00000000002780bc: a7f4fe2e        brc    15,277d18
> >> Call Trace:
> >> ([<0000000000277df2>] __alloc_pages_nodemask+0x1a2/0xbe0)
> >>  [<000000000013afae>] s390_dma_alloc+0xfe/0x310
> >>  [<000003ff8065f362>] __genwqe_alloc_consistent+0xfa/0x148 [genwqe_card]
> >>  [<000003ff80658f7a>] genwqe_mmap+0xca/0x248 [genwqe_card]
> >>  [<00000000002b2712>] mmap_region+0x4e2/0x778
> >>  [<00000000002b2c54>] do_mmap+0x2ac/0x3e0
> >>  [<0000000000292d7e>] vm_mmap_pgoff+0xd6/0x118
> >>  [<00000000002b081c>] SyS_mmap_pgoff+0xdc/0x268
> >>  [<00000000002b0a34>] SyS_old_mmap+0x8c/0xb0
> >>  [<000000000074e518>] sysc_tracego+0x14/0x1e
> >>  [<000003ffacf87dc6>] 0x3ffacf87dc6
> >>
> >> turns out the check in __genwqe_alloc_consistent uses "> MAX_ORDER"
> >> while the mm code uses ">= MAX_ORDER". Fix genwqe.
> >>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>  drivers/misc/genwqe/card_utils.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/misc/genwqe/card_utils.c b/drivers/misc/genwqe/card_utils.c
> >> index 3fcb9a2fe1c9..efe2fb72d54b 100644
> >> --- a/drivers/misc/genwqe/card_utils.c
> >> +++ b/drivers/misc/genwqe/card_utils.c
> >> @@ -215,7 +215,7 @@ u32 genwqe_crc32(u8 *buff, size_t len, u32 init)
> >>  void *__genwqe_alloc_consistent(struct genwqe_dev *cd, size_t size,
> >>                     dma_addr_t *dma_handle)
> >>  {
> >> -    if (get_order(size) > MAX_ORDER)
> >> +    if (get_order(size) >= MAX_ORDER)
> >>          return NULL;
> >>
> >>      return dma_zalloc_coherent(&cd->pci_dev->dev, size, dma_handle,
> > 
> > Thanks for sending a fix for this ugly message.
> > Regards
> > 
> > Frank
> > 
> > Signed-off-by: Frank Haverkamp <haver@linux.vnet.ibm.com>
> 
> This should have been an Acked-by, I guess.
> Will this go via Gregs misc driver tree?

Yes, I can take it, thanks.

greg k-h
