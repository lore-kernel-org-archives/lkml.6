Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDE9C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145E020779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145E020779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeICVMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:12:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36284 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbeICVMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:12:12 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2BAA3CEE;
        Mon,  3 Sep 2018 16:51:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 09/56] drm/imx: imx-ldb: check if channel is enabled before printing warning
Date:   Mon,  3 Sep 2018 18:48:59 +0200
Message-Id: <20180903164924.554960463@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas Stach <l.stach@pengutronix.de>

[ Upstream commit c80d673b91a6c81d765864e10f2b15110ee900ad ]

If the second LVDS channel has been disabled in the DT when using dual-channel
mode we should not print a warning.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/imx-drm/imx-ldb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/staging/imx-drm/imx-ldb.c
+++ b/drivers/staging/imx-drm/imx-ldb.c
@@ -500,14 +500,14 @@ static int imx_ldb_bind(struct device *d
 		if (ret || i < 0 || i > 1)
 			return -EINVAL;
 
+		if (!of_device_is_available(child))
+			continue;
+
 		if (dual && i > 0) {
 			dev_warn(dev, "dual-channel mode, ignoring second output\n");
 			continue;
 		}
 
-		if (!of_device_is_available(child))
-			continue;
-
 		channel = &imx_ldb->channel[i];
 		channel->ldb = imx_ldb;
 		channel->chno = i;


