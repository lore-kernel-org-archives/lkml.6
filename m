Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0E0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB03020660
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB03020660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeKZWzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:55:51 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48173 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeKZWzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:55:51 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gRFaJ-0007w2-Ry; Mon, 26 Nov 2018 13:01:51 +0100
Message-ID: <1543233711.2507.29.camel@pengutronix.de>
Subject: Re: imx6sx uart failing loopback tests with sdma firmware (ROM
 works)
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        Andy Duan <fugang.duan@nxp.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Date:   Mon, 26 Nov 2018 13:01:51 +0100
In-Reply-To: <6d8280df85c6e5b2ddba635780cd2912d9c5d425.camel@nxp.com>
References: <6d8280df85c6e5b2ddba635780cd2912d9c5d425.camel@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 26.11.2018, 11:53 +0000 schrieb Leonard Crestez:
> Hello,
> 
> On a build farm at NXP we found that linux-next now fails on simple
> loopback tests on imx6sx-sdb (but not other SOCs AFAICT). I tracked
> this down to commit 30fdd51be161
> ("ARM: imx_v6_v7_defconfig: add CONFIG_FW_LOADER_USER_HELPER")
> 
> All that does is enable loading SDMA firmware from rootfs, in theory
> this config was always supported so it would not be a new bug.
> 
> This doesn't happen with the NXP vendor tree but there is quite a large
> delta in uart dma code. In particular upstream dropped IDDMAEN claiming
> that this works with both ROM and FW scripts, see commit 905c0decad28
> ("serial: imx: don't use idle condition detect for DMA transfers")
> 
> This doesn't seem to work on 6sx though and I don't know why :(
> 
> The issue can be worked-around by forcing RX script from ROM:
> 
> diff --git drivers/dma/imx-sdma.c drivers/dma/imx-sdma.c
> @@ -894,9 +894,11 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
>                 break;
>         case IMX_DMATYPE_UART:
> -               per_2_emi = sdma->script_addrs->uart_2_mcu_addr;
> +               //per_2_emi = sdma->script_addrs->uart_2_mcu_addr;
> +               per_2_emi = 817;
>                 emi_2_per = sdma->script_addrs->mcu_2_app_addr;
>                 break;
>         case IMX_DMATYPE_UART_SP:
> 
> The above doesn't look like a good fix. I tried to revert 905c0decad28
> and resolve conflicts and that also seems to work, pushed here:
> https://github.com/cdleonard/linux/commit/0a1757f467e6dc96037ec2e3ea7c88c5a4eb2ceb
> 
> You can find test code here (not very interesting):
> https://source.codeaurora.org/external/imx/imx-test/tree/test/mxc_uart_test/mxc_uart_test.c?h=imx_4.14.62_1.0.0_beta
> 
> Any idea on how to fix this?

The RAM script is probably busted, as it doesn't provide the same
interface as the ROM script. The assumption of 905c0decad28 was that
the RAM script is an extension to the ROM script, but it seems like
this is not the case and the RAM script actually dropped some crucial
functionality.

See also https://lkml.org/lkml/2018/9/20/522

Please see if you can follow up internally and get a fixed SDMA
firmware pushed out. Fixed probably only means that the UART script
needs to be dropped, as the ROM script is totally fine when doing the
correct setup in the UART driver and the sole purpose of the RAM script
was to work with the broken UART driver.

Regards,
Lucas
