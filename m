Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27C7C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7515025BFE
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7515025BFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934731AbeFYPEZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:04:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46790 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934531AbeFYPEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:04:24 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fXT2U-000242-QJ; Mon, 25 Jun 2018 17:04:22 +0200
Date:   Mon, 25 Jun 2018 17:04:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mukesh Ojha <mojha@codeaurora.org>
cc:     john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        neeraju@codeaurora.org, gkohli@codeaurora.org,
        cpandya@codeaurora.org
Subject: Re: [PATCH v2] time: Fix sleeptime injection for non-stop clocksource
 & persistent clock
In-Reply-To: <e869c2ec-90fa-27e2-975c-a92469f56dac@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1806251701410.1821@nanos.tec.linutronix.de>
References: <1527680699-16068-1-git-send-email-mojha@codeaurora.org> <alpine.DEB.2.21.1806222312340.1589@nanos.tec.linutronix.de> <e869c2ec-90fa-27e2-975c-a92469f56dac@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018, Mukesh Ojha wrote:
> On 6/23/2018 2:57 AM, Thomas Gleixner wrote:
> > @@ -1671,7 +1685,6 @@ void timekeeping_resume(void)
> >   	struct timespec64 ts_new, ts_delta;
> >   	u64 cycle_now;
> >   -	sleeptime_injected = false;
> >   	read_persistent_clock64(&ts_new);
> >     	clockevents_resume();
> > @@ -1743,6 +1756,8 @@ int timekeeping_suspend(void)
> >   	if (timekeeping_suspend_time.tv_sec ||
> > timekeeping_suspend_time.tv_nsec)
> >   		persistent_clock_exists = true;
> >   +	sleeptime_injected = false;
> 
> I did not get the exact valid point of moving it from `timekeeping_suspend` to
> `timekeeping_resume`.

It's the other way round. I move it from resume to suspend. Simply because
it should only be set to 'false' when suspend is reached. It would work the
other way round as well, but I felt it's inconsistent.

Thanks,

	tglx


