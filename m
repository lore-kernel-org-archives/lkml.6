Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2D9C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFFA2175A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQGMBvC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFFA2175A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbeHMVXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:23:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34503 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbeHMVXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:23:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id y5-v6so7932949pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 11:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eVpCjFtqFJ7UUqA6mmkrlFvoXm7xitUCYiXtCc6Ee/U=;
        b=KQGMBvC0ql8oL90popySWN6B5XRUTL68aWwu4GVsT9RAs5gTCeNKkVBHs4zkTRTSQT
         eWc7QjrLI5fPbODqvAPxtxBDPqX87JBj27IoOvc0DLJHSP3h+7G22IZN/gwNaO2eSpFU
         9UtzGbBuauvUBtln0JWfhNHLZMr9zgTBKi4Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eVpCjFtqFJ7UUqA6mmkrlFvoXm7xitUCYiXtCc6Ee/U=;
        b=A0ucim+yQY3FSybgBxuohejp2xBGxEcpCVmlJkff+HoB/b+PtbcKTluqkzvOvynGLA
         3t+u8RR/T7CGVibltf3z/9hDDyBqXgvuqAx8s7KgMWvK5u50asJgR6VjKpczAdvp4Zl7
         AnaDn5MYT1EXtiiYnJ7IAHPKSVTt8uUtuz5oZ6ESRwm/jVKspvuicTM2flE1Hwwoqspq
         +TsGy6Mm+8s+r9dkMHBrF7uLmH3dVKUJ41rnGKsNODbgGz46OsG4hIgPvFqEZAvOaMzY
         xnrA8WBADWgRWieZeSim8Mejh8TXQ7shDN8NTbxu4Jx2aJPnxs46i5zmDwl4g+EzNzfY
         wgpw==
X-Gm-Message-State: AOUpUlEafYYkXWAnjzSiJgdvSMe1Y5Ej3NZNJEH8J8SsFy7+oBvtIcQI
        EoHjf0CgMsYRixJY88vizCwUsQ==
X-Google-Smtp-Source: AA+uWPxaYVEFdZ9HB0m1tGkNgWH4X7+KcyFe0WZHxaP/6kt3m+1DisWstWUKlrToOSFLDhwH/V5Cdg==
X-Received: by 2002:a63:24c:: with SMTP id 73-v6mr18480783pgc.252.1534185631114;
        Mon, 13 Aug 2018 11:40:31 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m20-v6sm28869978pfg.61.2018.08.13.11.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 11:40:30 -0700 (PDT)
Date:   Mon, 13 Aug 2018 11:43:51 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: Add some missing gcc clks for msm8996
Message-ID: <20180813184351.GG23866@tuxbook-pro>
References: <20180809220119.18932-1-bjorn.andersson@linaro.org>
 <153391387168.37448.10798348572941173469@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153391387168.37448.10798348572941173469@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10 Aug 08:11 PDT 2018, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2018-08-09 15:01:19)
> > From: Rajendra Nayak <rnayak@codeaurora.org>
> > 
> > Add a few missing gcc clks for msm8996
> > 
> > Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> > [bjorn: omit aggre0_noc_qosgen_extref_clk]
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> 
> This is still going on?! I'm going to ignore Rob's auto email on this
> patch.
> 

There wasn't much "going on" since your last reply, found this on the
floor between some chairs...


The issue pointed to you on v1 was that there was another patch that
already added two of the clocks, so this v2 simply drops the two
duplicated clocks; i.e. solves the merge conflict.

What I see now is that I did forget to carry Rob's R-b from v1.

Regards,
Bjorn
