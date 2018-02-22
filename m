Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227ZwaMM2A6bbtLCzpUG77F17Ifrher5wJFLagbjkUh7gNlxcEm5rqOpdektP8ScWSQpDpjl
ARC-Seal: i=1; a=rsa-sha256; t=1519264709; cv=none;
        d=google.com; s=arc-20160816;
        b=u112Jekcx6he61aGh3dtEpbGbW8aBXftXTIAi3fgdyt56H7VuRzG+zHawWPiOFS3q2
         qLQsmrZwr2iXW2GTCBffeMDaKUdjBiZhFIRUnP0LVjynV/PGY+BiB32gbT1+2p0cVHXr
         DZLYp+lIqiy7XP5T7kntsY12d/AowmBzQOz7NYmjuOvqJMm5RgEdrpDlRkCg3RpGI1gV
         oq5HGqQ8hD9jjNFBIXEzSLY9tdr+qwNbGzyNqZrfHJsKFRfwJRVSQqSAi8WkbR65/Jdg
         m+7OTZCuMJNMehXcsgsR36spWSerzBwDnU0EwZHGhNeLKkKdBgKfyRuG0cQAeoEQseSV
         l15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Id1X8asn+6tSRgQED3Qg/nfTn2WTYbW4NRSqTmYDFQg=;
        b=VCrIHJh71M0wFjcXwx1oKgNEzwZD/8vRbb+slkjNJZFJ6dmZ8v7HSIRwQi7MLveiOk
         x70ACvM2ZsdluyT4WpVM4RNN76ow8uBf+7PIFLfo4zm7tiZIYp97L/p5TpTsljDBRn10
         87oYb9tIDmksvbFa6RhtDkn5EQyFwHw6koAJgrEDX85ymn9/XOr0Nz98u+rBNHHGql/G
         wa6Q7h6VV56qi6g7W2LaOEvvHOdsXLuOEf074tT7gk0U882Ml7PpkFVHx14+2VM+NBV6
         meBCB6RcrJF4/4Kf8BN8s/+4x5p6L0iVIVIXskftljLB/37JEQXYRa+MxqrGn2c61uq5
         zeuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=ZKSr4snf;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=ZKSr4snf;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeBVB5V (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 20:57:21 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42729 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752130AbeBVB5P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:57:15 -0500
From: Ram Pai <linuxram@us.ibm.com>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org, dave.hansen@intel.com,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
        linuxram@us.ibm.com, arnd@arndb.de
Subject: [PATCH v12 16/22] selftests/vm: fix an assertion in test_pkey_alloc_exhaust()
Date: Wed, 21 Feb 2018 17:55:35 -0800
Message-Id: <1519264541-7621-17-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064512550172050?=
X-GMAIL-MSGID: =?utf-8?q?1593064512550172050?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The maximum number of keys that can be allocated has to
take into consideration, that some keys are reserved by
the architecture for   specific   purpose. Hence cannot
be allocated.

Fix the assertion in test_pkey_alloc_exhaust()

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    |   14 ++++++++++++++
 tools/testing/selftests/vm/protection_keys.c |    9 ++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index 88ef58f..67f9b0f 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -416,4 +416,18 @@ static inline int get_start_key(void)
 #endif
 }
 
+static inline int arch_reserved_keys(void)
+{
+#if defined(__i386__) || defined(__x86_64__) /* arch */
+	return NR_RESERVED_PKEYS;
+#elif __powerpc64__ /* arch */
+	if (sysconf(_SC_PAGESIZE) == 4096)
+		return NR_RESERVED_PKEYS_4K;
+	else
+		return NR_RESERVED_PKEYS_64K;
+#else /* arch */
+	NOT SUPPORTED
+#endif /* arch */
+}
+
 #endif /* _PKEYS_HELPER_H */
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 58da5a0..aae6771 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1167,12 +1167,11 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 	pkey_assert(i < NR_PKEYS*2);
 
 	/*
-	 * There are 16 pkeys supported in hardware.  One is taken
-	 * up for the default (0) and another can be taken up by
-	 * an execute-only mapping.  Ensure that we can allocate
-	 * at least 14 (16-2).
+	 * There are NR_PKEYS pkeys supported in hardware. arch_reserved_keys()
+	 * are reserved. One   can   be   taken   up by an execute-only mapping.
+	 * Ensure that we can allocate at least the remaining.
 	 */
-	pkey_assert(i >= NR_PKEYS-2);
+	pkey_assert(i >= (NR_PKEYS-arch_reserved_keys()-1));
 
 	for (i = 0; i < nr_allocated_pkeys; i++) {
 		err = sys_pkey_free(allocated_pkeys[i]);
-- 
1.7.1

