Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA3AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1983720821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ae9Rv438"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1983720821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeJaQCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 12:02:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41393 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbeJaQCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 12:02:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id 23-v6so6917909pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 00:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=3jyZ13izQhVAKF5quP9WYMttRkn6iZPgb27lAx7LTpA=;
        b=ae9Rv438eSwYpoAyeZFpXyOG3u812yjKnMqnj4FuYxmbUxZlngDSFxSCB5kGMV6jho
         Auo4omYyEEYBDSNMsTP3Hkja3WPpilGNlXDoys1o7TEy7il0yNTUZwnyy3a7Eur6II4F
         4KLOTW1HopvQH2XkxUU3fKlzZ3SUmc5JfqEa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=3jyZ13izQhVAKF5quP9WYMttRkn6iZPgb27lAx7LTpA=;
        b=Oril9FDGCWsPvE9pgC40Rgwc35o3mbeDzQ12YC8zOvD3GdqTi9mVBPTTCQf13TgBOS
         uvn8n93OW9ZxXrG5Z+CGmbNud1C24ogDwqGtBIzfwTt/Sv8d30y7tKy5d7EtlPyuUune
         oBHlnWgQdsSFmzugEGdMtp+wgHx7K4ihw06hxzryf6mSwuUh03xHxaF3BS9HJUWBrx7y
         1COqVgOqrGPbf1uwJhfyZj8x4IA9paIhd6EGv1yK/V+kA0sUmSp+egkymFp69Ji3+kY5
         Fpd/eDocwZ5qdnGTaygBEaCZtPGCmf7YfoWeuYOXlZUyS5yS5E0xBhmqByWuxfNIR9lC
         AFHA==
X-Gm-Message-State: AGRZ1gJegn9Ya2qR0+iTf4MKP+QnROhPKS5vQGTShgoWyVEESx5Kb8tW
        NiLb31yQH0FWDeItJQ9S45Id3g==
X-Google-Smtp-Source: AJdET5e8MefJpabYnqKW+P44eAcC/VNeEthlQHcOnneF7X2SZF31zFjRZOMJD5ls0ndy/G7gyIEGqA==
X-Received: by 2002:a63:2ad4:: with SMTP id q203-v6mr1939050pgq.356.1540969544877;
        Wed, 31 Oct 2018 00:05:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id p62-v6sm42143192pfp.111.2018.10.31.00.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 00:05:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lina Iyer <ilina@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181011002958.2597-2-ilina@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, evgreen@chromium.org,
        marc.zyngier@arm.com
References: <20181011002958.2597-1-ilina@codeaurora.org>
 <20181011002958.2597-2-ilina@codeaurora.org>
Message-ID: <154096954339.98144.12348474096990107321@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH RFC 1/1] drivers: pinctrl: qcom: add wakeup capability to GPIO
Date:   Wed, 31 Oct 2018 00:05:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lina,

Quoting Lina Iyer (2018-10-10 17:29:58)
> QCOM SoC's that have Power Domain Controller (PDC) chip in the always-on
> domain can wakeup the SoC, when interrupts and GPIOs are routed to its
> interrupt controller. Only select GPIOs that are deemed wakeup capable
> are routed to specific PDC pins. During low power state, the pinmux
> interrupt controller may be non-functional but the PDC would be. The PDC
> can detect the wakeup GPIO is triggered and bring the TLMM to an
> operational state.
> =

> Interrupts that are level triggered will be detected at the TLMM when
> the controller becomes operational. Edge interrupts however need to be
> replayed again.
> =

> Request the corresponding PDC IRQ, when the GPIO is requested as an IRQ,
> but keep it disabled. During suspend, we can enable the PDC IRQ instead
> of the GPIO IRQ, which may or not be detected.
> =

> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---

I spoke with Marc about this at ELCE last week and I think we came up
with a plan for how to make this all work while keeping the TLMM driver
largely unaware of what's happening. One important point that we need to
keep in mind is that we don't want the interrupt to appear twice at the
GIC for the same TLMM irq, once in TLMM and once in PDC. That situation
would be quite bad and confuse things.

So the plan is as follows:

 1) Split PDC irqdomain into two domains. One for GIC interrupts and one
    for TLMM interrupts

 2) Support hierarchical irq domains in the TLMM driver and/or gpiolib

 3) Stack the irq controllers into a hierarchy so that GIC is the parent
    of PDC and PDC is the parent of TLMM while also leaving the TLMM
    summary IRQ chained directly from the GIC irqdomain

 4) Mask a TLMM irq in the TLMM driver and unmask the PDC irq in the PDC
    driver when an irq_set_wake() call is made on a TLMM gpio irq that
    PDC can monitor (and vice versa)

 5) Have the PDC driver be the only driver that knows if a TLMM pin is
    wakeup capable or not expressed in some DT table

Implementing #4 will require changing TLMM irqchip to call
irq_chip_set_wake_parent() for the .irq_set_wake op and then checking
the return value to figure out if PDC is monitoring the pin or not and
doing the mask/unmask dance. Furthermore, implementing #2 will be a bit
of work that Thierry has already started for Nvidia Tegra pinctrl
drivers.

The important part of #4 is that the irq can only happen in TLMM or in
PDC, and not in both places because of how we mask and unmask in
different drivers. The TLMM summary irq line can't be triggered when the
PDC is monitoring the line.

This also limits the usage of PDC to pins that are really waking up the
system from some sort of sleep mode. Either the device driver is trying
to wakeup from suspend so it's setting irq wake in the driver suspend
path, or it's runtime suspending a device and wanting to wakeup from
that device suspend state so it's again setting irq wake in runtime
suspend. Either way, in "normal" active modes the irq path will be
through the TLMM summary irq line and not through PDC. I don't know if
a similar design would work for pre-PDC qcom hardware where the MPM is
handled by RPM software.

And finally, thinking about this after writing this mail I'm a little
concerned that doing any sort of mask/unmask or irq movement from TLMM
to PDC at runtime will miss edges for edge triggered interrupts. Is that
also your concern? How is this handled with MPM? We would leave the TLMM
interrupt enabled in that case and then have to replay the edge in
software when resuming from suspend or idle paths but otherwise ignore
the level type interrupts that MPM sees? I suppose MPM never gets an
edge if TLMM gets the edge so this just works.

I'm worried that when we're moving the gpio irq line from the summary
GIC SPI line to the PDC's GIC SPI line we'll get an edge and then miss
it in TLMM and be too late unmasking it in PDC or worse see it in PDC
and TLMM because we unmask in PDC before masking in TLMM. So we may need
to change #4 up above to always allocate the irq from PDC and somehow
communicate that the irq is wakeup capable in PDC back to the TLMM
driver so TLMM knows to keep the irq masked in the hardware forever.
That way it can't cause the summary irq line to trigger in addition to
the PDC one. Given that we have allocation hooks with domain hierarchy
it may be easy enough to remove TLMM irqs from the summary irq domain
when they can be allocated from the parent PDC domain.

