Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025D0C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70B52081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70B52081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbeLIW1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:27:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34702 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726392AbeLIVzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:12 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0002ik-Ka; Sun, 09 Dec 2018 21:55:09 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0003EG-TA; Sun, 09 Dec 2018 21:55:06 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Haishuang Yan" <yanhaishuang@cmss.chinamobile.com>,
        "Jiri Benc" <jbenc@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.948258754@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 027/328] vxlan: fix a potential issue when create a
 new vxlan fdb entry.
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

commit 17b463654f41f0aa334efd5a6efeab8a6e9496f7 upstream.

vxlan_fdb_append may return error, so add the proper check,
otherwise it will cause memory leak.

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

Changes in v2:
  - Unnecessary to initialize rc to zero.
Acked-by: Jiri Benc <jbenc@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/vxlan.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -695,6 +695,7 @@ static int vxlan_fdb_create(struct vxlan
 	struct vxlan_rdst *rd = NULL;
 	struct vxlan_fdb *f;
 	int notify = 0;
+	int rc;
 
 	f = __vxlan_find_mac(vxlan, mac);
 	if (f) {
@@ -729,8 +730,7 @@ static int vxlan_fdb_create(struct vxlan
 		if ((flags & NLM_F_APPEND) &&
 		    (is_multicast_ether_addr(f->eth_addr) ||
 		     is_zero_ether_addr(f->eth_addr))) {
-			int rc = vxlan_fdb_append(f, ip, port, vni, ifindex,
-						  &rd);
+			rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
 
 			if (rc < 0)
 				return rc;
@@ -760,7 +760,11 @@ static int vxlan_fdb_create(struct vxlan
 		INIT_LIST_HEAD(&f->remotes);
 		memcpy(f->eth_addr, mac, ETH_ALEN);
 
-		vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
+		rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
+		if (rc < 0) {
+			kfree(f);
+			return rc;
+		}
 
 		++vxlan->addrcnt;
 		hlist_add_head_rcu(&f->hlist,

