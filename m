Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B45BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E829321908
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392110AbeLVSbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 13:31:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42517 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391976AbeLVSbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 13:31:11 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gagcv-00082I-Hg; Sat, 22 Dec 2018 12:43:33 +0000
From:   Colin King <colin.king@canonical.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drivers: base: swnode: check if swnode is null before dereferencing it
Date:   Sat, 22 Dec 2018 12:43:33 +0000
Message-Id: <20181222124333.13561-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The macro to_software_mode can potentially return NULL, so also add
a null check on the swnode before dereferencing it to avoid any null
pointer dereferences.

Detected by CoverityScan, CID#1476052 ("Explicit null dereferenced")

Fixes: 59abd83672f7 ("drivers: base: Introducing software nodes to the firmware node framework")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/base/swnode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 306bb93287af..204aa7d049e0 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -477,7 +477,8 @@ software_node_get_parent(const struct fwnode_handle *fwnode)
 {
 	struct software_node *swnode = to_software_node(fwnode);
 
-	return swnode->parent ? &swnode->parent->fwnode : NULL;
+	return swnode ? (swnode->parent ? &swnode->parent->fwnode : NULL) :
+			NULL;
 }
 
 struct fwnode_handle *
-- 
2.19.1

