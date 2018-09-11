Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408A6C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2E920866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYtcDXgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2E920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeIKUju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:39:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38366 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbeIKUju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:39:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so1486153wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CF5qbw9eZsnasOLCjjka9UXFyeunsSf0JZhEtSP86F8=;
        b=RYtcDXgmJ0/0OFhIz55LaJSZKGxcM7CCKEeAyHxRo+pOc1pkfEA7OuzUQ9kiqLuK78
         N2/OCRdqT3GsLof5HDkyhONwD31t6Fbh+ztlxjP/wEqOVSyZ3M4iTZy6SgH6gVdPbREl
         hTm/vRkRU1LON5ZFJc4uryhU5PwM/npK7VLNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CF5qbw9eZsnasOLCjjka9UXFyeunsSf0JZhEtSP86F8=;
        b=cRVBwKTanR3aOAW8aoueZlgdbVjWYLtm2YjJvfaKiLQjOCDtL4G4t0L0PfUr9dtm/x
         btfBIJEYqAI1luxa5OKX1MhxNUNrSuMo1+IOMGeKwrHO9KOeJfu1J/0ES6/q79exmTNb
         jdZIRMaHkC9UbVJRLe10yaYcVD4mkH6CChl/wJ+Kd0GAYfcJEuBBu9QrS8cA+IhGdyPY
         YNjHjvLFIJR3qsvUykbzII3k2wFOV/gO1z1QMXM8uTuhoEH9eVaGBrgGDyQzKu9/Xwfq
         TKP5NlZaJ6D9YkSpaHYoO+XQ3VeOefDPrMEECA1CuDw/mijnHK9e/jC+UEf80mLK3WAz
         HeOg==
X-Gm-Message-State: APzg51Ds6jIXlhfCy9Sbvo0HxirDHOWB8sdcpl/iyQLqCXuM6qg3b2yP
        0sNPasLLWQY2GoNUlol/uxkgFA==
X-Google-Smtp-Source: ANB0VdZgUAUhBzRQ214xxrwm70exGaou+Z/sMwh7SW+8uRZONiH1zT44CGmufZ09ndXgu3XmOKXQlg==
X-Received: by 2002:a1c:9cd3:: with SMTP id f202-v6mr1747289wme.148.1536680397246;
        Tue, 11 Sep 2018 08:39:57 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id s205-v6sm1773721wmf.42.2018.09.11.08.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 08:39:56 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:39:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] mfd: menelaus: fix possible race condition and leak
Message-ID: <20180911153954.GA4185@dell>
References: <20180909204858.4257-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180909204858.4257-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Sep 2018, Alexandre Belloni wrote:

> The IRQ work is added before the struct rtc is allocated and registered,
> but this struct is used in the IRQ handler. This may lead to a NULL pointer
> dereference.
> 
> Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
> before calling menelaus_add_irq_work.
> 
> Also, this solves a possible leak as the RTC is never released.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> 
> Lee,
> 
> If that is ok with you, I would like to take this patch through the RTC
> tree. So I can have a follow up patch removing rtc_device_register().
> 
> Thanks
> 
>  drivers/mfd/menelaus.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
