Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89EEC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF8720857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF8720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389794AbeG0W6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:58:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48799 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389523AbeG0W6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:58:25 -0400
Received: from 2.general.tyhicks.us.vpn ([10.172.64.53] helo=sec.ubuntu-ci)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1fjANg-0003dc-TA; Fri, 27 Jul 2018 21:34:37 +0000
From:   Tyler Hicks <tyhicks@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next] sysfs: Fix regression when adding a file to an existing group
Date:   Fri, 27 Jul 2018 21:33:27 +0000
Message-Id: <1532727207-10912-1-git-send-email-tyhicks@canonical.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5f81880d5204 ("sysfs, kobject: allow creating kobject belonging
to arbitrary users") incorrectly changed the argument passed as the
parent parameter when calling sysfs_add_file_mode_ns(). This caused some
sysfs attribute files to not be added correctly to certain groups.

Fixes: 5f81880d5204 ("sysfs, kobject: allow creating kobject belonging to arbitrary users")
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
---

Note, this was a regression exclusively in linux-next and never made it to
Linus' tree. There's no need to queue it up for linux-stable.

 fs/sysfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index fa46216523cf..052e5ad9a4d2 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -373,7 +373,7 @@ int sysfs_add_file_to_group(struct kobject *kobj,
 		return -ENOENT;
 
 	kobject_get_ownership(kobj, &uid, &gid);
-	error = sysfs_add_file_mode_ns(kobj->sd, attr, false,
+	error = sysfs_add_file_mode_ns(parent, attr, false,
 				       attr->mode, uid, gid, NULL);
 	kernfs_put(parent);
 
-- 
2.7.4

