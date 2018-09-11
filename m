Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E87C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A814A2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+a2eqc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A814A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeIKSuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:50:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36775 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeIKSuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:50:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id e1-v6so17092758wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FC4Fya1rNfny+ubE9vjRTwdJMeBHJU902zmL7q8NIfg=;
        b=D+a2eqc5VKnke7Dkd04SxynO2Mq8Mz3ZLVTFwxRGakPIbZRBmjgKUeardx3CzCDc47
         yDoh/lpSHiHh1V4S8ZBXiKp1ngmdWRFPz3ycmS+w7KOWRKxlh0/p1Dcqyr2kW8LRJreB
         uNDVqFiRmxYmwo7fCW0oo9LEnKW7bYpkFyRAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FC4Fya1rNfny+ubE9vjRTwdJMeBHJU902zmL7q8NIfg=;
        b=bGqfGBeneilNxKLOlcDAcTVULdtvRbL5fzLsdVSJvn3m01mTsCJY9OUEFfg3xRwtVC
         fcmqEKNJ/IWhEa5sVwAv8HQdH0bZiml1Je81c1BRToCsRB3O1HGxWOLXk+CVTCDnJcc/
         4wGZNy9iS4y7P7f5JjllnephMdruFcpKhreA99lt7mnzdf1G5/NpiPjVgTCZldhjW31K
         beNqS+ZaaFBWBBRwlHkwe6lkw7+XEMAEjZs+1jfivur+km0ixnVQm0DDmmwH5mB3XIuG
         qI5vR7cKI9/VM1UutIeJxconce5p4tIZHb86KcAibGBeZHBXoZ1ZW0olbhOUliwsGTwX
         4Xsg==
X-Gm-Message-State: APzg51ANwIg23w1MXUjRQx+0vyI2tGWUThn/TjalmESTWvfnK4A+OyE2
        WAukiSYIpSzt8QeaY1WANQ0nEA==
X-Google-Smtp-Source: ANB0VdZ+9x50/UX/pelce112MMlW5+KqOiFm4JHQKLw9U1uIxdias9GRuZhAIiCGY2gb8o1hYiVEbg==
X-Received: by 2002:adf:d84a:: with SMTP id k10-v6mr17397019wrl.26.1536673884004;
        Tue, 11 Sep 2018 06:51:24 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id j11-v6sm19503490wrr.37.2018.09.11.06.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 06:51:23 -0700 (PDT)
Date:   Tue, 11 Sep 2018 14:51:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH 6/8] regulator/mfd: bd718xx: rename bd71837/bd71847
 common instances
Message-ID: <20180911135121.GR4185@dell>
References: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <1f979c0abdea658dbd4b3760fd7c50d1c6bc6da1.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f979c0abdea658dbd4b3760fd7c50d1c6bc6da1.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018, Matti Vaittinen wrote:

> Rename parts of code that support both BD71837 and BD71847 to BD718XX.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/mfd/rohm-bd718x7.c            | 112 +++++++++++++++++-----------------
>  drivers/regulator/bd71837-regulator.c |  24 ++++----
>  include/linux/mfd/rohm-bd718x7.h      |  62 +++++++++----------
>  3 files changed, 99 insertions(+), 99 deletions(-)

The premise of XXing things out seems fine.

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
