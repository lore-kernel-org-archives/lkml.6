Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30B5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 16:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63B12086E
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 16:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63B12086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbeGNQio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 12:38:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50894 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeGNQio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 12:38:44 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1feNGG-0007YB-OD; Sat, 14 Jul 2018 16:19:08 +0000
From:   Colin King <colin.king@canonical.com>
To:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: remove redundant pointer 'info'
Date:   Sat, 14 Jul 2018 17:19:05 +0100
Message-Id: <20180714161905.5403-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'info' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'info' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/apparmor/domain.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 098d546d8253..410d9ce09861 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -1006,7 +1006,6 @@ static struct aa_label *build_change_hat(struct aa_profile *profile,
 					 const char *name, bool sibling)
 {
 	struct aa_profile *root, *hat = NULL;
-	const char *info = NULL;
 	int error = 0;
 
 	if (sibling && PROFILE_IS_HAT(profile)) {
@@ -1014,7 +1013,6 @@ static struct aa_label *build_change_hat(struct aa_profile *profile,
 	} else if (!sibling && !PROFILE_IS_HAT(profile)) {
 		root = aa_get_profile(profile);
 	} else {
-		info = "conflicting target types";
 		error = -EPERM;
 		goto audit;
 	}
@@ -1025,10 +1023,8 @@ static struct aa_label *build_change_hat(struct aa_profile *profile,
 		if (COMPLAIN_MODE(profile)) {
 			hat = aa_new_null_profile(profile, true, name,
 						  GFP_KERNEL);
-			if (!hat) {
-				info = "failed null profile create";
+			if (!hat)
 				error = -ENOMEM;
-			}
 		}
 	}
 	aa_put_profile(root);
-- 
2.17.1

