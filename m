Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033420AbeBOT0O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 14:26:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38904 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeBOT0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 14:26:13 -0500
From: Colin King <colin.king@canonical.com>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i40evf: pass struct virtchnl_filter by reference rather than by value
Date: Thu, 15 Feb 2018 19:26:05 +0000
Message-Id: <20180215192605.28350-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Passing struct virtchnl_filter f by value requires a 272 byte copy
on x86_64, so instead pass it by reference is much more efficient. Also
adjust some lines that are over 80 chars.

Detected by CoverityScan, CID#1465285 ("Big parameter passed by value")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 32 ++++++++++++----------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 6134b61e0938..3c76c817ca1a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -1048,24 +1048,28 @@ void i40evf_disable_channels(struct i40evf_adapter *adapter)
  * Print the cloud filter
  **/
 static void i40evf_print_cloud_filter(struct i40evf_adapter *adapter,
-				      struct virtchnl_filter f)
+				      struct virtchnl_filter *f)
 {
-	switch (f.flow_type) {
+	switch (f->flow_type) {
 	case VIRTCHNL_TCP_V4_FLOW:
 		dev_info(&adapter->pdev->dev, "dst_mac: %pM src_mac: %pM vlan_id: %hu dst_ip: %pI4 src_ip %pI4 dst_port %hu src_port %hu\n",
-			 &f.data.tcp_spec.dst_mac, &f.data.tcp_spec.src_mac,
-			 ntohs(f.data.tcp_spec.vlan_id),
-			 &f.data.tcp_spec.dst_ip[0], &f.data.tcp_spec.src_ip[0],
-			 ntohs(f.data.tcp_spec.dst_port),
-			 ntohs(f.data.tcp_spec.src_port));
+			 &f->data.tcp_spec.dst_mac,
+			 &f->data.tcp_spec.src_mac,
+			 ntohs(f->data.tcp_spec.vlan_id),
+			 &f->data.tcp_spec.dst_ip[0],
+			 &f->data.tcp_spec.src_ip[0],
+			 ntohs(f->data.tcp_spec.dst_port),
+			 ntohs(f->data.tcp_spec.src_port));
 		break;
 	case VIRTCHNL_TCP_V6_FLOW:
 		dev_info(&adapter->pdev->dev, "dst_mac: %pM src_mac: %pM vlan_id: %hu dst_ip: %pI6 src_ip %pI6 dst_port %hu src_port %hu\n",
-			 &f.data.tcp_spec.dst_mac, &f.data.tcp_spec.src_mac,
-			 ntohs(f.data.tcp_spec.vlan_id),
-			 &f.data.tcp_spec.dst_ip, &f.data.tcp_spec.src_ip,
-			 ntohs(f.data.tcp_spec.dst_port),
-			 ntohs(f.data.tcp_spec.src_port));
+			 &f->data.tcp_spec.dst_mac,
+			 &f->data.tcp_spec.src_mac,
+			 ntohs(f->data.tcp_spec.vlan_id),
+			 &f->data.tcp_spec.dst_ip,
+			 &f->data.tcp_spec.src_ip,
+			 ntohs(f->data.tcp_spec.dst_port),
+			 ntohs(f->data.tcp_spec.src_port));
 		break;
 	}
 }
@@ -1303,7 +1307,7 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 						 i40evf_stat_str(&adapter->hw,
 								 v_retval));
 					i40evf_print_cloud_filter(adapter,
-								  cf->f);
+								  &cf->f);
 					list_del(&cf->list);
 					kfree(cf);
 					adapter->num_cloud_filters--;
@@ -1322,7 +1326,7 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 						 i40evf_stat_str(&adapter->hw,
 								 v_retval));
 					i40evf_print_cloud_filter(adapter,
-								  cf->f);
+								  &cf->f);
 				}
 			}
 			}
-- 
2.15.1
