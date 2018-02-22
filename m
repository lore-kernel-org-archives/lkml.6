Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226zWlkOsUbLlVeOgSJdmtCe3Xr+UiV8SZur+Ye2u6ObhokStg9fz87uCCqMmDW7t1PIjQcu
ARC-Seal: i=1; a=rsa-sha256; t=1519264917; cv=none;
        d=google.com; s=arc-20160816;
        b=t2SAmm/T+NHd8IBOUwa7nAcAhb/j08rdVuOEc5BTWClM6eZ57fCLFoYRB+MESwQc5z
         Wl7od7pkLHaVT0SVuacH09ZILqGFPi6whczwpTHgCnSC9Bi/5hxCZprPLQpqfozYBAIT
         MvRjAUWyjv9CfOYtR0g+u6cfhDAWKDsU/C0c7/MjJAx83L9FoWGI3U+ZtbG9evJ9GcfK
         Vskbw8KLEnFVKfyTM6kl8eXpLjQ0MjkxojHj8X37LmgCWodrXVgrlKLmWz/T8IWZydu1
         tlI0YJ1bxqpUD0aZDiTsSiK3lfKrvH6h+ksDW/EYb/0dq5h+QyZpDIp+vYmEv1vNXUPr
         FJog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Q09UcdB7R4ZVzTeRN7F8OrdVobYY88aVNgyQI4tbnEE=;
        b=H9ymHYL8wYvJ8eElyP3UTfSS6oFn1c13wR7KEtznfKzp6GHeR2tXJd7ZBUuei9qyHg
         3+hd2YYLIsofgMZ8H7Ki6faAf+G4lwhZ44tjQqLletG8dkWgi31ScEmtxms9u69SBAGp
         nLXtqXQmwvLhhOBxgcy5LLl0TXJvzAJJiy92vpqJMUV+izOVHprLIRfhnc2n3CNa8Adz
         QZm1tFNHKdp6Ya0oD/y1x88htMFvv8MZ3fcWXIYt7Zc8KHTNDH+aSsOi9aEQsDwVndEe
         yZ0VLrjHfoBgx20+QV5L/bMxgGTUJxt5LYFoEHbHb1eEG2Z2lcy7RchsZZDc30UPWzN3
         X6LA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=UIaAFKDv;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=UIaAFKDv;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeBVCBn (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 21:01:43 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38683 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeBVB43 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:56:29 -0500
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
Subject: [PATCH v12 05/22] selftests/vm: generic function to handle shadow key register
Date: Wed, 21 Feb 2018 17:55:24 -0800
Message-Id: <1519264541-7621-6-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064730361349989?=
X-GMAIL-MSGID: =?utf-8?q?1593064730361349989?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

helper functions to handler shadow pkey register

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    |   27 ++++++++++++++++++++
 tools/testing/selftests/vm/protection_keys.c |   34 ++++++++++++++++---------
 2 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index b6c2133..7c979ad 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -44,6 +44,33 @@
 #define DEBUG_LEVEL 0
 #endif
 #define DPRINT_IN_SIGNAL_BUF_SIZE 4096
+
+static inline u32 pkey_to_shift(int pkey)
+{
+	return pkey * PKEY_BITS_PER_PKEY;
+}
+
+static inline pkey_reg_t reset_bits(int pkey, pkey_reg_t bits)
+{
+	u32 shift = pkey_to_shift(pkey);
+
+	return ~(bits << shift);
+}
+
+static inline pkey_reg_t left_shift_bits(int pkey, pkey_reg_t bits)
+{
+	u32 shift = pkey_to_shift(pkey);
+
+	return (bits << shift);
+}
+
+static inline pkey_reg_t right_shift_bits(int pkey, pkey_reg_t bits)
+{
+	u32 shift = pkey_to_shift(pkey);
+
+	return (bits >> shift);
+}
+
 extern int dprint_in_signal;
 extern char dprint_in_signal_buffer[DPRINT_IN_SIGNAL_BUF_SIZE];
 static inline void sigsafe_printf(const char *format, ...)
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 3ef2569..83216c5 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -374,7 +374,7 @@ u32 pkey_get(int pkey, unsigned long flags)
 			__func__, pkey, flags, 0, 0);
 	dprintf2("%s() raw pkey_reg: %x\n", __func__, pkey_reg);
 
