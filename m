Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B55DC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46C021A0F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46C021A0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbeHFOSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:18:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731180AbeHFOSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:18:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1657B818AAEB;
        Mon,  6 Aug 2018 12:09:52 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C962C101042B;
        Mon,  6 Aug 2018 12:09:51 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w76C9pYk022731;
        Mon, 6 Aug 2018 08:09:51 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w76C9oVn022722;
        Mon, 6 Aug 2018 08:09:50 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 6 Aug 2018 08:09:50 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
cc:     Florian Weimer <fweimer@redhat.com>,
        Andrew Pinski <pinskia@gmail.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAKv+Gu8HyHX8qjg1qHV2M9Re+RGQJigjdAFVC_yR4niGkk2ikA@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1808060700070.10220@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com> <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com> <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com> <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com> <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com> <fd2cae87-b2df-d8ef-8836-e6cbf8c5f851@redhat.com> <alpine.LRH.2.02.1808060325110.3756@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_y6La77sWOSROrwfRy65jrFVYVvRZt+ewNheYhdhHCkQ@mail.gmail.com> <alpine.LRH.2.02.1808060626060.2986@file01.intranet.prod.int.rdu2.redhat.com> <CAKv+Gu87YqLM=FFZ6V8rHhuhskDdsBUuXFpqNKVbXWqdnuNEyA@mail.gmail.com> <alpine.LRH.2.02.1808060639200.2986@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8HyHX8qjg1qHV2M9Re+RGQJigjdAFVC_yR4niGkk2ikA@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 06 Aug 2018 12:09:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 06 Aug 2018 12:09:52 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Aug 2018, Ard Biesheuvel wrote:

> >> Are we talking about a quirk for the Armada 8040 or about PCIe on ARM
> >> in general?
> >
> > I don't know - there are not any other easily available PCIe ARM boards
> > except for Armada 8040.
> 
> ... indeed, and sadly, the ones that are available all have this
> horrible Synopsys DesignWare PCIe IP that does not implement a true
> root complex at all, but is simply repurposed endpoint IP with some
> tweaks so it vaguely resembles a root complex.
> 
> But this is exactly why I am asking: I use a AMD Seattle Overdrive as
> my main Linux development system, and it runs the gnome-shell stack
> flawlessly (using the nouveau driver), as well as a UEFI framebuffer
> using efifb. So my suspicion is that this is either a Synopsys IP
> issue or an interconnect issue, and has nothing to do with the
> impedance mismatch between AMBA and PCIe.

If you run the program for testing memcpy on framebuffer that I posted in 
this thread - does it detect some corruption for you?


BTW. does the Radeon GPU driver work for you?

My observation is that OpenGL with Nouveau works, but it's slow and the 
whole system locks up when playing video in chromium.

Radeon HD 6350 (pre-GCN), doesn't lock up, but OpenGL (and Glamour) has 
many artifacts and corrupted textures. When I switch it to EXA 
acceleration and don't use OpenGL, it works.

The artifacts are not fixed by preloading a glibc with fixed memcpy, so 
there's supposedly some other bug somewhere.


Unfortunatelly, there's no low-power GCN card.

Mikulas
