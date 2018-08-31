Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F700C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3033320652
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3033320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeHaWyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:54:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53142 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeHaWyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:54:23 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=[192.168.0.145])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fvoQF-0002hL-SE; Fri, 31 Aug 2018 20:45:32 +0200
Date:   Fri, 31 Aug 2018 20:45:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matthew Rickard <matt@softrans.com.au>
cc:     Andy Lutomirski <luto@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] x86/vdso: Handle clock_gettime(CLOCK_TAI) in
 vDSO
In-Reply-To: <bcbd99e0-2e83-e220-18d1-4ec0cd474475@softrans.com.au>
Message-ID: <alpine.DEB.2.21.1808312044380.1349@nanos.tec.linutronix.de>
References: <20180817121251.4EB5318E01A1@virtux64.softrans.com.au> <CALCETrXY=PSdp6mpQ89yBQPsMrDj7j2p8AyLR1o4_+heiMzRbQ@mail.gmail.com> <bcbd99e0-2e83-e220-18d1-4ec0cd474475@softrans.com.au>
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

On Wed, 29 Aug 2018, Matthew Rickard wrote:

> Here are the before and after times with CONFIG_RETPOLINE=y always on.
> I don't see any regression, just the hoped-for improvement on glibc and
> vDSO calls of CLOCK_TAI.
> 
> Before:
>        sec Timestamp                   nanos clockname    tzname type
> ---------- --------------------------- ----- --------- --------- -------
> 1535445844 2018/08/28 08:44:04.338599419  96 CLOCK_REALTIME  UTC 0 glibc
> 1535445844 2018/08/28 08:44:04.348494684  87 CLOCK_REALTIME  UTC 1 vdso
> 1535445844 2018/08/28 08:44:04.357328913 321 CLOCK_REALTIME  UTC 2 sys
> 1535445834 2018/08/28 08:43:27.507099055 233 CLOCK_TAI right/UTC 0 glibc
> 1535445834 2018/08/28 08:43:27.530666383 239 CLOCK_TAI right/UTC 1 vdso
> 1535445834 2018/08/28 08:43:27.554827262 389 CLOCK_TAI right/UTC 2 sys
>         80 1970/01/01 00:01:20.593942210  88 CLOCK_MONOTONIC UTC 0 glibc
>         80 1970/01/01 00:01:20.602866312  84 CLOCK_MONOTONIC UTC 1 vdso
>         80 1970/01/01 00:01:20.611322392 272 CLOCK_MONOTONIC UTC 2 sys
>         80 1970/01/01 00:01:20.638630685 298 CLOCK_BOOTTIME  UTC 0 glibc
>         80 1970/01/01 00:01:20.668487920 293 CLOCK_BOOTTIME  UTC 1 vdso
>         80 1970/01/01 00:01:20.697818847 279 CLOCK_BOOTTIME  UTC 2 sys
> 
> After yours and my patches:
>        sec Timestamp                   nanos clockname    tzname type
> ---------- --------------------------- ----- --------- --------- -------
> 1535466985 2018/08/28 14:36:25.483377529  93 CLOCK_REALTIME  UTC 0 glibc
> 1535466985 2018/08/28 14:36:25.493020681  89 CLOCK_REALTIME  UTC 1 vdso
> 1535466985 2018/08/28 14:36:25.502139080 282 CLOCK_REALTIME  UTC 2 sys
> 1535466975 2018/08/28 14:35:48.530621935  87 CLOCK_TAI right/UTC 0 glibc
> 1535466975 2018/08/28 14:35:48.539393751  81 CLOCK_TAI right/UTC 1 vdso
> 1535466975 2018/08/28 14:35:48.547693183 276 CLOCK_TAI right/UTC 2 sys
>        224 1970/01/01 00:03:44.575542852  87 CLOCK_MONOTONIC UTC 0 glibc
>        224 1970/01/01 00:03:44.584329822  81 CLOCK_MONOTONIC UTC 1 vdso
>        224 1970/01/01 00:03:44.592473982 269 CLOCK_MONOTONIC UTC 2 sys
>        224 1970/01/01 00:03:44.619450784 296 CLOCK_BOOTTIME  UTC 0 glibc
>        224 1970/01/01 00:03:44.649224430 312 CLOCK_BOOTTIME  UTC 1 vdso
>        224 1970/01/01 00:03:44.680600544 297 CLOCK_BOOTTIME  UTC 2 sys

Can you please send a V3 with that information (condensed) in the
changelog?

Thanks,

	tglx
