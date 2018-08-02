Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DAEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDB92098A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ho8ttMNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDB92098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeHBIWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:22:08 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:51199 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeHBIWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:22:08 -0400
Received: by mail-wm0-f52.google.com with SMTP id s12-v6so1144020wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 23:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sclHyPI658Bo86ihATULFDPhWb21Qn8HPq3LhZbMxPM=;
        b=ho8ttMNNlw58QqrvD0c/U07uh9K3eQ0HtjfMMKAOU0aFhGzgtZ8wQp3VAjKIG8Poyj
         TNEYicZv42kErHK7EOqGcz0oc1PAFbs/hdKegFIpnWWtS/4bIMFjXiY+4VPGKfQ4Zuv+
         HbW1C6LWsbQ+Mde++mBNfRuhAe8zSnKtgruaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sclHyPI658Bo86ihATULFDPhWb21Qn8HPq3LhZbMxPM=;
        b=bUlWCz4VEPoksXZJ3DlHSiET4SGJd+ob31DvK8g8ljyrKNbgieXxLnLJmFyWgg1zzd
         0EfmJ6Dkpw4vI0g00tRmQ4GVumR21zDS8IIYk9xrPZB84l3UfWIm/1prpi710DO34D4P
         aGn7Rq0M66qkeO0MJh00zj3+LXCmIgO42xfFrBCK6496/WMag29QCMHNM8oCe36+Q5jR
         tNoVkO2Bzxf4O+FCIk9wKReQx+P4C0g/bW2GQtXMyTthoXEuE/DGCTXtW8mKuVydm4fN
         2NQ/nuiIRG7d9QIr6pwBkIkLfMocOjQTR8RKwp+/Qdapan7A3Fym2V7HddqzBbyaHhY/
         acNw==
X-Gm-Message-State: AOUpUlGVqhdv/lsFJ9KjepJv/C5KCvUYBm2Bh1s4rqtNXo+u6cExrgTU
        2eLE//yY+v0++8ls1jTJ7oEZHg==
X-Google-Smtp-Source: AAOMgpdta05AK6e1qNDm2bfPttxWXE7t3nJ7WVJ1j3mrSJ4eXcEpUXwElQqHVMc177dv5vy98KuFCQ==
X-Received: by 2002:a1c:ad4:: with SMTP id 203-v6mr903068wmk.98.1533191548970;
        Wed, 01 Aug 2018 23:32:28 -0700 (PDT)
Received: from dell ([95.149.160.4])
        by smtp.gmail.com with ESMTPSA id w185-v6sm1112014wmw.6.2018.08.01.23.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 23:32:28 -0700 (PDT)
Date:   Thu, 2 Aug 2018 07:32:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Subject: Re: Applied "ASoC: wcd9335: add support to wcd9335 codec" to the
 asoc tree
Message-ID: <20180802063226.GK4662@dell>
References: <20180801112011.33C511124241@debutante.sirena.org.uk>
 <2b90faa5-6fd9-f769-183e-23cb59bf460e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b90faa5-6fd9-f769-183e-23cb59bf460e@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Aug 2018, Srinivas Kandagatla wrote:

> Hi Mark,
> 
> On 01/08/18 12:20, Mark Brown wrote:
> > +#include <sound/soc.h>
> > +#include <sound/pcm_params.h>
> > +#include <sound/soc-dapm.h>
> > +#include <sound/tlv.h>
> > +#include <sound/info.h>
> > +#include <dt-bindings/mfd/wcd9335.h>
> > +#include <linux/mfd/wcd9335/wcd9335.h>
> > +#include <linux/mfd/wcd9335/registers.h>
> 
> Without the "[PATCH v2 02/10] mfd: wcd9335: add support to wcd9335 core" It
> would break the build.

This file should not be built without 02/10.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
