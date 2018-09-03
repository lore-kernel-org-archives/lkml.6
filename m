Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78068C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7FC20645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7FC20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbeICVgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:36:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42410 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728676AbeICVgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:36:37 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 596F4D02;
        Mon,  3 Sep 2018 17:15:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 012/165] drm/imx: imx-ldb: disable LDB on driver bind
Date:   Mon,  3 Sep 2018 18:54:58 +0200
Message-Id: <20180903165655.622866839@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas Stach <l.stach@pengutronix.de>

[ Upstream commit b58262396fabd43dc869b576e3defdd23b32fe94 ]

The LVDS signal integrity is only guaranteed when the correct enable
sequence (first IPU DI, then LDB) is used. If the LDB display output was
active before the imx-drm driver is loaded (like when a bootsplash was
active) the DI will be disabled by the full IPU reset we do when loading
the driver. The LDB control registers are not part of the IPU range and
thus will remain unchanged.

This leads to the LDB still being active when the DI is getting enabled,
effectively reversing the required enable sequence. Fix this by also
disabling the LDB on driver bind.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/imx/imx-ldb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/imx/imx-ldb.c
+++ b/drivers/gpu/drm/imx/imx-ldb.c
@@ -612,6 +612,9 @@ static int imx_ldb_bind(struct device *d
 		return PTR_ERR(imx_ldb->regmap);
 	}
 
+	/* disable LDB by resetting the control register to POR default */
+	regmap_write(imx_ldb->regmap, IOMUXC_GPR2, 0);
+
 	imx_ldb->dev = dev;
 
 	if (of_id)


