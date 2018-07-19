Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81F4ECDFB4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5240D20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VKHPtLgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5240D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeGSENQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 00:13:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46463 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeGSENQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 00:13:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id p23-v6so2921881pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 20:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HVOtnnbRSY7mr/IWtgkXvNZ+IBiZLSNFKc1SCIkaQm0=;
        b=VKHPtLgx7nBghoEyWxP3TFczMazKlZVvIuY4I4xoFRXATHLmadNMtob0R2REZbPh6u
         b/M1j/vQ2axi4yz+XTnE6MU+JvmHYeAZjweu7AZMMN6hFU5lHIDOB3Jyd6q9DpX7r9ql
         izF6FLuBdeGQg7DjM/Yxpc8r618hCD5GPefSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HVOtnnbRSY7mr/IWtgkXvNZ+IBiZLSNFKc1SCIkaQm0=;
        b=fs33z1J7DZ21LZ+6W76Qx4uanAUG+PXhf53nQM887jATpjjYypbmjyrum1HuJayB+b
         k+e+0KYJNFPaelZBnQzau+nPQZwpqwlvI8SfwnrERWNyx95LSiiUz6vl7cap6BCRH1C5
         Ob+S7vZI30MGCQdBYwUcArKhf4ub3oQGxdYk8n/2B9Oy4tahdNuoz59SBG5C0lsjsvrc
         rKpLNtxacxeQYVp2vVp/ZcBS53rAKWt+XJ/IsC3ZzsCWFh8dDh/uTFWkulM0TDKHBoNu
         ODCohXI40xrp0nTKcrL8NYuFvOO0gD/BcXcRKIKj+3nzH3e5H1iR8UyO7WDDzitb4oX+
         H9Og==
X-Gm-Message-State: AOUpUlFqOtetL5HmW1vz9b3ATz3X1d5uUTumNsyB3jaAF27OpthejYMN
        XDmcN9DHYJnlBeVsAkZwtMRmXw==
X-Google-Smtp-Source: AAOMgpfjqMMX7AiJYeLv4uYnx8tHS0SzVshrADFxCFPlR2JzUdYtpBsrbr88uN01v+HY3c6loek5pQ==
X-Received: by 2002:a63:1e66:: with SMTP id p38-v6mr8217025pgm.376.1531971137847;
        Wed, 18 Jul 2018 20:32:17 -0700 (PDT)
Received: from localhost ([122.171.235.75])
        by smtp.gmail.com with ESMTPSA id t12-v6sm6931752pgg.72.2018.07.18.20.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 20:32:17 -0700 (PDT)
Date:   Thu, 19 Jul 2018 09:02:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>, s.hauer@pengutronix.de,
        kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx7d: add missing OPP property for cpu0
Message-ID: <20180719033215.ww2q5mjvgdj34wny@vireshk-i7>
References: <1531896889-21377-1-git-send-email-Anson.Huang@nxp.com>
 <20180719032002.GT4576@dragon>
 <20180719032454.2bxp4eil7lfaijji@vireshk-i7>
 <20180719032609.GV4576@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719032609.GV4576@dragon>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-18, 11:26, Shawn Guo wrote:
> On Thu, Jul 19, 2018 at 08:54:54AM +0530, Viresh Kumar wrote:
> > On 19-07-18, 11:20, Shawn Guo wrote:
> > > On Wed, Jul 18, 2018 at 02:54:49PM +0800, Anson Huang wrote:
> > > > Commit b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for CPUs")
> > > > added "operating-points" property for all CPUs, but missed i.MX7D's cpu0,
> > > > this patch adds it.
> > > > 
> > > > Fixes: b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for CPUs")
> > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > 
> > > In general, when you send a patch fixing a commit, you should have the
> > > author of that commit copied.  I added Viresh here.
> > > 
> > > It looks like a wrong fix to me.  It seems that commit b97872d4eb22
> > > shouldn't change imx7d.dtsi at all.  So the correct fix would be
> > > reverting the change on imx7d.dtsi, @Viresh?
> > 
> > Wow! Can't believe such a stupid mistake got merged and no one noticed
> > :(
> > 
> > Please revert that patch and I will resend the right fix Shawn.
> 
> Please just send a incremental fix patch for that commit.

Sure. Actually I almost wrote the patch but then realized that it
wouldn't be fair for me to send a patch for something Anson has been
working on.

@Anson: Please send a patch to remove the "operating-points" property.

-- 
viresh
