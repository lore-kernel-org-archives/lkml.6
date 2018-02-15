Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755569AbeBOTmy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 14:42:54 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39184 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbeBOTmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 14:42:52 -0500
From: Colin King <colin.king@canonical.com>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i40evf: remove redundant array comparisons to 0 checks
Date: Thu, 15 Feb 2018 19:42:45 +0000
Message-Id: <20180215194245.28860-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The checks to see if key->dst.s6_addr and key->src.s6_addr are null
pointers are redundant because these are constant size arrays and
so the checks always return true.  Fix this by removing the redundant
checks.

Detected by CoverityScan, CID#1465279 ("Array compared to 0")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 4955ce3ab6a2..63e4169828ea 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2710,22 +2710,19 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 		if (!ipv6_addr_any(&mask->dst) || !ipv6_addr_any(&mask->src))
 			field_flags |= I40EVF_CLOUD_FIELD_IIP;
 
-		if (key->dst.s6_addr) {
-			for (i = 0; i < 4; i++)
-				filter->f.mask.tcp_spec.dst_ip[i] |=
+		for (i = 0; i < 4; i++)
+			filter->f.mask.tcp_spec.dst_ip[i] |=
 							cpu_to_be32(0xffffffff);
-			memcpy(&filter->f.data.tcp_spec.dst_ip,
-			       &key->dst.s6_addr32,
-			       sizeof(filter->f.data.tcp_spec.dst_ip));
-		}
-		if (key->src.s6_addr) {
-			for (i = 0; i < 4; i++)
-				filter->f.mask.tcp_spec.src_ip[i] |=
+		memcpy(&filter->f.data.tcp_spec.dst_ip,
+		       &key->dst.s6_addr32,
+		       sizeof(filter->f.data.tcp_spec.dst_ip));
+
+		for (i = 0; i < 4; i++)
+			filter->f.mask.tcp_spec.src_ip[i] |=
 							cpu_to_be32(0xffffffff);
-			memcpy(&filter->f.data.tcp_spec.src_ip,
-			       &key->src.s6_addr32,
-			       sizeof(filter->f.data.tcp_spec.src_ip));
-		}
+		memcpy(&filter->f.data.tcp_spec.src_ip,
+		       &key->src.s6_addr32,
+		       sizeof(filter->f.data.tcp_spec.src_ip));
 	}
 	if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_PORTS)) {
 		struct flow_dissector_key_ports *key =
-- 
2.15.1
