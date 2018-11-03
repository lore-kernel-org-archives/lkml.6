Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B514DC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3672081F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3672081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeKCTPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:15:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60081 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeKCTPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:15:08 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gIsmp-00040N-6N; Sat, 03 Nov 2018 11:04:11 +0100
Date:   Sat, 3 Nov 2018 11:04:10 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Vacek <neelx@redhat.com>
cc:     x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tsc: make calibration refinement more robust
In-Reply-To: <CACjP9X-aZ4-6h7KkgZO6TtPCY4teiBTzVn-c11ULPwbPid8qWQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1811020922240.1642@nanos.tec.linutronix.de>
References: <1541085133-32534-1-git-send-email-neelx@redhat.com> <alpine.DEB.2.21.1811011630310.1642@nanos.tec.linutronix.de> <CACjP9X-aZ4-6h7KkgZO6TtPCY4teiBTzVn-c11ULPwbPid8qWQ@mail.gmail.com>
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

Daniel,

On Fri, 2 Nov 2018, Daniel Vacek wrote:
> On Thu, Nov 1, 2018 at 4:34 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> -#define MAX_RETRIES     5
> >> -#define SMI_TRESHOLD    50000
> >> +#define MAX_RETRIES  5
> >> +#define TSC_THRESHOLD        (tsc_khz >> 5)
> >
> > This breaks pit_hpet_ptimer_calibrate_cpu() because at that point tsc_hkz is 0.
> 
> That did not show up with my testing, sorry. I guess
> pit_calibrate_tsc() never failed for me. Hmm, actually it looks like
> quick_pit_calibrate() does the job for me so
> pit_hpet_ptimer_calibrate_cpu() is likely not even called.

Right. It's only called when quick calibration fails. Testing does not
replace code inspection :)

> Would this:
> 
> #define TSC_THRESHOLD   (tsc_khz? tsc_khz >> 5: 0x20000)
> 
> work for you instead? Or alternatively at some point when chasing this
> down I used:
> 
> #define TSC_THRESHOLD (0x10000 + (tsc_khz >> 6))
> 
> The first one seems better though. I can send v2 next week if you like it.

Can you please avoid hiding the logic in a macro? Just use a local
variable:

	u64 thresh = tsc_khz ? tsc_khz >> 5 : TSC_DEFAULT_THRESHOLD;

and use that in the comparison.

Thanks,

	tglx



