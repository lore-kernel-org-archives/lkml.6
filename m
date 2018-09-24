Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA8AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F39208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F39208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732955AbeIXX34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:29:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46875 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730789AbeIXX34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:29:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E5AE620731; Mon, 24 Sep 2018 19:26:42 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id A0C9F20379;
        Mon, 24 Sep 2018 19:26:32 +0200 (CEST)
Date:   Mon, 24 Sep 2018 19:26:32 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 2/3] mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash
 controller driver
Message-ID: <20180924192632.1d5754da@bbrezillon>
In-Reply-To: <6df8455e-2fb2-e65c-a492-fba42a9453f3@st.com>
References: <1537199260-7280-1-git-send-email-christophe.kerello@st.com>
        <1537199260-7280-3-git-send-email-christophe.kerello@st.com>
        <20180922154819.015dcca7@xps13>
        <6df8455e-2fb2-e65c-a492-fba42a9453f3@st.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2018 18:36:36 +0200
Christophe Kerello <christophe.kerello@st.com> wrote:

> >> +static int stm32_fmc2_resume(struct device *dev)
> >> +{
> >> +	struct stm32_fmc2 *fmc2 = dev_get_drvdata(dev);
> >> +	int i, ret;
> >> +
> >> +	pinctrl_pm_select_default_state(dev);
> >> +
> >> +	ret = clk_prepare_enable(fmc2->clk);
> >> +	if (ret) {
> >> +		dev_err(dev, "can not enable the clock\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	stm32_fmc2_init(fmc2);
> >> +	stm32_fmc2_timings_init(fmc2);
> >> +	stm32_fmc2_setup(fmc2);
> >> +
> >> +	for (i = 0; i < fmc2->ncs; i++)
> >> +		nand_reset(&fmc2->chip, i);  
> > 
> > This means you have one different NAND chip wired on each CS.
> > 
> > We could have two CS wired to the same NAND chip. Calling nand_reset
> > twice would be harmless but a lost of time.

Actually, you have to call nand_reset() for each CS, otherwise not all
dies are reset.
