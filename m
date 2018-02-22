Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225/JJ64gUGlZrovRzDR+jNylNbWwNqw/K/8efcufLA+Jj8bzbFC4h5d4K+4QypoDw0hmiBl
ARC-Seal: i=1; a=rsa-sha256; t=1519264746; cv=none;
        d=google.com; s=arc-20160816;
        b=cXKv24vhMF3pdCDQ+u+sHJ1uQvtQytc537zEkLtw2IwPZmo9h0BSDBQiJgtBQDyUHY
         HWcU0wqcZoTJ7AhR/+OpEK/TvAiN3OFoSTacyoo0AadUXIaw6oSqjR5SbfdiLrpH8ZvA
         QkVsVFo5ZtSMxRcxdZm4Nsz5oPgtbcqjMj+f1MBFyPD1VOj1s7qcKe062CXaFQFccQze
         ZG7NEAq90rkrji21jlWZsJFOOS4sixnxuKH3Hd/xFb76sUXPXYgPNHhbZItqkhyPs7OB
         ACkv9mk6R4zJc75FgPnLXBqhQiE9B0hCU2DAXaywiZzpzxGPPzDklS2K5bN0+64to5h8
         T79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=OXrX5KCdS8uNy7DNUS9JFi1VXD86+zisNNLiejGFFSw=;
        b=NBj3FgFfU6w4DFyfXd5Ipmqf4G7c2L+Ha04PLCTYMogMMg0/JkU8bUqnMU6F9xyoez
         S/iGeICsTzNgFhqsoHqKCe1Mm2hfLD36H5APt6HT2JQ2OVdBpZb1P9l1FODzYpw3nX3l
         oeKoyRyW5kwJKvvibpCK9EqcqAkEhA+6muvn//ETDayYNwMoMeHWNmnJauLJfQkNgccI
         8KRyNf7ajekRZs0izYwAxmBTwjGHhM6zQGP1l4VpeJngVWyOTtt1taiFVoeVhTK9RpI2
         BVOc95dUMKSSvIGQBSBv1GU0LQoQaHhVb6qhDEXbK4vPNm1C3RXcSff7NwtDrAW4Wwqi
         4AMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=h7kO5LKs;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=h7kO5LKs;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbeBVB6i (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 20:58:38 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41534 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751838AbeBVB5S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:57:18 -0500
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
Subject: [PATCH v12 17/22] selftests/vm: associate key on a mapped page and detect access violation
Date: Wed, 21 Feb 2018 17:55:36 -0800
Message-Id: <1519264541-7621-18-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064551027163997?=
X-GMAIL-MSGID: =?utf-8?q?1593064551027163997?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

detect access-violation on a page to which access-disabled
key is associated much after the page is mapped.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index aae6771..dba9162 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1016,6 +1016,24 @@ void test_read_of_access_disabled_region(int *ptr, u16 pkey)
 	dprintf1("*ptr: %d\n", ptr_contents);
 	expected_pkey_fault(pkey);
 }
+
+void test_read_of_access_disabled_region_with_page_already_mapped(int *ptr,
+		u16 pkey)
+{
+	int ptr_contents;
+
+	dprintf1("disabling access to PKEY[%02d], doing read @ %p\n",
+				pkey, ptr);
+	ptr_contents = read_ptr(ptr);
+	dprintf1("reading ptr before disabling the read : %d\n",
+			ptr_contents);
+	rdpkey_reg();
+	pkey_access_deny(pkey);
+	ptr_contents = read_ptr(ptr);
+	dprintf1("*ptr: %d\n", ptr_contents);
+	expected_pkey_fault(pkey);
+}
+
 void test_write_of_write_disabled_region(int *ptr, u16 pkey)
 {
 	dprintf1("disabling write access to PKEY[%02d], doing write\n", pkey);
@@ -1310,6 +1328,7 @@ void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 void (*pkey_tests[])(int *ptr, u16 pkey) = {
 	test_read_of_write_disabled_region,
 	test_read_of_access_disabled_region,
+	test_read_of_access_disabled_region_with_page_already_mapped,
 	test_write_of_write_disabled_region,
 	test_write_of_access_disabled_region,
 	test_kernel_write_of_access_disabled_region,
-- 
1.7.1

