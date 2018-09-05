Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229FBC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD05206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD05206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeIEVAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:00:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41243 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIEVAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:00:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id f38-v6so6572015edd.8;
        Wed, 05 Sep 2018 09:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VQLI4fYanzG+OtAnBzNAUK/nfYBOOTSwQlXCDcVd76c=;
        b=Xoq4jotfM2CdNHhNn8onEgyWUoVun4i4Ka0ZB3IDPuB9heTGph9fNky6jmpbfI+EVn
         Kf1h9k9kUJB7DgiJescGz2o+0mHMdi5D9MK/Qaoqh5AlQ7cDP/uKSY5RbryDO1jMi5PT
         +1RBaEmEL1PmcKSGApu1r5T1axHWB/Hpx8/sUmGh80dtHy9kU+APQjytWire4xFCwedn
         MDGi1HqAo1Opii4j1Sdf5StAswdUsBwzJW6gr3A16aiM/LoGBobQvPBaG0aGq3scwxw7
         zQ2VQ7gZVJqx/VvHkkbbMAZf87EpkqTIsyOsqGs7KYU0aEi4tXZUqPA6l0AJtcxe7+2y
         ZFNw==
X-Gm-Message-State: APzg51D4sIenOD1Bairja5Po7EPzpkAGmh3mvHUs0OqblltMcdRnb7Qn
        RkEyAxU2EvfKHSxb4CxX+KA=
X-Google-Smtp-Source: ANB0VdYlPttjK5+R9qir9fn5lfUiFO6D3TIve3hWOsaloSTkfvhzLFQOQtkDhOay7vDoFnQ8IMZRAg==
X-Received: by 2002:a50:9a02:: with SMTP id o2-v6mr43878260edb.236.1536164985149;
        Wed, 05 Sep 2018 09:29:45 -0700 (PDT)
Received: from kozik-lap (xdsl-188-155-58-14.adslplus.ch. [188.155.58.14])
        by smtp.googlemail.com with ESMTPSA id r44-v6sm3160697edd.87.2018.09.05.09.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 09:29:44 -0700 (PDT)
Date:   Wed, 5 Sep 2018 18:29:42 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2] mfd: max8997: Disable interrupt handling for
 suspend/resume cycle
Message-ID: <20180905162942.huedb7grtqvp3xpr@kozik-lap>
References: <CGME20180905143815eucas1p29cb4247cfef8180433d9b4627f5ff883@eucas1p2.samsung.com>
 <20180905143606.5916-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180905143606.5916-1-m.szyprowski@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 04:36:06PM +0200, Marek Szyprowski wrote:
> Disable IRQs during suspend/resume cycle to ensure handling of wakeup
> interrupts (i.e. RTC wake alarm) after max8997_resume(). This way it can
> be properly handled when I2C bus is finally available. This pattern is
> also used in other MAX PMIC MFD drivers.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> changelog:
> v2:
> - reordered the sequence of operation as suggested by Krzysztof Kozlowski
> ---
>  drivers/mfd/max8997.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

