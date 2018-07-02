Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28036C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D874D21D62
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lFM66/yL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D874D21D62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932580AbeGBWfF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:35:05 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38188 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932134AbeGBWfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:35:02 -0400
Received: by mail-pg0-f67.google.com with SMTP id c9-v6so626pgf.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 15:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HeBeG/Xqg3Duyw82mH81hYPODDYgmMLvp1NhGLt5psY=;
        b=lFM66/yLh5qBcH3Zn5fhEb8LCBAXNZHIQsaewuZOUw0IVXUguYiQnqbw6h2k/+LOQH
         exrBxcAMbQww948aZ+swuZUtqbL0aOZY8uUbVEs9J/Jfnd/QmDgV7qNoxjDTHp9mOvlW
         VbRq4LPVk4yyVR+mZRI0ESBFfC0nnWgf8sY8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HeBeG/Xqg3Duyw82mH81hYPODDYgmMLvp1NhGLt5psY=;
        b=P62k2cgxsjDXuAM+CvKoKL2BRVTEnxzxlYnBR3lKcQnbanfc7Lk39BPo/sjT3tKnE0
         x2TRL+fOrO6cTYfYsNFSUW2ZEFuTZp/5Hpxjxy6E1tzP2iMn25WJt9DPO34AchM5GA6y
         F6tB/hquqeT4nKLoXhiD96YQbcZXjrIYlchgYNoya6AhxmBGvcPuf03THL8V0Rpeu5vD
         7e9JhVhvxowBwRfWPJkFDP6Dksi77j/PleZsAh2kroLRVMC71kkj8K0pvpOHguA9uhTw
         3FJt9US60zBD+d4nWHN2grE/Gq6Z/UxLaoLyM4sdl6q55tItCF/fCAv17+gU+NX9f9Iv
         PVSA==
X-Gm-Message-State: APt69E08T2oYOvuz3H5hjhuGeijdbN1tw1GYaAcO60fr6YTxY6KFSiSL
        j7yQt/8g5M69Q/7mrPRkKCQrPA==
X-Google-Smtp-Source: ADUXVKInemWke+6MJEAkR4uAciPH24Nh9HdGdEGGj7gKaqnLOgTH8QUIt6dkTItnOijegXYuEvBw3w==
X-Received: by 2002:a63:7c5c:: with SMTP id l28-v6mr23565146pgn.352.1530570901982;
        Mon, 02 Jul 2018 15:35:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id a23-v6sm25154541pfn.113.2018.07.02.15.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 15:35:01 -0700 (PDT)
Date:   Mon, 2 Jul 2018 15:35:00 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: pm8998: Add pm8998 thermal zone
Message-ID: <20180702223500.GB129942@google.com>
References: <20180702181005.18247-1-mka@chromium.org>
 <20180702181005.18247-2-mka@chromium.org>
 <CAD=FV=WH8q-3Rt89Get0N357+hWmKiEsruaKtWzo_JoE6gd_3g@mail.gmail.com>
 <20180702204611.GZ129942@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180702204611.GZ129942@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 01:46:11PM -0700, Matthias Kaehlcke wrote:
> On Mon, Jul 02, 2018 at 12:53:44PM -0700, Doug Anderson wrote:
> > Hi,
> > 
> > On Mon, Jul 2, 2018 at 11:10 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > > The thermal zone uses spmi-temp-alarm as sensor. If the sensor is
> > > configured without an IIO input it always reports 37°C for temperatures
> > > below the first hardware trip point at 105°C. This hardware trip point
> > > is configured as critical trip point, to initiate a system shutdown
> > > before the temperature reaches the next hardware trip point at 125°C,
> > > where the PMIC performs a partial shutdown.
> > >
> > > The temperature of the critical trip point can be raised after adding
> > > the die temperature ADC as IIO input for spmi-temp-alarm, which
> > > significantly increases the precision of the temperature measurements.
> > >
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > Changes in v2:
> > > - defined 'thermal-zones' node in pm8998.dtsi instead of using a label
> > >   to refer to it
> > > - use 105°C hardware trip point as critical trip point
> > 
> > I'm not sure this was right.  I guess you're trying to avoid
> > Temperature Stage 2?
> 
> Indeed
> 
> > From Davi'd email in response to v1:
> > 
> > > The PMIC TEMP_ALARM hardware peripheral will perform an automatic partial
> > > PMIC shutdown upon hitting over-temperature stage 2 (125 C).  This turns
> > > off peripherals within the PMIC that are expected to draw significant
> > > current.  The set of peripherals included varies between PMICs.  This
> > > partial shutdown will occur simultaneously with the triggering of an
> > > interrupt to the APPS processor that informs the qcom-spmi-temp-alarm
> > > driver that an over-temperature threshold has been crossed.
> > 
> > I think it's actually OK to use Temperature Stage 2 as the "critical"
> > point, which is why it still interrupts the CPU.  At "critical" the
> > system will shut down, right?  ...so presumably it's OK if the drivers
> > can't recover from having the power yanked out from underneath them as
> > long as they don't hang/crash the system in this case.  If I had to
> > guess the whole point of this stage is to give the system shutdown a
> > better chance of succeeding without getting to stage 3.
> 
> That was my starting point, however in my tests the system reset
> several times when the temperature got close to 125°C, not allowing
> for a proper shutdown. Apparently the partial shutdown of the PMIC can
> result in a full reset at least on some systems.

For the record: Linux does a proper shutdown when software override
for stage 2 is enabled (bit OVRD_ST2_EN in TEMP_ALARM_SHUTDOWN_CTL1).
