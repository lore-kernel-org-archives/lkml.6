Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B47C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B014D217B7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B014D217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeHDP3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:29:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbeHDP3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:29:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF4138197021;
        Sat,  4 Aug 2018 13:29:11 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52F577C39;
        Sat,  4 Aug 2018 13:29:11 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w74DTBhC025452;
        Sat, 4 Aug 2018 09:29:11 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w74DTAZW025448;
        Sat, 4 Aug 2018 09:29:10 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sat, 4 Aug 2018 09:29:10 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Matt Sealey <neko@bakuhatsu.net>
cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1808040840410.16932@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com> <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com> <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com> <20180803094129.GB17798@arm.com> <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com> <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com> <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 04 Aug 2018 13:29:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 04 Aug 2018 13:29:11 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Aug 2018, Matt Sealey wrote:

> On 3 August 2018 at 13:25, Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> >
> > On Fri, 3 Aug 2018, Ard Biesheuvel wrote:
> >
> >> Are we still talking about overlapping unaligned accesses here? Or do
> >> you see other failures as well?
> >
> > Yes - it is caused by overlapping unaligned accesses inside memcpy. When I
> > put "dmb sy" between the overlapping accesses in
> > glibc/sysdeps/aarch64/memcpy.S, this program doesn't detect any memory
> > corruption.
> 
> It is a symptom of generating reorderable accesses inside memcpy. It's nothing
> to do with alignment, per se (see below). A dmb sy just hides the symptoms.
> 
> What we're talking about here - yes, Ard, within certain amounts of 
> reason - is that you cannot use PCI BAR memory as 'Normal' - certainly 
> never cacheable memory, but Normal NC isn't good either.

So, are you going to map the PCI BAR as Device-nGnRE and then emulate all 
the unaligned accesses in the trap handler?

Or are you going to give up on supporting PCIe graphics on ARM at all?

Videocards have linear framebuffer for 25 years. It was introduced as a 
feature that simplified graphics programming a lot - programmers can use C 
pointer arithmetics for drawing and they don't have to fiddle with 
hardware registers. If you argue that graphics programmers can't use it 
(after they have been using it for 25 years) - they will just ignore you 
and ARM.


> Links is broken.

What else should it use? Are you going to introduce new functions 
memcpy_to_framebuffer() and memset_framebuffer()?

> Even on Intel.

No, it's not. Intel will detect overlapping accesses.

You can write this - it is legal C code:

void g(void);
void overlapping(unsigned char *p)
{
        p[0] = p[1] = p[2] = p[3] = 1;
        g();
        p[3] = p[4] = p[5] = p[6] = 2;
}

and the compiler compiles it to this:

overlapping:
.LFB0:
        pushl   %ebx
        subl    $8, %esp
        movl    16(%esp), %ebx
        movl    $16843009, (%ebx)
        call    g
        movl    $33686018, 3(%ebx)
        addl    $8, %esp
        popl    %ebx
        ret

Now - if the CPU is incapable of detecing the hazaard between writes to 
(%ebx) and 3(%ebx) and reorders these writes, it is just broken because it 
violates the C standard.

If you argue that ARM is incapable of detecting this hazaard and reorders 
these two overlapping memory writes - it means that you can't use C 
pointers to access videoram on ARM - which means that you can't have PCIe 
graphics at all.

Mikulas
