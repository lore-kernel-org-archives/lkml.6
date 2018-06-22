Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0545BC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EE723C01
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EE723C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934157AbeFVBTc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:19:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933129AbeFVBTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:19:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D2A08AA0D;
        Fri, 22 Jun 2018 01:19:31 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7471E1C67D;
        Fri, 22 Jun 2018 01:19:27 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5M1JRST016859;
        Thu, 21 Jun 2018 21:19:27 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5M1JReS016855;
        Thu, 21 Jun 2018 21:19:27 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 21 Jun 2018 21:19:27 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Ingo Molnar <mingo@kernel.org>
cc:     Mike Snitzer <snitzer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] x86: optimize memcpy_flushcache
In-Reply-To: <20180621143140.GA14095@gmail.com>
Message-ID: <alpine.LRH.2.02.1806211224470.19940@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180519052503.325953342@debian.vm> <20180519052631.730455475@debian.vm> <CAPcyv4jpY0x7kZtT+afAKnHKy8Uy1AC_N_QM7RrELSj_0iNrRw@mail.gmail.com> <20180524182013.GA59755@redhat.com> <20180618132306.GA25431@redhat.com>
 <20180621143140.GA14095@gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 22 Jun 2018 01:19:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 22 Jun 2018 01:19:31 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Jun 2018, Ingo Molnar wrote:

> 
> * Mike Snitzer <snitzer@redhat.com> wrote:
> 
> > From: Mikulas Patocka <mpatocka@redhat.com>
> > Subject: [PATCH v2] x86: optimize memcpy_flushcache
> > 
> > In the context of constant short length stores to persistent memory,
> > memcpy_flushcache suffers from a 2% performance degradation compared to
> > explicitly using the "movnti" instruction.
> > 
> > Optimize 4, 8, and 16 byte memcpy_flushcache calls to explicitly use the
> > movnti instruction with inline assembler.
> 
> Linus requested asm optimizations to include actual benchmarks, so it would be 
> nice to describe how this was tested, on what hardware, and what the before/after 
> numbers are.
> 
> Thanks,
> 
> 	Ingo

It was tested on 4-core skylake machine with persistent memory being 
emulated using the memmap kernel option. The dm-writecache target used the 
emulated persistent memory as a cache and sata SSD as a backing device. 
The patch results in 2% improved throughput when writing data using dd.

I don't have access to the machine anymore.

Mikulas
