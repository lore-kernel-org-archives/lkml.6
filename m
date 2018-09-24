Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D0FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D63921486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D63921486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732716AbeIXSZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:25:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56714 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbeIXSZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:25:51 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C7390107E;
        Mon, 24 Sep 2018 12:23:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Walker <robert.walker@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 139/173] coresight: tpiu: Fix disabling timeouts
Date:   Mon, 24 Sep 2018 13:52:53 +0200
Message-Id: <20180924113125.836328252@linuxfoundation.org>
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

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit ccff2dfaceaca4517432f5c149594215fe9098cc ]

Probing the TPIU driver under UBSan triggers an out-of-bounds shift
warning in coresight_timeout():

...
[    5.677530] UBSAN: Undefined behaviour in drivers/hwtracing/coresight/coresight.c:929:16
[    5.685542] shift exponent 64 is too large for 64-bit type 'long unsigned int'
...

On closer inspection things are exponentially out of whack because we're
passing a bitmask where a bit number should be. Amusingly, it seems that
both calls will find their expected values by sheer luck and appear to
succeed: 1 << FFCR_FON_MAN ends up at bit 64 which whilst undefined
evaluates as zero in practice, while 1 << FFSR_FT_STOPPED finds bit 2
(TCPresent) which apparently is usually tied high.

Following the examples of other drivers, define separate FOO and FOO_BIT
macros for masks vs. indices, and put things right.

CC: Robert Walker <robert.walker@arm.com>
CC: Mike Leach <mike.leach@linaro.org>
CC: Mathieu Poirier <mathieu.poirier@linaro.org>
Fixes: 11595db8e17f ("coresight: Fix disabling of CoreSight TPIU")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/coresight/coresight-tpiu.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -47,8 +47,9 @@
 
 /** register definition **/
 /* FFSR - 0x300 */
-#define FFSR_FT_STOPPED		BIT(1)
+#define FFSR_FT_STOPPED_BIT	1
 /* FFCR - 0x304 */
+#define FFCR_FON_MAN_BIT	6
 #define FFCR_FON_MAN		BIT(6)
 #define FFCR_STOP_FI		BIT(12)
 
@@ -93,9 +94,9 @@ static void tpiu_disable_hw(struct tpiu_
 	/* Generate manual flush */
 	writel_relaxed(FFCR_STOP_FI | FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
 	/* Wait for flush to complete */
-	coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN, 0);
+	coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
 	/* Wait for formatter to stop */
-	coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED, 1);
+	coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
 
 	CS_LOCK(drvdata->base);
 }


