Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA091C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E5C2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vzzo20bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfAVTZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:25:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43352 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfAVTZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:25:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so12232468pfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 11:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G29wjMkLj+Y2nfu//z6vHYUDN//Ak1WE+QM/90U42Dk=;
        b=Vzzo20bssNoGII46AxgitJ2qgj8Lkip67EN9b63vk7oo5OZ5qoHTTIGuYpkEWcCdao
         TxyV5b3+Plf5yTSshYSdj4HiSemaLwhx43r7sdLgt0TLfXHXiGzmO1+pIh165hp8wxTU
         9TZoLTIRlUNXHu8jOX+5gVYlPcv+MIsuOLFww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G29wjMkLj+Y2nfu//z6vHYUDN//Ak1WE+QM/90U42Dk=;
        b=U8Je2Pm5zoT2dbPvS/CrkeIjVgJCSPnYsd9SG8qPScBgSTr1K0nV7GLG1kYklVRGu3
         E4w5Z7a1QDmBM3Z22rE/3JowRWyD8t08a/oGpx4QJRMAEf5mWacOYipnevpJNA0xpwha
         C4kHj8NiajQGbIHtcOKQ92RFzV9U4kzUVODXpYRfGRA4wVqKuHxLZqNn6ISImiP89wg4
         QsPgnE7BPjOPBSmDo+wuD/pGAFusPlJsGDhty7U7ooFnJmF7sBKSxam3Dnso6UdDAk89
         M2uv3XrnNeOod2AkcHRWCGq20zs5hQjyFbB8ar2VVlCNep+DorsP1Nx6CnXKGu7u6AKy
         OkdA==
X-Gm-Message-State: AJcUukfoBnzNTYaKPFpvu8WtQXSQA8h5y1TEqjEdMnFems79Kzr7l++W
        f5eMEYU3nxzL9z7rsvN4QacW9A==
X-Google-Smtp-Source: ALg8bN4/p0dUDPtGKrVGlQwzCO6tme4ouE5Ay8xGtyZcL8X27Tp+SHRPS92t6FqUMWsRsfuOvuj0Ng==
X-Received: by 2002:a63:c24c:: with SMTP id l12mr33328662pgg.146.1548185140592;
        Tue, 22 Jan 2019 11:25:40 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j197sm20789591pgc.76.2019.01.22.11.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 11:25:39 -0800 (PST)
Date:   Tue, 22 Jan 2019 11:25:37 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/10] dt-bindings: soc: qcom: Add AOSS QMP binding
Message-ID: <20190122192537.GC31919@minitux>
References: <20190122055112.30943-1-bjorn.andersson@linaro.org>
 <20190122055112.30943-5-bjorn.andersson@linaro.org>
 <154818385792.20280.7601798748317142776@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154818385792.20280.7601798748317142776@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 Jan 11:04 PST 2019, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2019-01-21 21:51:06)
> > Add binding for the QMP based side-channel communication mechanism to
> > the AOSS, which is used to control resources not exposed through the
> > RPMh interface.
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v2:
> > - Update indentation of example
> > - Add colling device subnodes to the description
> > 
> >  .../bindings/soc/qcom/qcom,aoss-qmp.txt       | 75 +++++++++++++++++++
> >  include/dt-bindings/power/qcom-aoss-qmp.h     | 15 ++++
> >  2 files changed, 90 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
> >  create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
> > new file mode 100644
> > index 000000000000..881dc8c7907a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
> > @@ -0,0 +1,75 @@
> > +Qualcomm Always-On Subsystem side channel binding
> > +
> > +This binding describes the hardware component responsible for side channel
> > +requests to the always-on subsystem (AOSS), used for certain power management
> > +requests that is not handled by the standard RPMh interface. Each client in the
> > +SoC has it's own block of message RAM and IRQ for communication with the AOSS.
> > +The protocol used to communicate in the message RAM is known as QMP.
> 
> Just curious if QMP is "Qualcomm Messaging Protocol"? I don't think it's
> ever spelled out in this patchset.
> 

I believe that is the case, would you like me to spell it out?
