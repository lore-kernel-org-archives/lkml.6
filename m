Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DBDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC9D224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXrWIq0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC9D224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbeKMTDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:03:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52662 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731446AbeKMTDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:03:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id r11-v6so11043231wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 01:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jxYPneGrKfWUWxQimfs6bah5xf6x8JIqlgZ3if8iPP0=;
        b=HXrWIq0/gZepHYMltenN77NVQ2uNrFidbY4jVtF/WYuOF8j2ZbjTZIiWBhtONmsUWb
         g90WZawQ5r5asAINnclldWDxy+S4HP9T6wxH4hBkDvvwpOHVmoazdtfp/IkZZw0epZ9q
         UGqrII+nVUNPDh8BWra9lrE+BJeOEBPpBHVAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jxYPneGrKfWUWxQimfs6bah5xf6x8JIqlgZ3if8iPP0=;
        b=YDH4R53wL4hoMiIbHS2fTEDD6bTNLFTlU9ArWpiVeFDpgDlNQZKCcIMQbGAdsdszku
         dMpDuVsBaU5DRBr6AuZqdfeXwpLV0jXB9J86ej6bkSpEYI+KG/93E1/ZAGyyBL6CsEIo
         72uRH0k00ZXqFBeTqybr3z5BkoDnssdqLHdlRuBmEiMsCR9e0boCRNHcd/qb2WrbpgOd
         7SATNK7FYj5+vsqqSZ6oscJ22g2MI+KHYUv4ppGGBOM4DmDnd9lOQPMvof0Kg9Np7omt
         d/x9B3MBXqDBgoOHMGVLqy7zcXz7jmUmzp6Wi+NxmkXkHs5yIqj3mUutkEcNdMGxsOdN
         WcGQ==
X-Gm-Message-State: AGRZ1gJgiIeOLB52712hq+vJ5AwABz0kpvqDsz4bz4z0YCcdkkohP8WM
        DmIUGJYlmV/GyWnD9vLjx7ZO5rfH13I=
X-Google-Smtp-Source: AJdET5eq8wVpyK+y+nBJEa1hKcQ1rsy1Soi2pPiU/U7dIxXfI1eikRLHgQ9i9oB33xte0HM60nQ0tw==
X-Received: by 2002:a7b:c083:: with SMTP id r3-v6mr2485105wmh.101.1542099981508;
        Tue, 13 Nov 2018 01:06:21 -0800 (PST)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id 74-v6sm15546420wmn.42.2018.11.13.01.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 01:06:20 -0800 (PST)
Subject: Re: [PATCH 4/4] nvmem: meson-efuse: add peripheral clock
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181030102231.4851-1-jbrunet@baylibre.com>
 <20181030102231.4851-5-jbrunet@baylibre.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <256195a8-db8b-0945-090f-a63e5e665b15@linaro.org>
Date:   Tue, 13 Nov 2018 09:06:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181030102231.4851-5-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/10/18 10:22, Jerome Brunet wrote:
> Get and enable the peripheral clock required by the efuse device.
> The driver has been handle to work without it so far because the
> clock was left enabled by default but it won't be the case soon.
> 
> Signed-off-by: Jerome Brunet<jbrunet@baylibre.com>
> ---
>   drivers/nvmem/meson-efuse.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)

Applied, thanks,

--
Srini
