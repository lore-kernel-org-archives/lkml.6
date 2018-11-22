Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428BEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0888620820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SE59Qf8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0888620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392598AbeKVSI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:08:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34319 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbeKVSI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:08:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so1522639pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 23:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jy8/H7P+CzbH2lthHSGT0pJzwCSE4ehdyZ5BAVj91yU=;
        b=SE59Qf8G8ZPCFSneReVIYD6aHxrxstiSZxHl3ST6MLxHI/MsWjbg/d8Pig7Ei0/sIF
         /aDWkG9lbrxwiRyopz3QQgyyLhlclM5CzsRHknm0YNkVtCSCav3RBR1Q1FxICWukJQ14
         Tbz3VzebtCdspRCqyrCyf4CLJ2Yc84zCTJRSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jy8/H7P+CzbH2lthHSGT0pJzwCSE4ehdyZ5BAVj91yU=;
        b=IChDQKyjAGSbtEBfgP5WpbTYmZRDZtBD2HkTHRTF9uYSvku9pq9vZVfpg/vonzLbBq
         L60PmB9Tf3mN93aZCwOPXBF0lXu+39coJhZVT7zcOSBHRBG2lpk1R0WWCfRZxo1KPmyb
         mEXjuzefA+dyGp3T3NqljKivFiqhXjM3ulC9LwL3mHsQpdfL7eUvKClIxnMDk34nHP5Y
         EgYqrcKTovPUSJLvrcdnqjazGZfK1N8JOvUEG+Rwu4VVx55MPhXTgrXXAzP++HKvNJWD
         OyMRqYr+37cwDLCwxbZeAh3JsvVmo4eSeP29tevbrEMhMao96LKLEzQt97CD6uE0zJMK
         Y2kQ==
X-Gm-Message-State: AGRZ1gKxfl1E87C4pIzKXIQeEYXNxE8OdVIRrnaCvjKj+wwvjvVaJw0x
        YipCP5agKAAMf2SJx3Gs2MJmhA==
X-Google-Smtp-Source: AJdET5fQb/fG+/+qY5vR/j+rzdZlO1mwAMvSkQ/GUGGY7dvxhlO66eOSInWdnb5GaJeuHbWZyymymw==
X-Received: by 2002:a62:2b17:: with SMTP id r23-v6mr10535587pfr.251.1542871846262;
        Wed, 21 Nov 2018 23:30:46 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n13-v6sm73272145pfk.19.2018.11.21.23.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 23:30:45 -0800 (PST)
Date:   Wed, 21 Nov 2018 23:30:43 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-mtp: Mark protected gcc clocks
Message-ID: <20181122073043.GN2225@minitux>
References: <20181106055013.11271-1-bjorn.andersson@linaro.org>
 <154279089454.88331.1059903104788594574@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154279089454.88331.1059903104788594574@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21 Nov 01:01 PST 2018, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2018-11-05 21:50:13)
> > As of v4.20-rc1 probing the GCC driver on a SDM845 device with the
> > standard security implementation causes an access violation and an
> > immediate system restart. Use the protected-clocks property to mark the
> > offending clocks protected for the MTP, in order to allow it to boot.
> > 
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > This depends on the acceptance of
> > https://lore.kernel.org/lkml/20181105194011.43770-1-swboyd@chromium.org/
> 
> Do you need me to merge this into clk-fixes so that Andy can send this
> up for v4.20 final? I thought you may have other boot blocking issues so
> this wouldn't be a critical fix.
> 

We resolved the gpio-related issues, so iirc this is the only other item
preventing the MTP from booting. So yes please.

Unless you enable USB support, because configuring the first USB
controller in host currently crashes the device - I've not yet found the
cause for this though.

Regards,
Bjorn
