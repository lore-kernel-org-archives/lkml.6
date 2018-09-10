Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20906C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03C120854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y437N2gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03C120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeIJTcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:32:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41984 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbeIJTcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:32:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id v17-v6so22192137wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gaWNHQh58OTQhiOoBzlZ0SFxlIugpaWCFQHjEzVP3z4=;
        b=Y437N2gv3nz5hcEiyK1AvcyFRLQQZiva3XFUF0AiJ+2hmLObwfhMv+mbtxVIWjocTL
         r05MpglD0fM2hfo4zuMtaj9ue8Dn3kNl/Rr4aAa04BrG41bsw4oejRGcPCuBsdNjMbe9
         yCctW6CbOBveUUpC3fQ6NoYi0t88FnJDUEetY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gaWNHQh58OTQhiOoBzlZ0SFxlIugpaWCFQHjEzVP3z4=;
        b=NvRmPmpdGvrYKo1k4fIsa0vTOjq1Qx6hfCrxj8hOnxmgPg4N8PrEAbRkzIYVSw1E1y
         a7dBrXLzjoKCdCqFjsU7oc1Xgt3ovD2JM3Va6344c4V4/o2dugpJDEYG2rmG1bggSTpB
         pGdisbQtsRPYW8J3Hh83i+a9fupdvYFvDWhOQb6gyTTVRsLm1xquh8Y6i0PDWChsY0nB
         myrWUxCxGI4qEjfQwqWlq36x4dbcfcp7kwcOHFsxaiZFtIrgH4nDdTLxlzM0+9sQ2Tj6
         cpUh77CcXKHVo+kXqUUto6QazLiiu6uRAQiSu9MHIdAW7clHQKRWrEPFzH6Bnt5oDEKa
         OQdA==
X-Gm-Message-State: APzg51Co3nEZK9ppjouusVRT19iwk0ZAZPaj+zkIp9dvw3u5FtYnkc1g
        dIPgk1A+LE0Rk7PBBEMOeyq5eQ==
X-Google-Smtp-Source: ANB0VdZrbWD+nhyc9Ni5euctxLeFb8/43A2kuYhJgLo2v4q4zNmfGp4vRjq280nyACU5cLtGP/yRpw==
X-Received: by 2002:adf:959a:: with SMTP id p26-v6mr14684046wrp.202.1536590267149;
        Mon, 10 Sep 2018 07:37:47 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id x15-v6sm15140648wrt.53.2018.09.10.07.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 07:37:46 -0700 (PDT)
Date:   Mon, 10 Sep 2018 15:37:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     RaviChandra Sadineni <ravisadineni@chromium.org>
Cc:     dmitry.torokhov@gmail.com, ravisadineni@google.com,
        dtor@google.com, linux-samsung-soc@vger.kernel.org,
        tbroch@google.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com
Subject: Re: mfd: cros_ec: Check for mkbp events on resume only if supported.
Message-ID: <20180910143744.GT28860@dell>
References: <20180820153419.32098-1-ravisadineni@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180820153419.32098-1-ravisadineni@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018, RaviChandra Sadineni wrote:

> Currently on every resume we check for mkbp events and notify the
> clients. This helps in identifying the wakeup sources. But on devices
> that do not support mkbp protocol, we might end up querying key state of
> the keyboard in a loop which blocks the resume. Instead check for events
> only if mkbp is supported.
> 
> Signed-off-by: RaviChandra Sadineni <ravisadineni@chromium.org>
> ---
> 
>  Note: This patch fixes the suspend/resume issue on Snow and Peach-Pit
>  Chromebooks, both on vanilla v4.18 as well as linux-next from 20 August 
>  2018. Further info at: https://lkml.org/lkml/2018/6/5/1076
>  
>  drivers/mfd/cros_ec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
