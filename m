Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE93C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DB2206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OQQVbhPR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SQXU5Rh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DB2206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbeIEBg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:36:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42828 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeIEBg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:36:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 89ACD607DC; Tue,  4 Sep 2018 21:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536095376;
        bh=SgGNFOpGhzFtXiu5QGsbnzKs61oyalGJerBcRWHku28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OQQVbhPRUXP6U8WvR+PyHzTeny8a6O45oNXb7vus6UyQVh0mPXbFcLGvM8ZL3JPk8
         wdsPRtF/+Zf5zorRmxKBE9C1Q262qT8b5P/Arp+I9AgUsOv7NBA83bv3POOdDIYvIK
         uExBXyAaTL3VyA3bI8iGVR2VmfEFv70EpBNBurYI=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9889060388;
        Tue,  4 Sep 2018 21:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536095375;
        bh=SgGNFOpGhzFtXiu5QGsbnzKs61oyalGJerBcRWHku28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQXU5Rh73Ff/AibkVwu8tQoUcfxOYnOdcylkuMgZ4Yt9GrNu9PvFk1S4iKFASl+Ip
         lTUeobXP8x8zkraLMpoAv5ZQ9QaCkaokT53bwtHOMNf4fvSDEutmk6wzEp71RpUqiE
         XKyZSYgJigZ8gIL7y1ADlGAIJuIrYxeCLfMAvdXk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9889060388
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 4 Sep 2018 15:09:34 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        linus.walleij@linaro.org, marc.zyngier@arm.com,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org
Subject: Re: [PATCH RESEND v1 2/5] drivers: pinctrl: msm: enable PDC
 interrupt only during suspend
Message-ID: <20180904210934.GA23990@codeaurora.org>
References: <20180817191026.32245-1-ilina@codeaurora.org>
 <20180817191026.32245-3-ilina@codeaurora.org>
 <153509896098.28926.3622217918056498792@swboyd.mtv.corp.google.com>
 <20180824171432.GM5081@codeaurora.org>
 <153540005334.129321.18196967002233663397@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <153540005334.129321.18196967002233663397@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27 2018 at 14:01 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-08-24 10:14:32)
>> On Fri, Aug 24 2018 at 02:22 -0600, Stephen Boyd wrote:
>> >Quoting Lina Iyer (2018-08-17 12:10:23)
>> >> During suspend the system may power down some of the system rails. As a
>> >> result, the TLMM hw block may not be operational anymore and wakeup
>> >> capable GPIOs will not be detected. The PDC however will be operational
>> >> and the GPIOs that are routed to the PDC as IRQs can wake the system up.
>> >>
>> >> To avoid being interrupted twice (for TLMM and once for PDC IRQ) when a
>> >> GPIO trips, use TLMM for active and switch to PDC for suspend. When
>> >> entering suspend, disable the TLMM wakeup interrupt and instead enable
>> >> the PDC IRQ and revert upon resume.
>> >
>> >What about idle paths? Don't we want to disable the TLMM interrupt and
>> >enable the PDC interrupt when the whole cluster goes idle so we get
>> >wakeup interrupts?
>> We would need to do this from the idle paths. When we have that support
>> (a patch for cluster power down is in the works), we would need to hook
>> up to TLMM and do the same.
>
>Ok so then this approach doesn't really seem to work for the CPU idle
>paths.
>
>> >Because of this complicated dance, it may make sense to always get the
>> >interrupt at the PDC and then replay it into the TLMM chip "manually"
>> >with the irq_set_irqchip_state() APIs. This way the duplicate interrupt
>> >can't happen. The only way for the interrupt handler to run would be by
>> >PDC poking the TLMM hardware to inject the irq into the status register.
>> If the PDC interrupt was always enabled and the interrupt at TLMM was
>> always disabled, all we would need to set the action handler of the PDC
>> interrupt to that of the TLMM. I couldn't find a way to retrieve that
>> nicely.
>
>Can't we just configure a different chained IRQ handler with
>irq_set_chained_handler_and_data() for each of the GPIO IRQs that are
>handled by PDC to be the interrupts provide by the PDC irq controller
>that match the GPIOs? And then set their parent irq with
>irq_set_parent() for completeness? And also move those GPIOs from the
>existing msm_gpio irqchip to a different PDC gpio irqchip that does
>nothing besides push irqchip calls up to the PDC irqchip? Then we don't
>even have to think about resending anything and we can rely on PDC to do
>all the interrupt sensing all the time but still provide the irqs from
>the GPIO controller.
>
Seems like the irqchips need to be in hierarchy for this to work, which
is not the case with TLMM and the PDC, currently.

-- Lina

