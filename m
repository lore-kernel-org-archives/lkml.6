Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705B9C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A75820672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A75820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeLIUiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:38:20 -0500
Received: from mail5.windriver.com ([192.103.53.11]:52302 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbeLIUiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:38:19 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wB9Kb4nf004222
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 9 Dec 2018 12:37:39 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 9 Dec 2018
 12:37:27 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-security-module@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH 3/5] security: fs: make inode explicitly non-modular
Date:   Sun, 9 Dec 2018 15:36:31 -0500
Message-ID: <1544387793-32309-4-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544387793-32309-1-git-send-email-paul.gortmaker@windriver.com>
References: <1544387793-32309-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Makefile/Kconfig entry controlling compilation of this code is:

security/Makefile:obj-$(CONFIG_SECURITYFS)                += inode.o

security/Kconfig:config SECURITYFS
security/Kconfig:       bool "Enable the securityfs filesystem"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

The removal of module.h uncovered a couple previously hidden implicit
header requirements which are now included explicitly.

Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 security/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 8dd9ca8848e4..b7772a9b315e 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -13,7 +13,8 @@
  */
 
 /* #define DEBUG */
-#include <linux/module.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
@@ -341,7 +342,4 @@ static int __init securityfs_init(void)
 #endif
 	return 0;
 }
-
 core_initcall(securityfs_init);
-MODULE_LICENSE("GPL");
-
-- 
2.7.4

