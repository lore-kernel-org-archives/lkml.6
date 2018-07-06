Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCBAC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE19A2409E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE19A2409E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932580AbeGFF0B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:26:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45695 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932197AbeGFFZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:25:59 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=sec.l.tihix.com)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1fbJFl-0001Jc-4P; Fri, 06 Jul 2018 05:25:57 +0000
From:   Tyler Hicks <tyhicks@canonical.com>
To:     John Johansen <john.johansen@canonical.com>
Cc:     James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>,
        Seth Arnold <seth.arnold@canonical.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] apparmor: Fully initialize aa_perms struct when answering userspace query
Date:   Fri,  6 Jul 2018 05:25:01 +0000
Message-Id: <1530854701-7348-3-git-send-email-tyhicks@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530854701-7348-1-git-send-email-tyhicks@canonical.com>
References: <1530854701-7348-1-git-send-email-tyhicks@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fully initialize the aa_perms struct in profile_query_cb() to avoid the
potential of using an uninitialized struct member's value in a response
to a query from userspace.

Detected by CoverityScan CID#1415126 ("Uninitialized scalar variable")

Fixes: 4f3b3f2d79a4 ("apparmor: add profile permission query ability")
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 security/apparmor/apparmorfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 949dd8a48164..e09fe4d7307c 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -603,7 +603,7 @@ static const struct file_operations aa_fs_ns_revision_fops = {
 static void profile_query_cb(struct aa_profile *profile, struct aa_perms *perms,
 			     const char *match_str, size_t match_len)
 {
-	struct aa_perms tmp;
+	struct aa_perms tmp = { };
 	struct aa_dfa *dfa;
 	unsigned int state = 0;
 
@@ -613,7 +613,6 @@ static void profile_query_cb(struct aa_profile *profile, struct aa_perms *perms,
 		dfa = profile->file.dfa;
 		state = aa_dfa_match_len(dfa, profile->file.start,
 					 match_str + 1, match_len - 1);
-		tmp = nullperms;
 		if (state) {
 			struct path_cond cond = { };
 
@@ -627,8 +626,6 @@ static void profile_query_cb(struct aa_profile *profile, struct aa_perms *perms,
 					 match_str, match_len);
 		if (state)
 			aa_compute_perms(dfa, state, &tmp);
-		else
-			tmp = nullperms;
 	}
 	aa_apply_modes_to_perms(profile, &tmp);
 	aa_perms_accum_raw(perms, &tmp);
-- 
2.7.4

