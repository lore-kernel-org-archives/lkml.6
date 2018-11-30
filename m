Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6769C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B0B20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CP0PFPHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B0B20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbeLABys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:54:48 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37297 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeLABys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:54:48 -0500
Received: by mail-oi1-f194.google.com with SMTP id y23so4910947oia.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 06:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+Xz2i0f4yjctFsVxdGJgYXpJUnPK4IN7smwaPVnsCeE=;
        b=CP0PFPHV+sIBUxo/tUHa+fgrUk6l6txNRKBOybSM9o+keff4+kuCo4BpaUIexZ2Qrf
         CboxWtSNZxKjgaMT22dS/NX3PylvCsg+vxcDbuCFHO28wlV4tsE+6IymOuCzmbQp5Ep9
         phj5qA4n1DN5AmkshZi4mlHq4KgImqg1BAagA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+Xz2i0f4yjctFsVxdGJgYXpJUnPK4IN7smwaPVnsCeE=;
        b=cC9tFoWze0M4YcP07cHYg7tHK/uayrKO8jmdYolZfm+HSvtOIGzlpO4CzEvmEakM5L
         hLVrLRpKYyqvQw5nyUhLA8FTlLG4OOtXOunoYt56IFSW2gK8DSI9yupgI99/2sclxXHB
         n0m8h1kJExHnc7CCAQTlscbUaPGQlVWmcnT22mz9IP9mTFb/MO0HDHMVtG1qpoF8N5Pj
         A21gp4QEJ7+xBq9mJ8AIOyVfwL42SHt/Kkal/9fU06vlJWOxpx2a6PRk2hytIK9VFLsK
         zMhzGAC+BGW2qd66KMgCPSLLl3/e1LT03OmL/0et6R6Yd5OixZZnW9iG5CqS9oLQArkI
         Dy/Q==
X-Gm-Message-State: AA+aEWZ27IeJ+A286O3o/7RzMRbCYWTsQJkMa1D3aYluLDZY8pkn7Bqd
        xaIl5AXQer0qnjm4TYOLWSJO012SZTT7dhAdOzf4ng==
X-Google-Smtp-Source: AFSGD/UULX1jl9aq9vD0gtv/38NomqdoxhkUZslP3DU5zxHPDJ8GT6/SyyrfJohnQSK5zHt9xA2GeJOLPavH6gI4BDY=
X-Received: by 2002:aca:4282:: with SMTP id p124mr3337279oia.327.1543589114916;
 Fri, 30 Nov 2018 06:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
In-Reply-To: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 30 Nov 2018 15:45:03 +0100
Message-ID: <CA+M3ks5m1=gsGqB55T4xSGtAQW9Ct3Fxqx-gbYg=GoNwoX6B-w@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add support of STM32 hwspinlock
To:     Ohad Ben Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 14 nov. 2018 =C3=A0 10:00, Benjamin Gaignard
<benjamin.gaignard@linaro.org> a =C3=A9crit :
>
> This serie adds the support of the hardware semaphore block for stm32mp1 =
SoC.
>
> version 4:
> - add Linaro SoB

Gentle ping on this series

Regards,
Benjamin

>
> version 3:
> - fix clock name in properties description.
> - use postcore_initcall() instead of module_platform_driver()
>
> version 2:
> - fix comments done by Bjorn about clock naming, license terms in header,
>   alphabetic ordering in Makefile and Kconfig and remove function
> - Do not push test module in this version while waiting for feedbacks abo=
ut it
>
> Benjamin Gaignard (4):
>   dt-bindings: hwlock: Document STM32 hwspinlock bindings
>   hwspinlock: add STM32 hwspinlock device
>   ARM: dts: stm32: Add hwspinlock node for stm32mp157 SoC
>   ARM: dts: stm32: enable hwspinlock on stm32mp157c-ed1
>
>  .../bindings/hwlock/st,stm32-hwspinlock.txt        |  23 +++
>  arch/arm/boot/dts/stm32mp157c-ed1.dts              |   4 +
>  arch/arm/boot/dts/stm32mp157c.dtsi                 |   9 ++
>  drivers/hwspinlock/Kconfig                         |   9 ++
>  drivers/hwspinlock/Makefile                        |   1 +
>  drivers/hwspinlock/stm32_hwspinlock.c              | 156 +++++++++++++++=
++++++
>  6 files changed, 202 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hws=
pinlock.txt
>  create mode 100644 drivers/hwspinlock/stm32_hwspinlock.c
>
> --
> 2.15.0
>
