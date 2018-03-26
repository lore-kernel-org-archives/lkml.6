Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeCZL1V (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 07:27:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48134 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeCZL1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 07:27:20 -0400
From: Colin King <colin.king@canonical.com>
To: "David S . Miller" <davem@davemloft.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/ncsi: check for null return from call to nla_nest_start
Date: Mon, 26 Mar 2018 12:27:12 +0100
Message-Id: <20180326112712.31165-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The call to nla_nest_start calls nla_put which can lead to a NULL
return so it's possible for attr to become NULL and we can potentially
get a NULL pointer dereference on attr.  Fix this by checking for
a NULL return.

Detected by CoverityScan, CID#1466125 ("Dereference null return")

Fixes: 955dc68cb9b2 ("net/ncsi: Add generic netlink family")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/ncsi/ncsi-netlink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 05fcfb4fbe1d..8d7e849d4825 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -190,6 +190,10 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
 
 	attr = nla_nest_start(skb, NCSI_ATTR_PACKAGE_LIST);
+	if (!attr) {
+		kfree_skb(skb);
+		return -EMSGSIZE;
+	}
 	rc = ncsi_write_package_info(skb, ndp, package_id);
 
 	if (rc) {
-- 
2.15.1
