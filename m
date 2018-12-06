Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70C9C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F2B20661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F2B20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbeLFRGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:06:00 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44521 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeLFRF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:05:59 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gUx65-0001Z2-Qu; Thu, 06 Dec 2018 17:05:57 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][RESEND] drivers: base: remove need for a temporary string for the node name
Date:   Thu,  6 Dec 2018 17:05:57 +0000
Message-Id: <20181206170557.27834-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the node name is being formatting into a temporary string
node_name, however, kobject_init_and_add allows one to format up
a node name, so use that instead. This removes the need for the
node_name string and also cleans up the following warning:

Fixes clang warning:
warning: format string is not a string literal (potentially
insecure) [-Wformat-security]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/base/swnode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 9c63ec8d8ab4..306bb93287af 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -553,7 +553,6 @@ fwnode_create_software_node(const struct property_entry *properties,
 {
 	struct software_node *p = NULL;
 	struct software_node *swnode;
-	char node_name[20];
 	int ret;
 
 	if (parent) {
@@ -576,8 +575,6 @@ fwnode_create_software_node(const struct property_entry *properties,
 	}
 
 	swnode->id = ret;
-	sprintf(node_name, "node%d", swnode->id);
-
 	swnode->kobj.kset = swnode_kset;
 	swnode->fwnode.ops = &software_node_ops;
 
@@ -590,7 +587,7 @@ fwnode_create_software_node(const struct property_entry *properties,
 		list_add_tail(&swnode->entry, &p->children);
 
 	ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
-				   p ? &p->kobj : NULL, node_name);
+				   p ? &p->kobj : NULL, "node%d", swnode->id);
 	if (ret) {
 		kobject_put(&swnode->kobj);
 		return ERR_PTR(ret);
-- 
2.19.1

