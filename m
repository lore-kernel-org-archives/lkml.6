Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55FEC282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D9121019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f2IEo5dQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfAWAkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:40:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35890 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfAWAkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:40:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so244924pfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 16:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cTj+oBqZshiYHNrvZjpClGJBGUqsmCLF6ICD2bj9n3Y=;
        b=f2IEo5dQRacxHIS0G4X6XnNny6OvflGL93/DiYSjvbJWFP9WmRRJRRRODWyj4GWWO0
         VPc2oB7LxWrP65uZhnMPmqP2GRLbBpVvflsidTzmaglBZcBuj9pZR3eY/AfNtvJlOLaZ
         BLrSBhaBT8FudvezP5ZaasTxj2jYnXnB+lCtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cTj+oBqZshiYHNrvZjpClGJBGUqsmCLF6ICD2bj9n3Y=;
        b=ctN3qi5QgyvubNJr1FkJYxRKMB6NfFxhwxcl4s1K9j6QYdHhS3i9lbO6nG88nT3nvj
         rr/skP+6OMQrBf4G2MUjm8xqyADyzQFqCMfeLIMrnQ2PF1z1zsgfB08ULpaLLVh1pXGy
         O9rMCgL9q0H2uqx12iQK2oKQKzOM9WbcR3qDEuoet3fUN3nuGIwifTfW76Hb5+/TY2N3
         DjYMycPcKYeWGPLTXEqrT7ibmy4GPDhgsYq0ew48okhJBK3vVp55JzrhIF5a5xpfuyKf
         GX0A9hFYTq590DC9I7XomiB2TjuWz0ioPQ+Mmur3RF9Drd2Cg8D5le/Rq41BDVeYzVM4
         XXeQ==
X-Gm-Message-State: AJcUukfmf/dgTtDlmB3kBw2Yy5gPkfpdFJFw2SclF0fhacE7XB+2Jr6f
        bPRZwVYDOwyy8lH9sj3bgkdxow==
X-Google-Smtp-Source: ALg8bN4astgThK05CINyBCyOKzGtYABllnLrBagiRg/IAlRyILukPK10FtZK8xkKF/allWzgQ34Q5A==
X-Received: by 2002:a65:4049:: with SMTP id h9mr114337pgp.304.1548204001264;
        Tue, 22 Jan 2019 16:40:01 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i4sm30263286pfj.82.2019.01.22.16.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 16:40:00 -0800 (PST)
Date:   Tue, 22 Jan 2019 16:39:58 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/10] arm64: dts: qcom: sdm845: Update PIL region
 memory map
Message-ID: <20190123003958.GG31919@minitux>
References: <20190122055112.30943-1-bjorn.andersson@linaro.org>
 <20190122055112.30943-2-bjorn.andersson@linaro.org>
 <CAD=FV=Ubg2D+1w8AxwYMwFfBZt3ZFf6auPJGDr8+2wE7=DV6Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Ubg2D+1w8AxwYMwFfBZt3ZFf6auPJGDr8+2wE7=DV6Yw@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 Jan 15:16 PST 2019, Doug Anderson wrote:

> Hi,
> 
> On Mon, Jan 21, 2019 at 9:52 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > Update existing and add all missing PIL regions to the reserved memory
> > map, as described in version 10.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >
> > Changes since v2:
> > - New patch
> >
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 61 ++++++++++++++++++++++++++--
> >  1 file changed, 58 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 0ec827394e92..cdcac3704c13 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -89,12 +89,47 @@
> >                 };
> >
> >                 memory@86200000 {
> > -                       reg = <0 0x86200000 0 0x2d00000>;
> > +                       reg = <0 0x86200000 0 0x100000>;
> >                         no-map;
> >                 };
> >
> > -               wlan_msa_mem: memory@96700000 {
> > -                       reg = <0 0x96700000 0 0x100000>;
> > +               memory@86300000 {
> > +                       reg = <0 0x86300000 0 0x4800000>;
> > +                       no-map;
> > +               };
> 
> I know it's not a problem upstream (yet), but downstream this collides
> with a memory region in the cheza board.  We have:
> 
> rmtfs@88f00000 {
>   compatible = "qcom,rmtfs-mem";
>   reg = <0x0 0x88f00000 0x0 0x800000>;
>   no-map;
> 
>   qcom,client-id = <1>;
> };
> 
> ...and the above region overlays it since it goes till 0x8ab00000
> 

Digging through the table again I see that there's another level here,
so it seems only the first 44MB of these 78MB are reserved for non-APSS
things. So this should actually be 0x2c00000 long.

I will update this and we'll have one conflict less.

> 
> > +
> > +               memory@8ab00000 {
> > +                       reg = <0 0x8ab00000 0 0x1400000>;
> > +                       no-map;
> > +               };
> > +
> > +               memory@8bf00000 {
> > +                       reg = <0 0x8bf00000 0 0x500000>;
> > +                       no-map;
> > +               };
> > +
> > +               ipa_fw_mem: memory@8c400000 {
> > +                       reg = <0 0x8c400000 0 0x10000>;
> > +                       no-map;
> > +               };
> > +
> > +               ipa_gsi_mem: memory@8c410000 {
> > +                       reg = <0 0x8c410000 0 0x5000>;
> > +                       no-map;
> > +               };
> > +
> > +               memory@8c415000 {
> > +                       reg = <0 0x8c415000 0 0x2000>;
> > +                       no-map;
> > +               };
> > +
> > +               adsp_mem: memory@8c500000 {
> > +                       reg = <0 0x8c500000 0 0x1a00000>;
> > +                       no-map;
> > +               };
> > +
> > +               wlan_msa_mem: memory@8df00000 {
> 
> Your patch moves 'wlan_msa_mem' from 0x96700000 to 0x8df00000.  Is
> that OK?  I haven't been involved in all of the previous discussions
> but if everything is all OK w/ the device tree just moving this chunk
> around (without any other coordination w/ firmware) it seems really
> weird that we even need to specify it in the device tree.  ...but
> maybe I shouldn't open this can of worms.  You can pretend I didn't
> say anything.
> 

0x96700000 seems to be reserved for the sensor core, so either WiFi
wasn't actually tested before, or more likely its firmware is position
independent.

Most (all?) firmware is position independent, but the security
configuration prevents us from relocating it. One such example is that
the ADSP in the newer firmware versions are not allowed to execute from
the old memory region.

Regards,
Bjorn
