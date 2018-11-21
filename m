Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB73FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942F7206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KFTC72gn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942F7206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389883AbeKVIMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 03:12:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40489 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbeKVIM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 03:12:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22-v6so7267859pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 13:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=JqudZ139m+VYodFfo+67+6ZHtqhfcKz0RRJF8Nrd0r8=;
        b=KFTC72gnlr6xMXqlQJAQs6HGZ0cQV6qyb49mh5yeVrr4yS2+fo03VPvuK9+sczKDTG
         Txgx+xkpdEN1uV54+xYHiViAG1YsA4SXXLwCNQ1pULY2KvlyoMybtRKWtcdpp6LlbX2p
         XRZbct7+vx8GiIsmwPCN8swvjGC8Kbyn+TZcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=JqudZ139m+VYodFfo+67+6ZHtqhfcKz0RRJF8Nrd0r8=;
        b=dNaBJZkHXQvCHAhfdu3fjk7p6d5NXhdaZ694oLJm78ZJvGfSmw8NjSnmw66aOm/klT
         rO4mpUxbiJ5ithpojiyarC5WfWt1EOYWOj7Kh3lnrHnqlcuQhuX/98dUEmL+vXmRxW0e
         Nz3Mssdsf+Gucps18uxJR2XFWLXt1cDls1OhnPo+mnUkFZIGwfQFdH7gz92kFGYar+bc
         VkwRwmgRE+o7X29mxOr4C+o5BDXBd6uVbSPFTK1S2HOXadZi04xpswgXu6/OjvBjCqdM
         cPFCkEsTW9GdA+w4JtyqtsStFDVMIK9xdI4tdZ0ICo10J+9Bdfhr34uDOrHMVYIrVzvU
         CAMQ==
X-Gm-Message-State: AGRZ1gJ06yuuosezhae1Q3xEk79/JoIVwgJFwlQG/HfMdvQ230/7BWU3
        4Mgd227HpDcEZmqwPnjWZFqTug==
X-Google-Smtp-Source: AJdET5fJd7kBLAu0hxO3LJx+5kB+P8KaQR1TyDeRm7LjQYxQPnBOyYeBQMsZDRSsTweiOaK5maga2Q==
X-Received: by 2002:a62:4641:: with SMTP id t62mr7813948pfa.141.1542836183443;
        Wed, 21 Nov 2018 13:36:23 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id j64-v6sm24709016pfc.43.2018.11.21.13.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 13:36:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lina Iyer <ilina@codeaurora.org>, evgreen@chromium.org,
        marc.zyngier@arm.com
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181121000648.29262-3-ilina@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        thierry.reding@gmail.com, Lina Iyer <ilina@codeaurora.org>
References: <20181121000648.29262-1-ilina@codeaurora.org>
 <20181121000648.29262-3-ilina@codeaurora.org>
Message-ID: <154283618199.88331.10217252750356423959@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC v3 2/3] dt-bindings: sdm845-pinctrl: add wakeup interrupt parent
 for GPIO
Date:   Wed, 21 Nov 2018 13:36:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-11-20 16:06:47)
> SDM845 SoC has an always-on interrupt controller (PDC) with select GPIO
> routed to the PDC as interrupts that can be used to wake the system up
> from deep low power modes and suspend.
> =

> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  | 31 ++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> =

> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctr=
l.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> index 665aadb5ea28..bedfa0b57fa6 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> @@ -29,6 +29,17 @@ SDM845 platform.
>         Definition: must be 2. Specifying the pin number and flags, as de=
fined
>                     in <dt-bindings/interrupt-controller/irq.h>
>  =

> +- wakeup-parent:
> +       Usage: optional
> +       Value type: <phandle>
> +       Definition: A phandle to the wakeup interrupt controller for the =
SoC.
> +
> +- wakeup-irq:

This shouldn't be needed. TLMM driver can probe for the possibility of
wakeup capable irqs from irq allocation step. The only place we should
need to know what TLMM pins map to what PDC lines is in the PDC driver.

