Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF8FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B7020844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P9r1O0ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B7020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbeIGAtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:49:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33914 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbeIGAtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:49:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so5835427pfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 13:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cCXoOEo4xOFfLCVn0k5ds6/abD8olm3SEr37XnyQtVA=;
        b=P9r1O0ut0VAkWkBShj7FQqd1ynjvoHNRLyu9vse+mQ9ARCrKzy6Q9o3Vd1UlHofdRV
         DWeNbMXrzkpOkip7Golw70JMymtAY2YKY7b4OFd65Q615+XpxEHuFJ0GaukxVEBPYcjj
         WV+s5aXjap6eZKzN7tCFdxWBhseaxWg6RPffU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cCXoOEo4xOFfLCVn0k5ds6/abD8olm3SEr37XnyQtVA=;
        b=X0IdPP3ie9ZzJUTPQTPoIzy7s0+V3Nl8ADzI65DZR62o4V1/IMh89qA7xvOHesm/GB
         FrNOzEM3bQGvANxvCjFgQY19N8mtjrAJ1NPum3cvgfW38iCjRS2iQo2b7+SrY3ZyB4sq
         OSHMhehV46b9R7G0T7qMi42UbJzOqTSUed3vANlS+IWrEAZz+8ZIIb4Wi9ywNo1RnRqx
         G4VRAsINtf8866DcCcWRhJn3XaXsgbsSeXdRFAnJw6wPZoD7BHXZrfIZf+NTrkNy+d1v
         0wjwR4Pn7CTs7VF/LJFWxS9+RESnzLBudqhZJxOSLq6iwKncUQeROZ6DOyi2o72LM+IM
         jONg==
X-Gm-Message-State: APzg51Bdd2b+2DKA/CnRGUQBR45Bwr8Qt/ixhifixSFFiWoS/N2HZDxe
        FjiInDB45U6NhyXTb0taToPQBA==
X-Google-Smtp-Source: ANB0VdZp3N0oykEdBP6GuDZvUteFQDgAuucmFYJpfXuexhnZPr/xJqszddf2bBYpcftnFOpAA/8aLw==
X-Received: by 2002:a63:d09:: with SMTP id c9-v6mr4709814pgl.314.1536264728946;
        Thu, 06 Sep 2018 13:12:08 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q80-v6sm8538911pfd.15.2018.09.06.13.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 13:12:08 -0700 (PDT)
Date:   Thu, 6 Sep 2018 13:12:06 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-mtp: pm8998 and pmi8998
 regulators
Message-ID: <20180906201206.GX2523@minitux>
References: <20180901221953.21666-1-bjorn.andersson@linaro.org>
 <CAD=FV=VE5gYyivgy=OrZV6g0UrtYfZZ+CGv7DV+v5be3teVSdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VE5gYyivgy=OrZV6g0UrtYfZZ+CGv7DV+v5be3teVSdw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06 Sep 10:52 PDT 2018, Doug Anderson wrote:

> Bjorn,
> 
> On Sat, Sep 1, 2018 at 3:19 PM, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > Add regulator definitions for pm8998 and pmi8998 regulators on the MTP.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 216 ++++++++++++++++++++++++
> >  1 file changed, 216 insertions(+)
> 
> I'm curious why you chose to post this instead of reviewing and/or
> building upon the patch I sent up at
> <https://lkml.kernel.org/r/20180822173629.202885-3-dianders@chromium.org>.

Sorry about that, my search skills failed me.

> Compared to mine, yours:
> 
> * Seems to have a few rails named differently LDO22 is named
> "vreg_l22a_2p95" in your DTS but "vreg_l22a_2p85" in mine as one
> example.  The schematics I have (from Dec 5, 2017) show it as 2p85.
> 

Looks like a typo on my part, yours matches the schematics I have as
well.

> * Is missing "regulator-initial-mode".  We can debate this if you want.
> 

Either we start by making them all HPM or we tune as we debug, I'm fine
with your suggestion.

> * Is lacking many alternate names for rails.  We can debate this also
> if you want.
> 

Afaict names such as "vdda_pcie_1p2" is the name of the pin on the
SDM845, while the thing that comes out of the regulator is named
vreg_l26a_1p2.

So I believe this name should be used in the pcie node as:

  vdda_pcie_1p2-supply = <&vreg_l26a_1p2>;

> * Have a few voltage values different.  If you have better info than
> me we should update to yours.  Diffing against yours does make me
> believe that perhaps LDO14 should be listed as 1.88 V in my patch.
> 

Downstream it's listed as min: 1.8V max: 1.88V init: 1.8V.

> * Is lacking pm8005.
> 

I didn't need this, yet...

> Anyway, let me know.  If you provide a review of my patch I'm happy to
> spin it with your feedback.
> 

I will review your patches.

Regards,
Bjorn
