Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA76C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E762089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdG00IEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E762089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJIQMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:12:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35600 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeJIQMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:12:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id w5-v6so907179wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 01:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aBqEDN0W5FsPUdGZsdaa0cMpgxZh9GWRKGnBLfPBm78=;
        b=kdG00IEIhKaf6Et4WMzYVrc51UAf0bq/S1MvqPGmFOq2H6jWhQa7g2wfyTjK2Lgntn
         2hh9/kcz8xMzbMPpkEUolaGKL0kC8TCaagw0rz97C+YVWdcMPI/fc82OSakp/MBGHZLA
         TYrTldwl3jEIpKwSHrd6preucSxw2gnseuTvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aBqEDN0W5FsPUdGZsdaa0cMpgxZh9GWRKGnBLfPBm78=;
        b=oqCgq1XBKsvT3/FE4QQ2GAXhsIGQXnPuoWLuBA9yTq/fDgv7w6BIepeK7pDqd/T+a3
         YFPNcD7CdB4GkBMkA5hczNizW1hDQtUCXRpXwE6ZbYrczyQYDwHZr6bKybqhCg30e6lk
         74J+1r0LHQ2VxoeyKo7GBxopotNndECFjNxoBiYEldaKpVZGTzyHWNQwLg+vLVJ3/jaT
         Lh9/qVAh/qxt1Tw5iFuwf0pRSRseVLNfGIRphgs71Paf9CWCKTY0jrLkn2pbLY+cqDWB
         ZfAVVGFlN9h7RcZjoY1+pJZsiujd+kd/zz/HTo7GlVFs7R0o7MDJlWDm1DarERfMVH0u
         JoeQ==
X-Gm-Message-State: ABuFfojbir7ob1EP1AjQ5TgohULkgJAoSIM2szyqGkCrNO1jTG0u2aLF
        GV1dA3fnXBiaxkcL8oyTS7eZC7aAW6w=
X-Google-Smtp-Source: ACcGV61YrZpzYoOLtkGRPywhpk+x3KVbuAUG8OBjNlXCaAF0cNAM5vaKsLNmqQTze39G27QR7/9BHg==
X-Received: by 2002:adf:e9c7:: with SMTP id l7-v6mr18148725wrn.238.1539075406315;
        Tue, 09 Oct 2018 01:56:46 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id e21-v6sm12421764wma.8.2018.10.09.01.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 01:56:45 -0700 (PDT)
Date:   Tue, 9 Oct 2018 01:56:43 -0700
From:   Lee Jones <lee.jones@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        dmurphy@ti.com
Subject: Re: [PATCH 2/3] mfd: ti-lmu: use managed resource for everything
Message-ID: <20181009085643.GB4939@dell>
References: <20180911210133.GA32497@amd>
 <20180911210344.GB32497@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180911210344.GB32497@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Pavel Machek wrote:

> This replaces all remaining unmanaged resources with device
> managed ones, so that the remove function is no longer needed.
> This makes the code slightly shorter and fixes two problems:
>     
>  1. The hardware is disabled after the child devices have
>     been removed. Previously there was a potential race
>     condition.
>  2. The hardware is disabled when mfd_add_devices fails
>     during probe.
>     
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
