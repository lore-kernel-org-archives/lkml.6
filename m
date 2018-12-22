Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FCFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC40221908
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392131AbeLVSb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 13:31:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42517 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391986AbeLVSbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 13:31:14 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gagNi-0007IB-TD; Sat, 22 Dec 2018 12:27:50 +0000
From:   Colin King <colin.king@canonical.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] smack: fix two memory leaks in smack_add_opt
Date:   Sat, 22 Dec 2018 12:27:50 +0000
Message-Id: <20181222122750.13075-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently if s is null or when returning via the error exit label
out_opt_err leaks of the allocated opts can occur. Fix the leak
on the null s case by checking s is null before the allocation. Fix
the leak on the exit path by checking if opts was allocated by
kfree'ing opts.

Detected by CoverityScan, CID#1475953 ("Resource leak")

Fixes: b2130173efae ("smack: take the guts of smack_parse_opts_str() into a new helper")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/smack/smack_lsm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 84f72116a027..b5dc520adaa2 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -604,13 +604,13 @@ static int smack_add_opt(int token, const char *s, void **mnt_opts)
 {
 	struct smack_mnt_opts *opts = *mnt_opts;
 
+	if (!s)
+		return -ENOMEM;
 	if (!opts) {
 		opts = kzalloc(sizeof(struct smack_mnt_opts), GFP_KERNEL);
 		if (!opts)
 			return -ENOMEM;
 	}
-	if (!s)
-		return -ENOMEM;
 
 	switch (token) {
 	case Opt_fsdefault:
@@ -644,6 +644,8 @@ static int smack_add_opt(int token, const char *s, void **mnt_opts)
 
 out_opt_err:
 	pr_warn("Smack: duplicate mount options\n");
+	if (opts != *mnt_opts)
+		kfree(opts);
 	return -EINVAL;
 }
 
-- 
2.19.1

