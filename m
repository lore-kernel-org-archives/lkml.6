Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD318C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C272086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oeox6uhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C272086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeIKToE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:44:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36842 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbeIKToD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:44:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id j192-v6so1304857wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DQqJsCr4l/xzABMFYb+k/bCsW8gXM9jnVs5ZxkDB9mY=;
        b=Oeox6uhjVA6QNlzuys2cC92LlubvrSKwKxhxlu5BtK/gAhz4J2IecVnkSFRzhkYX0v
         A4Q5Hq3eEotgfcWpYii8Cz94IQlbx7gbGjz14Apuw/+CeM6j0ss3/bC4BZ8jR9IXQrUu
         Ew0ddG2xyoebmTdZhwB8s5vwRpZV1G7q5bRYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DQqJsCr4l/xzABMFYb+k/bCsW8gXM9jnVs5ZxkDB9mY=;
        b=HcksTUkZ5MV8tZIOrMrzfrvlhhkkP8xpCqSNHukvkpjGpDw3UW5mE61XnvPagI0mdp
         +JzGO4b0gOkTmtXTc4SbpN5qRCde1uK+amZpzjWu1aaiCYNlA5aIqln/RsKPdglD2xeJ
         4YGF8BUUEkpMk6QAgPfggzoaVkXyavtG8YYWOhtRmRNa88nOBtzxsnKP4XgQ/x5F77+R
         VxBRqmKpF6gDzNwI9trPqFH66fVltj3y/6ZDQMappFYvpb8oKTXCwvcIRU433UE9qcn5
         1OiylAi9jIXjDN8ZdxlWDTeow5GrFO0O/x5D2kaKrnI4s2B+B792dXaY8q9Y5HBw8r5O
         dLsg==
X-Gm-Message-State: APzg51BYZi7IIIqVOLnUQQYo3KITpePYNq02rtvwl3XYsQGWBG6DJ37m
        P9o1CavNro3QgNSE38TAufZ1bQ==
X-Google-Smtp-Source: ANB0VdbrJo7yH6Y4Pk9TRFNaWfL+UsKNv5NskNxdD35FA096ZnIlaAKPtJ8WoMZV5j6QrojXVihIkA==
X-Received: by 2002:a1c:4e16:: with SMTP id g22-v6mr1504036wmh.111.1536677065435;
        Tue, 11 Sep 2018 07:44:25 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id t9-v6sm41468366wra.91.2018.09.11.07.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 07:44:24 -0700 (PDT)
Date:   Tue, 11 Sep 2018 15:44:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2] mfd: max8997: Enale irq-wakeup unconditionally
Message-ID: <20180911144422.GW4185@dell>
References: <CGME20180905115422eucas1p2150fd04724ec667bd8798023a73f1127@eucas1p2.samsung.com>
 <20180905115407.10595-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180905115407.10595-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Sep 2018, Marek Szyprowski wrote:

> IRQ wake up support for MAX8997 driver was initially configured by
> respective property in pdata. However, after the driver conversion to
> device-tree, setting it was left as 'todo'. Nowadays most of other PMIC MFD
> drivers initialized from device-tree assume that they can be an irq wakeup
> source, so enable it also for MAX8997. This fixes support for wakeup from
> MAX8997 RTC alarm.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> changelog:
> v2:
> - removed pdata->wakeup entry as suggested by Krzysztof Kozlowski
> ---
>  drivers/mfd/max8997.c       | 8 +-------
>  include/linux/mfd/max8997.h | 1 -
>  2 files changed, 1 insertion(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
