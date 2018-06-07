Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1tIZI5P5GFt6agAAmS7hNA
	; Thu, 07 Jun 2018 09:24:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D9924607DC; Thu,  7 Jun 2018 09:24:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 58190601C3;
	Thu,  7 Jun 2018 09:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 58190601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932985AbeFGJYS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:24:18 -0400
Received: from inva020.nxp.com ([92.121.34.13]:46320 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932878AbeFGJWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:22:47 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D4961A02FF;
        Thu,  7 Jun 2018 11:22:45 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2BA351A008B;
        Thu,  7 Jun 2018 11:22:45 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id 9488E40A70;
        Thu,  7 Jun 2018 02:22:44 -0700 (MST)
Received: from titan.ap.freescale.net ([10.192.208.233])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w579MJ4n020959;
        Thu, 7 Jun 2018 02:22:41 -0700
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v3, 07/10] fsl/fman_port: support getting timestamp
Date: Thu,  7 Jun 2018 17:20:47 +0800
Message-Id: <20180607092050.46128-8-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180607092050.46128-1-yangbo.lu@nxp.com>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add fman_port_get_tstamp() interface
to get timestamp.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None.
Changes for v3:
	- Moved endianness conversion from dpaa to fman API.
---
 drivers/net/ethernet/freescale/fman/fman_port.c |   12 ++++++++++++
 drivers/net/ethernet/freescale/fman/fman_port.h |    2 ++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_port.c b/drivers/net/ethernet/freescale/fman/fman_port.c
index ce6e24c..dce860d 100644
--- a/drivers/net/ethernet/freescale/fman/fman_port.c
+++ b/drivers/net/ethernet/freescale/fman/fman_port.c
@@ -1731,6 +1731,18 @@ int fman_port_get_hash_result_offset(struct fman_port *port, u32 *offset)
 }
 EXPORT_SYMBOL(fman_port_get_hash_result_offset);
 
+int fman_port_get_tstamp(struct fman_port *port, const void *data, u64 *tstamp)
+{
+	if (port->buffer_offsets.time_stamp_offset == ILLEGAL_BASE)
+		return -EINVAL;
+
+	*tstamp = be64_to_cpu(*(u64 *)(data +
+			port->buffer_offsets.time_stamp_offset));
+
+	return 0;
+}
+EXPORT_SYMBOL(fman_port_get_tstamp);
+
 static int fman_port_probe(struct platform_device *of_dev)
 {
 	struct fman_port *port;
diff --git a/drivers/net/ethernet/freescale/fman/fman_port.h b/drivers/net/ethernet/freescale/fman/fman_port.h
index e86ca6a..9dbb69f 100644
--- a/drivers/net/ethernet/freescale/fman/fman_port.h
+++ b/drivers/net/ethernet/freescale/fman/fman_port.h
@@ -153,6 +153,8 @@ int fman_port_cfg_buf_prefix_content(struct fman_port *port,
 
 int fman_port_get_hash_result_offset(struct fman_port *port, u32 *offset);
 
+int fman_port_get_tstamp(struct fman_port *port, const void *data, u64 *tstamp);
+
 struct fman_port *fman_port_bind(struct device *dev);
 
 #endif /* __FMAN_PORT_H */
-- 
1.7.1
