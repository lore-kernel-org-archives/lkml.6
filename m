Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D19C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343A420850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343A420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeLCOdR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:33:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40104 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbeLCOdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:33:16 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DB8422072A; Mon,  3 Dec 2018 15:32:00 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 87E53206FF;
        Mon,  3 Dec 2018 15:32:00 +0100 (CET)
Date:   Mon, 3 Dec 2018 15:32:00 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v2 2/4] clk: core: link consumer with clock driver
Message-ID: <20181203153200.4f7a036c@xps13>
In-Reply-To: <201812010856.JW2q4YnG%fengguang.wu@intel.com>
References: <20181130153214.9058-3-miquel.raynal@bootlin.com>
        <201812010856.JW2q4YnG%fengguang.wu@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

kbuild test robot <lkp@intel.com> wrote on Sat, 1 Dec 2018 08:29:05
+0800:

> Hi Miquel,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on clk/clk-next]
> [also build test ERROR on v4.20-rc4 next-20181130]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Miquel-Raynal/Add-device-links-to-clocks/20181201-074305
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> config: i386-randconfig-x071-201847 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers//clk/clkdev.c:115:13: error: static declaration of 'clk_link_consumer' follows non-static declaration  
>     static void clk_link_consumer(struct device *consumer, struct clk *clk) {}
>                 ^~~~~~~~~~~~~~~~~
>    In file included from drivers//clk/clkdev.c:22:0:
>    include/linux/clk-provider.h:784:6: note: previous declaration of 'clk_link_consumer' was here
>     void clk_link_consumer(struct device *consumer, struct clk *clk);
>          ^~~~~~~~~~~~~~~~~
> >> drivers//clk/clkdev.c:116:13: error: static declaration of 'clk_unlink_consumer' follows non-static declaration  
>     static void clk_unlink_consumer(struct clk *clk) {}
>                 ^~~~~~~~~~~~~~~~~~~
>    In file included from drivers//clk/clkdev.c:22:0:
>    include/linux/clk-provider.h:785:6: note: previous declaration of 'clk_unlink_consumer' was here
>     void clk_unlink_consumer(struct clk *clk);
>          ^~~~~~~~~~~~~~~~~~~
> 
> vim +/clk_link_consumer +115 drivers//clk/clkdev.c
> 
>    114	
>  > 115	static void clk_link_consumer(struct device *consumer, struct clk *clk) {}
>  > 116	static void clk_unlink_consumer(struct clk *clk) {}  
>    117	
> 

Both functions should not be static. I will remove the keyword in a v3.


Thanks,
Miquèl
