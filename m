Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224GzIFooadQ175bCjbDQjc5Y7FSfYuuJv3AjemkCCxqUL2xMi0YooCAvlJ4Ij4nQwk2yUf0
ARC-Seal: i=1; a=rsa-sha256; t=1519264686; cv=none;
        d=google.com; s=arc-20160816;
        b=dfv/qBOtETvxJJ6pzMBEjvIBDD/8kbhpvHoqWaMgkVc1uyx2uUwB4YKpW+iLQg+bEX
         j9nKkJr2Vy66OBK4kVq+E4NjoZUdOJqrNyxoi1AaBkieoBFov09vSSlc2/kgl/zMPydn
         ZRBn6RbDRLI2SOj7NyYHZH/3McOo1mmoph2aKd5gl5Qz3Bsymf9LuMvaCVu0enrZr3oE
         62Cxg2bzQ+iCqHFRbsYzgtMf145cBtFwa9fvGBeKdLXFtLDN75u6rYoUP88KVEWwC+Lo
         IcdtSa1L7vzLFJxy+2U9HUOhiq9DlWPW1xYtJ0grqvFT8JCoKShBj6OLeVja7R3/oJW2
         7zAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=2F/Ft1r/gRNR4KB0IQjN5F6/i42sOlLmKu74xl8hSm8=;
        b=UV/pRwfzcQSAq2fRYVxlmIp6eLBDHcjHD5ShUt1RU3bfqsUgcnXmyB1J28LUU/hYlR
         4IBCIjq1q+hpmaorpAEn6w4DJkkmZWNUu3/Vx9kB862Dzb9QN61vC2WVZS4pdtj/Uf50
         xpEtYKdfEG8yrqbaNiv7W/zHcikepkDAVAQP6InamOOyr/BIDoEqRU4Hmj/wIgLeawlV
         sFXoftrki/mWFZkbtRj/tc5ZOQAKfSUDX9cDd57N4agea22lcDlhAiPRORM1KzK1XukB
         mPcgrI0lM/GgJix2Do9cj+jXxamB4uWNw7c5STBhg4GHOmYyQb9r4V5y1CryOHYEUA/y
         zNPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=ue6/fR/t;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=ue6/fR/t;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbeBVB51 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 20:57:27 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:37421 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbeBVB5X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:57:23 -0500
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
Subject: [PATCH v12 19/22] selftests/vm: detect write violation on a mapped access-denied-key page
Date: Wed, 21 Feb 2018 17:55:38 -0800
Message-Id: <1519264541-7621-20-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064488113796574?=
X-GMAIL-MSGID: =?utf-8?q?1593064488113796574?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

detect write-violation on a page to which access-disabled
key is associated much after the page is mapped.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index b685e26..437ee74 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1059,6 +1059,18 @@ void test_write_of_access_disabled_region(int *ptr, u16 pkey)
 	*ptr = __LINE__;
 	expected_pkey_fault(pkey);
 }
+
+void test_write_of_access_disabled_region_with_page_already_mapped(int *ptr,
+			u16 pkey)
+{
+	*ptr = __LINE__;
+	dprintf1("disabling access; after accessing the page, "
+		" to PKEY[%02d], doing write\n", pkey);
+	pkey_access_deny(pkey);
+	*ptr = __LINE__;
+	expected_pkey_fault(pkey);
+}
+
 void test_kernel_write_of_access_disabled_region(int *ptr, u16 pkey)
 {
 	int ret;
@@ -1343,6 +1355,7 @@ void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 	test_write_of_write_disabled_region,
 	test_write_of_write_disabled_region_with_page_already_mapped,
 	test_write_of_access_disabled_region,
+	test_write_of_access_disabled_region_with_page_already_mapped,
 	test_kernel_write_of_access_disabled_region,
 	test_kernel_write_of_write_disabled_region,
 	test_kernel_gup_of_access_disabled_region,
-- 
1.7.1

