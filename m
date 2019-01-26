Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32BFC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA11218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="poIrwlbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfAZTcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 14:32:09 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:30276 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfAZTcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 14:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1548531124;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Uwkip8Wbya1rcLsLOp4PFx2RZVRL78FTKAYH2T5nrwY=;
        b=poIrwlbqOEhvI0HyD4mKQfn2uCIf8qSKgf0KxB19yppgol0+hYiW9GdjunrMzahSMb
        aH178+SgLpimBvri6U9y3zQXlK6PHeUTZJRo3b1xP3wbFGD8OugW2JbvTAxw1IAm/YPQ
        fHOyJio8HGkuimTXV2rsDOJKeHNiZwb/HbRVmPHblZYJEN8Zo7OJejBiaNcLKxk50LAQ
        +R65b+JfuBWyWnxJWxihiPClogJDvQFrrkH+LwP9fiC2bp+rkXQJsh5vGR+JOsVBfi0i
        69qAawe758sgS9BKBqU3oiemg4aX39QGjgbd7YPXJB5w4EqOYXP7vhbfAQ1ppoXpmAub
        NxXQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/zswDuotw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v0QJVqspE
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 26 Jan 2019 20:31:52 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/3] bus: ti-sysc: Fix timer handling with drop pm_runtime_irq_safe()
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190126194145.2b3484da@aktux>
Date:   Sat, 26 Jan 2019 20:31:51 +0100
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Transfer-Encoding: 7bit
Message-Id: <2369C6FA-32A2-4F29-9DFB-60D576AB867F@goldelico.com>
References: <20190122175717.13428-1-tony@atomide.com> <20190122175717.13428-3-tony@atomide.com> <20190126194145.2b3484da@aktux>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 26.01.2019 um 19:41 schrieb Andreas Kemnade <andreas@kemnade.info>:
> 
> On Tue, 22 Jan 2019 09:57:16 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
>> Commit 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
>> them with ti-sysc") started producing a warning for pwm-omap-dmtimer:
>> 
>> WARNING: CPU: 0 PID: 77 at drivers/bus/omap_l3_noc.c:147
>> l3_interrupt_handler+0x2f8/0x388
>> 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Idle):
>> Data Access in Supervisor mode during Functional access
>> ...
>> __pm_runtime_idle
>> omap_dm_timer_disable
>> pwm_omap_dmtimer_start
>> pwm_omap_dmtimer_enable
>> pwm_apply_state
>> pwm_vibrator_start
>> pwm_vibrator_play_work
>> 
>> This is because the timer that pwm-omap-dmtimer is using is now being
>> probed with ti-sysc interconnect target module instead of omap_device
>> and the ti-sysc quirk for SYSC_QUIRK_LEGACY_IDLE is not fully
>> compatible with what omap_device has been doing.
>> 
>> We could fix this by reverting the timer changes and have the timer
>> probe again with omap_device. Or we could add more quirk handling to
>> ti-sysc driver. But as these options don't work nicely as longer term
>> solutions, let's just make timers probe with ti-sysc without any
>> quirks.
>> 
>> To do this, all we need to do is remove quirks for timers for ti-sysc,
>> and drop the bogus pm_runtime_irq_safe() flag for timer-ti-dm.
>> 
>> We should not use pm_runtime_irq_safe() anyways for drivers as it will
>> take a permanent use count on the parent device blocking the parent
>> devices from idling and has been forcing ti-sysc driver to use a
>> quirk flag.
>> 
>> Note that we will move the timer data to DEBUG section later on in
>> clean-up patches.
>> 
> together with 1/3 it fixes things on pyra.
> 
> Tested-By: Andreas Kemnade <andreas@kemnade.info>

H. Nikolaus Schaller <hns@goldelico.com>
