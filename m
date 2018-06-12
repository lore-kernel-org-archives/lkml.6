Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6F4A3C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22409208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22409208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933905AbeFLIKJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:10:09 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:6074 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933789AbeFLIKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:10:01 -0400
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: [PATCH 11/13] selinux: Cleanup printk logging in netif
Date:   Tue, 12 Jun 2018 10:09:10 +0200
Message-ID: <20180612080912.7827-12-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180612080912.7827-1-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace printk with pr_* to avoid checkpatch warnings.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/netif.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index ac65f7417413..8c738c189942 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -145,9 +145,8 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 
 	dev = dev_get_by_index(ns, ifindex);
 	if (unlikely(dev == NULL)) {
-		printk(KERN_WARNING
-		       "SELinux: failure in sel_netif_sid_slow(),"
-		       " invalid network interface (%d)\n", ifindex);
+		pr_warn("SELinux: failure in %s(), invalid network interface (%d)\n",
+			__func__, ifindex);
 		return -ENOENT;
 	}
 
@@ -177,10 +176,8 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 	spin_unlock_bh(&sel_netif_lock);
 	dev_put(dev);
 	if (unlikely(ret)) {
-		printk(KERN_WARNING
-		       "SELinux: failure in sel_netif_sid_slow(),"
-		       " unable to determine network interface label (%d)\n",
-		       ifindex);
+		pr_warn("SELinux: failure in %s(), unable to determine network interface label (%d)\n",
+			__func__, ifindex);
 		kfree(new);
 	}
 	return ret;
-- 
2.15.1

