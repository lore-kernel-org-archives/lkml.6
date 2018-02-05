Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753112AbeBENhj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 08:37:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50196 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752843AbeBENhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 08:37:31 -0500
From: Colin King <colin.king@canonical.com>
To: Harish Patil <harish.patil@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Dept-GELinuxNICDev@cavium.com, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] qlcnic: remove redundant initializations to pointers vh and nf
Date: Mon,  5 Feb 2018 13:37:29 +0000
Message-Id: <20180205133729.13453-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer vh is initialized however the value is never read as it
is re-assigned inside an if-statement.  Move the declaration to
inside the if-statement and remove the extraneous initialization.

Similarly, pointer nf is being initialized and the value is never
read and is re-assigned later, so this is redundant and can also
be removed.

Cleans up clang warnings:
drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c:306:22: warning:
Value stored to 'vh' during its initialization is never read
drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c:627:26: warning:
Value stored to 'nf' during its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
index 84dd83031a1b..db0267a8eec4 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
@@ -303,7 +303,6 @@ static void qlcnic_send_filter(struct qlcnic_adapter *adapter,
 			       struct cmd_desc_type0 *first_desc,
 			       struct sk_buff *skb)
 {
-	struct vlan_ethhdr *vh = (struct vlan_ethhdr *)(skb->data);
 	struct ethhdr *phdr = (struct ethhdr *)(skb->data);
 	u16 protocol = ntohs(skb->protocol);
 	struct qlcnic_filter *fil, *tmp_fil;
@@ -318,6 +317,8 @@ static void qlcnic_send_filter(struct qlcnic_adapter *adapter,
 
 	if (adapter->flags & QLCNIC_VLAN_FILTERING) {
 		if (protocol == ETH_P_8021Q) {
+			struct vlan_ethhdr *vh;
+
 			vh = (struct vlan_ethhdr *)skb->data;
 			vlan_id = ntohs(vh->h_vlan_TCI);
 		} else if (skb_vlan_tag_present(skb)) {
@@ -624,7 +625,7 @@ static int qlcnic_map_tx_skb(struct pci_dev *pdev, struct sk_buff *skb,
 static void qlcnic_unmap_buffers(struct pci_dev *pdev, struct sk_buff *skb,
 				 struct qlcnic_cmd_buffer *pbuf)
 {
-	struct qlcnic_skb_frag *nf = &pbuf->frag_array[0];
+	struct qlcnic_skb_frag *nf;
 	int i, nr_frags = skb_shinfo(skb)->nr_frags;
 
 	for (i = 0; i < nr_frags; i++) {
-- 
2.15.1
