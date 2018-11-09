Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381D4C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E726820883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a69qT5P9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E726820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeKIQLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:11:04 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36966 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeKIQLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:11:04 -0500
Received: by mail-pl1-f196.google.com with SMTP id p6-v6so482312pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5RS/Hj27X3/8n0I58JEsmkThuHOCDwlx8b3A7d1Jzkw=;
        b=a69qT5P9zNLSKyuzXf17DZ0kp7IesRh3IdT5cNlQB+Rr4T4OZu9H2oPio+Ta+g9Vho
         kXGbuf+NVbwv0YhY8MfrdRXWVCu7E8m3AXzP+yCUEqc7rjZPQ2en9+ty2TRHbWrPXbXC
         Q3K69T6w6+l1kQrsZ1Ic/MevWibvqhzzw4la8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5RS/Hj27X3/8n0I58JEsmkThuHOCDwlx8b3A7d1Jzkw=;
        b=TJBvqzbs5Qri8xgr5Fvk4z7v/Lx2BL5x9cRfzAh/9MmqhemYH5rE1m50You5mP4C43
         WWw4DpCocli08/jngZuDyDumWw7kq1Gd0U/igSKvvkbu7gLnOE9hjqWxGejJiupKOubL
         eiBjdo00grLp4vwYV0LKVCf3hnENcbAfYD21O4sIxjvzI7UhmuIgL8G0vqlfRKWFEVmC
         fK3VHJLCK+GCnguUk4hO0hKW2q0K5k5AX86UcH5faMPTWC1NMYTpSAXUJVZOmKc3DtND
         +YwIkeLq1DylKt0qSHBfAysCAg+dIOg/2cR/A8IOyGhXQyo7hRsRl+0YVy609A2segp7
         2PLQ==
X-Gm-Message-State: AGRZ1gIOKQ2aKn+aco0BqwOp2DWI4qrHeKOLDX2YCMyfJnegiMKZwUyk
        k1KlsjRDKIPpu+/JBl5KqfqvQQ==
X-Google-Smtp-Source: AJdET5dOdd9xt6KF+RvsMdzvdRuDAD3/DeA0c+V5nE7fg3goCwa6hN6RvKcpYA3qdTJej8FDw0FPrw==
X-Received: by 2002:a17:902:104:: with SMTP id 4-v6mr7866640plb.184.1541745118214;
        Thu, 08 Nov 2018 22:31:58 -0800 (PST)
Received: from tiger (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id g65-v6sm7680070pfg.98.2018.11.08.22.31.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 22:31:56 -0800 (PST)
Date:   Fri, 9 Nov 2018 14:31:37 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Qualcomm Synopsys High-Speed
 USB PHY binding
Message-ID: <20181109063134.GA20049@tiger>
References: <20181108070449.23572-1-shawn.guo@linaro.org>
 <20181108070449.23572-2-shawn.guo@linaro.org>
 <20181109050819.GK12092@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109050819.GK12092@vkoul-mobl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:38:19AM +0530, Vinod Koul wrote:
> On 08-11-18, 15:04, Shawn Guo wrote:
> > From: Sriharsha Allenki <sallenki@codeaurora.org>
> > 
> > It adds bindings for Synopsys 28nm femto phy controller that supports
> > LS/FS/HS usb connectivity on Qualcomm chipsets.
> > 
> > Signed-off-by: Sriharsha Allenki <sallenki@codeaurora.org>
> > Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  .../phy/qcom,snps-28nm-usb-hs-phy.txt         | 101 ++++++++++++++++++
> >  1 file changed, 101 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt b/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
> > new file mode 100644
> > index 000000000000..75e7a09dd558
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
> > @@ -0,0 +1,101 @@
> > +Qualcomm Synopsys 28nm Femto phy controller
> > +===========================================
> > +
> > +Synopsys 28nm femto phy controller supports LS/FS/HS usb connectivity on
> > +Qualcomm chipsets.
> > +
> > +Required properties:
> > +
> > +- compatible:
> > +    Value type: <string>
> > +    Definition: Should contain "qcom,usb-snps-hsphy".
> > +
> > +- reg:
> > +    Value type: <prop-encoded-array>
> > +    Definition: USB PHY base address and length of the register map.
> > +
> > +- #phy-cells:
> > +    Value type: <u32>
> > +    Definition: Should be 0.
> 
> I dont quite understand the definition that it should be 0, maybe you
> mean allowed value is 0, if so why have this property?

The property is defined by generic phy bindings phy/phy-bindings.txt.
I can add a pointer to it if you think that's necessary.  The property
should be 0 for our device, because there is zero number cell in phy
specifier from dwc3 node as shown in the example.

	dwc3@78c0000 {
		...
		phys = <&usb2_phy_prim>;
		phy-names = "usb2-phy";
	}

And for that reason, we can use the generic .of_xlate implementation
of_phy_simple_xlate() provided by phy core.  There are some comments
in kernel doc of of_phy_simple_xlate() which might be helpful.

Shawn
