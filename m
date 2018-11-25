Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348FAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34D220868
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34D220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeKZDAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 22:00:19 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51402 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeKZDAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 22:00:19 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gQwxo-0007lj-AW; Sun, 25 Nov 2018 16:08:52 +0000
From:   Colin King <colin.king@canonical.com>
To:     Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] net: bridge: remove redundant checks for null p->dev and p->br
Date:   Sun, 25 Nov 2018 16:08:51 +0000
Message-Id: <20181125160851.6919-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A recent change added a null check on p->dev after p->dev was being
dereferenced by the ns_capable check on p->dev. It turns out that
neither the p->dev and p->br null checks are necessary, and can be
removed, which cleans up a static analyis warning.

As Nikolay Aleksandrov noted, these checks can be removed because:

"My reasoning of why it shouldn't be possible:
- On port add new_nbp() sets both p->dev and p->br before creating
  kobj/sysfs

- On port del (trickier) del_nbp() calls kobject_del() before call_rcu()
  to destroy the port which in turn calls sysfs_remove_dir() which uses
  kernfs_remove() which deactivates (shouldn't be able to open new
  files) and calls kernfs_drain() to drain current open/mmaped files in
  the respective dir before continuing, thus making it impossible to
  open a bridge port sysfs file with p->dev and p->br equal to NULL.

So I think it's safe to remove those checks altogether. It'd be nice to
get a second look over my reasoning as I might be missing something in
sysfs/kernfs call path."

Thanks to Nikolay Aleksandrov's suggestion to remove the check and
David Miller for sanity checking this.

Detected by CoverityScan, CID#751490 ("Dereference before null check")

Fixes: a5f3ea54f3cc ("net: bridge: add support for raw sysfs port options")
Signed-off-by: Colin Ian King <colin.king@canonical.com>

---

V2: remove checks instead of moving them before the dereference of
p->dev.
---
 net/bridge/br_sysfs_if.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 7c87a2fe5248..88715edb119a 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -320,9 +320,6 @@ static ssize_t brport_store(struct kobject *kobj,
 	if (!rtnl_trylock())
 		return restart_syscall();
 
-	if (!p->dev || !p->br)
-		goto out_unlock;
-
 	if (brport_attr->store_raw) {
 		char *buf_copy;
 
-- 
2.19.1

