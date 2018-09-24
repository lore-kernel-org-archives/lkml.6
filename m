Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DC6C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB272148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB272148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbeIXS0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:26:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56738 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732082AbeIXS0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:26:01 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B6D41108B;
        Mon, 24 Sep 2018 12:24:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 140/173] coresight: ETM: Add support for Arm Cortex-A73 and Cortex-A35
Date:   Mon, 24 Sep 2018 13:52:54 +0200
Message-Id: <20180924113125.894659818@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
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

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit 5cedd22370a0a460b663c06de1fc10b4ba3c5d0b ]

Add ETM PIDs of the Arm cortex-A CPUs to the white list of ETMs.
While at it add a helper macro to make it easier to add the new
entries.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c |   31 +++++++++++---------------
 1 file changed, 14 insertions(+), 17 deletions(-)

--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1034,7 +1034,8 @@ static int etm4_probe(struct amba_device
 	}
 
 	pm_runtime_put(&adev->dev);
-	dev_info(dev, "%s initialized\n", (char *)id->data);
+	dev_info(dev, "CPU%d: ETM v%d.%d initialized\n",
+		 drvdata->cpu, drvdata->arch >> 4, drvdata->arch & 0xf);
 
 	if (boot_enable) {
 		coresight_enable(drvdata->csdev);
@@ -1052,23 +1053,19 @@ err_arch_supported:
 	return ret;
 }
 
+#define ETM4x_AMBA_ID(pid)			\
+	{					\
+		.id	= pid,			\
+		.mask	= 0x000fffff,		\
+	}
+
 static const struct amba_id etm4_ids[] = {
-	{       /* ETM 4.0 - Cortex-A53  */
-		.id	= 0x000bb95d,
-		.mask	= 0x000fffff,
-		.data	= "ETM 4.0",
-	},
-	{       /* ETM 4.0 - Cortex-A57 */
-		.id	= 0x000bb95e,
-		.mask	= 0x000fffff,
-		.data	= "ETM 4.0",
-	},
-	{       /* ETM 4.0 - A72, Maia, HiSilicon */
-		.id = 0x000bb95a,
-		.mask = 0x000fffff,
-		.data = "ETM 4.0",
-	},
-	{ 0, 0},
+	ETM4x_AMBA_ID(0x000bb95d),		/* Cortex-A53 */
+	ETM4x_AMBA_ID(0x000bb95e),		/* Cortex-A57 */
+	ETM4x_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
+	ETM4x_AMBA_ID(0x000bb959),		/* Cortex-A73 */
+	ETM4x_AMBA_ID(0x000bb9da),		/* Cortex-A35 */
+	{},
 };
 
 static struct amba_driver etm4x_driver = {


