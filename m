Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B041C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C443520868
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gX+7lNPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfAWArr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:47:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33240 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfAWArq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:47:46 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so263879pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 16:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dlfBrqE+HWgQqWqQOj3BNs1ESOk5l7RBOHvtp2nvnZs=;
        b=gX+7lNPEFLv53Gun8cXbCKpnHoejb683tP13qlBt4soH33eDW9nVwDYmekohHDVWEF
         qKwyRk7HoThZvjRVAH0HL8UsLXreRrxKaX5EuBuDSD7bdFtSGKu1TvIf5xmLRp+UgklQ
         nSrN3PyrM2RZpaUYoeTurz1fDottOieJBnpMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dlfBrqE+HWgQqWqQOj3BNs1ESOk5l7RBOHvtp2nvnZs=;
        b=ogQHmzZnIlaIsOSHv1pJAxA+7mAqSTKgMaiR4E9UV34/GgHWh/sEpbIvDzMf5hpv85
         Yu5Xx6XtVAQ1uCpsnPk4GKXaL6xIDqr3PRC7TbdolCPr9RhWpVcdJUcXTJ415VsXrd1K
         Xo/caBGLcI+/LGW4486JuqKnNgNNu9QEY+A4PN1Iq8uNe4jRlQK4xIIEsdsyqWAq1xT5
         kzB/BkuQhL68O+ZbkTropBl7PC7Ncru49zVCPlxFZ2LB42/7/NhEEtwcByG8CVTy0Dwy
         7HHhRhtyhuCGgHxuHBKcGvNOM9Rty7C41kNMGJK3myKbNg+xHndzb6er65o3TH0z8Kxi
         qPZg==
X-Gm-Message-State: AJcUukeIUF6e3zzeg+hF6mbE/xpEI3ugSbTVyOnDTj3Q1yWmkLwOFDLL
        xjhnM9ksuRVlgVbV1We/tZBDXQ==
X-Google-Smtp-Source: ALg8bN5qkwcZ/XroZO9wnGYUTfL07bi8uH4DWuXam0nD/bQ4T31QqXmgU9jN9/XFb/0uWfxsMnUcPQ==
X-Received: by 2002:a63:a35c:: with SMTP id v28mr113119pgn.205.1548204465485;
        Tue, 22 Jan 2019 16:47:45 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h128sm40762621pgc.15.2019.01.22.16.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 16:47:44 -0800 (PST)
Date:   Tue, 22 Jan 2019 16:47:42 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Ben Chan <benchan@google.com>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3 02/10] arm64: dts: qcom: sdm845: Define rmtfs memory
Message-ID: <20190123004742.GH31919@minitux>
References: <20190122055112.30943-1-bjorn.andersson@linaro.org>
 <20190122055112.30943-3-bjorn.andersson@linaro.org>
 <CAD=FV=X0x4hQ=8yQ6wDWE8ximf9A8hpgpRWTdPrFXDD4FVO8VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=X0x4hQ=8yQ6wDWE8ximf9A8hpgpRWTdPrFXDD4FVO8VQ@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 Jan 15:26 PST 2019, Doug Anderson wrote:

> Hi,
> 
> On Mon, Jan 21, 2019 at 9:51 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > Define the rmtfs memory node, as described in version 10 of the memory
> > map.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >
> > Changes since v2:
> > - New patch
> >
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index cdcac3704c13..64f57cc5c61a 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -72,6 +72,15 @@
> >                 #size-cells = <2>;
> >                 ranges;
> >
> > +               rmtfs@85d00000 {
> > +                       compatible = "qcom,rmtfs-mem";
> > +                       reg = <0 0x85d00000 0 0x200000>;
> > +                       no-map;
> > +
> > +                       qcom,client-id = <1>;
> > +                       qcom,vmid = <15>;
> > +               };
> 
> Ah, I saw this after I posted my comments to patch #1.  I guess this
> is the same as this node we have in our cheza board file downstream
> (need to get that posted upstream soon):
> 
> rmtfs@88f00000 {
>   compatible = "qcom,rmtfs-mem";
>   reg = <0x0 0x88f00000 0x0 0x800000>;
>   no-map;
> 
>   qcom,client-id = <1>;
> };
> 
> That brings up a few things:
> 
> 1. You should add a node label here.  This allows us to act on the
> node more easily from board files, like setting it to disabled or
> changing it.
> 

I'll make sure to label it.

> 2. In https://crrev.com/c/1119572, the argument was made that the size
> of this carveout is board-specific.  That makes it hard to put it in
> sdm845.dts.
> 

I don't think I've seen a modern platform where this isn't 2MB, so I
think it's safe to add it to the platform. But a label sounds good, if
someone out there has a custom modem firmware with some odd changes in
this area.

I'll label it, to make it possible to move, resize or reclaim in boards.

Regards,
Bjorn
