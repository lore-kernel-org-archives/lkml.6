Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D713C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70262083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544204194;
	bh=jzosZpNl+FiExH0xW0Qs+NPb7IQUm3c0Gws8FdhwJ08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1K91sXkycBpvSdf9NGaqZR4B0Ngy8+sZwn9BgD25FnrGSoiKh2ixdnPiCte1U9viM
	 RbW41O8mEwDsi+cMrelDtoo1SMTCIAyXQ8R89qxb0ct2aos4xlkPMOn1qHC7orNST5
	 TmBq1B7FDssFZcp+icwaQrFEpGxJdtcLpgYChNsY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70262083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeLGRgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:36:32 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39429 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeLGRgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:36:32 -0500
Received: by mail-ot1-f65.google.com with SMTP id n8so4523174otl.6;
        Fri, 07 Dec 2018 09:36:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tC2xy8Vly8lZisGGjQMEFFtCmApSofx7Kl/XdkfgGso=;
        b=HdJUYOc4mLysmmQC/VtA10Z0jNRUUCJIwVumrAG/Ck6V+V/Ug+p/lMDzOrHMDwFld5
         Esg1ggG4xPxZYu8lmYinzjj5fLTh/l0s8MW/tCaGFE/emz5e6YLqlgTd06W7j0QVfKO3
         b3o4BpyxDzIql5fl415xLx7adiubqRXhvlz1pfoeisMfYCRLbdH/RrB7c1hooLeFVuPg
         VAqYSMmeCTLYF0m3nPjrnrsYWQ8jtZv8JtfP/8Qwy4IXiBFL4DaWX8faljpyE6eGmwKI
         PXkXKdUk6RSHXhVa7Kh861tvH2H1WS7v9qhPYCNpPMXL3WC4ttfIVbyBJJnZLFED6p1L
         hUvw==
X-Gm-Message-State: AA+aEWbrxqJhVqb3/wjI3RwjPjwjKqHXKdFeDeaiSq3a2FaUwslTlTp3
        ImzQwfyJXZfJTN8WfWDdTQ==
X-Google-Smtp-Source: AFSGD/XUTt9a4XjP+OgTbLwLZAc1xOpzOITIkW1MdGRqQIkrOY3ZigRKelJA8yAvp9SMq9JCUCT8hA==
X-Received: by 2002:a9d:14e:: with SMTP id 72mr2144088otu.54.1544204190409;
        Fri, 07 Dec 2018 09:36:30 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m2sm3815177otp.34.2018.12.07.09.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 09:36:29 -0800 (PST)
Date:   Fri, 7 Dec 2018 11:36:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, ulf.hansson@linaro.org,
        viresh.kumar@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/8] arm64: dts: sdm845: Add rpmh powercontroller node
Message-ID: <20181207173629.GA4443@bogus>
References: <20181204052119.806-1-rnayak@codeaurora.org>
 <20181204052119.806-8-rnayak@codeaurora.org>
 <154396536335.88331.9265777410326926096@swboyd.mtv.corp.google.com>
 <f6c6f238-0d5e-e47c-caf7-7e45bd1327dc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6c6f238-0d5e-e47c-caf7-7e45bd1327dc@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 12:37:29PM +0530, Rajendra Nayak wrote:
> 
> 
> On 12/5/2018 4:46 AM, Stephen Boyd wrote:
> > Quoting Rajendra Nayak (2018-12-03 21:21:18)
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > index b72bdb0a31a5..a6d0cd8d17b0 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > @@ -1324,6 +1325,56 @@
> > >                                  compatible = "qcom,sdm845-rpmh-clk";
> > >                                  #clock-cells = <1>;
> > >                          };
> > > +
> > > +                       rpmhpd: power-controller {
> > > +                               compatible = "qcom,sdm845-rpmhpd";
> > > +                               #power-domain-cells = <1>;
> > > +                               operating-points-v2 = <&rpmhpd_opp_table>;
> > > +                       };
> > > +
> > > +                       rpmhpd_opp_table: opp-table {
> > 
> > This table should go somewhere else? I don't understand why it's in the
> > rpmh node because it's not an rpmh device. Does it go to the root? Or
> > does it go under rpmhpd itself? I'm not sure.
> 
> I could move it to root perhaps, we seem to do that atleast in the case of
> GPU. The power domain bindings (Documentation/devicetree/bindings/power/power_domain.txt)
> seem to suggest it can't be under the power-controller node itself.

Why not? I don't see anything forbidding that like already having some 
other type of child nodes. It's a little weird to have 
operating-points-v2 point to a child node, but that will still work.

Rob
