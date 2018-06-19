Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195CEC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D160D20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D160D20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754276AbeFSWw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:52:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58495 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754142AbeFSWwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:52:06 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVPTW-0004qr-40; Wed, 20 Jun 2018 00:51:46 +0200
Date:   Wed, 20 Jun 2018 00:51:45 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
Subject: Re: [PATCH v10 7/7] x86/tsc: use tsc early
In-Reply-To: <20180615174204.30581-8-pasha.tatashin@oracle.com>
Message-ID: <alpine.DEB.2.21.1806200046130.10546@nanos.tec.linutronix.de>
References: <20180615174204.30581-1-pasha.tatashin@oracle.com> <20180615174204.30581-8-pasha.tatashin@oracle.com>
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

On Fri, 15 Jun 2018, Pavel Tatashin wrote:
> This patch adds early clock feature to x86 platforms.

See Documentation about 'This patch' .... We already know that this is a
patch otherwise it would not be marked as such ...

> +/*
> + * Finish clock for early time stamps, and hand over to permanent clock by
> + * setting __sched_clock_offset appropriately for continued time keeping.
> + */
> +static void __init tsc_early_fini(void)
> +{
> +	unsigned long long t;
> +	unsigned long r;
> +
> +	t = -cyc2ns_early.cyc2ns_offset;
> +	r = do_div(t, NSEC_PER_SEC);
> +
> +	__sched_clock_offset = sched_clock_early() - sched_clock();

As this is called _AFTER_ the TSC initialization which also includes
sanitizing of TSC_ADJUST, this can result in a complete bogus
__sched_clock_offset because sched_clock_early() will return nonsense when
TSC_ADJUST has been modified.

> +	pr_info("early sched clock is finished, offset [%lld.%09lds]\n", t, r);

That only gives useful information when the machine boots cold and when the
machine has a sane BIOS. So it's almost guaranteed to print useless
information.

Thanks,

	tglx
