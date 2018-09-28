Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C58AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B1F216FA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3k6KKNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B1F216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbeI1MIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 08:08:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37315 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeI1MIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 08:08:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id y26-v6so899606wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 22:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xEGE5DU1O98krIGWQG4A1LBz2KM3jLaZwfQ8nakMnUc=;
        b=e3k6KKNwNVRnsPr7UgxTPIp47TAN9KUhQMKezq8VJEEd3t/9wJ+fY57vvGmGP55uaT
         pCILpy9ttmjVrnWHaNsNNKOcjC7iZ+EfGI4jBLtl11gepvOxAXAnlNaNRYroA5IId8ob
         JCb75FDUEcS+v5iWlnWrPQEAeUtQjEQrNgbfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xEGE5DU1O98krIGWQG4A1LBz2KM3jLaZwfQ8nakMnUc=;
        b=kUAl1DnvMKXcuiVJgm2cwBDdmTTbVN1QjvhGyoOmx0uJgEDmusvH29jCQ/2wQorxnK
         MfOdYFkTl56sxMTEf9TUqHp6WLC1yBo8tDfa6KAktorgHx/c6ObbfqNHBDudHO4j/mIM
         gRQKK92N6+kTzjGI+sdQaRKi6QVKft7qZXm+yKaeF9jH8MdNx/nkUQc8gzWlKW9A9oha
         hzjVsadD3YzZvlNawo2LTtrZ0HI4qq8sLUYyyOCUwQ227vsZ9pQYudl+FAK4lR5s+6a4
         p5UBTl4l4yEui3g4ykrqk3PECvCdlT/IghdahtkC0ZdTfAeireREvoBiuv5S0lDfgeDo
         dHmg==
X-Gm-Message-State: ABuFfogiYz8Ln1lJGBHvg11SaPgqorOOs+yJsEpQTFR9mN6ECMBlFTfG
        AsMlw3mcaBc2hSEmoOWwfoJIsAI4rQ8tKg==
X-Google-Smtp-Source: ACcGV63Pfgn4TgWjq7jGwXgY/ku8v+JRiXeJM1PaG5Hc5JJuilQwCZpOfzhVRMJl99NcD5KaNQOHQA==
X-Received: by 2002:a1c:5fc2:: with SMTP id t185-v6mr512273wmb.12.1538113609203;
        Thu, 27 Sep 2018 22:46:49 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id d2-v6sm3689916wrm.71.2018.09.27.22.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 22:46:48 -0700 (PDT)
Date:   Fri, 28 Sep 2018 06:46:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] mfd: arizona: Correct link for sound binding document
Message-ID: <20180928054646.GK8485@dell>
References: <20180917153322.29206-1-ckeepax@opensource.cirrus.com>
 <20180926223944.GA30051@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180926223944.GA30051@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018, Rob Herring wrote:

> On Mon, Sep 17, 2018 at 04:33:22PM +0100, Charles Keepax wrote:
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/arizona.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Applied.

Probably won't do any harm in this instance, but it's usually better
for MFD binding changes to go through the MFD tree to avoid
merge-conflicts.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
