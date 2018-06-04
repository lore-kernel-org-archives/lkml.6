Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753808AbeFDHMS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:12:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34810 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753086AbeFDHKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:10:41 -0400
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 07/10] fsl/fman_port: support getting timestamp field
Date: Mon,  4 Jun 2018 15:08:34 +0800
Message-Id: <20180604070837.19265-8-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180604070837.19265-1-yangbo.lu@nxp.com>
References: <20180604070837.19265-1-yangbo.lu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add fman_port_get_tstamp_field() interface
to get timestamp field data.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/net/ethernet/freescale/fman/fman_port.c |   12 ++++++++++++
 drivers/net/ethernet/freescale/fman/fman_port.h |    3 +++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_port.c b/drivers/net/ethernet/freescale/fman/fman_port.c
index ce6e24c..86f0094 100644
--- a/drivers/net/ethernet/freescale/fman/fman_port.c
+++ b/drivers/net/ethernet/freescale/fman/fman_port.c
@@ -1731,6 +1731,18 @@ int fman_port_get_hash_result_offset(struct fman_port *port, u32 *offset)
 }
 EXPORT_SYMBOL(fman_port_get_hash_result_offset);
 
+int fman_port_get_tstamp_field(struct fman_port *port, const void *data,
+			       u64 *tstamp)
+{
+	if (port->buffer_offsets.time_stamp_offset == ILLEGAL_BASE)
+		return -EINVAL;
+
+	*tstamp = *(u64 *)(data + port->buffer_offsets.time_stamp_offset);
+
+	return 0;
+}
+EXPORT_SYMBOL(fman_port_get_tstamp_field);
+
 static int fman_port_probe(struct platform_device *of_dev)
 {
 	struct fman_port *port;
diff --git a/drivers/net/ethernet/freescale/fman/fman_port.h b/drivers/net/ethernet/freescale/fman/fman_port.h
index e86ca6a..d10e48d 100644
--- a/drivers/net/ethernet/freescale/fman/fman_port.h
+++ b/drivers/net/ethernet/freescale/fman/fman_port.h
@@ -153,6 +153,9 @@ int fman_port_cfg_buf_prefix_content(struct fman_port *port,
 
 int fman_port_get_hash_result_offset(struct fman_port *port, u32 *offset);
 
+int fman_port_get_tstamp_field(struct fman_port *port, const void *data,
+			       u64 *tstamp);
+
 struct fman_port *fman_port_bind(struct device *dev);
 
 #endif /* __FMAN_PORT_H */
-- 
1.7.1
