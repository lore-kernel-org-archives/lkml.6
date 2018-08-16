Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB372C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6461921480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cl8TbEVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6461921480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404141AbeHPSri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:47:38 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53663 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeHPSri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:47:38 -0400
Received: by mail-it0-f66.google.com with SMTP id 72-v6so6898813itw.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 08:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WGOinU9NqiO1dOZNBDxer4tHNGbfEzKHyzzyhNPHR4E=;
        b=cl8TbEVeGZ+YtKCJrzTRWd2qtj3eugV7o/a/OeTZXBBcdHq+XhjljzTGdg13yoDQvU
         kDjT3qe9jhoWL5OmEGQ7AHxX2YUMbDYJVqYxE+vMbZ/Pz68Ju45800+4de09svfusKHR
         7anxAd6lpH0IVcGqRviUnTRO787GwZzRf8T2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WGOinU9NqiO1dOZNBDxer4tHNGbfEzKHyzzyhNPHR4E=;
        b=oiiGmwydLBh9xSueyq6+GSmqqwm5X9Xx2HVa0IVQaWOZcXgrPqxod5DCXlbaqlsAHh
         oC/aExI64QN9aju4aPaSPIDdF5Bdb9+o/y8ABkiS8By4Uia2zizkbpLtelqR9fzBqJIT
         y1/ZEL0zeCBIpzn2DDhBYJUnTx4JjW4WClPsmH1JG8XXMQqilSkXppu5rLWexw3iHSbG
         2oOW+jO14Fogge7BxhVffPiadPV7ZhZsoKKdkSsUmoUmkYsvD6pEHxhaWJgOQoexvV8Y
         F2+iyhAYw8LVFINJgJ9ZXMTrJF+tXBK/0Qn+sMHHZPBJKSykIOrvTbdN1PFt39QbbVSW
         2LLw==
X-Gm-Message-State: AOUpUlF0o68ym6IR89x4PTNYYVozP+IKcYMk3IyRjZtgvGQMmcm2U5Ev
        ePLzPXFPYAk7FLVcSCH9tUFiLcwJ3Ek=
X-Google-Smtp-Source: AA+uWPzsEBg/bn9iOs1HmtNvAy7VGn3eFZGWGIYf3o8WIg6A5SCpdoy995qs02ri/yHLoXGDEJzpbw==
X-Received: by 2002:a02:1294:: with SMTP id 20-v6mr28078550jap.141.1534434500539;
        Thu, 16 Aug 2018 08:48:20 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l75-v6sm623637itl.5.2018.08.16.08.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 08:48:19 -0700 (PDT)
Date:   Thu, 16 Aug 2018 09:48:17 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] coresight: etb10: Refactor etb_drvdata::mode handling
Message-ID: <20180816154817.GA14955@xps15>
References: <1534284866-2523-1-git-send-email-mathieu.poirier@linaro.org>
 <5cd6b8a8-2370-517d-deb1-378bff6e362b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cd6b8a8-2370-517d-deb1-378bff6e362b@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 04:13:03PM +0100, Suzuki K Poulose wrote:
> Hi Mathieu,
> 
> The patch looks good to me. One minor nit below.

You have not included any comment - did you change your mind?

> 
> On 14/08/18 23:14, Mathieu Poirier wrote:
> >This patch moves the etb_drvdata::mode from a locat_t to a simple u32,
> >as it is for the ETF and ETR drivers.  This streamlines the code and adds
> >commonality with the other drivers when dealing with similar operations.
> >
> >Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >---
> >  drivers/hwtracing/coresight/coresight-etb10.c | 62 +++++++++++++++------------
> >  1 file changed, 34 insertions(+), 28 deletions(-)
> >
> >diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> >index 9fd77fdc1244..69287163ce4e 100644
> >--- a/drivers/hwtracing/coresight/coresight-etb10.c
> >+++ b/drivers/hwtracing/coresight/coresight-etb10.c
> 
> >@@ -488,7 +494,7 @@ static void etb_dump(struct etb_drvdata *drvdata)
> >  	unsigned long flags;
> >  	spin_lock_irqsave(&drvdata->spinlock, flags);
> >-	if (local_read(&drvdata->mode) == CS_MODE_SYSFS) {
> >+	if (drvdata->mode == CS_MODE_SYSFS) {
> >  		etb_disable_hw(drvdata);
> >  		etb_dump_hw(drvdata);
> >  		etb_enable_hw(drvdata);
> 
> Looks good to me.
> 
> Reviewed-by : Suzuki K Poulose <suzuki.poulose@arm.com>
