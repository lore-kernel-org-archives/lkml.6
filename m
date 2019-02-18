Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A1DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B345320851
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499976;
	bh=cro5u5RLxmFgdbIkUmxjc8OOtpxvzmxQ6UjwaKoIzMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PQS/3/njBqsSTJ1SS8Wv+X0qKsihw0FAENsA/o2Dx98CmDZbHUJQtgQugvEPh4m29
	 EMXEOL1RBeDpLQUmgt0Px+Hk3k2kQDF2Ua/Qor7FwavnOfW1tdjetByyT5n861+PL8
	 YGgSiBMFgQfZKM9Gc5wudBKmsNeZM0KvPK+7WqUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389475AbfBROCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:02:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389452AbfBROCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:02:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24C2721908;
        Mon, 18 Feb 2019 14:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498559;
        bh=cro5u5RLxmFgdbIkUmxjc8OOtpxvzmxQ6UjwaKoIzMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vz+iz3Oy80S74zPiL9eUt0gTzNQVXEshoGvKUanE1AMipU+e8SjN579jJ35NEAG2G
         9lijaQFVkMnL74olEwa3WFKGlHyonMe789PuRkUXkII5WzMBHixQUK5UkHNN/asZO4
         JthfN3wMBYgxFt4m5nGmGyGrN95RUNhILHDU74ik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Zoran Markovic <zmarkovic@sierrawireless.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 025/143] smack: fix access permissions for keyring
Date:   Mon, 18 Feb 2019 14:42:33 +0100
Message-Id: <20190218133530.072077456@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5b841bfab695e3b8ae793172a9ff7990f99cc3e2 ]

Function smack_key_permission() only issues smack requests for the
following operations:
 - KEY_NEED_READ (issues MAY_READ)
 - KEY_NEED_WRITE (issues MAY_WRITE)
 - KEY_NEED_LINK (issues MAY_WRITE)
 - KEY_NEED_SETATTR (issues MAY_WRITE)
A blank smack request is issued in all other cases, resulting in
smack access being granted if there is any rule defined between
subject and object, or denied with -EACCES otherwise.

Request MAY_READ access for KEY_NEED_SEARCH and KEY_NEED_VIEW.
Fix the logic in the unlikely case when both MAY_READ and
MAY_WRITE are needed. Validate access permission field for valid
contents.

Signed-off-by: Zoran Markovic <zmarkovic@sierrawireless.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smack_lsm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c73361859d11..9db7c80a74aa 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4311,6 +4311,12 @@ static int smack_key_permission(key_ref_t key_ref,
 	int request = 0;
 	int rc;
 
+	/*
+	 * Validate requested permissions
+	 */
+	if (perm & ~KEY_NEED_ALL)
+		return -EINVAL;
+
 	keyp = key_ref_to_ptr(key_ref);
 	if (keyp == NULL)
 		return -EINVAL;
@@ -4330,10 +4336,10 @@ static int smack_key_permission(key_ref_t key_ref,
 	ad.a.u.key_struct.key = keyp->serial;
 	ad.a.u.key_struct.key_desc = keyp->description;
 #endif
-	if (perm & KEY_NEED_READ)
-		request = MAY_READ;
+	if (perm & (KEY_NEED_READ | KEY_NEED_SEARCH | KEY_NEED_VIEW))
+		request |= MAY_READ;
 	if (perm & (KEY_NEED_WRITE | KEY_NEED_LINK | KEY_NEED_SETATTR))
-		request = MAY_WRITE;
+		request |= MAY_WRITE;
 	rc = smk_access(tkp, keyp->security, request, &ad);
 	rc = smk_bu_note("key access", tkp, keyp->security, request, rc);
 	return rc;
-- 
2.19.1



