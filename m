Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA41C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A672820838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544226576;
	bh=hkJl3QhiXWbbHfHy5tI+QYqWSMBTRUlwOWKYmMuWcKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PpzxVq9TEA0YcfUAk72PBefbHBI5f+QoFV22UDZbEnXe2PG4qv6Hk4b5MNW1OauCj
	 //xFsEsrJiSqxoaxncrZvm1R9R4XWMPSOY/CF7gerQ+b3BMr9oxD+USzlOmXctkrBI
	 Qo6q1ilbAyG+/8u1AUn4v79U+KCzzHMMXybHPqis=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A672820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbeLGXtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:49:36 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36695 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeLGXtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:49:35 -0500
Received: by mail-oi1-f193.google.com with SMTP id x23so4785515oix.3;
        Fri, 07 Dec 2018 15:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kt6hWJv0hdJJNY/ems+6RGohkJkTkz4bkdrGemSL0go=;
        b=r7DW3tA23UKcSuXktanLDs1uium6Ru2zOYP6/wL4iFbPBNXn1yj9ZyYyk4Sc9AzCZw
         XwvKZIRD2TNRZDN/qD+JPtrqpaGU4y2xnFe56obKu0B9Jp/6CZmYY7RTqBW2e20vPZHa
         zxysvBsiVrl43xXL0DRMrZizAhBSSzJNxhr2geQrTMelqy1MS4RvZMd7idlkVZL2XrcU
         +0mmNEwHPrCqQfH0zqh6RH2N2mQMj+4pX0/rfwCxexvFIzEx3lF9HsMyvtVGeSeojewi
         J+a/XEFPJIr0inglqYH7N4TAo9uVqFlK80rfdXfy84SaQBOK8WDBvDGJQQf6aeFFTd9z
         UWyQ==
X-Gm-Message-State: AA+aEWYNq8fmx+iOpUtxrMk59al3zynrZAU+Wxw/wOan7uwrEJLYmP3W
        3VtG0ZfPCfnoN+Q81hJHAw==
X-Google-Smtp-Source: AFSGD/Uu8c8EyQpmiw8gzXigTBMbqCXP964gJrTiDljnwx1YwFUIVwn0VW4/zQtBLc7ULVjEuwTJ+Q==
X-Received: by 2002:aca:aad8:: with SMTP id t207mr2289487oie.90.1544226574713;
        Fri, 07 Dec 2018 15:49:34 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f127sm2479298oia.19.2018.12.07.15.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:49:34 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:49:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eric Anholt <eric@anholt.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v3 3/5] soc: bcm: bcm2835-pm: Add support for power
 domains under a new binding.
Message-ID: <20181207234933.GA28189@bogus>
References: <20181130202743.20585-1-eric@anholt.net>
 <20181130202743.20585-4-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130202743.20585-4-eric@anholt.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 12:27:41PM -0800, Eric Anholt wrote:
> This provides a free software alternative to raspberrypi-power.c's
> firmware calls to manage power domains.  It also exposes a reset line,
> where previously the vc4 driver had to try to force power off the
> domain in order to trigger a reset.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/mfd/bcm2835-pm.c             |  36 +-
>  drivers/soc/bcm/Kconfig              |  11 +
>  drivers/soc/bcm/Makefile             |   1 +
>  drivers/soc/bcm/bcm2835-power.c      | 661 +++++++++++++++++++++++++++
>  include/dt-bindings/soc/bcm2835-pm.h |  28 ++

Acked-by: Rob Herring <robh@kernel.org>

>  include/linux/mfd/bcm2835-pm.h       |   1 +
>  6 files changed, 734 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/soc/bcm/bcm2835-power.c
>  create mode 100644 include/dt-bindings/soc/bcm2835-pm.h
