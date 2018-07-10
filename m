Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AA8C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D804208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E486ktNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D804208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933629AbeGJO6Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:58:25 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:44616 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933383AbeGJO6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:58:23 -0400
Received: by mail-wr1-f53.google.com with SMTP id r16-v6so14971664wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I6EIVdhVz6GeWnohGLQ/hSOl0BtOITXbwYjxUMUaY9U=;
        b=E486ktNeXqc2AA9kablSsyxiXB7gW7IPA0nJU3E+MD4ok5eY+jFa1bnlFzlAWf7PB2
         MVST0bdKTHf76zjAinegKNdSlYkWmFZhX8NEYPW1r2Yrhvno+MO/WGqiMltkNfer35xQ
         W+mUWDciVwvagHIgkGxPeZKJtrB8Zszf6DGbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I6EIVdhVz6GeWnohGLQ/hSOl0BtOITXbwYjxUMUaY9U=;
        b=WqaFKP64sNWH0iF0srTPDF0VO57enT34Sc+zqssiZRu7EHcVNM2If/UrUA4Nq3+CIF
         0i56VzyQ1bOwV9RWzSk/vpLz1wcUgOYKAmCcHksO6grxmbJ1OQWvkY+1/LBAkxBN1kwY
         VkchlYtP1dln3xL8mTEvFI9WJSgFEmJTscDJzHAWXGuIJWQU3InfCWRWFpgRaYs5WJdF
         869LuiyCQjy00SJK464dN/IKVipRMHq2mWwjoRHE11wERx421ozhM5lQcWQPME3yyUj9
         ylnaDUDUMLoEQKliXA4wh1Gbr80LpNbcNvF6Tmp7Hj9p/t9mTxwBCxtoik8dxbBqELO0
         E+Fw==
X-Gm-Message-State: AOUpUlFDZ9uRPuLYwo3VwBh45LIbcxMZTivhXsVoJMU3DEyCG3zaAaow
        HdN5yQtfyLgODqJX9snk+51FDw==
X-Google-Smtp-Source: AAOMgpdnaHskpoBkvXpZIayPX7uL8U5hifXu1TTPkz4crvOmYRGm+H1/DUow4F9mWnfA+iGn332iIQ==
X-Received: by 2002:adf:b243:: with SMTP id y3-v6mr10096822wra.90.1531234702536;
        Tue, 10 Jul 2018 07:58:22 -0700 (PDT)
Received: from [192.168.8.101] ([37.173.49.80])
        by smtp.googlemail.com with ESMTPSA id n8-v6sm20964930wrt.56.2018.07.10.07.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 07:58:21 -0700 (PDT)
Subject: Re: [PATCH v7 0/5] Reintroduce i.MX EPIT Timer
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Agner <stefan@agner.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?Q?Cl=c3=a9ment_Peron?= <clement.peron@devialet.com>
References: <20180611155001.3506-1-peron.clem@gmail.com>
 <CAJiuCcf3g2fzrR2_4mthjwKRcyZ8KVPX+EZ5_Uifh2E6TkzusQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5a7bab1d-52b5-ec9d-49ea-4acc3ad9ea00@linaro.org>
Date:   Tue, 10 Jul 2018 16:58:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJiuCcf3g2fzrR2_4mthjwKRcyZ8KVPX+EZ5_Uifh2E6TkzusQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2018 16:55, Clément Péron wrote:
> Hi,
> 
> Is there still some remark against merging this ?

Thanks for the heads up.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

