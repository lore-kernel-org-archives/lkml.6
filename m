Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F75C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67CE206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67CE206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbeJBURU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:17:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35110 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbeJBURT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:17:19 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 676E8B2F;
        Tue,  2 Oct 2018 13:33:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 089/137] spi: sh-msiof: Fix invalid SPI use during system suspend
Date:   Tue,  2 Oct 2018 06:24:50 -0700
Message-Id: <20181002132504.748569359@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

commit ffa69d6a16f686efe45269342474e421f2aa58b2 upstream.

If the SPI queue is running during system suspend, the system may lock
up.

Fix this by stopping/restarting the queue during system suspend/resume
by calling spi_master_suspend()/spi_master_resume() from the PM
callbacks.  In-kernel users will receive an -ESHUTDOWN error while
system suspend/resume is in progress.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
[geert: Cleanup, reword]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-sh-msiof.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1361,12 +1361,37 @@ static const struct platform_device_id s
 };
 MODULE_DEVICE_TABLE(platform, spi_driver_ids);
 
+#ifdef CONFIG_PM_SLEEP
+static int sh_msiof_spi_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
+
+	return spi_master_suspend(p->master);
+}
+
+static int sh_msiof_spi_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
+
+	return spi_master_resume(p->master);
+}
+
+static SIMPLE_DEV_PM_OPS(sh_msiof_spi_pm_ops, sh_msiof_spi_suspend,
+			 sh_msiof_spi_resume);
+#define DEV_PM_OPS	&sh_msiof_spi_pm_ops
+#else
+#define DEV_PM_OPS	NULL
+#endif /* CONFIG_PM_SLEEP */
+
 static struct platform_driver sh_msiof_spi_drv = {
 	.probe		= sh_msiof_spi_probe,
 	.remove		= sh_msiof_spi_remove,
 	.id_table	= spi_driver_ids,
 	.driver		= {
 		.name		= "spi_sh_msiof",
+		.pm		= DEV_PM_OPS,
 		.of_match_table = of_match_ptr(sh_msiof_match),
 	},
 };


