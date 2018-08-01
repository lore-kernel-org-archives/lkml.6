Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAE0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFBE20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BFBE20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388976AbeHAKrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:47:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33393 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388646AbeHAKrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:47:10 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkn0x-0002FG-W0; Wed, 01 Aug 2018 11:01:52 +0200
Date:   Wed, 1 Aug 2018 11:01:51 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH 4/7] x86/umwait_contro: Set global umwait maximum time
 limit and umwait C0.2 state
In-Reply-To: <28650265-964f-caeb-5ebb-788bf86ee9e3@kernel.org>
Message-ID: <alpine.DEB.2.21.1808011100460.2501@nanos.tec.linutronix.de>
References: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com> <1532350557-98388-5-git-send-email-fenghua.yu@intel.com> <28650265-964f-caeb-5ebb-788bf86ee9e3@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018, Andy Lutomirski wrote:
> On 07/23/2018 05:55 AM, Fenghua Yu wrote:
> > UMWAIT or TPAUSE called by user process makes processor to reside in
> > a light-weight power/performance optimized state (C0.1 state) or an
> > improved power/performance optimized state (C0.2 state).
> > 
> > IA32_UMWAIT_CONTROL MSR register allows OS to set global maximum umwait
> > time and disable C0.2 on the processor.
> > 
> > The maximum time value in IA32_UMWAIT_CONTROL[31-2] is set as zero which
> > means there is no global time limit for UMWAIT and TPAUSE instructions.
> > Each process sets its own umwait maximum time as the instructions operand.
> > We don't set a non-zero global umwait maximum time value to enforce user
> > wait timeout because we couldn't find any usage for it.
> 
> Do you know what the instruction designers had in mind?  I assume they were
> thinking of *something*, but I'm seriously mystified by three things:
> 
>  - Why does CF work the way it does?  It seems like it would be genuinely
> useful for CF to indicate whether the in-register timeout has expired, but
> that's not what CF does.

Right, it would be useful to see whether the timeout caused the exit or
something else.

Thanks,

	tglx
