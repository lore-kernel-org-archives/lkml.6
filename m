Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27693C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1232205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CcBoI1dY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1232205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeLJGcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 01:32:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54841 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeLJGcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 01:32:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so2224185wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 22:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eOUDufZKznOjTsLXEXn9EV+3WYmTeiSrLsED1U7BNF0=;
        b=CcBoI1dYyMyvBv6CJOIbhB+5/DD6/wgj3v0dy0yhsCUMUvg2bvmKjiXkffiwK6KYXH
         MfuKfozAM6VG8+b/uVRFXG7jam4pFWXVIFHTMEgmb+lbVbhO/L/BlqcsrLO0mEydCxjV
         APUsqSGBo8IO5mrCIdsMpQWUhiS6eB3+jEVcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eOUDufZKznOjTsLXEXn9EV+3WYmTeiSrLsED1U7BNF0=;
        b=EH5YSI6VqRxtsCpqxtivvFwbyENnUnFqSrKrkbwknUi3JrJtW+5BfOis2GdScFswgt
         jV5/vQm349ioyuhaYd0nsw/Al+l9doweh4Ir2eJrp3/JqHil+oP1cC1pzFAU/VIiVIT5
         OSMz7lxQMoS5McFbDYd3FPc28WiZGohi6o6q2DT9QSzztbS1CJscrHzN6C5YJyNIaUkn
         fTA/X38SYU7eaUbmBKmDwvRvYUZJtfXLrl6THf3g1jFxIIfwVDc5f3nEVdRbXiVQLewY
         ZdqjP1YN9h1SjbIib0nYIHJreG1AmfFyYB/elTOB9DJt2eZIzBevO7jtPP3WjUECH10S
         E+/g==
X-Gm-Message-State: AA+aEWaXMlpCTYFZZsxzXBhMzLCl/AcxaH3ysWjeMbcm1cm4xHhAgDT0
        s/Urp7BxushTd47KilkWX7pH62QeGfY=
X-Google-Smtp-Source: AFSGD/WBOZx6C+4fo8lNoqglfbNISVzKBnI+2mAt/RMd/UveRuYPjn93p545usZ/g4+4uoi9WZX3Dw==
X-Received: by 2002:a1c:544f:: with SMTP id p15mr9223939wmi.37.1544423549361;
        Sun, 09 Dec 2018 22:32:29 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id a12sm10085215wrm.45.2018.12.09.22.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 22:32:28 -0800 (PST)
Date:   Mon, 10 Dec 2018 06:32:26 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] mfd: axp20x: Re-align mfd cell entries
Message-ID: <20181210063226.GQ26661@dell>
References: <20181208175847.32068-1-oskari@lemmela.net>
 <20181208175847.32068-2-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181208175847.32068-2-oskari@lemmela.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Dec 2018, Oskari Lemmela wrote:

> From: Chen-Yu Tsai <wens@csie.org>
> 
> In the axp20x driver, the various mfd_cell lists had varying amounts
> of indentation, sometimes even within the same list. For the axp288,
> there's no alignment at all.
> 
> Re-align the right hand side of the assignments with the least amount
> of tabs possible. Also collapse the closing bracket and the opening
> bracket of the next entry onto the same line for the axp288, to be
> consistent with all the other mfd_cell lists.
> 
> This patch is whitespace change only. No functionality is modified.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  drivers/mfd/axp20x.c | 107 +++++++++++++++++++++----------------------
>  1 file changed, 51 insertions(+), 56 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
