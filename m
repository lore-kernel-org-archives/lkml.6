Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225GBLpDwy2YM6zDEnu4D1S7VlTU+TPpiTmOJggDcIw7WNDT311RUE3Xv71k4xtfgDxPZE/y
ARC-Seal: i=1; a=rsa-sha256; t=1519264824; cv=none;
        d=google.com; s=arc-20160816;
        b=vu1X9X2+ealKlvo2yD6Y6jzr1RuBZaGy4pd4xBOMKZczs5vu0JWilIqeu++WEO4bk7
         IeDLn/VBvxnlzd+wayH5XsfZOSN8TrLBAysF5ewRLL0UzPs6QDWgKdAmosKqyLFOD+a4
         qG8YZk/AIQKInkj2gf+HdJbYkhBEyaemSHisQeAWA2t1JJipHdhrC1q749cmH7xNs+wM
         9P/lsXVyEZzTZP86Ry29A08n5BAEzkSweP1seb3RvG2lHQ6PnVPI7yQrCzLl+HxsGWDL
         wLSRS7yBKjGKyT8b3ZS4RY0TLmlOH0HIOspwOrrqy8wgJaG/V4TTXjs9sIK4LBqS1T/m
         oLmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=i8HkVzYPTFGNHFt71pOQOHSKTnm3nBZWlwp59VXuv8c=;
        b=auMW9P8sfX68qfHvc/feDPfRRy2z0hZIZvPIh8XPV3rEsTjEraB9K4RkaYcsuW9Tyo
         YQAPkimbDdRZ6eGqgiZTaQ3r/LvOcZ3Xy/3Xfs70llHyjYPWfseUnUmYqn65TFWuKR8p
         PHczy3/d6HP8lW3MyXftzYPOYuMmueFbktbHiITpD9zw9UORmN/TAZRwt0sANF87rKMx
         owvMt674FIW2rJ91jurpaJsFB1sq6dzZlLfiwiB4rNxi4BCB3G/nD4Hh/2s9v8G3h34I
         w9Ti/ah2Ootf9oF8lR3tyocnGtQQqnmnOuFDdPiY8fKstW884L+pFzvA2Gh8bKQYV+nR
         siEg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=bI/cqePK;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=bI/cqePK;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeBVB4q (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 20:56:46 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38515 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeBVB4n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:56:43 -0500
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
Subject: [PATCH v12 10/22] selftests/vm: introduce two arch independent abstraction
Date: Wed, 21 Feb 2018 17:55:29 -0800
Message-Id: <1519264541-7621-11-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064631935429734?=
X-GMAIL-MSGID: =?utf-8?q?1593064631935429734?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

open_hugepage_file() <- opens the huge page file
get_start_key() <--  provides the first non-reserved key.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    |   11 +++++++++++
 tools/testing/selftests/vm/protection_keys.c |    6 +++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index 7c979ad..c8f5739 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -304,3 +304,14 @@ static inline void __page_o_noops(void)
 	}					\
 } while (0)
 #define raw_assert(cond) assert(cond)
+
+static inline int open_hugepage_file(int flag)
+{
+	return open("/sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages",
+		 O_RDONLY);
+}
+
+static inline int get_start_key(void)
+{
+	return 1;
+}
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 2e4b636..254b66d 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -809,7 +809,7 @@ void setup_hugetlbfs(void)
 	 * Now go make sure that we got the pages and that they
 	 * are 2M pages.  Someone might have made 1G the default.
 	 */
-	fd = open("/sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages", O_RDONLY);
+	fd = open_hugepage_file(O_RDONLY);
 	if (fd < 0) {
 		perror("opening sysfs 2M hugetlb config");
 		return;
@@ -1087,10 +1087,10 @@ void test_kernel_gup_write_to_write_disabled_region(int *ptr, u16 pkey)
 void test_pkey_syscalls_on_non_allocated_pkey(int *ptr, u16 pkey)
 {
 	int err;
-	int i;
+	int i = get_start_key();
 
 	/* Note: 0 is the default pkey, so don't mess with it */
-	for (i = 1; i < NR_PKEYS; i++) {
+	for (; i < NR_PKEYS; i++) {
 		if (pkey == i)
 			continue;
 
-- 
1.7.1

