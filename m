Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D95C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B6A2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B6A2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeI2N5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 09:57:52 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59326 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbeI2N5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 09:57:51 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DCAC6200079;
        Sat, 29 Sep 2018 09:30:26 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 15E42200086;
        Sat, 29 Sep 2018 09:30:22 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E447F40324;
        Sat, 29 Sep 2018 15:30:15 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v2, 5/5] net: dpaa2: fix and improve dpaa2-ptp driver
Date:   Sat, 29 Sep 2018 15:26:45 +0800
Message-Id: <20180929072645.20027-5-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180929072645.20027-1-yangbo.lu@nxp.com>
References: <20180929072645.20027-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to fix and improve dpaa2-ptp driver
in some places.

- Fixed the return for some functions.
- Replaced kzalloc with devm_kzalloc.
- Removed dev_set_drvdata(dev, NULL).
- Made ptp_dpaa2_caps const.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Added this patch.
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c |   25 ++++++++--------------
 1 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
index c73eef2..84b942b 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
@@ -46,7 +46,7 @@ static int ptp_dpaa2_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
 					  mc_dev->mc_handle, tmr_add);
 	if (err)
 		dev_err(dev, "dprtc_set_freq_compensation err %d\n", err);
-	return 0;
+	return err;
 }
 
 static int ptp_dpaa2_adjtime(struct ptp_clock_info *ptp, s64 delta)
@@ -61,17 +61,15 @@ static int ptp_dpaa2_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	err = dprtc_get_time(mc_dev->mc_io, 0, mc_dev->mc_handle, &now);
 	if (err) {
 		dev_err(dev, "dprtc_get_time err %d\n", err);
-		return 0;
+		return err;
 	}
 
 	now += delta;
 
 	err = dprtc_set_time(mc_dev->mc_io, 0, mc_dev->mc_handle, now);
-	if (err) {
+	if (err)
 		dev_err(dev, "dprtc_set_time err %d\n", err);
-		return 0;
-	}
-	return 0;
+	return err;
 }
 
 static int ptp_dpaa2_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
@@ -87,12 +85,12 @@ static int ptp_dpaa2_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 	err = dprtc_get_time(mc_dev->mc_io, 0, mc_dev->mc_handle, &ns);
 	if (err) {
 		dev_err(dev, "dprtc_get_time err %d\n", err);
-		return 0;
+		return err;
 	}
 
 	ts->tv_sec = div_u64_rem(ns, 1000000000, &remainder);
 	ts->tv_nsec = remainder;
-	return 0;
+	return err;
 }
 
 static int ptp_dpaa2_settime(struct ptp_clock_info *ptp,
@@ -111,10 +109,10 @@ static int ptp_dpaa2_settime(struct ptp_clock_info *ptp,
 	err = dprtc_set_time(mc_dev->mc_io, 0, mc_dev->mc_handle, ns);
 	if (err)
 		dev_err(dev, "dprtc_set_time err %d\n", err);
-	return 0;
+	return err;
 }
 
-static struct ptp_clock_info ptp_dpaa2_caps = {
+static const struct ptp_clock_info ptp_dpaa2_caps = {
 	.owner		= THIS_MODULE,
 	.name		= "DPAA2 PTP Clock",
 	.max_adj	= 512000,
@@ -136,7 +134,7 @@ static int dpaa2_ptp_probe(struct fsl_mc_device *mc_dev)
 	u32 tmr_add = 0;
 	int err;
 
-	ptp_dpaa2 = kzalloc(sizeof(*ptp_dpaa2), GFP_KERNEL);
+	ptp_dpaa2 = devm_kzalloc(dev, sizeof(*ptp_dpaa2), GFP_KERNEL);
 	if (!ptp_dpaa2)
 		return -ENOMEM;
 
@@ -182,8 +180,6 @@ static int dpaa2_ptp_probe(struct fsl_mc_device *mc_dev)
 err_free_mcp:
 	fsl_mc_portal_free(mc_dev->mc_io);
 err_exit:
-	kfree(ptp_dpaa2);
-	dev_set_drvdata(dev, NULL);
 	return err;
 }
 
@@ -198,9 +194,6 @@ static int dpaa2_ptp_remove(struct fsl_mc_device *mc_dev)
 	dprtc_close(mc_dev->mc_io, 0, mc_dev->mc_handle);
 	fsl_mc_portal_free(mc_dev->mc_io);
 
-	kfree(ptp_dpaa2);
-	dev_set_drvdata(dev, NULL);
-
 	return 0;
 }
 
-- 
1.7.1

