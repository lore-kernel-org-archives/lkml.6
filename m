Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225PeVtVC3RjvAdjlEY3KOzXdUBXhnV69MY7X0/unnwnzDrwpSVDq/Q2adP3C8AwRT/dhr+G
ARC-Seal: i=1; a=rsa-sha256; t=1519264676; cv=none;
        d=google.com; s=arc-20160816;
        b=wQqqJYLmPqSHhaHCuD2zRZ+fIAvyf6XGclPB09hE1cMzwBUYrQ40Eq3W8APt1V4FoD
         q4O6fVANpjEQSF1U+spBZXs/QNbrjLt46nek0qdnH6cH5HJ4+6fDEwLGm2nLFukevTxh
         dKkctE+4sX5e8ZkDoN/kN0zpcuqOs2pfVo/97tSGv8rOCmfurs/AG/ntfs0FLXAwZAaG
         O6j1WlHkZss1WWETaoAFSCktG78da89cKidYgtsJJmVXy8sQ3Pas2kEe9Qag3CKRoh+n
         5Av+uqUM21bnPNRodV2jxXiVzReNS1Qh5IGOgrmNUCfDfJEeDFb25uJVNh3/2JtJJJ7M
         Flqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=hde8Nje6LFioeZtG60gGzpWvJPLuHAYPT6Jaz/3f75A=;
        b=aj+ZCGmet6gNmt9EDXl5l34Oxr64b1Ckhon0LLekAk/MiODrngSFl2cRjyuzcuKPGc
         qvrU3glNP6rW0FX9e7vEl2HjnkDFv1ETRs/eHZDT9kDZYUDLMEQBEirOW2zBAkYoAn1J
         HdUru5jvHySIcZ883sC6W/MmLby9FlpTyk2VQAKwPfXdOOWT8t55+0Rn4HXVsd9VAJIM
         slWZRXivJvq2Mq12JScB30JG+65ALi43hOIwEYpzDO1ZsQyafZVQ7PP7BmwLd7cCiWNA
         6HppU2z0ked/46cJu4eo8oXt5ES0w2CGt72z+g63qguLc6SC8byDupmYEmBWgCaQxx0h
         jKeg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=cjh8G9CQ;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=cjh8G9CQ;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeBVB5c (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 20:57:32 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34436 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbeBVB53 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:57:29 -0500
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
Subject: [PATCH v12 21/22] selftests/vm: sub-page allocator
Date: Wed, 21 Feb 2018 17:55:40 -0800
Message-Id: <1519264541-7621-22-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064477181029892?=
X-GMAIL-MSGID: =?utf-8?q?1593064477181029892?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

introduce a new allocator that allocates 4k hardware-pages to back
64k linux-page. This allocator is only applicable on powerpc.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |   30 ++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 42c068a..1b06e59 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -766,6 +766,35 @@ void free_pkey_malloc(void *ptr)
 	return ptr;
 }
 
+void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
+{
+#ifdef __powerpc64__
+	void *ptr;
+	int ret;
+
+	dprintf1("doing %s(size=%ld, prot=0x%x, pkey=%d)\n", __func__,
+			size, prot, pkey);
+	pkey_assert(pkey < NR_PKEYS);
+	ptr = mmap(NULL, size, prot, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	pkey_assert(ptr != (void *)-1);
+
+	ret = syscall(__NR_subpage_prot, ptr, size, NULL);
+	if (ret) {
+		perror("subpage_perm");
+		return PTR_ERR_ENOTSUP;
+	}
+
+	ret = mprotect_pkey((void *)ptr, PAGE_SIZE, prot, pkey);
+	pkey_assert(!ret);
+	record_pkey_malloc(ptr, size);
+
+	dprintf1("%s() for pkey %d @ %p\n", __func__, pkey, ptr);
+	return ptr;
+#else /*  __powerpc64__ */
+	return PTR_ERR_ENOTSUP;
+#endif /*  __powerpc64__ */
+}
+
 void *malloc_pkey_anon_huge(long size, int prot, u16 pkey)
 {
 	int ret;
@@ -888,6 +917,7 @@ void setup_hugetlbfs(void)
 void *(*pkey_malloc[])(long size, int prot, u16 pkey) = {
 
 	malloc_pkey_with_mprotect,
+	malloc_pkey_with_mprotect_subpage,
 	malloc_pkey_anon_huge,
 	malloc_pkey_hugetlb
 /* can not do direct with the pkey_mprotect() API:
-- 
1.7.1

