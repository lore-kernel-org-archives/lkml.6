Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E203C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E4420672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E4420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeLIUin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:38:43 -0500
Received: from mail5.windriver.com ([192.103.53.11]:52320 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeLIUin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:38:43 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wB9Kb4ne004222
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 9 Dec 2018 12:37:14 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 9 Dec 2018
 12:36:53 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-security-module@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>
Subject: [PATCH 2/5] keys: remove needless modular infrastructure from ecryptfs_format
Date:   Sun, 9 Dec 2018 15:36:30 -0500
Message-ID: <1544387793-32309-3-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544387793-32309-1-git-send-email-paul.gortmaker@windriver.com>
References: <1544387793-32309-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though the support can be modular, only one file needs to use
all the macros like MODULE_AUTHOR, MODULE_LICENSE etc.  Only the one
responsible for registering/removal with module_init/module_exit
needs to declare these.  In this case, that file is "encrypted.c"
and it already has the MODULE_LICENSE that we are removing here.

Since the file does EXPORT_SYMBOL, we add export.h - and build tests
show that module.h (which includes everything) was hiding an implicit
use of string.h - so that is added as well.

Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 security/keys/encrypted-keys/ecryptfs_format.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/keys/encrypted-keys/ecryptfs_format.c b/security/keys/encrypted-keys/ecryptfs_format.c
index 6daa3b6ff9ed..efac03047919 100644
--- a/security/keys/encrypted-keys/ecryptfs_format.c
+++ b/security/keys/encrypted-keys/ecryptfs_format.c
@@ -15,7 +15,8 @@
  * the Free Software Foundation, version 2 of the License.
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
+#include <linux/string.h>
 #include "ecryptfs_format.h"
 
 u8 *ecryptfs_get_auth_tok_key(struct ecryptfs_auth_tok *auth_tok)
@@ -77,5 +78,3 @@ int ecryptfs_fill_auth_tok(struct ecryptfs_auth_tok *auth_tok,
 	return 0;
 }
 EXPORT_SYMBOL(ecryptfs_fill_auth_tok);
-
-MODULE_LICENSE("GPL");
-- 
2.7.4

