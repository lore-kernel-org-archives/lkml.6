Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BIGNUM_EMAILS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBB4C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D79F20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D79F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeLIWKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:10:40 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37570 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728116AbeLIWKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:10:32 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73B-0002pr-Pr; Sun, 09 Dec 2018 21:55:45 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0003Qk-7z; Sun, 09 Dec 2018 21:55:12 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "John Johansen" <john.johansen@canonical.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.181027988@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 156/328] apparmor: remove no-op permission check in
 policy_unpack
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: John Johansen <john.johansen@canonical.com>

commit c037bd615885f1d9d3bdb48531bace79fae1505d upstream.

The patch 736ec752d95e: "AppArmor: policy routines for loading and
unpacking policy" from Jul 29, 2010, leads to the following static
checker warning:

    security/apparmor/policy_unpack.c:410 verify_accept()
    warn: bitwise AND condition is false here

    security/apparmor/policy_unpack.c:413 verify_accept()
    warn: bitwise AND condition is false here

security/apparmor/policy_unpack.c
   392  #define DFA_VALID_PERM_MASK             0xffffffff
   393  #define DFA_VALID_PERM2_MASK            0xffffffff
   394
   395  /**
   396   * verify_accept - verify the accept tables of a dfa
   397   * @dfa: dfa to verify accept tables of (NOT NULL)
   398   * @flags: flags governing dfa
   399   *
   400   * Returns: 1 if valid accept tables else 0 if error
   401   */
   402  static bool verify_accept(struct aa_dfa *dfa, int flags)
   403  {
   404          int i;
   405
   406          /* verify accept permissions */
   407          for (i = 0; i < dfa->tables[YYTD_ID_ACCEPT]->td_lolen; i++) {
   408                  int mode = ACCEPT_TABLE(dfa)[i];
   409
   410                  if (mode & ~DFA_VALID_PERM_MASK)
   411                          return 0;
   412
   413                  if (ACCEPT_TABLE2(dfa)[i] & ~DFA_VALID_PERM2_MASK)
   414                          return 0;

fixes: 736ec752d95e ("AppArmor: policy routines for loading and unpacking policy")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 security/apparmor/policy_unpack.c | 32 -------------------------------
 1 file changed, 32 deletions(-)

--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -290,32 +290,6 @@ static int unpack_strdup(struct aa_ext *
 	return res;
 }
 
-#define DFA_VALID_PERM_MASK		0xffffffff
-#define DFA_VALID_PERM2_MASK		0xffffffff
-
-/**
- * verify_accept - verify the accept tables of a dfa
- * @dfa: dfa to verify accept tables of (NOT NULL)
- * @flags: flags governing dfa
- *
- * Returns: 1 if valid accept tables else 0 if error
- */
-static bool verify_accept(struct aa_dfa *dfa, int flags)
-{
-	int i;
-
-	/* verify accept permissions */
-	for (i = 0; i < dfa->tables[YYTD_ID_ACCEPT]->td_lolen; i++) {
-		int mode = ACCEPT_TABLE(dfa)[i];
-
-		if (mode & ~DFA_VALID_PERM_MASK)
-			return 0;
-
-		if (ACCEPT_TABLE2(dfa)[i] & ~DFA_VALID_PERM2_MASK)
-			return 0;
-	}
-	return 1;
-}
 
 /**
  * unpack_dfa - unpack a file rule dfa
@@ -351,15 +325,9 @@ static struct aa_dfa *unpack_dfa(struct
 		if (IS_ERR(dfa))
 			return dfa;
 
-		if (!verify_accept(dfa, flags))
-			goto fail;
 	}
 
 	return dfa;
-
-fail:
-	aa_put_dfa(dfa);
-	return ERR_PTR(-EPROTO);
 }
 
 /**

