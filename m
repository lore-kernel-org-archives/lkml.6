Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCD6C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B03220882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFUE0hw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B03220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbeLGHbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 02:31:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33102 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGHbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 02:31:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so676624wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 23:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=on5DWjAF9LpvkIPYgqixEFyxPhgmFwB2pHo8jQcHZvs=;
        b=EFUE0hw5rCdn+X1uMNNperYk+AfbN3qb0hNN8qIa2lYu/OU4DAIhrqK+8XT0uq16qo
         pEVXQUm5Zvl1o/Pb25udY6fbXs1Vp7ZSavQRXe8Ac1Y2JHC1ON+D3PBco9hXo4PIoqKu
         +8P0qBnErkaRJqvAC4EQWMFX8wuq0CBXmAFkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=on5DWjAF9LpvkIPYgqixEFyxPhgmFwB2pHo8jQcHZvs=;
        b=a3LFOKPyhSfyP58txnfG9JneNk0bbnOAUcMbsvC1RM5pd5oOWp6M/7CMywi0Be2age
         pfSouV6vURTkOSV4tJT5S7p0lCUYHW/cNVMP5oxdmA9l0TDsdcifeYktJ9hJ899b7TNx
         mHSw09t6hs4H07ihPYMBxX0BBdsGUn+wYSvv+B2fBz+0ZBDE6xhCb+P2qZ3yb8B6L9ht
         58gNL05T+1qPSH/aywP1KZ42XXjl01+RtQrk/UNLMFRxbpNlxsskycB+bZC3NW4SeqRk
         MHJCARMxqV+/dzE7p2tbH1G+yZvwdJ992qG9jF/VO9KbnFatWVKrC+fDTLweHDcb/lSo
         dl3Q==
X-Gm-Message-State: AA+aEWbH1wmtur78TDW1rrlAJU0io9cUGrTg8B2NrbSJJ4s6OSGIQmE7
        fGnfwZLQdd+OyrNkWkN+xz4xIQ==
X-Google-Smtp-Source: AFSGD/UabOKaU4UlD7KcdBOXR4qSmYDPsRNZIkjH6brYWCs9+XJjQlmZn7g+BPK0fh3GRaLw149M5A==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr1153721wmj.127.1544167895133;
        Thu, 06 Dec 2018 23:31:35 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id p74sm3713506wmd.29.2018.12.06.23.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 23:31:34 -0800 (PST)
Date:   Fri, 7 Dec 2018 07:31:32 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
Subject: Re: [PATCH v7 0/7] Introduce STPMIC1 PMIC Driver
Message-ID: <20181207073132.GH26661@dell>
References: <1543571742-17995-1-git-send-email-p.paillet@st.com>
 <20181203071145.GA26661@dell>
 <5C069C47.6080305@st.com>
 <20181205093604.GZ26661@dell>
 <5C07F08B.2010701@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5C07F08B.2010701@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Dec 2018, Pascal PAILLET-LME wrote:

> 
> pascal paillet (p.paillet@st.com) Le Mans / France
> Microcontrollers and Digital ICs Group | Application Development
> TEL: +33.(0)2.44.02.74.69 | TINA: 166 7469
> 
> Le 12/05/2018 10:36 AM, Lee Jones a écrit :
> > On Tue, 04 Dec 2018, Pascal PAILLET-LME wrote:
> >> Le 12/03/2018 08:11 AM, Lee Jones a écrit :
> >>> On Fri, 30 Nov 2018, Pascal PAILLET-LME wrote:
> >>>
> >>>> The goal of this patch-set is to propose a driver for the STPMIC1 PMIC from
> >>>> STMicroelectronics.
> >>>> The STPMIC1 regulators supply power to an application processor as well as
> >>>> to external system peripherals such as DDR, Flash memories and system
> >>>> devices. It also features onkey button input and an hardware watchdog.
> >>>> The STPMIC1 is controlled via I2C.
> >>>>
> >>>> Main driver is drivers/mfd/stpmic1 that handle I2C regmap configuration and
> >>>> irqchip. stpmic1_regulator, stpmic1_onkey and stpmic1_wdt need stpmic1 mfd
> >>>> as parent.
> >>>>
> >>>> STPMIC1 MFD and regulator drivers maybe mandatory at boot time.
> >>>>
> >>>> Pascal Paillet (7):
> >>>> changes in v7:
> >>>> * rebase on regul/for-next
> >>>>
> >>>>     dt-bindings: mfd: document stpmic1
> >>>>     mfd: stpmic1: add stpmic1 driver
> >>>>     dt-bindings: input: document stpmic1 pmic onkey
> >>>>     input: stpmic1: add stpmic1 onkey driver
> >>>>     dt-bindings: watchdog: document stpmic1 pmic watchdog
> >>>>     watchdog: stpmic1: add stpmic1 watchdog driver
> >>>>     regulator: stpmic1: fix regulator_lock usage
> >>>>
> >>>>    .../devicetree/bindings/input/st,stpmic1-onkey.txt |  28 +++
> >>>>    .../devicetree/bindings/mfd/st,stpmic1.txt         |  61 ++++++
> >>>>    .../bindings/watchdog/st,stpmic1-wdt.txt           |  11 ++
> >>>>    drivers/input/misc/Kconfig                         |  11 ++
> >>>>    drivers/input/misc/Makefile                        |   2 +
> >>>>    drivers/input/misc/stpmic1_onkey.c                 | 198 +++++++++++++++++++
> >>>>    drivers/mfd/Kconfig                                |  16 ++
> >>>>    drivers/mfd/Makefile                               |   1 +
> >>>>    drivers/mfd/stpmic1.c                              | 213 +++++++++++++++++++++
> >>>>    drivers/regulator/stpmic1_regulator.c              |   2 +-
> >>> Is it just Mark you're waiting on now?
> >> It is ok now, Mark has applied the patch.
> >> Evrey thing has been acked now. What is the nex step ?
> > Mark has applied patch 7?
> >
> > Why don't I see that?  Should you have removed it from this set?
> Hi Lee, I have received an email from Mark telliing that the regulator 
> patch is applied on
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git  
> 
> I can see it on the branch regul/for-next.

Mark,

Does your patch tracker only reply to the author?

Any reason why I don't see it?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
