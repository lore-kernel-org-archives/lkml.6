Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D83C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9C02175E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9C02175E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeHCOAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:00:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727291AbeHCOAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:00:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D001819701E;
        Fri,  3 Aug 2018 12:04:35 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8CB81CBBF;
        Fri,  3 Aug 2018 12:04:34 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w73C4Ygd014850;
        Fri, 3 Aug 2018 08:04:34 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w73C4WfT014841;
        Fri, 3 Aug 2018 08:04:33 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 3 Aug 2018 08:04:32 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     David Laight <David.Laight@ACULAB.COM>
cc:     "'Ard Biesheuvel'" <ard.biesheuvel@linaro.org>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Andrew Pinski <pinskia@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: RE: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <f696ebe8605840e3bb04bb78b60a6cfa@AcuMS.aculab.com>
Message-ID: <alpine.LRH.2.02.1808030759480.12341@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com> <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com> <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com> <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com> <f696ebe8605840e3bb04bb78b60a6cfa@AcuMS.aculab.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 03 Aug 2018 12:04:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 03 Aug 2018 12:04:35 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Aug 2018, David Laight wrote:

> From: Ard Biesheuvel
> > Sent: 03 August 2018 10:30
> ...
> > The discussion about whether memcpy() should rely on unaligned
> > accesses, and whether you should use it on device memory is orthogonal
> > to that, and not the heart of the matter IMO
> 
> Even on x86 using memcpy() on PCIe memory (maybe mmap()ed into userspace)
> isn't a good idea.
> In the kernel memcpy_to/fromio() ought to be a better choice but that
> is just an alternate name for memcpy().
> 
> The problem on x86 is that memcpy() is likely to be implemented as
> 'rep movsb' on modern cpu - relying on the cpu hardware to perform
> cache-line sized transfers (etc).
> Unfortunately on uncached locations it has to revert to byte copies.
> So PCIe transfers (especially reads) are very slow.
> 
> The transfers need to use the largest size register available.
> 
> 	David

On x86, the framebuffer is mapped as write-combining memory type, so "rep 
movsb" could merge the byte writes to larger chunks. I don't have a cpu 
with the ERMS feature - could anyone try it if rep movsb works worse or 
better than explicit writes to the framebuffer?

Mikulas
