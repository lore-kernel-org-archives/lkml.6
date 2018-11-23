Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44831C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1634A20663
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1634A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408848AbeKWTzU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:55:20 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48831 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731917AbeKWTzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:55:20 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A09F620D29; Fri, 23 Nov 2018 10:11:55 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 03A45207AB;
        Fri, 23 Nov 2018 10:11:32 +0100 (CET)
Date:   Fri, 23 Nov 2018 10:11:32 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH 2/2] clk: core: link consumer with clock driver
Message-ID: <20181123101132.6be3829c@xps13>
In-Reply-To: <201811231627.H7ojlKLL%fengguang.wu@intel.com>
References: <20181122212212.16039-3-miquel.raynal@bootlin.com>
        <201811231627.H7ojlKLL%fengguang.wu@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

kbuild test robot <lkp@intel.com> wrote on Fri, 23 Nov 2018 16:30:00
+0800:

> Hi Miquel,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on clk/clk-next]
> [also build test ERROR on v4.20-rc3 next-20181122]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Miquel-Raynal/Link-consumer-with-clock-driver/20181123-113833
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> config: sh-titan_defconfig (attached as .config)
> compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=sh 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers//clk/clkdev.c: In function 'clk_get':
> >> drivers//clk/clkdev.c:209:3: error: implicit declaration of function '__clk_device_link'; did you mean '__clk_free_clk'? [-Werror=implicit-function-declaration]  
>       __clk_device_link(dev, clk);
>       ^~~~~~~~~~~~~~~~~
>       __clk_free_clk
>    drivers//clk/clkdev.c: In function 'clk_put':
> >> drivers//clk/clkdev.c:217:2: error: implicit declaration of function '__clk_device_unlink'; did you mean 'device_online'? [-Werror=implicit-function-declaration]  
>      __clk_device_unlink(clk);
>      ^~~~~~~~~~~~~~~~~~~
>      device_online
>    cc1: some warnings being treated as errors

I figured thanks to this report that this code won't compile with
architectures not compliant to the common clock framework. I see there
is the following block in clkdev.c.

#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
#else
#endif

Would you agree with me adding dummy functions in the #else section
like:

static inline void __clk_device_link(struct device *consumer, struct clk *clk)
{
       return;
}

static inline void __clk_device_unlink(struct clk *clk)
{
       return;
}

Do you want me to also declare these functions in the #if section
(with the external keyword) to balance the above declarations?

Thanks for your input.
Miquèl

> 
> vim +209 drivers//clk/clkdev.c
> 
>    193	
>    194	struct clk *clk_get(struct device *dev, const char *con_id)
>    195	{
>    196		const char *dev_id = dev ? dev_name(dev) : NULL;
>    197		struct clk *clk = NULL;
>    198	
>    199		if (dev && dev->of_node) {
>    200			clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
>    201			if (PTR_ERR(clk) == -EPROBE_DEFER)
>    202				return clk;
>    203		}
>    204	
>    205		if (IS_ERR_OR_NULL(clk))
>    206			clk = clk_get_sys(dev_id, con_id);
>    207	
>    208		if (!IS_ERR(clk))
>  > 209			__clk_device_link(dev, clk);  
>    210	
>    211		return clk;
>    212	}
>    213	EXPORT_SYMBOL(clk_get);
>    214	
>    215	void clk_put(struct clk *clk)
>    216	{
>  > 217		__clk_device_unlink(clk);  
>    218		__clk_put(clk);
>    219	}
>    220	EXPORT_SYMBOL(clk_put);
>    221	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
