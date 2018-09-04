Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0E8C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008DB2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008DB2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeIDVt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:49:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52716 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeIDVt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:49:27 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EB083CD7;
        Tue,  4 Sep 2018 17:23:23 +0000 (UTC)
Date:   Tue, 4 Sep 2018 19:23:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     holger@applied-asynchrony.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.18 000/123] 4.18.6-stable review
Message-ID: <20180904172321.GA16923@kroah.com>
References: <20180903165719.499675257@linuxfoundation.org>
 <64889a4a-c095-3db8-b496-631acbafcf9a@applied-asynchrony.com>
 <CA+55aFyDZR4SGotsxUA7ahCGCDr+PGnn=_13e_0_W2SnoQbM5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFyDZR4SGotsxUA7ahCGCDr+PGnn=_13e_0_W2SnoQbM5w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 10:12:13AM -0700, Linus Torvalds wrote:
> On Mon, Sep 3, 2018 at 11:39 AM Holger Hoffstätte
> <holger@applied-asynchrony.com> wrote:
> >
> > Sep  3 20:19:38 ragnarok kernel:  tlb_flush_mmu_tlbonly+0x76/0xc0
> > Sep  3 20:19:38 ragnarok kernel:  tlb_table_flush.part.13+0xe/0x30
> > Sep  3 20:19:38 ragnarok kernel:  tlb_flush_mmu_tlbonly+0x54/0xc0
> > ..a few hundred times..
> > Sep  3 20:19:38 ragnarok kernel:  tlb_table_flush.part.13+0xe/0x30
> > Sep  3 20:19:38 ragnarok kernel:  tlb_flush_mmu_tlbonly+0x54/0xc0
> > Sep  3 20:19:38 ragnarok kernel:  arch_tlb_finish_mmu+0x3a/0x70
> > Sep  3 20:19:38 ragnarok kernel:  tlb_finish_mmu+0x1f/0x30
> 
> Yeah, so what seems to have happened is that commit db7ddef30112 ("mm:
> move tlb_table_flush to tlb_flush_mmu_free") wasn't applied to the
> stable tree (because it wasn't an obvious dependency).
> 
> And without that, the backport of d86564a2f085 ("mm/tlb, x86/mm:
> Support invalidating TLB caches for RCU_TABLE_FREE") ends up with
> recursion from tlb_flush_mmu_tlbonly() calling tlb_table_flush(),
> which in turn calls tlb_table_invalidate(), which calls back to
> tlb_flush_mmu_tlbonly().
> 
> So you have endless recursion - at least until you run out of stack.
> Then, if you have VMAP_STACK enabled (x86-64 without KASAN), you get a
> nice clean kernel stack overflow message like you did.
> 
> Or if you have KASAN enabled and no VMAP stack, you just end up with
> random hangs and huge memory corruption as the recursion stomps all
> over your memory.

Ok, I will go queue this patch up now, it was in my very-long "to-apply"
queue, but I didn't catch the dependancy here.

thanks,

greg k-h
