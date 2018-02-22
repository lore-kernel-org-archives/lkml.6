Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224Gpz4xj/+Nue3/Gr2JrDw24YNjG47hKQRSqFeLEMQy1SJr0UfMO5OABfQk0yJRHcjcqLvN
ARC-Seal: i=1; a=rsa-sha256; t=1519264761; cv=none;
        d=google.com; s=arc-20160816;
        b=XhmZ8T8gBhiX9eOpUfi707CSewMcotqT/+VvinzUVoVvUkgYDILTCX3PhR2E2gIf4R
         Zehts13lcTlelguOBmSDanEcZil8yM0GZWpMdjBcdLyRDsfVD/pww0HzuKNXlKrzDZRC
         xUgUobu0UmvC90S5CkOmnBjRxkD1KHp3DQGh5GrYKRGCi5BZkbYuXzJYJy9/VVO+7Z3R
         LKQhowW7w1YIuOmbV4w87gbcJi3Nr4EX7ngJv18mKJ3ek2fDqX5KBvIAyAdbUk4VjZN2
         K/HohbEEiMngAfFOH8FsTzBf+B5nRlf7dAKIeV2FNSk6JIMkwQ2zKDOfuThN4qn9o7GN
         V1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=NmjBTq5Zq1REesvyF7oiqTnmY77lt8wx7F327ISCgKc=;
        b=IdLVf2GYuBcrtFhJm804aX8BVj55WPCP8w8srYPljtl7CeHw/JNJF7B6finO2l3b3e
         C4FNSR7DAo5Yyu6ruSEeENEGIz0UUgO9oQO/sM9O+zlk/mw7Ifk2GKts2MwrOy9PbtZg
         to3AU6Qmyb4Nk++9gplIwky19x3Quums0Et3tKYy0KwokvvMuse2vm7xWnzeZuaiThqY
         cgQF2+PRBxbG0l9aFVqz9VwmVvlVE1wG2I1DLDNLZtsCl7phpUOcr4X3vsbD+PX7oWfw
         DdP4VJqUsX4F8XdXJByRaY5oKX8d5jdFIDs5Zbv3N6b3soQvmK3v9wBgnBvbqvCJ1Lee
         07PA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=nyGi6HU6;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=nyGi6HU6;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbeBVB6g (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 20:58:36 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44258 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeBVB5U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:57:20 -0500
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
Subject: [PATCH v12 18/22] selftests/vm: associate key on a mapped page and detect write violation
Date: Wed, 21 Feb 2018 17:55:37 -0800
Message-Id: <1519264541-7621-19-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064566016800488?=
X-GMAIL-MSGID: =?utf-8?q?1593064566016800488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

detect write-violation on a page to which write-disabled
key is associated much after the page is mapped.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index dba9162..b685e26 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1034,6 +1034,17 @@ void test_read_of_access_disabled_region_with_page_already_mapped(int *ptr,
 	expected_pkey_fault(pkey);
 }
 
+void test_write_of_write_disabled_region_with_page_already_mapped(int *ptr,
+		u16 pkey)
+{
+	*ptr = __LINE__;
+	dprintf1("disabling write access; after accessing the page, "
+		"to PKEY[%02d], doing write\n", pkey);
+	pkey_write_deny(pkey);
+	*ptr = __LINE__;
+	expected_pkey_fault(pkey);
+}
+
 void test_write_of_write_disabled_region(int *ptr, u16 pkey)
 {
 	dprintf1("disabling write access to PKEY[%02d], doing write\n", pkey);
@@ -1330,6 +1341,7 @@ void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 	test_read_of_access_disabled_region,
 	test_read_of_access_disabled_region_with_page_already_mapped,
 	test_write_of_write_disabled_region,
+	test_write_of_write_disabled_region_with_page_already_mapped,
 	test_write_of_access_disabled_region,
 	test_kernel_write_of_access_disabled_region,
 	test_kernel_write_of_write_disabled_region,
-- 
1.7.1

