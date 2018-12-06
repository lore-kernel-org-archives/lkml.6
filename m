Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE65C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C053F2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DH68Crua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C053F2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbeLFBMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:12:45 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46988 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbeLFBMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:12:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so10871794pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 17:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xc1DcH3Ccdt7Hjtu4AOtF7sgap6z8qY7r0DkdlQf02Q=;
        b=DH68Crua34XImI/EB+WV3DPl0eNCgXN0ZmZih8+939mNhFjN5T4tATswlOwaUzPQM8
         SabJP3OrtEkWNgjSukwyG9YmU5FNhlFQ4JwjviSHt6tzYTQcwBvYoJ266S2VNFG5g+TV
         gBfhhVrRZr/VMWcukf+6QqTVvc49e8RQlwlec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xc1DcH3Ccdt7Hjtu4AOtF7sgap6z8qY7r0DkdlQf02Q=;
        b=XAUzJc79CC9cmM1epAgxoHo7UE4DMffYUG8lzgMALGruIXi2/PNdb9jHwMPYNofF1R
         tdc1MvlSwk7PKttSiiEJr8RZbtwVdyKOwI2VQEG0aNzIwANYFEVqrkJkIL9wlMVUSuzk
         FUtHH/tcSog9l0nJzB/CsO0sYEsLmalwjDuPwPmbDrUAgKGHrVB/wNaKYNSNEU0R1G3Y
         U1TX7+txz715pccF4OAbAlTHT9YdGhyQxO8AVzLIuCMJhxej6tozqqdZvLZ0VpNb7ldE
         2Fc+BkMc0WiqzyLOtZiJolhYSkLMseXorgKl3Plw/TBoKjVvjJK47kSZCAP1QQnO4CJx
         sxYw==
X-Gm-Message-State: AA+aEWYBi4pXFPDvOu+7Ix4FLX7s1Yh28uv1b+c4ZW9nqzj1WPvsXiUv
        8pW8yr5/m6E3EEWEZQ0XBMf5XQ==
X-Google-Smtp-Source: AFSGD/X2m+iq2XcJF7bJpbVAh0eAlCrOhLIhPbfYf6YHdOBGsADCjuvdN/1Ts8KWnuyE2uU5GfQROw==
X-Received: by 2002:a63:8ac4:: with SMTP id y187mr22552911pgd.446.1544058764302;
        Wed, 05 Dec 2018 17:12:44 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h10sm24859653pgn.11.2018.12.05.17.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 17:12:43 -0800 (PST)
Date:   Wed, 5 Dec 2018 17:10:45 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Ohad Ben Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v4 0/4] Add support of STM32 hwspinlock
Message-ID: <20181206011045.GA23336@builder>
References: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
 <CA+M3ks5m1=gsGqB55T4xSGtAQW9Ct3Fxqx-gbYg=GoNwoX6B-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+M3ks5m1=gsGqB55T4xSGtAQW9Ct3Fxqx-gbYg=GoNwoX6B-w@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30 Nov 06:45 PST 2018, Benjamin Gaignard wrote:

> Le mer. 14 nov. 2018 à 10:00, Benjamin Gaignard
> <benjamin.gaignard@linaro.org> a écrit :
> >
> > This serie adds the support of the hardware semaphore block for stm32mp1 SoC.
> >
> > version 4:
> > - add Linaro SoB
> 
> Gentle ping on this series
> 

Sorry about that Benjamin, I was convinced that I picked your patches
already. Applied first two patches to hwspinlock tree.

I expect the dts update to go through the ST tree, and I guess the
complaint from 0day tells us they already are?

Regards,
Bjorn
