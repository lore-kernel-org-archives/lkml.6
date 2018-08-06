Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB215C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922A921A50
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922A921A50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbeHFQjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:39:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728723AbeHFQjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:39:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3189281663F1;
        Mon,  6 Aug 2018 14:30:17 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D49801049487;
        Mon,  6 Aug 2018 14:30:16 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w76EUGOx015286;
        Mon, 6 Aug 2018 10:30:16 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w76EUFkb015282;
        Mon, 6 Aug 2018 10:30:16 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 6 Aug 2018 10:30:15 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Pavel Machek <pavel@ucw.cz>
cc:     Andrew Pinski <pinskia@gmail.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        ard.biesheuvel@linaro.org,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Florian Weimer <fweimer@redhat.com>,
        thomas.petazzoni@free-electrons.com,
        GNU C Library <libc-alpha@sourceware.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <20180805215150.GB1862@amd>
Message-ID: <alpine.LRH.2.02.1808061003320.9697@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com> <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com> <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com> <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com> <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com> <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com> <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
 <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com> <20180805215150.GB1862@amd>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 06 Aug 2018 14:30:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 06 Aug 2018 14:30:17 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Aug 2018, Pavel Machek wrote:

> Hi!
> 
> > > Can you run the test program on x86 using the similar framebuffer
> > > setup?  Does doing two writes (one aligned and one unaligned but
> > > overlapping with previous one) cause the same issue?  I suspect it
> > > does, then using memcpy for frame buffers is wrong.
> 
> I'm pretty sure it will work ok on x86.
> 
> > Overlapping unaligned writes work on x86 - they have to, because of 
> > backward compatibility.
> 
> It is not that easy. 8086s (and similar) did not have MTRRs and PATs
> either. Overlapping unaligned writes _on main memory_, _with normal
> MTRR settings_ certainly work ok on x86.

It works even with write-combining. Write-combining specifies, that the 
writes may hit the framebuffer in unspecified order. But if the writes are 
overlapping, the CPU can't just reorder them and write the wrong result to 
the framebuffer.

> Chances is memory type can be configured to work similar way on your
> ARM/PCIe case?

ARM has memory types GRE, nGRE, nGnRE, nGnRnE - that allow or not allow 
gathering, reordering, early write acknowledgement. Unfortunatelly, all 
these memory types will trigger a fault on unaligned accesses.

It has also Non-Cached memory type (some people on this thread believe 
that it can't be used for GPUs, some believe that it can) - this memory 
type supports unaligned accesses, so it is actually used for framebuffers 
on ARM.

If we had a memory type that didn't do early write acknowledgement and 
supported unaligned accesses, it would solve this problem.

Mikulas
