Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26E0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C347D20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfBYTLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:11:41 -0500
Received: from gateway23.websitewelcome.com ([192.185.49.124]:40344 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726553AbfBYTLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:11:40 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 3DABADF25
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 13:11:40 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id yLfAgO8nEYTGMyLfAgfMap; Mon, 25 Feb 2019 13:11:40 -0600
X-Authority-Reason: nr=8
Received: from [189.250.127.169] (port=35712 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gyLf8-003g4D-5R; Mon, 25 Feb 2019 13:11:39 -0600
Date:   Mon, 25 Feb 2019 13:11:37 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] Bluetooth: mgmt: Use struct_size() helper
Message-ID: <20190225191137.GA24383@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.127.169
X-Source-L: No
X-Exim-ID: 1gyLf8-003g4D-5R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.169]:35712
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, change the following form:

sizeof(*rp) + (sizeof(rp->entry[0]) * count);

to :

struct_size(rp, entry, count)

Notice that, in this case, variable rp_len is not necessary, hence
it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/bluetooth/mgmt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ccce954f8146..1e2acaddcdfd 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -474,7 +474,6 @@ static int read_ext_index_list(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_rp_read_ext_index_list *rp;
 	struct hci_dev *d;
-	size_t rp_len;
 	u16 count;
 	int err;
 
@@ -488,8 +487,7 @@ static int read_ext_index_list(struct sock *sk, struct hci_dev *hdev,
 			count++;
 	}
 
-	rp_len = sizeof(*rp) + (sizeof(rp->entry[0]) * count);
-	rp = kmalloc(rp_len, GFP_ATOMIC);
+	rp = kmalloc(struct_size(rp, entry, count), GFP_ATOMIC);
 	if (!rp) {
 		read_unlock(&hci_dev_list_lock);
 		return -ENOMEM;
@@ -525,7 +523,6 @@ static int read_ext_index_list(struct sock *sk, struct hci_dev *hdev,
 	}
 
 	rp->num_controllers = cpu_to_le16(count);
-	rp_len = sizeof(*rp) + (sizeof(rp->entry[0]) * count);
 
 	read_unlock(&hci_dev_list_lock);
 
@@ -538,7 +535,8 @@ static int read_ext_index_list(struct sock *sk, struct hci_dev *hdev,
 	hci_sock_clear_flag(sk, HCI_MGMT_UNCONF_INDEX_EVENTS);
 
 	err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE,
-				MGMT_OP_READ_EXT_INDEX_LIST, 0, rp, rp_len);
+				MGMT_OP_READ_EXT_INDEX_LIST, 0, rp,
+				struct_size(rp, entry, count));
 
 	kfree(rp);
 
-- 
2.20.1

