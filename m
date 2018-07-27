Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625F6C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D243320891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VffsnhbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D243320891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbeG0IgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:36:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39754 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbeG0IgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:36:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so4339464wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 00:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LLGYLc5Ol/xnNAMHs4wYIO1iblMPl4LZoI50+ItSZw0=;
        b=VffsnhbFYoZXUE+b0e/uaV71TWM32hb7vkddlqWwx5DPjh1hGK797FvZvZayPGSmCb
         +UPzGoV33bAkJntWLifX8RFNgfZwPfvvvbKNQT3LMWHvPD0RPYd1Jvl/qjiIyUyi0faa
         796BHbLj25aSXAN5zqmCAEXb++AhBFcgjAu74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LLGYLc5Ol/xnNAMHs4wYIO1iblMPl4LZoI50+ItSZw0=;
        b=NTL9GjNE7RNBOGMWayqLIvupEdIQi2h8WA9/GUb+/iuc3vbUWeP9qke0R7arhTkD/j
         WMkjW8KoXphT/4lNU3PvoIr4RiuTGLss0BahaBlsI3p21GDOLsYnSt3Q4KEwD6RAGNM4
         puHDrUHDXRnoK1bzNRq6Ci1aIHij3wxF+xYZyIDtTsdnvRS8akWRDiYv6fSA7MNuIn35
         /CyRLjIKIT2zbzuY8ulpyWo7qXfPyI//zhaZokbsg66kb9PYD1FgXkqrQCOvIneGCMRS
         wpAHSN7G9drb7Cyj1du1FZsAdwrkhGIEC3J89sCtpw1mGycDJD7sHEYjNLO2S4lAqLCx
         I6Ew==
X-Gm-Message-State: AOUpUlEjnpgQ6nHf017f+9tsBudik+yNQCkZdv5+l+dsHdB6ZKSnnoCp
        G8+FLBw7ZJhMUeoF6lSO8o9KRw==
X-Google-Smtp-Source: AAOMgpehzU37ksTjEV7fWg7EitZ5/IrwerpNPzDj5LLpkid9OUGuVfNRZAswlnbOUuig+9J6/eGGuQ==
X-Received: by 2002:a1c:be13:: with SMTP id o19-v6mr3271758wmf.1.1532675747225;
        Fri, 27 Jul 2018 00:15:47 -0700 (PDT)
Received: from dell (host109-153-79-7.range109-153.btcentralplus.com. [109.153.79.7])
        by smtp.gmail.com with ESMTPSA id y14-v6sm6680170wrq.45.2018.07.27.00.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 00:15:46 -0700 (PDT)
Date:   Fri, 27 Jul 2018 08:15:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-tegra@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: as3722: disable auto power on when AC OK
Message-ID: <20180727071544.GD4628@dell>
References: <20180703150411.29709-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180703150411.29709-1-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jul 2018, Marcel Ziswiler wrote:

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> On ams AS3722, power on when AC OK is enabled by default.
> Making this option as disable by default and enable only
> when platform need this explicitly.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Reviewed-by: Bibek Basu <bbasu@nvidia.com>
> Tested-by: Bibek Basu <bbasu@nvidia.com>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - Document device tree property as suggested by Stefan.
> - Rename SEQ1 to SEQU1 as per datasheet as suggested by Stefan.
> - Drop reference to downstream commit as suggested by Lee.
> 
>  Documentation/devicetree/bindings/mfd/as3722.txt |  2 ++
>  drivers/mfd/as3722.c                             | 12 ++++++++++++
>  include/linux/mfd/as3722.h                       |  3 +++
>  3 files changed, 17 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
