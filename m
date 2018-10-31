Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79440C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7692054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OChd+WuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7692054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbeKAFqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 01:46:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43982 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeKAFqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 01:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HbVU1qMU7jfmDpq0n7mc+ceizetKVVY3CRZVQnKAMWg=; b=OChd+WuJTSOH4zP9dn2m+uphH
        g25GYGfSXwdrsuBxVNrtbZT3xI/j/xt0pGsQyGxiRgmHJmlT7jrGTsR+nPCifInPgESxIuAIuzW3x
        AXSSk5btwcQlicygX+VemPDUWWHtBAdTy9a2H20sPkUkYz9lNpMJsVlSk7qY7K2QXcpHPUfGG7Xna
        vkk0B7sd5xka+UcxQzRSdvRAa+DcoqIFdALLIXakXLt3Tuv9B7vB3IuavwW0sYmjqhWjUi55b57r0
        Kk80z8q6LBHEv1OaGW3oni8GniaVbUx5XbHx73WSnSwIP51tRUqn+tTcWWQmlchGUWTGYr8nGsaH3
        UK0E207Mw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHxNi-0006xQ-6V; Wed, 31 Oct 2018 20:46:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED21B20296F15; Wed, 31 Oct 2018 21:46:22 +0100 (CET)
Date:   Wed, 31 Oct 2018 21:46:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Garry <john.garry@huawei.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Linuxarm <linuxarm@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: Crash report: Broken NUMA distance map causes crash on arm64
 system
Message-ID: <20181031204622.GB3141@hirez.programming.kicks-ass.net>
References: <b89bf686-05bd-a3de-e7ef-4ab9ab7bdb6c@huawei.com>
 <20181030092640.GE1459@hirez.programming.kicks-ass.net>
 <d126099d-2698-8e3a-06ca-f229e57c3052@huawei.com>
 <ae352fe1-3c59-dcde-fd00-2c03b4491dc6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae352fe1-3c59-dcde-fd00-2c03b4491dc6@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 03:35:35PM +0000, John Garry wrote:
> [    7.154740] ERROR: Node-distance not symmetric
> [    7.154740]
> [    7.160724]   10 15 20 25
> [    7.163456]   15 10 25 30
> [    7.166190]   20 25 10 15
> [    7.168921]   10 10 15 10
> [    7.171655]

But I'm not getting the rest of those errors with my 'reproducer':

  kvm -smp 4 -m 4G -display none -monitor null -serial stdio -kernel defconfig-build/arch/x86/boot/bzImage -append "sched_debug debug ignore_loglevel earlyprintk=serial,ttyS0,115200,keep numa=fake=4:10,15,20,25,15,10,25,30,20,25,10,15,10,10,15,10,0"

[    0.828331] ERROR: Node-distance not symmetric
[    0.828331] 
[    0.829081]   10 15 20 25 
[    0.830079]   15 10 25 30 
[    0.831079]   20 25 10 15 
[    0.832079]   10 10 15 10 
[    0.833079] 
[    0.834373] CPU0 attaching sched-domain(s):
[    0.835082]  domain-0: span=0-3 level=DIE
[    0.836079]   groups: 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }
[    0.837082] CPU1 attaching sched-domain(s):
[    0.838081]  domain-0: span=0-3 level=DIE
[    0.839079]   groups: 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 0:{ span=0 }
[    0.840082] CPU2 attaching sched-domain(s):
[    0.841080]  domain-0: span=0-3 level=DIE
[    0.842079]   groups: 2:{ span=2 }, 3:{ span=3 }, 0:{ span=0 }, 1:{ span=1 }
[    0.843094] ------------[ cut here ]------------
[    0.844076] kernel BUG at ../mm/slub.c:3901!
[    0.844083] invalid opcode: 0000 [#1] SMP PTI
[    0.845076] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc8+ #305
[    0.845076] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    0.845076] RIP: 0010:kfree+0x113/0x160
[    0.845076] Code: 18 48 89 da 4c 89 e6 e8 db 01 c5 00 48 8b 45 00 48 85 c0 75 e4 e9 0e ff ff ff 49 8b 02 f6 c4 80 75 0a 49 8b 42 08 a8 01 75 02 <0f> 0b 49 8b 02 31 f6 f6 c4 80 74 05 41 0f b6 72 51 5b 5d 41 5c 4c
[    0.845076] RSP: 0000:ffffabc080633dc8 EFLAGS: 00010246
[    0.845076] RAX: ffff9f973fff8da0 RBX: ffff9f970000001e RCX: 00000000000000f9
[    0.845076] RDX: 0000000000000000 RSI: ffff9f963ea23c80 RDI: 0000606980000000
[    0.845076] RBP: 0000000000020ac0 R08: 0000000000023c80 R09: ffffffff9f8a10db
[    0.845076] R10: fffff17204000000 R11: 0000000000000001 R12: ffffffff9f8a113d
[    0.845076] R13: 0000000000000003 R14: ffffffffa0ab4820 R15: ffff9f973e5bde00
[    0.845076] FS:  0000000000000000(0000) GS:ffff9f963ea00000(0000) knlGS:0000000000000000
[    0.845076] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.845076] CR2: 00000000ffffffff CR3: 000000008ea0a000 CR4: 00000000000006f0
[    0.845076] Call Trace:
[    0.845076]  destroy_sched_domain+0x3d/0x50
[    0.845076]  cpu_attach_domain+0x378/0x680
[    0.845076]  ? update_group_capacity+0x20/0x2c0
[    0.845076]  build_sched_domains+0xde9/0xed0
[    0.845076]  ? set_debug_rodata+0xc/0xc
[    0.845076]  sched_init_domains+0x80/0x90
[    0.845076]  sched_init_smp+0x1d/0x63
[    0.845076]  kernel_init_freeable+0x101/0x23f
[    0.845076]  ? rest_init+0xb0/0xb0
[    0.845076]  kernel_init+0x5/0x100
[    0.845076]  ret_from_fork+0x35/0x40

I'll work on that crash though..

> I also note that if I apply the patch, below, to reject the invalid NUMA
> distance, we're still getting a warning/error:
> 
> [    7.144407] CPU: All CPU(s) started at EL2
> [    7.148678] alternatives: patching kernel code
> [    7.153557] ERROR: Node-0 not representative
> [    7.153557]
> [    7.159365]   10 15 20 25
> [    7.162097]   15 10 25 30
> [    7.164832]   20 25 10 15
> [    7.167562]   25 30 15 10

Yeah, that's an 'obviously' broken topology too.

Clearly you're far more creative than the ACPI BIOS people have been so
far.
