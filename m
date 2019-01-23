Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84281C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B73F2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfAWOoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:44:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:38046 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfAWOoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:44:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 06:44:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,511,1539673200"; 
   d="scan'208";a="140631675"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2019 06:44:17 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH] device property: Fix the length used in PROPERTY_ENTRY_STRING
Date:   Wed, 23 Jan 2019 17:44:16 +0300
Message-Id: <20190123144416.51859-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With string type property entries we need to use
sizeof(const char *) instead of the number of characters as
the length of the entry.

If the string was shorter then sizeof(const char *),
attempts to read it would have failed with -EOVERFLOW. The
problem has been hidden because all build-in string
properties have had a string longer then 8 characters until
now.

Fixes: a85f42047533 ("device property: helper macros for property entry creation")
Cc: stable@vger.kernel.org
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 include/linux/property.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 3789ec755fb6..65d3420dd5d1 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -258,7 +258,7 @@ struct property_entry {
 #define PROPERTY_ENTRY_STRING(_name_, _val_)		\
 (struct property_entry) {				\
 	.name = _name_,					\
-	.length = sizeof(_val_),			\
+	.length = sizeof(const char *),			\
 	.type = DEV_PROP_STRING,			\
 	{ .value = { .str = _val_ } },			\
 }
-- 
2.20.1

