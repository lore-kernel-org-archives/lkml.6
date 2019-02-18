Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA89C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBF92081B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732990AbfBRO3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:29:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58922 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388625AbfBRN7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:59:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A8FC15AB;
        Mon, 18 Feb 2019 05:59:39 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34DAD3F720;
        Mon, 18 Feb 2019 05:59:32 -0800 (PST)
Date:   Mon, 18 Feb 2019 13:59:29 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Qian Cai <cai@lca.pw>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, james.morse@arm.com
Subject: Re: [PATCH] trace: skip hwasan
Message-ID: <20190218135929.GB15050@fuggles.cambridge.arm.com>
References: <20190217043434.46233-1-cai@lca.pw>
 <CACT4Y+ZYd0LFLJTwBbPRXpS1SorgPjN6c6woUB+25Vd6GuStsw@mail.gmail.com>
 <ec947849-5743-d48b-e2fc-acb90bbe6559@lca.pw>
 <CACT4Y+a=d3G06tjLU0qEz8RWthFybeiJZ_sAAt2ybi+-JEDPZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a=d3G06tjLU0qEz8RWthFybeiJZ_sAAt2ybi+-JEDPZw@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+James, who knows how to decode these things]

On Mon, Feb 18, 2019 at 02:56:47PM +0100, Dmitry Vyukov wrote:
> On Mon, Feb 18, 2019 at 2:27 PM Qian Cai <cai@lca.pw> wrote:
> > On 2/17/19 2:30 AM, Dmitry Vyukov wrote:
> > > On Sun, Feb 17, 2019 at 5:34 AM Qian Cai <cai@lca.pw> wrote:
> > >>
> > >> Enabling function tracer with CONFIG_KASAN_SW_TAGS=y (hwasan) tracer
> > >> causes the whole system frozen on ThunderX2 systems with 256 CPUs,
> > >> because there is a burst of too much pointer access, and then KASAN will
> > >> dereference each byte of the shadow address for the tag checking which
> > >> will kill all the CPUs.
> > >
> > > Could you please elaborate what exactly happens and who/why kills
> > > CPUs? Number of memory accesses should not make any difference.
> > > With hardware support (MTE) it won't be possible to disable
> > > instrumentation (loads and stores check tags themselves), so it would
> > > be useful to keep track of exact reasons we disable instrumentation to
> > > know how to deal with them with hardware support.
> > > It would be useful to keep this info in the comment in the Makefile.
> >
> > It turns out sometimes it will trigger a hardware error.
> 
> Please add this to the comment that there is that error, reason is
> unknown, happens from time to time.
> "Too much pointer access" is confusing and does not seem to be the
> root cause (there are lots of source files that cause lots of pointer
> accesses).

I don't think this is directly related to KASAN, as I'm sure we've seen this
RAS error before.

Will

