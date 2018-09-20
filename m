Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A09C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B15206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B15206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbeITNCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:02:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42093 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeITNCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:02:15 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1g2tFo-00013y-Ed; Thu, 20 Sep 2018 09:20:00 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1g2tFl-0006uC-VF; Thu, 20 Sep 2018 09:19:57 +0200
Date:   Thu, 20 Sep 2018 09:19:57 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] serial: imx: remove set but not used variable
 'rtsirq'
Message-ID: <20180920071957.xnwni4lqb5kgncfc@pengutronix.de>
References: <1537408725-196364-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1537408725-196364-1-git-send-email-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 01:58:45AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/tty/serial/imx.c: In function 'imx_uart_probe':
> drivers/tty/serial/imx.c:2198:20: warning:
>  variable 'rtsirq' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Wow, this variable is write-only since 

	afe9cbb1a6ad ("serial: imx: drop support for IRDA")

which is over three years old. The last hunk of this patch is wrong
however, which means that nobody uses handshaking on imx1 with a kernel
newer than 4.1-rc1. (Well, or they fixed it and didn't made the effort
to tell.)

I suggest to break rx and tx on imx1, too, and if nobody reports a
regression within the next three years, we rip out imx1 support
completely. :-)

Otherwise we need:

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4e853570ea80..554a69db1bca 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2350,6 +2350,14 @@ static int imx_uart_probe(struct platform_device *pdev)
 				ret);
 			return ret;
 		}
+
+		ret = devm_request_irq(&pdev->dev, rtsirq, imx_uart_rtsint, 0,
+				       dev_name(&pdev->dev), sport);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request rts irq: %d\n",
+				ret);
+			return ret;
+		}
 	} else {
 		ret = devm_request_irq(&pdev->dev, rxirq, imx_uart_int, 0,
 				       dev_name(&pdev->dev), sport);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
