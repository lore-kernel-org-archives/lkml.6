Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8269C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5655620839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4Bxz/yF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5655620839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeIKRiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:38:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39600 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKRiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:38:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so16915020wrw.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 05:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VawQcM4GtwRvU5a/ecFcJekMDR8kf2N+Gm4esTnPpyY=;
        b=g4Bxz/yF51/kBZLSKNDz9lhIXrMI7ZqZYxhYi0TQA99pBo/H0+6QnxkWycvyp2rCjJ
         qmoIuFV2eiA2LN9E113CMjwnWAw5MToI0duSUB+O7iVYMcun+T5ZD8g005yOq69d18uc
         VPpYqaHZ/cVmH5KZmY71q23cpc6t7eEQVAQ5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VawQcM4GtwRvU5a/ecFcJekMDR8kf2N+Gm4esTnPpyY=;
        b=WpaPGjDA7va36gQvAg+Uqv5K3fUnZ2cFB1HTiP5r7m++4BWZgRltWmGq+1LbMTMc2r
         AkeBR+hXZQ41UoHHR9wzHZm+JADwLBgK77uXqSsvB+GxlPdAY2ekwhHPy6/h7TKS6wJf
         WEIs57zykDca2fp7yRZr1PDC4RsUUPNZYxXKwLk/2nadOGsGKGau8rCSpit9fkToEeIe
         lHMLEgVFpEOq0waN7p5D0xrNJ395a+9wnvCGOrguTUYsrgq1k3MjMqW82gtaS1A8MxUp
         euAo2KQf7gpFcUgtkjl5nuLah8EZ91zp4dX0pWOkZsvjZR4r3O9JAg8+XZl/GuBnInio
         T2MQ==
X-Gm-Message-State: APzg51C7KGfAv32iqkG09wVejfX5PCYC3v39ZeD3TUUIrEmqj/egBE9r
        PedZYvU0eff06V2J8Nbs2vbeiA==
X-Google-Smtp-Source: ANB0VdZRIetpNoa7Fznadr/RmV7Ghk4N3CascttH4v7uBF9ZASEnPPwQ7gZ7b5xlzkEgb9zeJJ4/yQ==
X-Received: by 2002:adf:a936:: with SMTP id u51-v6mr19874577wrc.175.1536669549775;
        Tue, 11 Sep 2018 05:39:09 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id k35-v6sm24435116wrc.14.2018.09.11.05.39.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 05:39:08 -0700 (PDT)
Date:   Tue, 11 Sep 2018 13:39:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Xie <tony.xie@rock-chips.com>
Cc:     heiko@sntech.de, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v4 1/5] mfd: rk808: Add RK817 and RK809 support
Message-ID: <20180911123907.GN4185@dell>
References: <1535968829-19418-1-git-send-email-tony.xie@rock-chips.com>
 <1535968829-19418-2-git-send-email-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1535968829-19418-2-git-send-email-tony.xie@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Sep 2018, Tony Xie wrote:

>     The rk809 and rk817 are a Power Management IC (PMIC) for multimedia
>     and handheld devices. It contains the following components:
> 
>         - Regulators
>         - RTC
>         - Clocking
> 
>     Both RK809 and RK817 chips are using a similar register map,
>     so we can reuse the RTC and Clocking and regulators functionality.
> 
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> ---

It's often helpful to place a Changelog in this space.

>  drivers/mfd/Kconfig       |   6 +-
>  drivers/mfd/rk808.c       | 218 +++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/rk808.h | 172 ++++++++++++++++++++++++++++++++++++
>  kernel/reboot.c           |   1 +
>  4 files changed, 391 insertions(+), 6 deletions(-)

I just reviewed v4.

It looks like the review comments are still relevant.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
