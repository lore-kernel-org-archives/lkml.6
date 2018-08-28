Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08336C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54EA2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k3gk7pqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54EA2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeH1VEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:04:36 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42871 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727292AbeH1VEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:04:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id g23-v6so995532plq.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 10:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QbOLXhV0EeL1OknsaL288wdsGULwdu9JWUn78ZgfRfU=;
        b=k3gk7pqkxNWP/9zB3O3SOoYYseo/eAq7t3+s8W0u4kxAM4hiz2LrpuybZWue5ZFK/n
         tblkEf+NjJWO3i/hSGVaqYO9hD2ybcFDcBLszN7rQ+LYFFuVAdNbeQx97QhMnQdZ9kVQ
         arTgBONUiyfF2LLfhbMZfOKmw8zpOSCZhVay4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QbOLXhV0EeL1OknsaL288wdsGULwdu9JWUn78ZgfRfU=;
        b=QMQIp2Er2eblYJskK3Y6xcl5d+h+sD00r13vKVT8OXxjwMu6o1Fq6W2C9yLRx+TdLG
         ztjht1b8CyT33VrIyIrCA0oBP8z8RR2Sjqpy38d54zy0eVdkArV9q0w8G2gb0V0s+y8a
         TPoBVXjYT9bmpXxWviXPoNOllsY4igH+hzBU2jiuifQ8V2fsWISvb+VftMqDkNoZ35n2
         1lrauywHP1C9pfeVlX5hQiHh8N/rI+u4dHRuPXcbxBmAUYkSzfWaiTrG6EZlKg5YJnHS
         T4ys1pWY4hlHhHoaDTqQDPyehR+0OZQPAumzXkk5QxSu5B0VlzsojXdP+Px3wQy79o9s
         cYqA==
X-Gm-Message-State: APzg51A9hWl2ilWu295qjZxHIR3SKoaI8wJ+ZotdKzDgXPDhbvaYSyUu
        kW/DyumNcAgrLBmvZfqy0+i7DQ==
X-Google-Smtp-Source: ANB0VdYv09rEY35Ie3IHh7WPfC/H2rxqcVtuui30/+zDwwG/X6GLvDipS8ZaZ07eynreYVyedKUHTQ==
X-Received: by 2002:a17:902:a60a:: with SMTP id u10-v6mr2448750plq.104.1535476319388;
        Tue, 28 Aug 2018 10:11:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id h69-v6sm2914078pfh.13.2018.08.28.10.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 10:11:58 -0700 (PDT)
Date:   Tue, 28 Aug 2018 10:11:58 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     sibis@codeaurora.org
Cc:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ohad@wizery.com, mark.rutland@arm.com, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH v2 1/6] dt-bindings: reset: Add PDC Global binding for
 SDM845 SoCs
Message-ID: <20180828171158.GB10879@google.com>
References: <20180824131900.5353-1-sibis@codeaurora.org>
 <20180824131900.5353-2-sibis@codeaurora.org>
 <20180828003823.GY160295@google.com>
 <c675b609fcd0d243e4db2e6637c70902@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c675b609fcd0d243e4db2e6637c70902@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 11:38:26AM +0530, sibis@codeaurora.org wrote:
> Hi Matthias,
> Thanks for the review
> 
> On 2018-08-28 06:08, Matthias Kaehlcke wrote:
> > Hi Sibi,
> > 
> > On Fri, Aug 24, 2018 at 06:48:55PM +0530, Sibi Sankar wrote:
> > > Add PDC Global(Power Domain Controller) binding for SDM845 SoCs.
> > 
> > nit: missing blank before the opening parenthesis.
> > 
> 
> Will fix it
> 
> > > 
> > > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> > > ---
> > >  .../bindings/reset/qcom,pdc-global.txt        | 52
> > > +++++++++++++++++++
> > >  include/dt-bindings/reset/qcom,sdm845-pdc.h   | 20 +++++++
> > >  2 files changed, 72 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
> > >  create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
> > > b/Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
> > > new file mode 100644
> > > index 000000000000..69f9edca9503
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
> > > @@ -0,0 +1,52 @@
> > > +PDC Global
> > > +======================================
> > > +
> > > +This binding describes a reset-controller found on PDC-Global(Power
> > > Domain
> > > +Controller) block for Qualcomm Technologies Inc SDM845 SoCs.
> > 
> > Are there other PDC reset controllers that aren't 'global'? Otherwise
> > I'd suggest to use 'pdc-reset' instead of 'pdc-global', which is more
> > specific and in line with the name of the driver added by this series.
> > Or something like 'pdc-reset-global/main' if there are other
> > controllers?
> > 
> 
> These are the only reset lines found in the pdc-global register space. But
> as
> explained by Bjorn, wouldn't it be better to leave it as such since
> pdc-global
> best describes the hardware without being limited by the current
> functionality
> it is being used for?

If I understand Bjorn's reply on
https://patchwork.kernel.org/patch/10575335/ correctly it is planned
to use the 'pdc-global' compatible string in the future in some sort
of MFD driver for the 'PDC Global' IP block, which then instantiates
other drivers like the reset controller. In this case I agree that
'pdc-global' seems a reasonable choice.
