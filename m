Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0DDC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D08B2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V20kTE3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D08B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbeLJVD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:03:28 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46032 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729967AbeLJVDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:03:25 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so10931813ljd.12;
        Mon, 10 Dec 2018 13:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kFwbormve1kLp9/sKtUZdbXeHANzuSCuoiHk3tCVwJE=;
        b=V20kTE3K+Z1oSzC0h1qXSk7BxiMKSBAu4LVR/ygKpxCfi9bZNxLi8NE+6egZWmuW2j
         NuEj7mwEJWX/GkpC4aoyPHoemBnxHHk+RpeWofcGtN8WvSn1ukl+/i661homL611WlPt
         m+LrtFT36njBwNJ/mLqlz8kYW7DDRexnDZdRPB53XPRToEfA0n/92VVoR6Tbk9Hfp4U6
         gdNqjH8+1in4FmIP0iVGYo3qF1LvFdiWGabDjaspUgq9orkSaRJY4SvSWAYEh5SjY5Rk
         5LaVsJPAa+xs4nihY4led210DXlhUQM7tG/fM178UMfiTvQAArFwYx3hYReN3UBl+/85
         5FgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kFwbormve1kLp9/sKtUZdbXeHANzuSCuoiHk3tCVwJE=;
        b=hV59byY0UsjDfIpqrULHz+3+9mGNuguPkRnZB2c1qc+MJExmjlcNq7Mg8P0Y4SSLYq
         SSYKklpKFDpElYzZCyaLkNtwipaoQk5x3ZPi2Qy5Dmd/TdGJFbGN3rPyGekOFNep/mT/
         QjCTSrbbImUc2dKFawLt57OEHD6zqazRkvfMZUFe3j6l0SfUgCSBAljFLJlpa8u+sqpL
         f+agR7kntylU+E8kVf6B6+/BBSU32j2b6WP9vsN82RtpqebIBLQAK3xNNZtjDjL5n+zn
         gx0HrNzS7QF3XVGVESuwzptHywmhnbnWruZl/SHTHBPHqdJerwe0ELgfyk06G47Dr3pN
         H4+g==
X-Gm-Message-State: AA+aEWY21q4NkUJeQWzB44ZHKy1sQ76FyLGppLy3crrasusX40AH0h/6
        3qdZ/tH/otYxcDme3uVGip35Lg9l
X-Google-Smtp-Source: AFSGD/WdqT8MPFcubMsWSwT5pEdgYzDyMkSAWqL205Y2zDO2KSa6N2b+Cpx7O34i4kFAyWrvWi1vSg==
X-Received: by 2002:a2e:8187:: with SMTP id e7-v6mr8317049ljg.50.1544475802011;
        Mon, 10 Dec 2018 13:03:22 -0800 (PST)
Received: from [192.168.1.18] (cit97.neoplus.adsl.tpnet.pl. [83.31.43.97])
        by smtp.gmail.com with ESMTPSA id c133sm2451420lfc.45.2018.12.10.13.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 13:03:21 -0800 (PST)
Subject: Re: [PATCH v2 0/5] leds: trigger: Add pattern initialization from
 Device Tree
To:     Krzysztof Kozlowski <krzk@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544434201-14190-1-git-send-email-krzk@kernel.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <be526095-5af9-38bb-7c72-629a82d318e0@gmail.com>
Date:   Mon, 10 Dec 2018 22:03:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1544434201-14190-1-git-send-email-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the update.

On 12/10/18 10:29 AM, Krzysztof Kozlowski wrote:
> Hi,
> 
> I rebased on top of Jacek's patches and, as I could not find them on git kernel
> tree, I included them here. Also with small fixup.
> 
> Changes since v1:
> 1. Rebase on Jacek's patches.

Made following amendments to 2/5:

- removed extra empty line
- fixed language in the commit message as proposed by Pavel

> 2. Add patch 3/5 for fixup of Jacek's solution.
> 3. Drop first two patches from the series (applied).
> 4. Patch 5/5: Use LED_INIT_DEFAULT_TRIGGER (suggested by Jacek Anaszewski).
> 5. Patch 5/5: Return-on-error and log warning (suggested by Pavel Machek)
Applied to the for-next branch of linux-leds.git, thanks.

Pavel - I'm still awaiting your acks, just wanted to have
the patch set in linux-next quicker, taking into account that
merge window is imminent.

Best regards,
Jacek Anaszewski

> Jacek Anaszewski (2):
>    led: triggers: Break the for loop after default trigger is found
>    led: triggers: Add LED_INIT_DEFAULT_TRIGGER flag
> 
> Krzysztof Kozlowski (3):
>    led: triggers: Initialize LED_INIT_DEFAULT_TRIGGER if trigger is
>      brought after class
>    dt-bindings: leds: Add pattern initialization from Device Tree
>    leds: trigger: Add pattern initialization from Device Tree
> 
>   Documentation/devicetree/bindings/leds/common.txt |  7 +++++
>   drivers/leds/led-triggers.c                       | 10 +++++--
>   drivers/leds/trigger/ledtrig-pattern.c            | 32 +++++++++++++++++++++++
>   include/linux/leds.h                              |  1 +
>   4 files changed, 48 insertions(+), 2 deletions(-)
> 

