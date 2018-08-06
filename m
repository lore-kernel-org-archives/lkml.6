Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CC1C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C31B21A05
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C31B21A05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeHFMeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:34:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727517AbeHFMeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:34:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 091ED40241C6;
        Mon,  6 Aug 2018 10:25:46 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3DC9104946B;
        Mon,  6 Aug 2018 10:25:45 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w76APj4i003136;
        Mon, 6 Aug 2018 06:25:45 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w76APi8s003132;
        Mon, 6 Aug 2018 06:25:44 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 6 Aug 2018 06:25:44 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
cc:     Matt Sealey <neko@bakuhatsu.net>,
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
In-Reply-To: <CAKv+Gu9_h-WFi1j4+DWUN_dMj75SKKHxWoDH8WQ9P7S7MNpZQg@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1808060553130.30832@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com> <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com> <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com> <20180803094129.GB17798@arm.com> <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com> <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com> <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com> <CAKv+Gu9_h-WFi1j4+DWUN_dMj75SKKHxWoDH8WQ9P7S7MNpZQg@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 06 Aug 2018 10:25:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 06 Aug 2018 10:25:46 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Aug 2018, Ard Biesheuvel wrote:

> On 3 August 2018 at 22:44, Matt Sealey <neko@bakuhatsu.net> wrote:
> > On 3 August 2018 at 13:25, Mikulas Patocka <mpatocka@redhat.com> wrote:
> >>
> >>
> >> On Fri, 3 Aug 2018, Ard Biesheuvel wrote:
> >>
> >>> Are we still talking about overlapping unaligned accesses here? Or do
> >>> you see other failures as well?
> >>
> >> Yes - it is caused by overlapping unaligned accesses inside memcpy. When I
> >> put "dmb sy" between the overlapping accesses in
> >> glibc/sysdeps/aarch64/memcpy.S, this program doesn't detect any memory
> >> corruption.
> >
> > It is a symptom of generating reorderable accesses inside memcpy. It's nothing
> > to do with alignment, per se (see below). A dmb sy just hides the symptoms.
> >
> > What we're talking about here - yes, Ard, within certain amounts of
> > reason - is that
> > you cannot use PCI BAR memory as 'Normal' - certainly never cacheable memory,
> > but Normal NC isn't good either. That is that your CPU cannot post
> > writes or reads
> > towards PCI memory spaces unless it is dealing with it as Device memory or very
> > strictly controlled use of Normal Non-Cacheable.
> >
> > I understand why the rest of the world likes to mark stuff as
> > 'writecombine,' but
> > that's x86-ism, not an Arm memory type.
> >
> > There is potential for accesses to the same slave from different
> > masters (or just
> > different AXI IDs, most cores rotate over 8 or 16 or so for Normal
> > memory to achieve)
> > to be reordered. PCIe has no idea what the source was, it will just
> > accept them in the order it receives them, and also it will be
> > strictly defined to
> > manage incoming AXI or ACE transactions (and barriers..) in a way that does
> > not violate the PCIe memory model - the worst case is deadlocks, the best case
> > is you see some very strange behavior.
> >
> > In any case the original ordering of two Normal-NC transactions may
> > not make it to
> > the PCIe bridge in the first place which is probably why a DMB
> > resolves it - it will
> > force the core to issue them in order and it's likely unless there is
> > some hyper-complex
> > multi-pathing going on, they'll stay ordered. If you MUST preserve the
> > order between
> > two Normal memory accesses, a barrier is required. The same is true also of any
> > re-orderable device access.
> >
> 
> None of this explains why some transactions fail to make it across
> entirely. The overlapping writes in question write the same data to
> the memory locations that are covered by both, and so the ordering in
> which the transactions are received should not affect the outcome.

You're right that the corruption couldn't be explained just by reordering 
writes. My hypothesis is that the PCIe controller tries to disambiguate 
the overlapping writes, but the disambiguation logic was not tested and it 
is buggy. If there's a barrier between the overlapping writes, the PCIe 
controller won't see any overlapping writes, so it won't trigger the 
faulty disambiguation logic and it works.

Could the ARM engineers look if there's some chicken bit in Cortex-A72 
that could insert barriers between non-cached writes automatically?



I observe these kinds of corruptions:
- failing to write a few bytes
- writing a few bytes that were written 16 bytes before
- writing a few bytes that were written 16 bytes after

Here is the example of corruptions (the first line is previous content of 
videoram, the second line is the content that should be present after a 
memcpy, and the third line is th real contents of videoram after memcpy).

Here it writes three bytes that were actually written by the memcpy 
function 16-bytes before:

