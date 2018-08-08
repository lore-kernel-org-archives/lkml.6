Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6F9C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACF5216FB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACF5216FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbeHHKvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:51:21 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:54031 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeHHKvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:51:21 -0400
Received: from ravnborg.org (unknown [158.248.196.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 7F75980347;
        Wed,  8 Aug 2018 10:32:39 +0200 (CEST)
Date:   Wed, 8 Aug 2018 10:32:38 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 5/5] tinydrm: add winstar wg160160 driver
Message-ID: <20180808083238.GA17613@ravnborg.org>
References: <20180802193909.GA11443@ravnborg.org>
 <20180802194536.10820-5-sam@ravnborg.org>
 <16dfa544-e454-f59b-91ef-9bac7bf1b490@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16dfa544-e454-f59b-91ef-9bac7bf1b490@tronnes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=8nJEP1OIZ-IA:10 a=7gkXJVJtAAAA:8 a=249DMrBgR86lWpuZAd0A:9
        a=CqonG5FjwSecqvkh:21 a=N7Bm7QP7HgvlW3iy:21 a=wPNLvfGTeEIA:10
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Noralf.

On Tue, Aug 07, 2018 at 07:35:30PM +0200, Noralf Trønnes wrote:
> 
> Den 02.08.2018 21.45, skrev Sam Ravnborg:
> >Add driver for the winstar wg160160 display.
> >The driver utilises pardata-dbi that
> >again utilise the pardata subsystem.
> >
> >Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> >---
> >  MAINTAINERS                        |   5 +
> >  drivers/gpu/drm/tinydrm/Kconfig    |  10 ++
> >  drivers/gpu/drm/tinydrm/Makefile   |   1 +
> >  drivers/gpu/drm/tinydrm/wg160160.c | 298 +++++++++++++++++++++++++++++++++++++
> >  4 files changed, 314 insertions(+)
> >  create mode 100644 drivers/gpu/drm/tinydrm/wg160160.c
> >
> 
> [...]
> 
> >+
> >+/**
> >+ * write_reg - Write instruction on parallel bus to controller
> >+ *
> >+ * Check BUSY flag and write instruction
> >+ *
> >+ * @pdd: pardata data
> >+ * @reg: The register to write
> >+ * @value: The value of the register
> >+ *
> >+ * Returns:
> >+ * Zero on success, negative error code on failure
> >+ */
> >+int write_reg(struct pardata_data *pdd, unsigned int reg, unsigned int value)
> >+{
> >+	int ins[PIN_NUM];
> >+	int val[PIN_NUM];
> >+	int i;
> >+
> >+	for (i = 0; i < PIN_NUM; i++)
> >+		ins[PIN_DB0 + i] = !!BIT(reg);
> >+
> >+	for (i = 0; i < PIN_NUM; i++)
> >+		val[PIN_DB0 + i] = !!(value & BIT(i));
> >+
> >+	gpiod_set_value_cansleep(pdd->bus->pin_rs, 1);
> >+	gpiod_set_array_value_cansleep(PIN_NUM, pdd->bus->data_pins->desc, ins);
> >+	wait_busy(pdd);
> >+	pardata_strobe_write(pdd);
> >+
> >+	gpiod_set_value_cansleep(pdd->bus->pin_rs, 0);
> >+	gpiod_set_array_value_cansleep(PIN_NUM, pdd->bus->data_pins->desc, val);
> >+	wait_busy(pdd);
> >+	pardata_strobe_write(pdd);
> >+
> >+	return 0;
> >+}
> 
> If this controller has normal registers, you could do a regmap
> implementation for pardata: drivers/base/regmap.

If I understand you correct then you suggest to add a regmap implementation
on top of the registers replacing the current gpio support?

So we in regmap can optimize access to the registers better.
Or did you have something else in mind?

As speed is not the main challenge here I will likely wait with this
and continue using gpio.

	Sam
