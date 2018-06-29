Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF4DC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613A821479
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N88ASGWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613A821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755350AbeF2SaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:30:22 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40113 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755126AbeF2SaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:30:19 -0400
Received: by mail-pl0-f65.google.com with SMTP id t6-v6so4846122plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mItX7gul4phlvnoA3VlJMxwT+xOxpek8NkB12w4KZSg=;
        b=N88ASGWNSib1S9KkwoahmnLho6rs+DuO07wqIaXfkPlbNvjaBIqqqkcYup++6+X0nl
         8eWZCT1EAxIFIoU6HEuyB5xItB3GGQYCf2PDYtPyXlbWjcRAEiJNtBfYEm4R5WaFJhlW
         m4+shvWu8tkJXpOV6Wh0RIyHZLe6bc9ey13iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mItX7gul4phlvnoA3VlJMxwT+xOxpek8NkB12w4KZSg=;
        b=DvjDXznhyX+dOuFpLneFEJ3iD0AmmUsgto7d4mTxES6t3Leywc1hlhRWhAP2Pg8h9L
         K2Ra565y8i8Tb3/EXtnL2hxUvoEBV24gRxz+YK1TjgzWxlCpX/d3jtogk3j3NzHAeJ1H
         P6BHX+0woZDy7TYXai9RtfaXUt9WT/woFaZ9eGJVkbKNJJJLnME/MOP45P0Qgm9SV8DU
         GkBQ17xCjnMj8mJIt68C3j8PtY21/nnrADDEBQqmOVK9IxIan5PeugprbdyxtXTY1Iml
         RmUyfUkNlTWX9x9Li3XL9dPm6fm//5CuoRFMbekz24VhNFcJwOhrUF2fnUC8ZwIFPvfy
         H1EQ==
X-Gm-Message-State: APt69E2W+CJduCPXASYEHmG/lS3OiolPv5cKXjPXiSeJm0f5d7mplHao
        /3PWXVN/LUpE4cpzQSkot3L9WQ==
X-Google-Smtp-Source: ADUXVKIjuGzerpSSoVXqqvDBCD17I5cHxYpMWdoDim50JX4bbWZHEgvh0kGGbTNpN4fMCp+DbFDcjw==
X-Received: by 2002:a17:902:6acc:: with SMTP id i12-v6mr15968395plt.278.1530297019397;
        Fri, 29 Jun 2018 11:30:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id y15-v6sm14470337pfm.136.2018.06.29.11.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 11:30:18 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:30:18 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add thermal-zones node
Message-ID: <20180629183018.GU129942@google.com>
References: <20180628210915.160893-1-mka@chromium.org>
 <CAD=FV=UPCgEvN1F5jFhLxq=KrH2_BwEG=ZRX3npy_EPLZ_V0hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=UPCgEvN1F5jFhLxq=KrH2_BwEG=ZRX3npy_EPLZ_V0hA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 03:52:57PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 28, 2018 at 2:09 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > The node is empty for now. It is needed to allow other DT snippets
> > to add thermal zone entries.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Sorry if you received this twice, lists were missing in cc in the first attempt ...
> >
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 00722b533a92..968390fb0933 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -9,6 +9,7 @@
> >  #include <dt-bindings/clock/qcom,rpmh.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> > +#include <dt-bindings/thermal/thermal.h>
> >
> >  / {
> >         interrupt-parent = <&intc>;
> > @@ -1087,4 +1088,7 @@
> >                         };
> >                 };
> >         };
> > +
> > +       thermal_zones: thermal-zones {
> > +       };
> 
> Others can feel free to disagree, but IMO ${SUBJECT} patch is not
> needed.  Instead patch #3 in your series should just define a
> "thermal-zones" node at the root level.  The "thermal-zones" node is a
> well-defined node with a well-defined node name and location (see the
> "thermal.txt" binding).  If the SoC has a "thermal-zones" node and so
> does the PMIC then they'll just be merged.

Just defining it here makes perfect sense, thanks!
