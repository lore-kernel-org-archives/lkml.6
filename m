Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F43C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAFF216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFAFF216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeHCIaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:30:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726851AbeHCIae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:30:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9238A4023132;
        Fri,  3 Aug 2018 06:35:47 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FA1110CD88E;
        Fri,  3 Aug 2018 06:35:47 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w736ZlUd020836;
        Fri, 3 Aug 2018 02:35:47 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w736Zkcd020832;
        Fri, 3 Aug 2018 02:35:46 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 3 Aug 2018 02:35:46 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Matt Sealey <neko@bakuhatsu.net>
cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Will Deacon <will.deacon@arm.com>, libc-alpha@sourceware.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com> <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 03 Aug 2018 06:35:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 03 Aug 2018 06:35:47 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Aug 2018, Matt Sealey wrote:

> The easiest explanation for this would be that the memory isn?t mapped 
> correctly. You can?t use PCIe memory spaces with anything other than 
> Device-nGnRE or stricter mappings. That?s just differences between the 
> AMBA and PCIe (posted/unposted) memory models.

I've tried to use Device-nGnRE mapping and I've got unaligned access 
traps. Gcc have store-merging pass so that it generates unaligned accesses 
even in code that has none explicit unaligned accesses. Perhaps it would 
be possible to recompile the kernel without the store-merging pass, but 
recompiling all the userspace code is impossible.

Should we catch the unaligned access traps in the kernel and emulate them? 
There are a lot of instructions that access memory in the ARMv8 ISA, so 
the emulator would be quite complicated.

> Normal memory (cacheable or uncacheable, which Linux tends to call 
> ?memory? and ?writecombine? respectively) is not a good idea.
> 
> There are two options; make sure Links maps it?s framebuffer as Device 
> memory, or the driver, or both - and make sure that only aligned 
> accesses happen (otherwise you?ll just get a synchronous exception) and 
> there isn?t a Normal memory alias.
> 
> Alternatively, tell the PCIe driver that the framebuffer is in system 
> memory

But how would the graphics card display from it? You'd have to 
periodically copy the framebuffer from the system memory to the real 
videoram. I'm not an expert in graphics drivers, I don't know if the 
graphics drivers have this possibility.

> - you can map it however you like but there?ll be a performance 
> hit if you start to use GPU acceleration, but a significant performance 
> boost from the PoV of the CPU. Only memory accessed from the PCIe master 
> interface (i.e. reads and writes generated by the card itself - telling 
> the GPU to pull from system memory or other DMA) can be in Normal memory 
> and this allows PCIe to be cache coherent with the right interconnect. 
> The slave port on a PCIe root complex (i.e. CPU writes) can?t be used 
> with Normal, or reorderable, and therefore your 2GB of graphics memory 
> is going to be slow from the point of view of the CPU.
> 
> To find the correct mapping you?ll need to know just how cache coherent 
> the PCIe RC is...
> 
> Ta,
> Matt

Mikulas
