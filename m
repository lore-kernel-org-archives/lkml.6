Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E065CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4F72086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6B2Tort"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4F72086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934847AbeFMIp5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:45:57 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51906 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933912AbeFMIpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:45:54 -0400
Received: by mail-it0-f65.google.com with SMTP id n7-v6so2742392itn.1;
        Wed, 13 Jun 2018 01:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ylEBp43G7QEyjoMWcAfnXF0/wURsCqiizdBs99EfrgE=;
        b=S6B2Tortb/yPFrFZ+g2SqfQGXDPfvucBBQ1qy9lKL7Shomko19AVNrafqTbCgTOwii
         2QqVNq0JVcjSJnY0c/UANUvUvok8fs70nzcwQzyHnPGoL9FGOdwMBuMcnU2wR3Ikx6zk
         Xl0PPhaarZlQVHT9/oFGpMOilv7h3nVxRTI4j/hk749oX7zYmdlhGPQ4dEnJM5u7MUqY
         HYQdvsxtw1EJ/QB2KTG9sXxVQeYRuKwmoi5Y1uQ/aK7tbXSpBTMn03K+1BCC+kfA0Ioj
         n4PwdnGICkt8T7zAX+aTXKdlRvsMtDGPBotiqXzCvuzSdNUfp2yd8N8r2c5LrEs13raz
         3ENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ylEBp43G7QEyjoMWcAfnXF0/wURsCqiizdBs99EfrgE=;
        b=JY68pN3Mk18z83NA8ZuBgGdIKlvUSAqNmUxfgDMw6pHoGY4b/e9M0MHVZQfwK2X+QJ
         A4NA/Cw2s5svI2HQUoCSo+9X/B4BlkyFyXpEyAMioPE/vmFG2c2QODd/+fjhVyNaVY6F
         NzeFfscjN7szkXPhbRKCx1lWd3sTdzgB+H1ccbf8BRgFATNLFtTEvoGJNX58zu0VT74g
         mg1QlRNjhwKw/iz0Z692hIWKNPzOvNEsYdq9s295zbmqBC0NR2ukAZYWdAJ/7WLMyCER
         rXBOM/wtzi3B5K/258ZoXoLWnqYtYPI30mmEXp8SzMhmu5p1MI1BzwBO7PKvKAO7JOZP
         /JYw==
X-Gm-Message-State: APt69E2YdOicMoCC6nMEFnvq1RL+OFCBGvsVcCoYkTUuIUDOnq6LiznC
        5ET0l55PINKih+iLt+Ep0TdIRymaIaO9398yrIs=
X-Google-Smtp-Source: ADUXVKK7+5gBgvO+rLPJey/r0pPTCFI0Ai7Ir2s1WzeTbzyD2WRGuiWSdGHG4A0Duycj67NG+8QElQGfNrxOpZJ7tT8=
X-Received: by 2002:a24:184d:: with SMTP id 74-v6mr3718319itr.127.1528879553989;
 Wed, 13 Jun 2018 01:45:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:4cb:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 01:45:53 -0700 (PDT)
In-Reply-To: <c4fafe97-fbf4-1037-394c-94c65fff3e21@linaro.org>
References: <20180612145516.30897-1-srinivas.kandagatla@linaro.org>
 <86d0ww7ymc.wl-marc.zyngier@arm.com> <c4fafe97-fbf4-1037-394c-94c65fff3e21@linaro.org>
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Wed, 13 Jun 2018 09:45:53 +0100
X-Google-Sender-Auth: iZe3YSqEz6PJhKYrMq8mxU7Dtpo
Message-ID: <CAPKp9uYQC+Pw+DgdTny317s3sNcyE=Shthvyrh7wn0r=Qy1tSQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3: do not access GICR_WAKER if its secured register.
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "Nayak, Rajendra" <rnayak@codeaurora.org>,
        bjorn.andersson@linaro.org, sboyd@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 9:21 AM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 12/06/18 17:34, Marc Zyngier wrote:
>>
>> I suggest you find out how the GIC has been integrated on this
>> platform. If you take a fault on accessing this register, this very
>> much looks like an integration bug, and it should be quirked as such.
>
> Thanks for the suggestion, This is a bug in the firmware which is
> restricting access to this register. We have been working around this bug
> for more than 2 years due to this. Now this platform support is in mainline
> and We/I have no hope that this will be fixed in near future atleast for
> this platform.
>

From what you are saying, you were aware of the firmware bug for 2 years as
you had work-around from then. I wish the firmware had come up with the fix
in those lost 2 years. I understand if it was discovered now, but that doesn't
seem to be the case here.

Firmware fixes are now becoming inevitable, so the attitude that firmware can't
be fixed has to slowing change. I am not saying I am against the quirk, but in
general I have seen the firmware support of QCOM parts are really bad. I waited
for almost 2 years for PSCI firmware on previous dragonboard where developer
are trying to upstream some feature.

--
Regards,
Sudeep
