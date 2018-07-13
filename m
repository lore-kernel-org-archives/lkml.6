Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54903ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B6A208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YCd/lRds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B6A208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbeGMHox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:44:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50459 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbeGMHow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:44:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id v25-v6so7858449wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+fO0ePYtzfbZc26Eew9P+Nn6myOosIanTBjxfo2iLjY=;
        b=YCd/lRdsBr7AmuSX6+3BKiaqgoSPmZ/RfMLAdLlrDDJhroGN0FoCwwY2M0OtO8mKdC
         3gODu363O/MZNCAMbo/A1IZR9cfvubOBE7zYguPqi087nBi57ZbqoGMJEXIW4TFuMlIg
         S4ccElZ8mhS5B/If8/w96aiZCTcE6NpCZGGq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+fO0ePYtzfbZc26Eew9P+Nn6myOosIanTBjxfo2iLjY=;
        b=t2Y6nqauHzapYVM6igZBMAnCVxKQxjRskeDpqsmr+Z4cA/yHGU6hlnXzYx5T41QNW4
         dFjDsgwe9XULdQmroxM+es4lcYJHczdjIDVI+mgdF6Tz8KyDFD/IpoB6syA0D3HeKqrv
         lVY8K+VD7cGGFu3Qdc9hN4VX8LeWR6IWc7IlIoA/YuM90R9DOCVteNKB67Xt/hPzKzhY
         jKlpv+c2/1BM0DR7ai1J586MUpRMjTue5ueKQt7Fo3eBSrrbRhe2XjhcNdLyeL3yaqVp
         ufe2Ii7vs9ESa7BMju0CYSl/DgRvP/WMQH66PEChqCWPF4LZb8bWb2ad3x/7fkiBL3ul
         TzQg==
X-Gm-Message-State: AOUpUlEXLsKGKVDVY5+hKg6f+R+LBXyuJ8nRIhgJ2GW/jJTrVtrh9LhS
        2LCMD2IzraO5qe76HNwZl8y2wg==
X-Google-Smtp-Source: AAOMgpfeQ9ab01/vbWSRI/jbfr8VFrTbtVX+Pc1281/FVFjvf9hDf7SAv/ezZkyOlxIEg7JGjyqQdA==
X-Received: by 2002:a1c:6709:: with SMTP id b9-v6mr3024842wmc.30.1531467089400;
        Fri, 13 Jul 2018 00:31:29 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id y102-v6sm8498513wmh.9.2018.07.13.00.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 00:31:28 -0700 (PDT)
Date:   Fri, 13 Jul 2018 08:31:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH 6/6] mfd: rave-sp: Emulate CMD_GET_STATUS on device that
 don't support it
Message-ID: <20180713073127.GR4641@dell>
References: <20180707024108.32373-1-andrew.smirnov@gmail.com>
 <20180707024108.32373-7-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180707024108.32373-7-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jul 2018, Andrey Smirnov wrote:

> CMD_GET_STATUS is not supported by some devices implementing
> RDU2-compatible ICD as well as "legacy" devices. To account for that
> fact, add code that obtains the same information (app/bootloader FW
> version) using several different commands.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: cphealy@gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/mfd/rave-sp.c | 96 ++++++++++++++++++++++++++++---------------
>  1 file changed, 63 insertions(+), 33 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
