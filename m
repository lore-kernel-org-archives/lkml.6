Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB7AECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1115208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n1Np7tKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1115208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbeGMQxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:53:53 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43999 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729770AbeGMQxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:53:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id y8-v6so22930029pfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9qg/rtsxPLZxuNk0h/sfr1DbEOSQDWGiy3pXY16pKfY=;
        b=n1Np7tKR2qxrdIOSLFTpw+rDB2XPb3z/6WCNqiDRXcap5nxeGiuVn2OB55oHv7+iQM
         RelNlQ3+4lxpUbksC9JXtMhvDqVMrhovmbiPuPzGFukIBVGj+Y6lUqRdGEvMk6c+v6Ji
         1kZofjdigKGKKUxxtjw9BxY6IQUZMI1vgj3uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9qg/rtsxPLZxuNk0h/sfr1DbEOSQDWGiy3pXY16pKfY=;
        b=B46Tt1ExPBnitoYK+b9JYL+Vis608GUWnJhk5nH/a4uK+PxxvnoaVApGfaBhKeucbn
         hKgTwF5Bz6xO1v9wKIipg9bHyA2/zMFEQSF2SBkc5mUnS7td/SCE7sU5PZOdG3DDebR4
         5f6EHiv7wMKezU99auz1kaPP1c4Hd7S/d4mTcFo0KHJcZlCknbfVR61XJfHspqaseomN
         M+ImSianqmEXOivq4nrEkKba6i+W7A3RaWjAnhY1Uebq3kvRSMkj6vu7p1IMCDcdSWSX
         EecyoY1mH8WdKE7T7MomT1M38B/20zqwp2ToWP7Nc/OUW2ACNfQKXlcpTwmsg3dhZECq
         uLXQ==
X-Gm-Message-State: AOUpUlHr274teej0bZ0PhrCyneQG2UJDInZQwISjHx0kzdnCJLyC2Pbf
        kQy47ZJ+AuOmrqcyUTSxoZF07g==
X-Google-Smtp-Source: AAOMgpegBRg4npgH7wgU+1nTfgi0LGJAWAc7c92IS7z6xGQllWzhxmb2yPuaB3Yy2ZFh39MdMHTTkw==
X-Received: by 2002:a62:9f16:: with SMTP id g22-v6mr7722810pfe.207.1531499909660;
        Fri, 13 Jul 2018 09:38:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id s87-v6sm48332880pfg.172.2018.07.13.09.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 09:38:28 -0700 (PDT)
Date:   Fri, 13 Jul 2018 09:38:28 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
Message-ID: <20180713163828.GW129942@google.com>
References: <20180709212522.187257-1-mka@chromium.org>
 <153149761947.48062.16210609862063613310@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <153149761947.48062.16210609862063613310@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 09:00:19AM -0700, Stephen Boyd wrote:
> Quoting Matthias Kaehlcke (2018-07-09 14:25:21)
> > diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > index 92bed1e7d4bb..7eea94701b23 100644
> > --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > @@ -11,6 +11,13 @@
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> >  
> > +               pm8998_temp: temp-alarm@2400 {
> 
> Are we sorting this file based on node name or unit address? Otherwise
> patch looks good.

The idea was to sort by address, following the 'convention' of
sdm845.dtsi (https://patchwork.kernel.org/patch/10381745/).