> > # echo function > /sys/kernel/debug/tracing/current_trace
> >
> > RAS CONTROLLER: Fatal unrecoverable error detected
> >
> >         *** NBU BAR Error ***
> >
> >
> >   MPIDR= 0x81000000
> >   CTX_X0= ffff10001032eb9c
> >   CTX_X1= ffff100010205f08
> >   CTX_X2= 0
> >   CTX_X3= ffff100010205efc
> >   CTX_X4= 8
> >   CTX_X5= 40
> >   CTX_X6= 3f
> >   CTX_X7= 0
> >   CTX_X8= ff
> >   CTX_X9= ffff0808ba65ab46
> >   CTX_X10= ffff0808ba65ab45
> >   CTX_X11= da
> >   CTX_X12= 10071651
> >   CTX_X13= fff60658
> >   CTX_X14= ffff1000140d5000
> >   CTX_X15= ffff100013855578
> >   CTX_X16= 804b004a
> >   CTX_X17= 1000100
> >   CTX_X18= 0
> >   CTX_X19= ffff100010205f08
> >   CTX_X20= ffff100012531cd0
> >   CTX_X21= ffff100010205f08
> >   CTX_X22= ffff10001032eb9c
> >   CTX_X23= 0
> >   CTX_X24= ffff100012531cc0
> >   CTX_X25= 12af
> >   CTX_X26= fffdba05
> >   CTX_X27= daff808ba65ab460
> >   CTX_X28= ffff100012531cc0
> >   CTX_X29= ffff808a2c617320
> >   CTX_X30= ffff10001009b5a4
> >   CTX_X31= ffff100012531cc0
> >   CTX_SCR_EL3= 735
> >   CTX_RUNTIME_SP= 6e545c0
> >   CTX_SPSR_EL3= 604003c9
> >   CTX_ELR_EL3= ffff100010205ecc
> >  Node 0 NBU 0 Error report :
> >  NBU BAR Error
> >       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
> >       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011ff00
> >       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
> >       Physical Address : 0x40011ff00
> >
> > NBU BAR Error : Decoded info :
> >         Agent info : CPU
> >             Core ID : 21
> >             Thread ID : 1
> >         Requ: type : 4 : Write Back
> >  Node 0 NBU 1 Error report :
> >  NBU BAR Error
> >       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
> >       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011ff40
> >       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
> >       Physical Address : 0x40011ff40
> >
> > NBU BAR Error : Decoded info :
> >         Agent info : CPU
> >             Core ID : 21
> >             Thread ID : 1
> >         Requ: type : 4 : Write Back
> >  Node 0 NBU 2 Error report :
> >  NBU BAR Error
> >       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
> >       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011ff80
> >       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
> >       Physical Address : 0x40011ff80
> >
> > NBU BAR Error : Decoded info :
> >         Agent info : CPU
> >             Core ID : 21
> >             Thread ID : 1
> >         Requ: type : 4 : Write Back
> >  Node 0 NBU 3 Error report :
> >  NBU BAR Error
> >       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
> >       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011ffc0
> >       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
> >       Physical Address : 0x40011ffc0
> >
> > NBU BAR Error : Decoded info :
> >         Agent info : CPU
> >             Core ID : 21
> >             Thread ID : 1
> >         Requ: type : 4 : Write Back
> >  Node 0 NBU 4 Error report :
> >  NBU BAR Error
> >       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
> >       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fe00
> >       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
> >       Physical Address : 0x40011fe00
> >
> > NBU BAR Error : Decoded info :
> >         Agent info : CPU
> >             Core ID : 21
> >             Thread ID : 1
> >         Requ: type : 4 : Write Back
> >  Node 0 NBU 5 Error report :
> >  NBU BAR Error
> >       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
> >       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fe40
> >       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
> >       Physical Address : 0x40011fe40
> >
> > NBU BAR Error : Decoded info :
> >         Agent info : CPU
> >             Core ID : 21
> >             Thread ID : 1
> >         Requ: type : 4 : Write Back
> >  Node 0 NBU 6 Error report :
> >  NBU BAR Error
> >       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
> >       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fe80
> >       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
> >       Physical Address : 0x40011fe80
> >
> > NBU BAR Error : Decoded info :
> >         Agent info : CPU
> >             Core ID : 21
> >             Thread ID : 1
> >         Requ: type : 4 : Write Back
> >  Node 0 NBU 7 Error report :
> >  NBU BAR Error
> >       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
> >       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fee0
> >       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
> >       Physical Address : 0x40011fee0
> >
> > NBU BAR Error : Decoded info :
> >         Agent info : CPU
> >             Core ID : 21
> >             Thread ID : 1
> >         Requ: type : 4 : Write Back
> >  Node 0 NBU 8 Error report :
> >  NBU BAR Error
> >       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
> >       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fd30
> >       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
> >       Physical Address : 0x40011fd30
> >
> > NBU BAR Error : Decoded info :
> >         Agent info : CPU
> >             Core ID : 21
> >             Thread ID : 1
> >         Requ: type : 4 : Write Back
> >  Node 0 NBU 9 Error report :
> >  NBU BAR Error
> >       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
> >       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fd60
> >       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
> >       Physical Address : 0x40011fd60
> >
> > NBU BAR Error : Decoded info :
> >         Agent info : CPU
> >             Core ID : 21
> >             Thread ID : 1
> >         Requ: type : 4 : Write Back
> >  Node 0 NBU 10 Error report :
> >  NBU BAR Error
> >       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
> >       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fda0
> >       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
> >       Physical Address : 0x40011fda0
> >
> > NBU BAR Error : Decoded info :
> >         Agent info : CPU
> >             Core ID : 21
> >             Thread ID : 1
> >         Requ: type : 4 : Write Back
> >  Node 0 NBU 11 Error report :
> >  NBU BAR Error
> >       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
> >       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fdc0
> >       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
> >       Physical Address : 0x40011fdc0
> >
> > NBU BAR Error : Decoded info :
> >         Agent info : CPU
> >             Core ID : 21
> >             Thread ID : 1
> >         Requ: type : 4 : Write Back
> >  Node 0 NBU 12 Error report :
> >  NBU BAR Error
> >       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
> >       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fc00
> >       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
> >       Physical Address : 0x40011fc00
> >
> > NBU BAR Error : Decoded info :
> >         Agent info : CPU
> >             Core ID : 21
> >             Thread ID : 1
> >         Requ: type : 4 : Write Back
> >  Node 0 NBU 13 Error report :
> >  NBU BAR Error
> >       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
> >       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fc40
> >       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
> >       Physical Address : 0x40011fc40
> >
> > NBU BAR Error : Decoded info :
> >         Agent info : CPU
> >             Core ID : 21
> >             Thread ID : 1
> >         Requ: type : 4 : Write Back
> >  Node 0 NBU 14 Error report :
> >  NBU BAR Error
> >       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
> >       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fc80
> >       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
> >       Physical Address : 0x40011fc80
> >
> > NBU BAR Error : Decoded info :
> >         Agent info : CPU
> >             Core ID : 21
> >             Thread ID : 1
> >         Requ: type : 4 : Write Back
> >  Node 0 NBU 15 Error report :
> >  NBU BAR Error
> >       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
> >       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fcc0
> >       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
> >       Physical Address : 0x40011fcc0
> >
> > NBU BAR Error : Decoded info :
> >         Agent info : CPU
> >             Core ID : 21
> >             Thread ID : 1
> >         Requ: type : 4 : Write Back
> >
> > Current NBU DRAM BAR setting:
> > Node0 BAR0 Base 00004000 Limit 00007FFC chan_xlation 00004008 node_xlation 00000000
> > Node0 BAR1 Base 00080001 Limit 000FEFFC chan_xlation 0007C008 node_xlation 00000000
> > Node0 BAR2 Base 00880001 Limit 00FFCFFC chan_xlation 007FD008 node_xlation 00000000
> > Node0 BAR3 Base 00FFD001 Limit 00FFFFDF chan_xlation 00FFD000 node_xlation 00000000
> > Node0 BAR4 Base 08800001 Limit 08BFCFDF chan_xlation 087FD000 node_xlation 00000000
> > Node0 BAR5 Base 08BFD001 Limit 093FCFEE chan_xlation 08BFD008 node_xlation 00000002
> > Node0 BAR6 Base 093FD001 Limit 097FCFDF chan_xlation 093FD000 node_xlation 00000002
> > Node0 BAR7 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> > Node0 BAR8 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> > Node0 BAR9 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> > Node0 BAR10 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> > Node0 BAR11 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> > Node0 BAR12 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> > Node0 BAR13 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> > Node0 BAR14 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> > Node0 BAR15 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> > Node1 BAR0 Base 00004000 Limit 00007FFC chan_xlation 00004008 node_xlation 00000000
> > Node1 BAR1 Base 00080001 Limit 000FEFFC chan_xlation 0007C008 node_xlation 00000000
> > Node1 BAR2 Base 00880001 Limit 00FFCFFC chan_xlation 007FD008 node_xlation 00000000
> > Node1 BAR3 Base 00FFD001 Limit 00FFFFDF chan_xlation 00FFD000 node_xlation 00000000
> > Node1 BAR4 Base 08800001 Limit 08BFCFDF chan_xlation 087FD000 node_xlation 00000000
> > Node1 BAR5 Base 08BFD001 Limit 093FCFEE chan_xlation 08BFD008 node_xlation 00000002
> > Node1 BAR6 Base 093FD001 Limit 097FCFDF chan_xlation 093FD000 node_xlation 00000002
> > Node1 BAR7 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> > Node1 BAR8 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> > Node1 BAR9 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> > Node1 BAR10 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> > Node1 BAR11 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> > Node1 BAR12 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> > Node1 BAR13 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> > Node1 BAR14 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> > Node1 BAR15 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> >
> > 0.0.0:
> >   00: AF00177D
> >   04: 00100006
> >   08: 06000000
> >   0C: 00000010
> >   10: 00000000
> >   14: 00000000
> >   18: 00000000
> >   1C: 00000000
> >   20: 00000000
> >   24: 00000000
> >   28: 00000000
> >   2C: 0000177D
> >   30: 00000000
> >   34: 00000090
> >   38: 00000000
> >   3C: 00000000
> >
> > 0.1.0:
> >   00: AF84177D
> >   04: 00100000
> >   08: 06040000
> >   0C: 00010000
> >   10: 00000000
> >   14: 00000000
> >   18: 00010100
> >   1C: 00000000
> >   20: 0000FFF0
> >   24: 0001FFF1
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000048
> >   38: 00000000
> >   3C: 00000100
> >
> > 0.2.0:
> >   00: AF84177D
> >   04: 00100000
> >   08: 06040000
> >   0C: 00010000
> >   10: 00000000
> >   14: 00000000
> >   18: 00020200
> >   1C: 00000000
> >   20: 0000FFF0
> >   24: 0001FFF1
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000048
> >   38: 00000000
> >   3C: 00000100
> >
> > 0.3.0:
> >   00: AF84177D
> >   04: 00100000
> >   08: 06040000
> >   0C: 00010000
> >   10: 00000000
> >   14: 00000000
> >   18: 00030300
> >   1C: 00000000
> >   20: 0000FFF0
> >   24: 0001FFF1
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000048
> >   38: 00000000
> >   3C: 00000100
> >
> > 0.4.0:
> >   00: AF84177D
> >   04: 00100000
> >   08: 06040000
> >   0C: 00010000
> >   10: 00000000
> >   14: 00000000
> >   18: 00040400
> >   1C: 00000000
> >   20: 0000FFF0
> >   24: 0001FFF1
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000048
> >   38: 00000000
> >   3C: 00000100
> >
> > 0.5.0:
> >   00: AF84177D
> >   04: 00100000
> >   08: 06040000
> >   0C: 00010000
> >   10: 00000000
> >   14: 00000000
> >   18: 00050500
> >   1C: 00000000
> >   20: 0000FFF0
> >   24: 0001FFF1
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000048
> >   38: 00000000
> >   3C: 00000100
> >
> > 0.6.0:
> >   00: AF84177D
> >   04: 00100000
> >   08: 06040000
> >   0C: 00010000
> >   10: 00000000
> >   14: 00000000
> >   18: 00060600
> >   1C: 00000000
> >   20: 0000FFF0
> >   24: 0001FFF1
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000048
> >   38: 00000000
> >   3C: 00000100
> >
> > 0.7.0:
> >   00: AF84177D
> >   04: 00100000
> >   08: 06040000
> >   0C: 00010000
> >   10: 00000000
> >   14: 00000000
> >   18: 00070700
> >   1C: 00000000
> >   20: 0000FFF0
> >   24: 0001FFF1
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000048
> >   38: 00000000
> >   3C: 00000100
> >
> > 0.8.0:
> >   00: AF84177D
> >   04: 00100000
> >   08: 06040000
> >   0C: 00010000
> >   10: 00000000
> >   14: 00000000
> >   18: 00080800
> >   1C: 00000000
> >   20: 0000FFF0
> >   24: 0001FFF1
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000048
> >   38: 00000000
> >   3C: 00000100
> >
> > 0.9.0:
> >   00: AF84177D
> >   04: 00100000
> >   08: 06040000
> >   0C: 00010000
> >   10: 00000000
> >   14: 00000000
> >   18: 00090900
> >   1C: 00000000
> >   20: 0000FFF0
> >   24: 0001FFF1
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000048
> >   38: 00000000
> >   3C: 00000100
> >
> > 0.a.0:
> >   00: AF84177D
> >   04: 00100000
> >   08: 06040000
> >   0C: 00010000
> >   10: 00000000
> >   14: 00000000
> >   18: 000A0A00
> >   1C: 00000000
> >   20: 0000FFF0
> >   24: 0001FFF1
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000048
> >   38: 00000000
> >   3C: 00000100
> >
> > 0.b.0:
> >   00: AF84177D
> >   04: 00100106
> >   08: 06040000
> >   0C: 00010000
> >   10: 00000000
> >   14: 00000000
> >   18: 000C0B00
> >   1C: 20000000
> >   20: 43104300
> >   24: 03F10001
> >   28: 00000100
> >   2C: 00000100
> >   30: 00000000
> >   34: 00000048
> >   38: 00000000
> >   3C: 000201FF
> >
> > 0.c.0:
> >   00: AF84177D
> >   04: 00100000
> >   08: 06040000
> >   0C: 00010000
> >   10: 00000000
> >   14: 00000000
> >   18: 000D0D00
> >   1C: 00000000
> >   20: 0000FFF0
> >   24: 0001FFF1
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000048
> >   38: 00000000
> >   3C: 00000100
> >
> > 0.d.0:
> >   00: AF84177D
> >   04: 00100000
> >   08: 06040000
> >   0C: 00010000
> >   10: 00000000
> >   14: 00000000
> >   18: 000E0E00
> >   1C: 00000000
> >   20: 0000FFF0
> >   24: 0001FFF1
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000048
> >   38: 00000000
> >   3C: 00000100
> >
> > 0.e.0:
> >   00: AF84177D
> >   04: 00100106
> >   08: 06040000
> >   0C: 00010000
> >   10: 00000000
> >   14: 00000000
> >   18: 00100F00
> >   1C: 20000000
> >   20: 42F04000
> >   24: 0001FFF1
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000048
> >   38: 00000000
> >   3C: 000201FF
> >
> > 0.f.0:
> >   00: 902614E4
> >   04: 00100406
> >   08: 0C033000
> >   0C: 00800010
> >   10: 0400000C
> >   14: 00000100
> >   18: 0401000C
> >   1C: 00000100
> >   20: 00000000
> >   24: 00000000
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000080
> >   38: 00000000
> >   3C: 00000000
> >
> > 0.f.1:
> >   00: 902614E4
> >   04: 00100406
> >   08: 0C033000
> >   0C: 00800010
> >   10: 0402000C
> >   14: 00000100
> >   18: 0403000C
> >   1C: 00000100
> >   20: 00000000
> >   24: 00000000
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000080
> >   38: 00000000
> >   3C: 00000000
> >
> > 0.10.0:
> >   00: 902714E4
> >   04: 00100406
> >   08: 01060100
> >   0C: 00800010
> >   10: 00000000
> >   14: 00000000
> >   18: 0404000C
> >   1C: 00000100
> >   20: 00000000
> >   24: 43200000
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000080
> >   38: 00000000
> >   3C: 000000FF
> >
> > 0.10.1:
> >   00: 902714E4
> >   04: 00100406
> >   08: 01060100
> >   0C: 00800010
> >   10: 00000000
> >   14: 00000000
> >   18: 0405000C
> >   1C: 00000100
> >   20: 00000000
> >   24: 43210000
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000080
> >   38: 00000000
> >   3C: 000000FF
> >
> > b.0.0:
> >   00: 101515B3
> >   04: 00100506
> >   08: 02000000
> >   0C: 00800000
> >   10: 0000000C
> >   14: 00000100
> >   18: 00000000
> >   1C: 00000000
> >   20: 00000000
> >   24: 00000000
> >   28: 00000000
> >   2C: 028A1590
> >   30: FFF00000
> >   34: 00000060
> >   38: 00000000
> >   3C: 000001FF
> >
> > b.0.1:
> >   00: 101515B3
> >   04: 00100506
> >   08: 02000000
> >   0C: 00800000
> >   10: 0200000C
> >   14: 00000100
> >   18: 00000000
> >   1C: 00000000
> >   20: 00000000
> >   24: 00000000
> >   28: 00000000
> >   2C: 028A1590
> >   30: FFF00000
> >   34: 00000060
> >   38: 00000000
> >   3C: 000002FF
> >
> > f.0.0:
> >   00: 11501A03
> >   04: 00100107
> >   08: 06040004
> >   0C: 00010000
> >   10: 00000000
> >   14: 00000000
> >   18: 0010100F
> >   1C: 022001F1
> >   20: 42F04000
> >   24: 0001FFF1
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000050
> >   38: 00000000
> >   3C: 000201FF
> >
> > 10.0.0:
> >   00: 20001A03
> >   04: 02100102
> >   08: 03000041
> >   0C: 00000000
> >   10: 40000000
> >   14: 42000000
> >   18: 00000001
> >   1C: 00000000
> >   20: 00000000
> >   24: 00000000
> >   28: 00000000
> >   2C: 20001A03
> >   30: 00000000
> >   34: 00000040
> >   38: 00000000
> >   3C: 000001FF
> >
> > 80.0.0:
> >   00: AF00177D
> >   04: 00100002
> >   08: 06000000
> >   0C: 00000010
> >   10: 00000000
> >   14: 00000000
> >   18: 00000000
> >   1C: 00000000
> >   20: 00000000
> >   24: 00000000
> >   28: 00000000
> >   2C: 0000177D
> >   30: 00000000
> >   34: 00000090
> >   38: 00000000
> >   3C: 00000000
> >
> > 80.1.0:
> >   00: AF84177D
> >   04: 00100000
> >   08: 06040000
> >   0C: 00010000
> >   10: 00000000
> >   14: 00000000
> >   18: 00818180
> >   1C: 00000000
> >   20: 0000FFF0
> >   24: 0001FFF1
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000048
> >   38: 00000000
> >   3C: 00000100
> >
> > 80.9.0:
> >   00: AF84177D
> >   04: 00100000
> >   08: 06040000
> >   0C: 00010000
> >   10: 00000000
> >   14: 00000000
> >   18: 00828280
> >   1C: 00000000
> >   20: 0000FFF0
> >   24: 0001FFF1
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000048
> >   38: 00000000
> >   3C: 00000100
> >
> > 80.b.0:
> >   00: AF84177D
> >   04: 00100000
> >   08: 06040000
> >   0C: 00010000
> >   10: 00000000
> >   14: 00000000
> >   18: 00838380
> >   1C: 00000000
> >   20: 0000FFF0
> >   24: 0001FFF1
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000048
> >   38: 00000000
> >   3C: 00000100
> >
> > 80.f.0:
> >   00: 902614E4
> >   04: 00100406
> >   08: 0C033000
> >   0C: 00800010
> >   10: 0000000C
> >   14: 00000140
> >   18: 0001000C
> >   1C: 00000140
> >   20: 00000000
> >   24: 00000000
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000080
> >   38: 00000000
> >   3C: 00000000
> >
> > 80.f.1:
> >   00: 902614E4
> >   04: 00100406
> >   08: 0C033000
> >   0C: 00800010
> >   10: 0002000C
> >   14: 00000140
> >   18: 0003000C
> >   1C: 00000140
> >   20: 00000000
> >   24: 00000000
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000080
> >   38: 00000000
> >   3C: 00000000
> >
> > 80.10.0:
> >   00: 902714E4
> >   04: 00100406
> >   08: 01060100
> >   0C: 00800010
> >   10: 00000000
> >   14: 00000000
> >   18: 0004000C
> >   1C: 00000140
> >   20: 00000000
> >   24: 60000000
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000080
> >   38: 00000000
> >   3C: 000000FF
> >
> > 80.10.1:
> >   00: 902714E4
> >   04: 00100406
> >   08: 01060100
> >   0C: 00800010
> >   10: 00000000
> >   14: 00000000
> >   18: 0005000C
> >   1C: 00000140
> >   20: 00000000
> >   24: 60010000
> >   28: 00000000
> >   2C: 00000000
> >   30: 00000000
> >   34: 00000080
> >   38: 00000000
> >   3C: 000000FF
> > RAS CONTROLLER: SYSTEM HALTED...
