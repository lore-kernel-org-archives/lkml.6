Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeBALGm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 06:06:42 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:39099
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751520AbeBALGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:06:40 -0500
X-IronPort-AV: E=Sophos;i="5.46,443,1511823600";
   d="scan'208";a="253250421"
Date: Thu, 1 Feb 2018 12:06:35 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Dan Carpenter <dan.carpenter@oracle.com>
cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: reduce false positives
In-Reply-To: <20180201102501.kc5pfxojn7fhxat4@mwanda>
Message-ID: <alpine.DEB.2.20.1802011158110.3135@hadrien>
References: <1517478532-5444-1-git-send-email-Julia.Lawall@lip6.fr> <20180201102501.kc5pfxojn7fhxat4@mwanda>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the results that are eliminated by my change:

drivers/clk/axs10x/pll_clock.c:323:1-6 kfree(pll_clk);
drivers/clk/clk-gpio.c:131:2-7 kfree(clk_gpio);
drivers/clk/clk-hsdk-pll.c:410:1-6 kfree(pll_clk);
drivers/clk/hisilicon/clk.c:97:1-6 kfree(clk_data);
drivers/mfd/syscon.c:130:1-8 iounmap(base);
drivers/mfd/syscon.c:132:1-6 kfree(syscon);
drivers/pinctrl/freescale/pinctrl-mxs.c:139:2-7 kfree(group);
drivers/pinctrl/samsung/pinctrl-exynos5440.c:264:1-6 kfree(gname);
drivers/platform/chrome/cros_ec_debugfs.c:248:1-6 kfree(msg);
drivers/pwm/pwm-lp3943.c:56:3-8 kfree(pwm_map);

The semantic patch is pretty naive in that it assumes that all uses of the
same name point to the same thing.

Looking through the code, it looks like sometimes both an __init and a
probe function are provided, and the __init function doesn't have access to
a device object.

julia