-	shifted_pkey_reg = (pkey_reg >> (pkey * PKEY_BITS_PER_PKEY));
+	shifted_pkey_reg = right_shift_bits(pkey, pkey_reg);
 	dprintf2("%s() shifted_pkey_reg: %x\n", __func__, shifted_pkey_reg);
 	masked_pkey_reg = shifted_pkey_reg & mask;
 	dprintf2("%s() masked  pkey_reg: %x\n", __func__, masked_pkey_reg);
@@ -397,9 +397,9 @@ int pkey_set(int pkey, unsigned long rights, unsigned long flags)
 	/* copy old pkey_reg */
 	new_pkey_reg = old_pkey_reg;
 	/* mask out bits from pkey in old value: */
-	new_pkey_reg &= ~(mask << (pkey * PKEY_BITS_PER_PKEY));
+	new_pkey_reg &= reset_bits(pkey, mask);
 	/* OR in new bits for pkey: */
-	new_pkey_reg |= (rights << (pkey * PKEY_BITS_PER_PKEY));
+	new_pkey_reg |= left_shift_bits(pkey, rights);
 
 	__wrpkey_reg(new_pkey_reg);
 
@@ -430,7 +430,7 @@ void pkey_disable_set(int pkey, int flags)
 	ret = pkey_set(pkey, pkey_rights, syscall_flags);
 	assert(!ret);
 	/*pkey_reg and flags have the same format */
-	shadow_pkey_reg |= flags << (pkey * 2);
+	shadow_pkey_reg |= left_shift_bits(pkey, flags);
 	dprintf1("%s(%d) shadow: 0x%016lx\n",
 		__func__, pkey, shadow_pkey_reg);
 
@@ -465,7 +465,7 @@ void pkey_disable_clear(int pkey, int flags)
 
 	ret = pkey_set(pkey, pkey_rights, 0);
 	/* pkey_reg and flags have the same format */
-	shadow_pkey_reg &= ~(flags << (pkey * 2));
+	shadow_pkey_reg &= reset_bits(pkey, flags);
 	pkey_assert(ret >= 0);
 
 	pkey_rights = pkey_get(pkey, syscall_flags);
@@ -523,6 +523,21 @@ int sys_pkey_alloc(unsigned long flags, unsigned long init_val)
 	return ret;
 }
 
+void pkey_setup_shadow(void)
+{
+	shadow_pkey_reg = __rdpkey_reg();
+}
+
+void pkey_reset_shadow(u32 key)
+{
+	shadow_pkey_reg &= reset_bits(key, 0x3);
+}
+
+void pkey_set_shadow(u32 key, u64 init_val)
+{
+	shadow_pkey_reg |=  left_shift_bits(key, init_val);
+}
+
 int alloc_pkey(void)
 {
 	int ret;
@@ -540,7 +555,7 @@ int alloc_pkey(void)
 			shadow_pkey_reg);
 	if (ret) {
 		/* clear both the bits: */
-		shadow_pkey_reg &= ~(0x3      << (ret * 2));
+		pkey_reset_shadow(ret);
 		dprintf4("%s()::%d, ret: %d pkey_reg: 0x%016lx "
 				"shadow: 0x%016lx\n",
 				__func__,
@@ -550,7 +565,7 @@ int alloc_pkey(void)
 		 * move the new state in from init_val
 		 * (remember, we cheated and init_val == pkey_reg format)
 		 */
-		shadow_pkey_reg |=  (init_val << (ret * 2));
+		pkey_set_shadow(ret, init_val);
 	}
 	dprintf4("%s()::%d, ret: %d pkey_reg: 0x%016lx shadow: 0x%016lx\n",
 			__func__, __LINE__, ret, __rdpkey_reg(),
@@ -1322,11 +1337,6 @@ void run_tests_once(void)
 	iteration_nr++;
 }
 
-void pkey_setup_shadow(void)
-{
-	shadow_pkey_reg = __rdpkey_reg();
-}
-
 int main(void)
 {
 	int nr_iterations = 22;
-- 
1.7.1

