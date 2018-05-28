Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938425AbeE1L7j (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:59:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423424AbeE1LHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:07:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 052/272] bnxt_en: Ignore src port field in decap filter nodes
Date: Mon, 28 May 2018 12:01:25 +0200
Message-Id: <20180528100245.234250676@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>

[ Upstream commit 479ca3bf91da971fcefc003cf5773e8d7db24794 ]

The driver currently uses src port field (along with other fields) in the
decap tunnel key, while looking up and adding tunnel nodes. This leads to
redundant cfa_decap_filter_alloc() requests to the FW and flow-miss in the
flow engine. Fix this by ignoring the src port field in decap tunnel nodes.

Fixes: f484f6782e01 ("bnxt_en: add hwrm FW cmds for cfa_encap_record and decap_filter")
Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -992,8 +992,10 @@ static int bnxt_tc_get_decap_handle(stru
 
 	/* Check if there's another flow using the same tunnel decap.
 	 * If not, add this tunnel to the table and resolve the other
-	 * tunnel header fileds
+	 * tunnel header fileds. Ignore src_port in the tunnel_key,
+	 * since it is not required for decap filters.
 	 */
+	decap_key->tp_src = 0;
 	decap_node = bnxt_tc_get_tunnel_node(bp, &tc_info->decap_table,
 					     &tc_info->decap_ht_params,
 					     decap_key);
