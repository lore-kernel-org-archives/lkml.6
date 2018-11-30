Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7443C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804AD20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHtThs6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804AD20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeK3Sfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:35:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35956 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeK3Sfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:35:51 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so2370797pfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 23:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6czgDvtOK84cQiH27gj58EcxjHCyIgKR400QoIHUptw=;
        b=FHtThs6UpCZbBKJ/ExPsF7EqkZMjHKczQyqT7U7YG2kia5CN8tvZ9DzQeia6y8L3Is
         xovFphAWiCZGw8+odr6RdGMLHv4HYTHarYmbNJAzOKSG5oU2J7LsExWPhF2ojo5AmStP
         tfdGn1NChoLEn/rRn4rFN5yCyhNuCuRTqTwEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6czgDvtOK84cQiH27gj58EcxjHCyIgKR400QoIHUptw=;
        b=cO52wc+9wO/bH3IjSx8JrCvDPs4D+0rXvah4x1D8i0OprGu9w4mJhWANehBOhELE24
         rZyDJbhYqGHjrE51tAAusF6Dy1Hz3WBh1il6sm78L4w52gd5WZ1Vf7FfnU/JnI8fGuWa
         RxtTkj7zzrpL0fczAAzRZSwXEMnegbmdi7mYYh88aS8C6YOB5rAcxdrwQvGaWkWq4cAH
         9rWvqe1YK2THkWJJsz57UQOsYkJzWenl0FaGmLSEg7aoajfCwbK/I8dPIxtxMRG9rsfs
         hHcZuKenD1ajYDKLNNClqWidKYrV6Vkhywwuf/B+qTNcDZsqamr7dWZuZE6r9UISixDI
         vqWQ==
X-Gm-Message-State: AA+aEWZ51gbe2pFUzDAB9M24Q7tt6bLN5M+dXSOP1HtnXHzU7zkdLTUI
        tYckWzW0arRYrdmsn3GQCjraGQ==
X-Google-Smtp-Source: AFSGD/VtmeqXwejpd/jSmZwn1a6DZlBSXlyrjlndOrmS7Sp566bbI/Ugk+vywZP0OYTsSfmwYkAscg==
X-Received: by 2002:a63:4b25:: with SMTP id y37mr4076905pga.181.1543562849166;
        Thu, 29 Nov 2018 23:27:29 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b10sm8897824pfj.183.2018.11.29.23.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 23:27:28 -0800 (PST)
Date:   Thu, 29 Nov 2018 23:27:25 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH 2/3] clk: qcom: gcc-msm8998: Disable halt check of UFS
 clocks
Message-ID: <20181130072725.GH5278@tuxbook-pro>
References: <20181130065259.26497-1-bjorn.andersson@linaro.org>
 <20181130065259.26497-3-bjorn.andersson@linaro.org>
 <154356160607.88331.15203631970252933137@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154356160607.88331.15203631970252933137@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 29 Nov 23:06 PST 2018, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2018-11-29 22:52:58)
> > Drop the halt check of the UFS symbol clocks, in accordance with other
> > platforms. This makes clk_disable_unused() happy and makes it possible
> > to turn the clocks on again without an error.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Someone was supposed to figure out why we needed to SKIP here instead of
> doing things in the proper order. Is anyone attempting to figure that
> out?
> 

I'm not aware of any such efforts, but looping in Vivek here.

I would be happy to revert this change in 8996, 8998 and 845 once such
fix arrives. But as this is needed to make progress on getting UFS up on
8998 it would be nice to get it merged for now...

Regards,
Bjorn
