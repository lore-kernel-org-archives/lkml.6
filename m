Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94D1C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F3D20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJTI+5CB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F3D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeILPid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:38:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38885 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeILPic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:38:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id p6-v6so1175536ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 03:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XVw9j3GvGDRS/S07+ejT4h1BmwaQXmi0ciiv/oE5Qxg=;
        b=ZJTI+5CBSpc1ZN2nIRArAIgi69pC2GfbdO7tMuOXnLdiyHusw8YPr+3d6t7ywAhNQN
         g/6fNAo3MCNcg9FpD872xXtnPEh4ebUJwYuFVScUJM9sL+gJ2rMUueh1i561SYzJisNZ
         g0MJHnl/LrqJk+A9M1KDL4ZE7lllEuDhj1dt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XVw9j3GvGDRS/S07+ejT4h1BmwaQXmi0ciiv/oE5Qxg=;
        b=kpspfXjnadAW82cnThduERizCyEjCFRTqnz7yY1wcfnnMP1RL+iknruUjns+QJkR6h
         m8Ptvy6VhvVe6JPDXW5cSsuCRJuM9WDeLah3OJOWKYMzytQpYXsV8gF+wuzH6aP0cuPk
         MWnZQYGT8jdIbj3lnsmRBUltyigF5eN0G3yFizsoLm5obU+4+955w5r3ppM1ae70dtne
         aoJp1vYhMcYOgJ3L9aWNnySgFn0vD1rzy0cQ5sHPvPxEI7/9GBzZUVgBprqY4EPqFu/n
         +S+z6aVFBwQVzXox6hODUYwzwavKVS7Z3UPosN4mYuEgkzsxwNvqxwC15NvXZnpKc+BX
         yn6g==
X-Gm-Message-State: APzg51BO6unZrfGozen8mFHBuGx2lzFYM9IFeGf33OiZPouvRATGrO5N
        ieIuQytSqyOf9Jjo+oVQPSoyag==
X-Google-Smtp-Source: ANB0VdbnrRMGUBA0kfE4XKItAllMt/1h/gga7XA7Zc7nHI1qcD72T/LMCnsD/IBRHXpfffohmnCnXA==
X-Received: by 2002:a2e:360c:: with SMTP id d12-v6mr930321lja.88.1536748473769;
        Wed, 12 Sep 2018 03:34:33 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id q16-v6sm114233ljj.68.2018.09.12.03.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 03:34:32 -0700 (PDT)
Date:   Wed, 12 Sep 2018 12:34:31 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 0/3] pinctrl: msm interrupt and muxing fixes
Message-ID: <20180912103431.GA27204@centauri.ideon.se>
References: <20180816200648.90458-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816200648.90458-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

I'm getting this warning on dragonboard 820c (msm8996) when booting linux-next:

[    3.211575] WARNING: CPU: 1 PID: 1 at drivers/pinctrl/qcom/pinctrl-msm.c:164 msm_pinmux_set_mux+0xc8/0x150
[    3.212127] l28: ramp_delay not set
[    3.215146] Modules linked in:
[    3.215168] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         4.19.0-rc2-next-2018904-00004-gd8c6804d9e9b #54
[    3.215175] Hardware name: Qualcomm Technologies, Inc. DB820c (DT)
[    3.215184] pstate: 60400005 (nZCv daif +PAN -UAO)
[    3.215197] pc : msm_pinmux_set_mux+0xc8/0x150
[    3.215206] lr : msm_pinmux_set_mux+0x30/0x150
[    3.215213] sp : ffff00000803b880
[    3.224815] l28: 925 mV
[    3.228149] x29: ffff00000803b880 x28: ffff00000978a22c
[    3.228172] x27: ffff000009f22000 x26: ffff000009640764
[    3.228193] x25: 0000000000000000
[    3.241956] x24: ffff8000d93f5f18
[    3.241971] x23: ffff8000d93fec18 x22: 0000000000000000
[    3.241992] x21: ffff000009100d10 x20: 000000000000003c
[    3.252891] x19: 000000000000000a x18: ffffffffffffffff
[    3.252913] x17: 00000000000017c7 x16: ffff000009fdaac0
[    3.252935] x15: ffff000009cbe1c8
[    3.257467] l29: supplied by regulator-dummy
[    3.261743] x14: ffff8000d85fea14
[    3.261757] x13: ffff8000d85fea13 x12: ffff8000d9f488b0
[    3.261778] x11: 0000000005f5e0ff x10: 0000000000000040
[    3.267734] x9 : ffff8000d91bae18 x8 : ffff8000d981efe8
[    3.267755] x7 : ffff8000d981f128 x6 : 000000000000000a
[    3.267776] x5 : 0000000000000040
[    3.273347] l29: Bringing 0uV into 2800000-2800000uV
[    3.278323] x4 : ffffffffffffffff
[    3.278338] x3 : 000000000000000a x2 : 00000000ffffffc6
[    3.278359] x1 : ffff000009d3eec8 x0 : 00000000000000f3
[    3.282026] l29: ramp_delay not set
[    3.292566] Call trace:
[    3.292581]  msm_pinmux_set_mux+0xc8/0x150
[    3.292590]  msm_pinmux_request_gpio+0x5c/0x68
[    3.292599]  pin_request+0x154/0x2c0
[    3.292608]  pinmux_request_gpio+0x60/0xa0
[    3.296080] l29: 2800 mV
[    3.301503]  pinctrl_gpio_request+0x148/0x1d8
[    3.301514]  gpiochip_generic_request+0x2c/0x38
[    3.301523]  gpiod_request_commit+0xc4/0x1a0
[    3.301532]  gpiod_request+0x6c/0x110
[    3.301544]  gpiod_get_index+0x134/0x360
[    3.322166]  devm_gpiod_get_index+0x64/0xc0
[    3.322174]  devm_gpiod_get_optional+0x38/0x58
[    3.322185]  qcom_pcie_probe+0xa4/0x230
[    3.322197]  platform_drv_probe+0x58/0xa8
[    3.322207]  really_probe+0x280/0x3d8
[    3.322215]  driver_probe_device+0x60/0x148
[    3.322224]  __driver_attach+0x144/0x148
[    3.322233]  bus_for_each_dev+0x84/0xd8
[    3.322241]  driver_attach+0x30/0x40
[    3.322250]  bus_add_driver+0x234/0x2a8
[    3.322258]  driver_register+0x64/0x110
[    3.322267]  __platform_driver_register+0x54/0x60
[    3.322279]  qcom_pcie_driver_init+0x20/0x28
[    3.322290]  do_one_initcall+0x94/0x3f8
[    3.322301]  kernel_init_freeable+0x47c/0x528
[    3.322315]  kernel_init+0x18/0x110
[    3.322323]  ret_from_fork+0x10/0x1c


If I revert patch 2/3 and 3/3 in this series, the warning goes away.


Kind regards,
Niklas
