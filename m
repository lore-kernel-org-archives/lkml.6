Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BD7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534DE20875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534DE20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966499AbeFSNEk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:04:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57052 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964999AbeFSNEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:04:38 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=nanos.guests.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVGJH-0005Mf-9Q; Tue, 19 Jun 2018 15:04:35 +0200
Date:   Tue, 19 Jun 2018 15:04:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
cc:     Stephen Hemminger <sthemmin@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, devel@linuxdriverproject.org
Subject: Re: [PATCH] x86/hyper-v: use cheaper HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,
 SPACE} hypercalls when possible
In-Reply-To: <87wouvkk5x.fsf@vitty.brq.redhat.com>
Message-ID: <alpine.DEB.2.21.1806191503560.10546@nanos.tec.linutronix.de>
References: <20180615163010.20381-1-vkuznets@redhat.com> <alpine.DEB.2.21.1806191403510.1684@nanos.tec.linutronix.de> <87wouvkk5x.fsf@vitty.brq.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018, Vitaly Kuznetsov wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> 
> > On Fri, 15 Jun 2018, Vitaly Kuznetsov wrote:
> >>   * Fills in gva_list starting from offset. Returns the number of items added.
> >> @@ -93,10 +95,19 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
> >>  	if (cpumask_equal(cpus, cpu_present_mask)) {
> >>  		flush->flags |= HV_FLUSH_ALL_PROCESSORS;
> >>  	} else {
> >> +		/*
> >> +		 * It is highly likely that VP ids are in ascending order
> >> +		 * matching Linux CPU ids; Check VP index for the highest CPU
> >> +		 * in the supplied set to see if EX hypercall is required.
> >> +		 * This is just a best guess but should work most of the time.
> >
> > TLB flushing based on 'best guess' and 'should work most of the time' is
> > not a brilliant approach.
> >
> 
> Oh no no no, that's not what I meant :-)
> 
> We have the following problem: from the supplied CPU set we need to
> figure out if we can get away with HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,
> SPACE} hypercalls which are cheaper or if we need to use more expensing
> HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST, SPACE}_EX ones. The dividing line is
> the highest VP_INDEX of the supplied CPU set: in case it is < 64 cheaper
> hypercalls are OK. Now how do we check that? In the patch I have the
> following approach:
> 1) Check VP number for the highest CPU in the supplied set. In case it
> is > 64 we for sure need more expensive hypercalls. This is the "guess"
> which works most of the time because Linux CPU ids usually match
> VP_INDEXes.
> 
> 2) In case the answer to the previous question was negative we start
> preparing input for the cheaper hypercall. However, if while walking the
> CPU set we meet a CPU with VP_INDEX higher than 64 we'll discard the
> prepared input and switch to the more expensive hypercall.
> 
> Said that the 'guess' here is just an optimization to avoid walking the
> whole CPU set when we find the required answer quickly by looking at the
> highest bit. This will help big systems with hundreds of CPUs.

Care to fix the comment to avoid the offending words?

Thanks,

	tglx
