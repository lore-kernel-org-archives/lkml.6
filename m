Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C42FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4499B2473C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJ0FuRLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4499B2473C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeGDHAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:00:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54572 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752810AbeGDHAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:00:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id i139-v6so4554647wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 00:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=c4fE5nqlza3Fgv1JuUqQZZGMdSOxOiEGNlfoFzCe3B4=;
        b=NJ0FuRLTt3kANFH39A0v9RuD5fUKt//N5/G0Jaus5xldLAugCAR7w4/KyiBKLElrv6
         HtwOIStW+PS/4vw2L4oBHCO3e+VIeXu/H3T3WjboR2J3UL9Qh9K5+pHx1RZpkpC8uLz4
         D7aniCZ7UY9y6YNytTwplqt8+t5pRXETdMPT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=c4fE5nqlza3Fgv1JuUqQZZGMdSOxOiEGNlfoFzCe3B4=;
        b=KqznXrq+gMuSdERAAZ9OIZAFrYLzxs1m/O2wfJ/JTuqa4VZZitrNKXFqg1zG8mQEAH
         39NoyHvj4R50quC60a+Q134nVPYrDqCFtlQY0q/OMmZMlsaDA0N0dMfUDQJYslcljU10
         Xd4+ggZHqmpj2VYWUvjH6wtTipvYNysj5SJXCmAX1KLdtWOoaGQ2NWx0sZeDpt0FzHax
         VNNN+XsMqn9R7zKuDWtKIuGyLfWs1uQOVTN1fGk3+XG8Kp+HRs8/C+iXmaNF1gxcTxYV
         esPRSFJ7aQ3lHMWG+qz1EoRJRfZvriTG8svC86tb+s2NMmHIeI++w+8fBY8E4zxi160b
         oj4Q==
X-Gm-Message-State: APt69E0TfammNz17HSrfAo3YzJyo+WE5Y6eSYLdfppipkKaqhtxC5saL
        7DgdUH7t2YMeZPq1ZTEaomvI3Q==
X-Google-Smtp-Source: AAOMgpfUQAunudiPCYJRyAh5gw2mE8RQPjipyvnPcT40GSThEtVCcpbG7K5u1Q3MA2gS1S5NaHJJ4g==
X-Received: by 2002:a1c:6d41:: with SMTP id i62-v6mr681578wmc.25.1530687610459;
        Wed, 04 Jul 2018 00:00:10 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id c188-v6sm1375842wma.31.2018.07.04.00.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 00:00:09 -0700 (PDT)
Date:   Wed, 4 Jul 2018 08:00:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH 2/2] Revert "mfd: cros_ec: Use devm_kzalloc for private
 data"
Message-ID: <20180704070008.GE20176@dell>
References: <20180620213033.100455-1-dmitry.torokhov@gmail.com>
 <20180620213033.100455-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180620213033.100455-2-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, Dmitry Torokhov wrote:

> This reverts commit 3aa2177e47878f7e7616da8a2050c44f22301b6e.
> 
> Linux device objects are refcounted and thus should not be allocated
> with devm API as they may outlive the timeframe of another device being
> bound to a driver.
> ---
>  drivers/mfd/cros_ec_dev.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
