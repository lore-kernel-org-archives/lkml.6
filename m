Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF691C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA8120676
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XB6Em/ee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA8120676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeHXMyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:54:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35263 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeHXMyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:54:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so974120wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/6Xk4xAvmseN5+DW9Y3b/KpTqpONjfBqT4tn1j2uPNY=;
        b=XB6Em/eeOF2rHy0o/rT6dJnAMlTbpfMXQSxtHHOugVvL3pntJo6griqWVQ7hazNxbh
         hO+Z7ViCUjNJjZJXAxq3Tw093V0euZYT8JYoSn/hH7Ki04QVJGWG4FsJUg2sMSQ6RCrI
         svBMzFP6LVzN+TsejSUUxEbOwfrnVevM9kNY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/6Xk4xAvmseN5+DW9Y3b/KpTqpONjfBqT4tn1j2uPNY=;
        b=svtYkHKSumxyMKaqARO1U53CdYRyMTK9H1BQXhW0gdvsVP8mSfaGyR1TSjeJolmB38
         cMirmteMC5d1GdympFnOCvfzn1yPRSn787g/yJDYzizl2fPMssDNsac0iRGrtke/7gig
         V6hD8OfQcplFHwhyxrwbiB6FMxD79OzN0X3qS+sOj4lHOEglMlkOptDzNdnfBjTzTWgb
         g6zaAAcfL5ylZMsvgb/ErP2a2lV1mmFUNqm3Ewmg801e4wLJZcN12QtoE3Pq+GfGt2gj
         ayVzMdtpMG6ZQFms8UE/DXrrLC+mAPbdm2qWt2Yh7bUrNESabqH9d+brpYn7Mk6TrLja
         deOQ==
X-Gm-Message-State: APzg51D6GTwEsej5sDu3QdG5LvW2rfI1pWovNnjBmTgW4Hl93w49b5BX
        uNpVqbr3JRR/DH2ESmMOZp4CnQ==
X-Google-Smtp-Source: ANB0VdYPReANAEJJBDN9qJRNVphYQdnLxeUdPxH6GRFTXiUF6LCOXZrvmKyyYrvbBr35DArd5+aPYw==
X-Received: by 2002:a1c:da51:: with SMTP id r78-v6mr862173wmg.153.1535102434044;
        Fri, 24 Aug 2018 02:20:34 -0700 (PDT)
Received: from dell ([2.27.167.102])
        by smtp.gmail.com with ESMTPSA id z3-v6sm884701wmf.12.2018.08.24.02.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 02:20:33 -0700 (PDT)
Date:   Fri, 24 Aug 2018 10:20:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 3/4] mfd: sec-core: Fix indentation of Kconfig description
Message-ID: <20180824092031.GE28860@dell>
References: <20180807161125.18155-1-krzk@kernel.org>
 <20180807161125.18155-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180807161125.18155-3-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Aug 2018, Krzysztof Kozlowski wrote:

> The indentation should be a tab followed by two spaces.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mfd/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
