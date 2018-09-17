Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7885ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DDA2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DDA2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbeIREng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:43:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51062 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbeIREnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:43:35 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5DB25707;
        Mon, 17 Sep 2018 23:14:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 134/158] media: rcar-csi2: update stream start for V3M
Date:   Tue, 18 Sep 2018 00:42:44 +0200
Message-Id: <20180917211717.362738695@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Niklas Söderlund" <niklas.soderlund+renesas@ragnatech.se>

[ Upstream commit 4070fc9ade52f7d0ad1397fe74f564ae95e68a4f ]

Latest errata document updates the start procedure for V3M. This change
in addition to adhering to the datasheet update fixes capture on early
revisions of V3M.

Signed-off-by: Niklas SÃ¶derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/rcar-vin/rcar-csi2.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

--- a/drivers/media/platform/rcar-vin/rcar-csi2.c
+++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
@@ -339,6 +339,7 @@ enum rcar_csi2_pads {
 
 struct rcar_csi2_info {
 	int (*init_phtw)(struct rcar_csi2 *priv, unsigned int mbps);
+	int (*confirm_start)(struct rcar_csi2 *priv);
 	const struct rcsi2_mbps_reg *hsfreqrange;
 	unsigned int csi0clkfreqrange;
 	bool clear_ulps;
@@ -545,6 +546,13 @@ static int rcsi2_start(struct rcar_csi2
 	if (ret)
 		return ret;
 
+	/* Confirm start */
+	if (priv->info->confirm_start) {
+		ret = priv->info->confirm_start(priv);
+		if (ret)
+			return ret;
+	}
+
 	/* Clear Ultra Low Power interrupt. */
 	if (priv->info->clear_ulps)
 		rcsi2_write(priv, INTSTATE_REG,
@@ -881,6 +889,11 @@ static int rcsi2_init_phtw_h3_v3h_m3n(st
 
 static int rcsi2_init_phtw_v3m_e3(struct rcar_csi2 *priv, unsigned int mbps)
 {
+	return rcsi2_phtw_write_mbps(priv, mbps, phtw_mbps_v3m_e3, 0x44);
+}
+
+static int rcsi2_confirm_start_v3m_e3(struct rcar_csi2 *priv)
+{
 	static const struct phtw_value step1[] = {
 		{ .data = 0xed, .code = 0x34 },
 		{ .data = 0xed, .code = 0x44 },
@@ -890,12 +903,6 @@ static int rcsi2_init_phtw_v3m_e3(struct
 		{ /* sentinel */ },
 	};
 
-	int ret;
-
-	ret = rcsi2_phtw_write_mbps(priv, mbps, phtw_mbps_v3m_e3, 0x44);
-	if (ret)
-		return ret;
-
 	return rcsi2_phtw_write_array(priv, step1);
 }
 
@@ -949,6 +956,7 @@ static const struct rcar_csi2_info rcar_
 
 static const struct rcar_csi2_info rcar_csi2_info_r8a77970 = {
 	.init_phtw = rcsi2_init_phtw_v3m_e3,
+	.confirm_start = rcsi2_confirm_start_v3m_e3,
 };
 
 static const struct of_device_id rcar_csi2_of_table[] = {


