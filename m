Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D118BC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BE82077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XX9IWH8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BE82077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeJIRqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:46:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40819 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeJIRqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:46:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id d2-v6so1219355wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 03:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=S5lZF5oI6oR0WKAKtPqdNCvf5iAqMKTgJ0i0i+oPMsU=;
        b=XX9IWH8aGUPivEVCnzfF0AWzTvTPN5XJ655nr3DQ7MojRBW6m+LB/sQxOYJGcisvgA
         cgrwLRfc0rEYtJXhAsU8Tt84bkJFHXdWjdEyMzwwsLrNk55umagiVrOjl3v5rSwYOl3y
         o1SsfZ8wJLOXAu8oxaGAWWoB4tHhQVIEPvh7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=S5lZF5oI6oR0WKAKtPqdNCvf5iAqMKTgJ0i0i+oPMsU=;
        b=TqvpR3KrvubJzrVPZIGmG03rCV8Cj+KWXxzvGpOSrywKUPgSG+IRBtlSL0tvFMXEB2
         oQAaIrAatTWn1I8zBjCVQHl4FinvhOn4KUaXsPWPuKbfCTpwH2gB9gHU12taXgIsyEbW
         QBeskE2DYnDd6Pae62K7clt1NWKto7FnTb79xTe6t0t3p3P2nWr6uncp2/fx5QGX60b0
         lY5X41s1RauTKHJp648fOpTW+jSWrOyv5FH858Pic/uBeBWNJ6RvBPiGwLJ/B2doWKHI
         E0R08zkMNmhwEQPQ6fK5QxnZPHexodKgWlDZr74BgP1ZEFaylf3cfv6+Yh5Icuo3gwKm
         cydA==
X-Gm-Message-State: ABuFfogN2f3kkz8EB15vlz5mVygIqSMsRUHzuO9DQaDxD/vPcZYbj79a
        8vLI0RyedGHawnABMSXMZiVymA==
X-Google-Smtp-Source: ACcGV60YVAgGdTqPhPrJ68Gz4gHZvZdwl7Sc1iS2P/Z/sizVVVY5EvKHl9yqCvcwq8vM3W/Lc2jvSw==
X-Received: by 2002:adf:e48e:: with SMTP id i14-v6mr19625137wrm.145.1539081030010;
        Tue, 09 Oct 2018 03:30:30 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id 90-v6sm25093049wrg.86.2018.10.09.03.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 03:30:29 -0700 (PDT)
Date:   Tue, 9 Oct 2018 11:30:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 5/5] Input: ti_am335x_tsc: Mark IRQ as wakeup capable
Message-ID: <20181009103027.GQ4939@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-6-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180630103318.25355-6-vigneshr@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2018, Vignesh R wrote:

> On AM335x, ti_am335x_tsc can wake up the system from suspend, mark the
> IRQ as wakeup capable, so that device irq is not disabled during system
> suspend.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
