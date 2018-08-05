Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E910EC28CF6
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 03:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DDF21736
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 03:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjZgwuu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DDF21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeHEFoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 01:44:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45792 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeHEFoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 01:44:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so5173728pfo.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 20:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qei0gYGaM+p+YVCxg0VrV2h4yIf3yFl6IUtEh/HIkXM=;
        b=cjZgwuu6jy1N15VfAq+BZFcWAt85cfbxXJzi0c6SnF7SMOwvVjMhQ7P7ov74ev0cWN
         24eHIna5S/hv9TPwjQDR1xXhVKuUgzOPGdcX4fnUtsmx9Do6r/o8Yf8V1KyNdgsISlaJ
         wfAnYTjwlsHeUiBU9NdtZlupOTUI2vwwKEyyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qei0gYGaM+p+YVCxg0VrV2h4yIf3yFl6IUtEh/HIkXM=;
        b=gU/iqgyX5LERcZnYQKC7zmhWg4bRWnx/UuuZMV2VAvp2ac9LJqsuqGrFOcjEjfTM6n
         7Y4o+rBSnEDsVjeEsLR1iWt8ig0s09kVwbtd2S/JDfjOjAp1hdtXzsi8UDsdCFO7RDUT
         GHZcMc/Xx9HQItatey3H/WdtUQw/douZoWpWczxVQt9p5+ZLmhZs5Pu9pxSs/udJnX7J
         DPYp3EZOT3pVBNaR41sNakfzg78inoTzU+jlxu9q9Q+qT9qa7vHYMdCxEAiCcsFXkYlV
         rxvRKcllY70yUpo76TzRwmd036zCvarmxufPFl77cdBUbSKjuXsCkwgY+wfYGW6DAsUB
         Xplg==
X-Gm-Message-State: AOUpUlEmMy+v7+/N0ivxLB0M80uIbPOxTXRWYTSha6rlmY8KqsCvI9L9
        lvJrQi4BQgIX9b8JVpZfc7T8
X-Google-Smtp-Source: AAOMgpcsvl11bXjOo3lp6acUDUk+y+I8NvAplLmATQN1zp/f9anAbx+GzeQIwxyCt8mKa2wqQJKRGQ==
X-Received: by 2002:a62:15c8:: with SMTP id 191-v6mr11249171pfv.194.1533440512732;
        Sat, 04 Aug 2018 20:41:52 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([111.93.136.226])
        by smtp.gmail.com with ESMTPSA id t19-v6sm16522037pfk.182.2018.08.04.20.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 20:41:51 -0700 (PDT)
Date:   Sun, 5 Aug 2018 09:11:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     afaerber@suse.de
Cc:     Wolfram Sang <wsa@the-dreams.de>, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com
Subject: Re: [PATCH v8 2/6] arm64: dts: actions: Add pinctrl definition for
 S900 I2C controller
Message-ID: <20180805034140.GA6907@Mani-XPS-13-9360>
References: <20180801180232.23680-1-manivannan.sadhasivam@linaro.org>
 <20180801180232.23680-3-manivannan.sadhasivam@linaro.org>
 <20180804210440.6fw4zrvk6lzawypc@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804210440.6fw4zrvk6lzawypc@ninjato>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 11:04:40PM +0200, Wolfram Sang wrote:
> On Wed, Aug 01, 2018 at 11:32:28PM +0530, Manivannan Sadhasivam wrote:
> > Add pinctrl definition for Actions Semiconductor S900 I2C controller.
> > Pinctrl definitions are only available for I2C0, I2C1, and I2C2.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Note that I don't take DTS patches, so skipping patches 2-4.
>

Hi Andreas,

Can you please take the DTS patches through Actions tree?

Thanks,
Mani


