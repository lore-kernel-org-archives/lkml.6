Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C84C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CDD20882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVNfEsNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CDD20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeLGH2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 02:28:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47097 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeLGH2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 02:28:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so2760747wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 23:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=srjPKbSPKggzrsNGf9ISRFoRZ63KrUzTnpJqPuUhlKU=;
        b=GVNfEsNMI0Q2Erb9Vbq9CVc3UkJyg3mKunhaxSonrrjFqk76xUxQCuxGow/ONdBdn/
         ASCmAhCf5mZJyG6XWFR0WUdM+fB7a3oDnN5BaDi7sEeUdyPiggT7a/JclicWVZunvXYK
         zTEDIHKd1o9p+G/isyjGEvjero0VNiQDkH2fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=srjPKbSPKggzrsNGf9ISRFoRZ63KrUzTnpJqPuUhlKU=;
        b=MgkRtcqFx11mwhJakAo6sSrRs8dSHj1wYjRIkYIUaoFlcKVXipC/+jdXKfKT7pc9BJ
         TEuM+yAPktnmhBqId34O37jV2LFAw6rRw+Ubxf7bfnOANXEkOzfMAiDz6mYXxNLxRY1L
         Onftf3FbBNzhM4AVfnG7JscmMryg6+kXh1FABfIne0BsJIZV6+QMzlSExQOKW54Of77i
         jjVBCPo4f6VRL9OGXId3cY9ilJK8iql0xhRFze5Pxqgmn7yZnyIT6gaeUDJIMRE8bHml
         kQlXUtmR7nuIBbp+XMBkjh/OyZOD68uAxNI+750rA1xjjkjV+4v/fEiCwiJxMx1hoqvx
         nQQg==
X-Gm-Message-State: AA+aEWYfMgRki5wE7mYwUTTLSg6dsYYk19qDpWL/NswtVIoNgXMzl29q
        A5xm4od5UqyaHsrSOzunNyZIbA==
X-Google-Smtp-Source: AFSGD/Vpp+3ayca6Et7r/FU71XkZexIumBc0GYA2adaeDSlFQaf4ChXH0NXIXXp/dGfPejFTKmkhPQ==
X-Received: by 2002:adf:83a7:: with SMTP id 36mr853777wre.13.1544167686296;
        Thu, 06 Dec 2018 23:28:06 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id e19sm5545816wrc.25.2018.12.06.23.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 23:28:05 -0800 (PST)
Date:   Fri, 7 Dec 2018 07:28:03 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, oskari@lemmela.net,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 0/8] AXP8x3 AC and battery power supply support
Message-ID: <20181207072803.GG26661@dell>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <CAGb2v65Bwve25jwdGHHK9j03RxQ3tKwme51762DjyQK2femG6g@mail.gmail.com>
 <20181205180042.fr5npvtwuvt2c6q3@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181205180042.fr5npvtwuvt2c6q3@earth.universe>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Dec 2018, Sebastian Reichel wrote:

> Hi,
> 
> On Fri, Nov 30, 2018 at 04:31:28PM +0800, Chen-Yu Tsai wrote:
> > On Wed, Nov 21, 2018 at 1:52 AM Oskari Lemmela <oskari@lemmela.net> wrote:
> > >
> > > AXP813 AC power supply support with input current and
> > > voltage limiting support.
> > >
> > > AXP803 AC and battery power supply support.
> > >
> > > Changes in v6:
> > > * Collected tags
> > > * Rebase to master
> > > * Dropped AXP803 compatible patches
> > >
> > > Changes in v5:
> > > * Return correct input current limit for values 0x6 and 0x7
> > > * Add specific compatibles for AXP803
> > > * Change commit messages
> > > * Add Vasily Khoruzhick Pinebook DTS patch
> > >
> > > Changes in v4:
> > > * Change order of axp20x-gpio in axp20x.c
> > > * Fix indentation and spaces to tabs in axp20x.c
> > >
> > > Changes in v3:
> > > * Reorder ac_power_supply DT node
> > > * Rename axp20x_ac_power_set_property function
> > > * Split mfd commit
> > >
> > > Changes in v2:
> > > * Reuse axp813 compatibles for axp803
> > > * Refactor axp20x_ac_power.c
> > >
> > >
> > > Oskari Lemmela (7):
> > >   dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
> > >   ARM: dts: axp81x: add AC power supply subnode
> > >   arm64: dts: allwinner: axp803: add AC and battery power supplies
> > >   arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
> > >   power: supply: add AC power supply driver for AXP813
> > >   mfd: axp20x: Add AC power supply cell for AXP813
> > >   mfd: axp20x: Add supported cells for AXP803
> > >
> > > Vasily Khoruzhick (1):
> > >   arm64: dts: allwinner: a64: pinebook: enable power supplies
> > 
> > Since this series has been fully reviewed, and the devices it
> > adds/enables aren't critical, i.e. won't cause the system to fail
> > if the drivers are missing, I've merged the dts patches for 4.21.
> > 
> > Hopefully Sebastian and Lee will get around to merging the driver
> > patches.
> 
> I queued the power-supply driver changes and prepared a signed
> immutable tag for Lee:
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/psy-mfd-axp813-immutable-for-v4.21-signed
> 
> for you to fetch changes up to 7693b5643fd2d682de90733b67fc8032b9646911:
> 
>   power: supply: add AC power supply driver for AXP813 (2018-12-05 18:49:32 +0100)
> 
> ----------------------------------------------------------------
> Immutable branch between mfd and power-supply for driver
> changes related to axp813.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> ----------------------------------------------------------------
> Oskari Lemmela (2):
>       dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
>       power: supply: add AC power supply driver for AXP813
> 
>  .../bindings/power/supply/axp20x_ac_power.txt      |  3 +
>  drivers/power/supply/axp20x_ac_power.c             | 94 ++++++++++++++++++++++
>  include/linux/mfd/axp20x.h                         |  1 +
>  3 files changed, 98 insertions(+)

What patches are left now?  Just 7 and 8?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
