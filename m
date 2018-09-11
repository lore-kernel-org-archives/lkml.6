Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DBBC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD872086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YfEaGw0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD872086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeIKTxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:53:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39763 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbeIKTxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:53:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so1321824wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 07:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GiQbaQeoqx+Ry+UFFVW3XmMCVtHB2x128/+S3NRRiWM=;
        b=YfEaGw0xNowZ+xt2cGAqSsPrfmD7DcpqaAwIrMFBxodWGKeGei7duMSJ/PxVdsmIKa
         gxwx2V3xo7M3EKZ8dPytYBHqLGv3k8PlQJdVsnYCVOPMG3Jz8Ipze18M+oMy3ev7Rm86
         bDCnHxmISnFG4rsHCFkG6fDS2274uFzmi/db4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GiQbaQeoqx+Ry+UFFVW3XmMCVtHB2x128/+S3NRRiWM=;
        b=WnJnWMOQSd8qGrygA/c8TQJTzwelNT8sdPZ3nh/CtDxqxydpAlobcFcG6rvygOXGJM
         3fxTM0JErV8BapugtomT50T1km0XicVzdYhdu68cor5hSYXmr5drpz0NIhHHsz8Da+/E
         eTd0Gailx5L7dPbUJDlHI4Pl2JUks2piHU2jBTNbL/yo0M9KhiIS61WVXTeAw7v9JdGT
         AQkAfwshrPA1NOXD45Lj/21GBi4wsRLuM3+mGbMP6E+73Yj7XjVlxpmCH6kw2ypmy1o5
         bheCA5UCKummbXpswSbFLOdfzyp64SPWLYjb5KMoc8kFLAzLvEWTNw+Uf7SJdUtorW0/
         OS8Q==
X-Gm-Message-State: APzg51Cqv2U0WYe0iEwqFLsPBK9/cT6bwrvrdJ760Iov+4bh24oaQpA2
        b1ORMNC48mlGek6LZpR/kq3CSQ==
X-Google-Smtp-Source: ANB0Vdb6SwXuNt5VUImOFwx3WZBqygdDNxXGgUsiWhVzOEYAWDV6P4GLm/IUMs2Q3E7LvpbY2L9f4g==
X-Received: by 2002:a1c:ba84:: with SMTP id k126-v6mr1597185wmf.96.1536677612775;
        Tue, 11 Sep 2018 07:53:32 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id 185-v6sm1938382wmy.38.2018.09.11.07.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 07:53:31 -0700 (PDT)
Date:   Tue, 11 Sep 2018 15:53:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2] mfd: max8997: Disable interrupt handling for
 suspend/resume cycle
Message-ID: <20180911145330.GX4185@dell>
References: <CGME20180905143815eucas1p29cb4247cfef8180433d9b4627f5ff883@eucas1p2.samsung.com>
 <20180905143606.5916-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180905143606.5916-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Sep 2018, Marek Szyprowski wrote:

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

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
