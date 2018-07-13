Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65B6ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82341208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYu1bpUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82341208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbeGMHo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:44:26 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34366 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731351AbeGMHo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:44:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id s13-v6so3800915wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1hd87SesrEhe4liWZxNFIr3PTp6c22zK6YrSQoRVdwQ=;
        b=IYu1bpUYFvtqpRFgsTF55WDWhw93jCjv6FZse6wcdSvGgjGmgoMn5lzevdobnHobiS
         tMMApBkD4oy38jwtD3svyr+8T0CI0g8VBUvFT2DuHisziYuCINA2l/kp6M7pCcZLb9FP
         sSwsQyGyMfOu5XdV1W07AqLYJ/wzF70kazZeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1hd87SesrEhe4liWZxNFIr3PTp6c22zK6YrSQoRVdwQ=;
        b=IaJSQ30N9Wf63lwePX55HiRESIiFPq23LIrcwboD1z992clVTZ/mnqnvpJq+kguvfo
         leHhUdbSoPD/wVcj1xMjH8fG+3xFKeh2zKebs2NOq9j7rPLuoZ9ddaOAxaCPOddYfTDK
         fMzqoMO928gSEfZsBT6LeXNmb7AyeVnMM669jSPQUaVYsy2tMpC4JiRKC6aUAg1uEKsp
         W9nTBjmndAuFSjV4+kX2dd0Yr2+lcKFBiACUz6mh4y47E3Zbtrq8iAf+52yt6lf5F9uO
         9Vmom1tHZra/w999pGGiHef6NFF1ooFQH5W+q4QQNKX7kn+zCSyP5939JHpCdMUwNm0f
         +hRg==
X-Gm-Message-State: AOUpUlEtR30U3Twt2jzDKO5tmGoHMcGvewKvRdlv/XK1cHWM8enbzpcx
        sr2VXvCQWNVluo5KjuBnLflWtQ==
X-Google-Smtp-Source: AAOMgpdmkySaOIM8vXMu3Fw8l8s4DnP2M29b/7jD7iR/Vm69+HhSLgDNJw5EuqWleUgJ9/r1Kxee6w==
X-Received: by 2002:a1c:e904:: with SMTP id q4-v6mr3260673wmc.154.1531467062748;
        Fri, 13 Jul 2018 00:31:02 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id b190-v6sm9582126wma.24.2018.07.13.00.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 00:31:02 -0700 (PDT)
Date:   Fri, 13 Jul 2018 08:31:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH 3/6] mfd: rave-sp: Initialize flow control and parity of
 the port
Message-ID: <20180713073100.GO4641@dell>
References: <20180707024108.32373-1-andrew.smirnov@gmail.com>
 <20180707024108.32373-4-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180707024108.32373-4-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jul 2018, Andrey Smirnov wrote:

> Relying on serial port defaults for flow control and parity can result
> in complete breakdown of communication with RAVE SP on some platforms
> where defaults are not what we need them to be. One such case is
> VF610-base ZII SPU3 board (not supported upstream). To avoid this
> problem in the future, add code to explicitly configure both.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: cphealy@gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/mfd/rave-sp.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
