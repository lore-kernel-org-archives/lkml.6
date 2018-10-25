Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DF4ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F124620834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JtDYxtk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F124620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbeJZFMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:12:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34509 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeJZFMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:12:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id g12-v6so4577889pgs.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iuhhLYWtDtX4hqesnv7GhJsIsubIoHe/yfabGPoTWwk=;
        b=JtDYxtk5ANxr/0mKAfzuycN55DUd8qEWYfV4MsjLVQ8MmSYGGYOTQNEnuVm5M0mF/X
         X9ZwqLDK5jmhdsmBLrOSkMe8EbjyvvKbY6zP0/JdnM8ia5r4ohpzRAN/9DMWQuRBNLT2
         lC0WWKkS/a8jcCHSTeie2RoI9fo5rucuqWRwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iuhhLYWtDtX4hqesnv7GhJsIsubIoHe/yfabGPoTWwk=;
        b=LkBgZIBy+u3hDSJGqrj3Abfykv4jU4u55ZNu6jqp7jaYNXZuIa/kmy4btslCcLS31h
         7xZoAfDhHe5VPLu4pbKaUaZjbNYc4tFL4MPBj0VNBTBZjQy9RJ7dlsWJyykotSeYnneu
         R/O1z3M/YxdJ5FBRmOV9ctpdWG+EjMGibWHfWRMN9ECdUSErulBDRim9f183K4jIBIbN
         viVPRFOar8w2V7sH8XvhRRtXQRjiG3EU05aF+98YTKsUut2MtN2oJ57tZRUDL3YDNFl7
         vU1ON87K2pIMiHM61EfBYStEj9tc5R7c4FSY8XWbVRS2z7cgX/1npGSBLdJpeGBtbsRu
         +VRA==
X-Gm-Message-State: AGRZ1gKSgaPFPJ2l9PUhYdQPDP0zlwfyooaPPMhJ8QDpQgPeQJeQtjyf
        CeBUgnxDTETlOJbb6OsahBOPUA==
X-Google-Smtp-Source: AJdET5etVOaIOBxo2MAAHqmC8HxLofqJKqD54fh83ScPkw0H4jl/8OxjxvzqWfiiPTJjaZaNU6UyLw==
X-Received: by 2002:a63:cc:: with SMTP id 195-v6mr653903pga.44.1540499873506;
        Thu, 25 Oct 2018 13:37:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id p11-v6sm10286639pfo.65.2018.10.25.13.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 13:37:52 -0700 (PDT)
Date:   Thu, 25 Oct 2018 13:37:52 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org, Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 16/16] arm64: dts: sdm845: enable tsens thermal zones
Message-ID: <20181025203752.GA22824@google.com>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
 <5e2d5fc463a5f5623c4fc1b18ccdf62adc954758.1536744310.git.amit.kucheria@linaro.org>
 <20181025192501.GZ22824@google.com>
 <CAP245DUFi1UWqnVfgxdeZHVHSx9Sn3z3AqVp_x5GGHHAvwAjyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP245DUFi1UWqnVfgxdeZHVHSx9Sn3z3AqVp_x5GGHHAvwAjyA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 01:33:40AM +0530, Amit Kucheria wrote:
> On Fri, Oct 26, 2018 at 12:55 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Hi Amit,
> >
> > vaguely related question, since you are working on SDM845 thermal
> > stuff: Do you have plans to add CPU cooling devices? I raised the
> > point during the review of the CPUfreq HW, however there was no
> > clear answer: https://lore.kernel.org/patchwork/patch/966833/#1164748
> > The driver is still under development/review, but I wonder what the
> > path forward is.
> >
> 
> Hi Matthias,
> 
> I plan to

Great!

> but the OSM driver doesn't work well enough for me to send
> out that patch yet. I responded with my findings on the v9 posting
> where it seems to get stuck at the high OPP. It'd be nice if somebody
> else could confirm (or refute) this behaviour.

Ok, we aren't using the latest version yet, I'll try to repro and
report back.

Cheers

Matthias
