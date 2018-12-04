Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90541C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BFA2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ieGqtLJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BFA2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeLDJyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:54:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52192 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbeLDJyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:54:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id s14so8878865wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 01:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZTAJqDRp6LQ0GsMdutAAABs90ihZh20zfr1KVJjWnNY=;
        b=ieGqtLJTBW7W7g5OwY5vXESJXRtL0FgYW1Bf5eNR7l8x5EIV6ye/P2WneAUqZrdOMR
         8p8Rsd05h8ofxpyaUjioYJcsOf8sVRVUn0foDaOvj4teTiN+fyIk76f+Zc7mbyz38mLZ
         ekambhewGpcap/fyrwCltuYUI9/rFr335moNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZTAJqDRp6LQ0GsMdutAAABs90ihZh20zfr1KVJjWnNY=;
        b=r+ZqN7iRJ/aPiM+MiOsd0iQfR1z/JS4TLLM7oY3akiwLSN4z884RGuoqSTg4uupBIw
         Rd+c4UuWkwVNPMfSxbErxGAl7u6UGVGD9TnnqLQ/3T+TGUMTyfe3/kM/diB7I1RLyoBH
         kNx2CcJRxXqFGwoJ8fvdw0fh3voKAnXwVoQeNuidTt/O9HZ56wulaUKOYHjApxWmz0xh
         mZjOgXoQtIaOPAxVrnQM9tjIShLx0Fbp99NogdjWI2U8N1N09euU5SvXv9oQi+RcIEXD
         SHIT+oSSWr2o07Z+wtEJ0KZo2uAO5W3jPAe0GTxJCN+tLyMLRuPU5yDO1YfdBqe9brpL
         WQBQ==
X-Gm-Message-State: AA+aEWbn+47prhF41txZD63qAB8OhYaJD4QCHw2DjM1qpfez4r/uczzQ
        IWrRHcUimTHkqyYrm1bMB7uIDg==
X-Google-Smtp-Source: AFSGD/U8h3XEZ3ONUO8ajzUP3YMBpnRA4HNqS9Fpv5WrIQOtiLkrpXI6+le0AM/DzMSONZz2q8CmCQ==
X-Received: by 2002:a1c:b94b:: with SMTP id j72mr11613099wmf.11.1543917244139;
        Tue, 04 Dec 2018 01:54:04 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id o17sm5142766wmg.35.2018.12.04.01.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 01:54:03 -0800 (PST)
Date:   Tue, 4 Dec 2018 09:54:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ti-tsc-adc: Add new compatible for AM654
 SoCs
Message-ID: <20181204095401.GU26661@dell>
References: <20181119094509.22542-1-vigneshr@ti.com>
 <4b42082c-462d-3d94-8ee9-6e7a61f57134@ti.com>
 <20181204095233.GT26661@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181204095233.GT26661@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2018, Lee Jones wrote:
> On Tue, 04 Dec 2018, Vignesh R wrote:
> > On 19/11/18 3:15 PM, Vignesh R wrote:
> > > AM654 SoCs has ADC IP which is similar to AM335x. Add new compatible to
> > > handle AM654 SoCs. Also, it seems that existing compatible strings used
> > > in the kernel DTs were never documented. So, document them now.
> > > 
> > > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > > ---
> > 
> > Gentle ping on this patch..
> 
> Don't do that.
> 
> If you think your patch has been forgotten, please submit a [RESEND].

As an aside, the subject line is missing a subsystem, which might be
why it was missed by the subsystem maintainer.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