p[020]  e3 e4 e5 e6  e7 e8 c8 bd  be bf c0 c1  c2 c3 c4 c5  c6 c7 c8 c9  ca cb cc cd  ce cf d0 d1  d2 d3 d4 d5
d[020]  97 98 99 9a  9b 9c 9d 9e  9f a0 a1 a2  a3 a4 a5 a6  a7 a8 a9 aa  ab ac ad ae  af b0 b1 b2  b3 d3 d4 d5
m[020]  97 98 99 9a  9b*8c*8d*8e* 9f a0 a1 a2  a3 a4 a5 a6  a7 a8 a9 aa  ab ac ad ae  af b0 b1 b2  b3 d3 d4 d5

Writes 4 bytes with a content that was written 16 bytes before:

p[020]  47 e2 e3 e4  e5 e6 e7 e8  e9 ea eb 52  53 54 55 56  57 58 59 5a  47 48 49 4a  4b 4c 4d 4e  4f 50 51 52
d[020]  47 e2 ec ed  ee ef f0 f1  f2 f3 f4 f5  f6 f7 f8 f9  fa fb fc fd  fe ff 00 01  02 03 04 05  06 07 08 09
m[020]  47 e2 ec ed  ee ef f0 f1  f2 f3 f4 f5  f6 f7 f8 f9  fa fb*ec*ed**ee*ef*00 01  02 03 04 05  06 07 08 09

Writes 2 bytes with a content that was written 16 bytes before:

p[0a0]  eb ec ed ee  ef f0 f1 f2  f3 f4 f5 f6  f7 f8 f9 fa  fb fc fd fe  ff 00 01 02  03 04 05 2f  30 31 32 33
d[0a0]  eb ec ed ee  ef f0 f1 f2  f3 f4 06 07  08 09 0a 0b  0c 0d 0e 0f  10 11 12 13  14 15 16 17  18 19 1a 1b
m[0a0]  eb ec ed ee  ef f0 f1 f2  f3 f4 06 07  08 09 0a 0b  0c 0d 0e 0f  10 11 12 13  14 15*06*07* 18 19 1a 1b

Writes 3 bytes with a content that was written 16 bytes after:

p[0a0]  0a 17 18 19  1a 1b 1c 1d  4a 4b 4c 4d  4e 4f 50 51  52 53 54 55  56 57 58 59  5a 5b 5c 5d  5e 5f 60 61
d[0a0]  0a 17 a9 aa  ab ac ad ae  af b0 b1 b2  b3 b4 b5 b6  b7 b8 b9 ba  bb bc bd be  bf c0 c1 c2  c3 c4 c5 c6
m[0a0]  0a 17 a9 aa  ab ac ad ae  af b0 b1 b2  b3 b4 b5 b6  b7 b8*c9*ca**cb*bc bd be  bf c0 c1 c2  c3 c4 c5 c6

Fails to write three bytes:

p[040]  0a 0b 0c 0d  0e 0f 10 11  12 13 14 15  16 17 18 19  1a 1b 1c 1d  1e 1f 20 21  22 23 24 25  26 27 28 29
d[040]  a0 a1 a2 a3  a4 a5 a6 a7  a8 a9 aa ab  ac ad ae af  b0 b1 b2 b3  b4 b5 b6 b7  b8 b9 ba bb  bc bd be bf
m[040]  a0 a1 a2 a3  a4 a5 a6 a7  a8 a9 aa ab  ac*17*18*19* b0 b1 b2 b3  b4 b5 b6 b7  b8 b9 ba bb  bc bd be bf

Fails to write one byte:

p[020]  25 26 27 28  29 2a 2b 2c  2d 2e 2f 30  31 32 28 29  2a 2b 2c 2d  2e 2f 30 31  32 33 34 35  36 37 38 39
d[020]  25 26 27 28  29 2a 2b 2c  2d 2e 2f 30  31 32 28 33  34 35 36 37  38 39 3a 3b  3c 3d 3e 3f  40 41 42 43
m[020]  25 26 27 28  29 2a 2b 2c  2d 2e 2f 30  31 32 28 33  34 35 36 37  38 39 3a 3b  3c 3d 3e 3f  40 41 42*39*

Fails to write 5 bytes:

p[020]  6e 6f 70 71  72 73 74 75  76 77 78 ca  cb cc cd ce  cf d0 d1 d2  d3 d4 d5 d6  d7 d8 d9 da  db dc dd de
d[020]  6e 6f 70 71  72 73 74 75  76 77 78 44  45 46 47 48  49 4a 4b 4c  4d 4e 4f 50  51 52 53 54  55 56 57 58
m[020]  6e 6f 70 71  72 73 74 75  76 77 78 44  45 46 47 48  49 4a 4b 4c  4d 4e 4f 50  51 52 53*da**db*dc*dd*de*


Mikulas
