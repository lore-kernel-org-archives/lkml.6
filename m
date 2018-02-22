Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225BSBEIh4bjk06pbj9QsJH8YsovCdA94nniXIqIo6j8W6DjCqpxDdToHf0K+y0Jj8BJq0cu
ARC-Seal: i=1; a=rsa-sha256; t=1519264770; cv=none;
        d=google.com; s=arc-20160816;
        b=dpsfB8wpqal3WJSYgmeGHb93vnvy5Z633uj7kPIMTBIjNzc6YM5IPcJRSbpI7U4qHO
         UL2fNC+Pr09ZOuB1F+91pV0CJ+bzwxLYPbRjrfkxq+J6xBBrJpxi4eAOqqTJakHudO/P
         6Oh0BEEpeDJm0Cn9WA+enBAg4FjYmjGHrn7w56fKJ5sg3wlN/XApnrJ20JiA3DAGd8P+
         4Hu43e+vIE0SZ0qafLKCEKMQ39bYvTqVkIkyWAXZK3Va3S9pCxJRZXfW7uKuFYuP7qKK
         giJCFLXw6imMigFkI+9scUNZsm/u9pYxIVRAPK76zuHpji50+hxcJU3NFrtc+23hjDfV
         F32w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=D5kswmQBFsvKIEtADORaWweLiqzBkjykVBDrCI8PfCU=;
        b=ZEp7vCZ8DcSJQ0+JBUxJ9CdisJ1Q6af9dzwyXMYAoCUvJH5aOk5XYD2ZOntwsiht2+
         Xnbg2/VkQ6E0lhee1Lfvv9Du3OnDwZal2y5Ped3JPymxlcsVRTeFvVuMuLVBpQGNCRwi
         RHncre7J5u7IIfoygc7pC+QJHstHZOQintklNG8y7l0k5XPuqjGauHCkthIWdg/29h8O
         09Sjpv6OcCzY1og9kH+X4Bc0mapo13UIMdJke9zk2RRJbs3uxLkziqtXtMpzT/wMxwGl
         /aoTE4IL8KNBF16h1i0lq2fffXcoOvpiq8MUpHm8M+Jp0K8ubgjjvjMoIR+ELFD2AUnx
         oASA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=gsG4/D9Y;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=gsG4/D9Y;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeBVB5O (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 20:57:14 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42725 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeBVB5M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:57:12 -0500
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
Subject: [PATCH v12 15/22] selftests/vm: powerpc implementation to check support for pkey
Date: Wed, 21 Feb 2018 17:55:34 -0800
Message-Id: <1519264541-7621-16-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064575819973717?=
X-GMAIL-MSGID: =?utf-8?q?1593064575819973717?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

pkey subsystem is supported if the hardware and kernel has support.
We determine that by checking if allocation of a key succeeds or not.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    |   22 ++++++++++++++++------
 tools/testing/selftests/vm/protection_keys.c |    9 +++++----
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index c47aead..88ef58f 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -258,7 +258,7 @@ static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
 #define X86_FEATURE_PKU        (1<<3) /* Protection Keys for Userspace */
 #define X86_FEATURE_OSPKE      (1<<4) /* OS Protection Keys Enable */
 
-static inline int cpu_has_pku(void)
+static inline bool is_pkey_supported(void)
 {
 	unsigned int eax;
 	unsigned int ebx;
@@ -271,13 +271,13 @@ static inline int cpu_has_pku(void)
 
 	if (!(ecx & X86_FEATURE_PKU)) {
 		dprintf2("cpu does not have PKU\n");
-		return 0;
+		return false;
 	}
 	if (!(ecx & X86_FEATURE_OSPKE)) {
 		dprintf2("cpu does not have OSPKE\n");
-		return 0;
+		return false;
 	}
-	return 1;
+	return true;
 }
 
 #define XSTATE_PKEY_BIT	(9)
@@ -323,9 +323,19 @@ static inline void __page_o_noops(void)
 #elif __powerpc64__ /* arch */
 
 #define PAGE_SIZE (0x1UL << 16)
-static inline int cpu_has_pku(void)
+static inline bool is_pkey_supported(void)
 {
-	return 1;
+	/*
+	 * No simple way to determine this.
+	 * lets try allocating a key and see if it succeeds.
+	 */
+	int ret = sys_pkey_alloc(0, 0);
+
+	if (ret > 0) {
+		sys_pkey_free(ret);
+		return true;
+	}
+	return false;
 }
 
 /* 8-bytes of instruction * 16384bytes = 1 page */
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index e82bd88..58da5a0 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1299,8 +1299,8 @@ void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 	int size = PAGE_SIZE;
 	int sret;
 
-	if (cpu_has_pku()) {
-		dprintf1("SKIP: %s: no CPU support\n", __func__);
+	if (is_pkey_supported()) {
+		dprintf1("SKIP: %s: no CPU/kernel support\n", __func__);
 		return;
 	}
 
@@ -1362,12 +1362,13 @@ void run_tests_once(void)
 int main(void)
 {
 	int nr_iterations = 22;
+	int pkey_supported = is_pkey_supported();
 
 	setup_handlers();
 
-	printf("has pkey: %d\n", cpu_has_pku());
+	printf("has pkey: %s\n", pkey_supported ? "Yes" : "No");
 
-	if (!cpu_has_pku()) {
+	if (!pkey_supported) {
 		int size = PAGE_SIZE;
 		int *ptr;
 
-- 
1.7.1

