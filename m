Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5562C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A305A2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iS1/Vw7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A305A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbeKUTDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:03:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38075 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbeKUTDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:03:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id k198so4825687wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 00:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5m/+TTBul8VWpRG7rp7NMGeDxE6htrudc6bh7sHcP1g=;
        b=iS1/Vw7p1ZLRN2gscQjJM12ij96097Li42EzASk1ClfyvhdLWQcoKFIDijLX+PKto5
         RimAAIhGLGNXo2pJZ6rLHOsC5Ti+Y2CYlxaNL5/28LlVME+DTQNWqr4yn5RmePcJZSNk
         GCMxThF9PGDCa4iP96m+WCIfWIMsnPwsG/vAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5m/+TTBul8VWpRG7rp7NMGeDxE6htrudc6bh7sHcP1g=;
        b=mdqWunIkLu01x6d+wvRbuPumVxTI9kRHPgvSCI+2oW4k+77dSq6ydNquRQx33014oM
         +r7zIFgrk1r89ZBAor+OjwRgRSAB6TzMuGWlufbaLz6l9GNMYmNP2uWct4Q1GKzRZsht
         dJ5J4C/ocFKzPExUFzrrBl3qRvZnGkRwJ7eLlWvvfbikgzTv+mxzYkgpX4OZmMGQS1Yi
         TIJbhAd/1tl8dJGosVc/y+wCOIVR1xNssCxUQ2+ShUYHyGJlPY60Xsmwv9RH+jZH81qK
         1dDwLMINpeBbr54I2teZ1SOuWfoe1sUIExvBCNrgRpbVo4Y+8tywSym1d77DOdQr9Gn1
         bCvA==
X-Gm-Message-State: AA+aEWbIipzi6ooheXcqG5HV7uMr2pn+QZ+b2c0H5j69lvOQ14bnMrix
        Wzfy9+2WcnZcVtxa66rDyc2a+g==
X-Google-Smtp-Source: AJdET5ePNcG3yuyU+1079WZMFK/P8/BaY9OmmuJY+asRkcKnpyWtiVKln5uBSOT3nbAZuD9bHhVpfA==
X-Received: by 2002:a1c:170e:: with SMTP id 14mr4879586wmx.113.1542789012990;
        Wed, 21 Nov 2018 00:30:12 -0800 (PST)
Received: from [192.168.0.40] (239.22.136.77.rev.sfr.net. [77.136.22.239])
        by smtp.googlemail.com with ESMTPSA id h203-v6sm458742wma.38.2018.11.21.00.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 00:30:11 -0800 (PST)
Subject: Re: [PATCH V5 1/2] thermal: imx: fix for dependency on cpu-freq
To:     Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1542779052-29536-1-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <45bf9c67-fd05-99e5-7f5d-3896c7d3fe31@linaro.org>
Date:   Wed, 21 Nov 2018 09:30:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542779052-29536-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2018 06:49, Anson Huang wrote:
> The thermal driver is a standalone driver for monitoring SoC temperature
> by enabling thermal sensor, so it can be enabled even when CONFIG_CPU_FREQ
> is NOT set. So remove the dependency with CPU_THERMAL.
> 
> Introduce dummy function of legacy cooling register/unregister to make
> thermal driver probe successfully when CONFIG_CPU_FREQ is NOT set.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

