Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970EFECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460C720858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7a/EOAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460C720858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeGUTtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:49:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40576 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbeGUTtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:49:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19-v6so13674595ljc.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 11:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZzsyCQk8NcSuCoZL+QyvIrnNTj5l1Fk5wX5gVP3Tw5M=;
        b=V7a/EOAaWa/EZpOjz+oHAwkrxWRSQlOsMzUZ4UtElgESPRF3MCy26D/13W73v3ytb2
         8lGzfl/LPs39NLZqvPcsn0Xo7oPBXGchitLUXGYWkt9mJygGB6eEjUtMfvye+1U+8sQt
         3A/4T42LjHvUlDrQ0ABWXGkvq+/LUShbOJ19w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZzsyCQk8NcSuCoZL+QyvIrnNTj5l1Fk5wX5gVP3Tw5M=;
        b=Fb1gTDNBL/TX67auVZKP7HW9ftt7HLwpX1Gcd9v9KoXna4ChagrXcDFgMFhvuzZ62Z
         pOEdJYEnQWfsIVXlRQBE2RRnEw48nbI05EJt/RY2x1dTmo9aUiQF+UM+s//YTaj9w/vG
         yEmHggVBj4fWs+9e/Ves6e6FYEIM+nGG91KPqkriff18hV1Vin/sB7V+ghZnyxFcE32B
         yXnoq5bwfazudWLMdnLYDm8S5f2wQSHDeufDzieEmExe4LUccjFdc5UuI3PE1v+nBodP
         M4zYFhLRgo/eGnoAzPh7ACjxH82I8CC6DqZ3aiW/fyfidS0Gmz0A3iyf783zsdX+UCc4
         cPuw==
X-Gm-Message-State: AOUpUlEExKhRw4lO3Ov8u55e9X5+cImBSFSxrgP90TMZkKjwoAgCMf03
        fGLd8NFA5NWQj8fJ6pDUrsdylg==
X-Google-Smtp-Source: AAOMgpd9I97g1EVPmTrxA3F2w+CLogtdm7tmXjyZhwx6WWZysGyj7HGKwTwa86AcBbGJjNmLyjhRhw==
X-Received: by 2002:a2e:8616:: with SMTP id a22-v6mr5037572lji.43.1532199319656;
        Sat, 21 Jul 2018 11:55:19 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id 203-v6sm957722ljj.35.2018.07.21.11.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jul 2018 11:55:19 -0700 (PDT)
Date:   Sat, 21 Jul 2018 20:55:16 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        David Brown <david.brown@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: msm8916: drop legacy suffix for clocks used
 by MSM DRM driver
Message-ID: <20180721185516.GA23252@centauri.lan>
References: <20180718145258.15254-1-niklas.cassel@linaro.org>
 <CAP71WjzPxxwNp-FkUsRAP4e_+Z_q12wcLeXryk-eYdLi-WJexg@mail.gmail.com>
 <20180721185147.GH7404@hector.attlocal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721185147.GH7404@hector.attlocal.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 01:51:47PM -0500, Andy Gross wrote:
> On Thu, Jul 19, 2018 at 12:53:04PM +0200, Nicolas Dechesne wrote:
> > hi Niklas,
> > 
> > On Wed, Jul 18, 2018 at 4:53 PM Niklas Cassel <niklas.cassel@linaro.org> wrote:
> > >
> > > Drop legacy suffix for clocks used by MSM DRM driver.
> > 
> > I had the same patch locally, which I forgot to send.. so thanks for
> > sending it ;)
> > 
> > you might want to add in the commit log:
> > 
> >     Since "720c3bb80235 (drm/msm: drop _clk suffix from clk names)",
> > we can see such
> >     messages when booting:
> > 
> 
> I'll amend the log to contain that info Nicolas.

Hello Andy,

There is a V2 of this patch with that info added :)

Kind regards,
Niklas

> 
> Thanks,
> 
> Andy
