Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C545C282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC6120821
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfBCQBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 11:01:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfBCQBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 11:01:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 910152D7E0;
        Sun,  3 Feb 2019 16:01:15 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E583424A;
        Sun,  3 Feb 2019 16:01:06 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com,
        dyoung@redhat.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>
Subject: [PATCH] integrity, KEYS: Fix build break with set_platform_trusted_keys
Date:   Sun,  3 Feb 2019 23:59:27 +0800
Message-Id: <20190203155927.24390-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 03 Feb 2019 16:01:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 15ebb2eb0705 ("integrity, KEYS: add a reference to platform
keyring") introduced a function set_platform_trusted_keys
and calls the function in __integrity_init_keyring.

It only checks if CONFIG_INTEGRITY_PLATFORM_KEYRING is enabled when
enabling this function, but actually this function also depends on
CONFIG_SYSTEM_TRUSTED_KEYRING.

So when built with CONFIG_INTEGRITY_PLATFORM_KEYRING &&
!CONFIG_SYSTEM_TRUSTED_KEYRING. we will get following error:

digsig.c:92: undefined reference to `set_platform_trusted_keys'

And it also mistakenly wrapped the function code in the ifdef block of
CONFIG_SYSTEM_DATA_VERIFICATION.

This commit fixes the issue by adding the missing check of
CONFIG_SYSTEM_TRUSTED_KEYRING and move the function code out of
CONFIG_SYSTEM_DATA_VERIFICATION's ifdef block.

Fixes: 15ebb2eb0705 ("integrity, KEYS: add a reference to platform keyring")
Signed-off-by: Kairui Song <kasong@redhat.com>
---
 certs/system_keyring.c        | 4 ++--
 include/keys/system_keyring.h | 9 +++------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 19bd0504bbcb..c05c29ae4d5d 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -279,11 +279,11 @@ int verify_pkcs7_signature(const void *data, size_t len,
 }
 EXPORT_SYMBOL_GPL(verify_pkcs7_signature);
 
+#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
+
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
 void __init set_platform_trusted_keys(struct key *keyring)
 {
 	platform_trusted_keys = keyring;
 }
 #endif
-
-#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index c7f899ee974e..42a93eda331c 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -61,16 +61,13 @@ static inline struct key *get_ima_blacklist_keyring(void)
 }
 #endif /* CONFIG_IMA_BLACKLIST_KEYRING */
 
-#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
-
+#if defined(CONFIG_INTEGRITY_PLATFORM_KEYRING) && \
+	defined(CONFIG_SYSTEM_TRUSTED_KEYRING)
 extern void __init set_platform_trusted_keys(struct key *keyring);
-
 #else
-
 static inline void set_platform_trusted_keys(struct key *keyring)
 {
 }
-
-#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
+#endif
 
 #endif /* _KEYS_SYSTEM_KEYRING_H */
-- 
2.20.1

