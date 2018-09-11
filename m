Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D53C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F942086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICgznb2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F942086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeIKXO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:14:27 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35331 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeIKXO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:14:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so1990578wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=69Br73VfIbLfSqByNNrBpiad3Ksx0mXRg10i0W+PENE=;
        b=ICgznb2tpORrHuPogBEvPJ5XYYcYNDa2UoamHca2DbdfcgqT9ewI9sQbT5+Ff6mNFx
         nkDAGQstflKuub0WkIF5xm7lDewcg9YqR98WKOtcBwW23dhBOluLJECrBKSwE0oeKt77
         QTeCFk5PIbIpDOBYN0l+K6yXAgllmIX3zzxOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=69Br73VfIbLfSqByNNrBpiad3Ksx0mXRg10i0W+PENE=;
        b=pYnY51qvwdI1N1RIE0MdGj0n6AIXDTy/hnRMHl09NPPfbi2p6ESe4nwiBNk14rDu1/
         O/X4QLdf0UYJJstEmteCRgRTC0IGZZHJALHb2L3WouRMKjESq1Wo5rGO1NM6j8aQDiQF
         xl25XygNRE4t1Mx1ykkXp8NJLC1HTOYgeJDCYZqB+n/nGGIBbRG55VVVZ1EuAM1ZR9l4
         FK/DKCHZkUadIrYPXeO+W+Cy9AFN/B6dbluPTv10USu453csLzsjRrZOkrfO41QjnoyU
         XNh3bQU4IMUY17pYArJhCC5MENUHk/1R/qsChaGq4RKTx2x8WoTGy0sbrrXSwiBh3wEw
         Vvug==
X-Gm-Message-State: APzg51CFiJiq86CSW7gD+7u0q2DhTk7fDh27qFDAumxhfM0zNGNwtuIj
        5zgyNdtO9JtnvTP3UR6s4yC6fA==
X-Google-Smtp-Source: ANB0VdZpL8QEoOD9jW1nlSmNPZH3/XF77+oGJCo7WJoY8VldC0GbiUSBxiYFBNwR4ssqN+ItV5Momg==
X-Received: by 2002:a1c:a507:: with SMTP id o7-v6mr2294364wme.45.1536689636976;
        Tue, 11 Sep 2018 11:13:56 -0700 (PDT)
Received: from dell ([89.238.177.251])
        by smtp.gmail.com with ESMTPSA id j66-v6sm26606115wrj.28.2018.09.11.11.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 11:13:56 -0700 (PDT)
Date:   Tue, 11 Sep 2018 19:13:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v7 2/6] mfd: ti-lmu: Remove support for LM3697
Message-ID: <20180911181353.GG4185@dell>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180911170825.17789-3-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Dan Murphy wrote:

> Remove support for the LM3697 from the ti-lmu
> driver in favor of a dedicated LED driver.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v7 - New change for the series based on the comments in https://lore.kernel.org/patchwork/patch/982550/
> 
>  drivers/mfd/Kconfig                 |  2 +-
>  drivers/mfd/ti-lmu.c                | 17 -----------
>  include/linux/mfd/ti-lmu-register.h | 44 -----------------------------
>  include/linux/mfd/ti-lmu.h          |  1 -
>  4 files changed, 1 insertion(+), 63 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
