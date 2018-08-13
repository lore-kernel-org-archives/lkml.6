Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F308C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D256121765
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D256121765
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbeHNAzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:55:10 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:39533 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730811AbeHNAzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:55:09 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0McWI4-1fXoA81Rei-00Hhe1; Tue, 14 Aug 2018 00:10:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tal Gilboa <talgi@mellanox.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: systemport: fix unused function warning
Date:   Tue, 14 Aug 2018 00:10:34 +0200
Message-Id: <20180813221041.219857-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:DJp+bkTe9hR/N2l/o8sTDB/16yJLkO43YHMlmjDUXzkfqzFHRni
 twXbzQItJsTY8FyFZobNzTKNV9JAMMWixwu9/nbfPzyJQzCzj4O5OTedXRguBVbtawPOmlf
 hE9b7HP3mTXsDvWxd6fABfihmKePHOSoNxkIzMvBNc1dQK9nd/XAifzKwOQtA4ms0a6ukoM
 yumOPN8rPeGZ61/pIVnGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fQKjvl29HFg=:MsX9uFweBlnICH5alapMGi
 PuuCnmbugbvE5sOadEbLVfLxp7p0Mv084rhphZk8zDC+/Nc5SJWNB9HJH81mpVFixg/ZADftB
 ZZ5nBTqgftio7y4cnUmM03kbv0CdikLWLJlVyk6dZ/qJfV4+U/fI8lEOFFuLCWoGv3gvH3vDd
 r4ofxijE+sJfpXPnIESb1i8GQ/g2Ipw+6zZcG+IvS4lU/SDfUK6DdfdUJbgzZd9Qz7I/74ABr
 zOrharZHZOvRlxswFCu04rLONEdyXDP+6PZf1fE+m9h4Bbwvk8L3WVnVgkceeswiPToCsDjNd
 UMduPeD+aQWH+Ac8SNUklmcPRKV2g9WiTdYHTlGbX/DVcSWxzV365mI71MuIH/5w1elnpuQt8
 n516bI4bs+xQfq0TCj2BPazVcSyGBg/IJ3I6LQUNsIWnh/YtosqgyX+Zk8NDVQZewxH4KNd3c
 k11sSkQzsCYT0aqVKaWCbNWDxHX8FRJe34rcE+UMXdu3tbW6fBcmSPkGgodzFx7tbBUI4CrSV
 c8KUw72JQh8EpyuHxUEeE2XQi43vxtnw2lRmlKJKzsgwsUpbQYUzYAz2xNDzSjzVFIL0DxVhj
 p7kSeYuANj+I96sDsL8mxp8stgp0+eVR9l6pCDCFiO4kxnrlAm9dKq25O4WtRWkUmuuclqTdM
 UvZlG4AT9aLV0VSkwpxOvT+P+ZUmX54X+j478GTqLXZ8lz/rBIAokTX1HG7ghkzbwY9A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only remaining caller of this function is inside of an #ifdef
after another caller got removed. This causes a harmless warning
in some configurations:

drivers/net/ethernet/broadcom/bcmsysport.c:1068:13: error: 'bcm_sysport_resume_from_wol' defined but not used [-Werror=unused-function]

Removing the #ifdef around the PM functions simplifies the code
and avoids the problem but letting the compiler drop the unused
functions silently.

Fixes: 9e85e22713d6 ("net: systemport: Do not re-configure upon WoL interrupt")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index ca47309d4494..147045757b10 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2585,7 +2585,6 @@ static int bcm_sysport_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int bcm_sysport_suspend_to_wol(struct bcm_sysport_priv *priv)
 {
 	struct net_device *ndev = priv->netdev;
@@ -2650,7 +2649,7 @@ static int bcm_sysport_suspend_to_wol(struct bcm_sysport_priv *priv)
 	return 0;
 }
 
-static int bcm_sysport_suspend(struct device *d)
+static int __maybe_unused bcm_sysport_suspend(struct device *d)
 {
 	struct net_device *dev = dev_get_drvdata(d);
 	struct bcm_sysport_priv *priv = netdev_priv(dev);
@@ -2712,7 +2711,7 @@ static int bcm_sysport_suspend(struct device *d)
 	return ret;
 }
 
-static int bcm_sysport_resume(struct device *d)
+static int __maybe_unused bcm_sysport_resume(struct device *d)
 {
 	struct net_device *dev = dev_get_drvdata(d);
 	struct bcm_sysport_priv *priv = netdev_priv(dev);
@@ -2805,7 +2804,6 @@ static int bcm_sysport_resume(struct device *d)
 		bcm_sysport_fini_tx_ring(priv, i);
 	return ret;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(bcm_sysport_pm_ops,
 		bcm_sysport_suspend, bcm_sysport_resume);
-- 
2.18.0

