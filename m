Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225+IYpb8uSIjthlKFzE/DQDYWNhZnVRDVs1OV8qtIHQOsm40Ogw5M74DklXJUgP/8u9jJ0l
ARC-Seal: i=1; a=rsa-sha256; t=1519264850; cv=none;
        d=google.com; s=arc-20160816;
        b=shpUJNTRdjsVLw4g+LFXpkkbMRHEI1g07eH7dspSQwyE59UC3tK9Ke/3dhoMLEgaJY
         N4d8qk8frX3e5AIgXSur0iJ3DbDn4AKPRok6mXzAenNLZabxpFB/2yLIUakO7MupoCfk
         c48AwZxP8p4zjP/kRwGiu71erul0aBJ+AzAzjRa2kx6Z3HqN4440PgUwGUGbUoZRbBwo
         BzyGFfjySUlIePUvTz+fZaolxuQFOcQ6TDoDKz3GI7TOueN611pgOjhdN/cJ5DlVhusn
         bMuA/VQ/fgjCmCCIP5Yv9yAC5crtmxsHDUdC8//kINbGho1zq2xEDIbue4rBt7fRe8dJ
         C5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=biCPTncNRu6Xjk5AGsLJvTpMmjtKMSbBkQ3hnJlBaqw=;
        b=M0SBJvov5OSrL8iM1Abzw8AmhS5SVeHg6CXIaIr74Z45nNN5ergkP6ErKfgtEZu22h
         xfniGU3EyC7C5sxMjBNq6p31qnyu+3iIYRx0D1i4eK8qE7JqLRMl5uVivEnmAqqm5X9m
         jRrwY+QZY6cs3IYEleGKgSmV5R0UYyhnKQj9L0YITMwU6tvJWFlDRvsD0d1fVo9pGqJK
         XdG+U2bw9s0BB1o+AB6V7yUfb+Kn6z4Wube6Q0sa8FLw1xh/9cdBJCsm9yBcfWYhwliE
         znpB76Biua7Dr2v6msws9ig+2zidLENDGwKS8qxAfaK4E5QSxZ87Fpy8EIk+bLCxik8L
         /W8w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=WpMWJwIz;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=WpMWJwIz;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeBVCAg (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 21:00:36 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34583 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbeBVB4l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:56:41 -0500
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
Subject: [PATCH v12 09/22] selftests/vm: fix alloc_random_pkey() to make it really random
Date: Wed, 21 Feb 2018 17:55:28 -0800
Message-Id: <1519264541-7621-10-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064660294767595?=
X-GMAIL-MSGID: =?utf-8?q?1593064660294767595?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

alloc_random_pkey() was allocating the same pkey every time.
Not all pkeys were geting tested. fixed it.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index aaf9f09..2e4b636 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -24,6 +24,7 @@
 #define _GNU_SOURCE
 #include <errno.h>
 #include <linux/futex.h>
+#include <time.h>
 #include <sys/time.h>
 #include <sys/syscall.h>
 #include <string.h>
@@ -602,13 +603,15 @@ int alloc_random_pkey(void)
 	int alloced_pkeys[NR_PKEYS];
 	int nr_alloced = 0;
 	int random_index;
+
 	memset(alloced_pkeys, 0, sizeof(alloced_pkeys));
+	srand((unsigned int)time(NULL));
 
 	/* allocate every possible key and make a note of which ones we got */
 	max_nr_pkey_allocs = NR_PKEYS;
-	max_nr_pkey_allocs = 1;
 	for (i = 0; i < max_nr_pkey_allocs; i++) {
 		int new_pkey = alloc_pkey();
+
 		if (new_pkey < 0)
 			break;
 		alloced_pkeys[nr_alloced++] = new_pkey;
@@ -624,13 +627,14 @@ int alloc_random_pkey(void)
 	/* go through the allocated ones that we did not want and free them */
 	for (i = 0; i < nr_alloced; i++) {
 		int free_ret;
+
 		if (!alloced_pkeys[i])
 			continue;
 		free_ret = sys_pkey_free(alloced_pkeys[i]);
 		pkey_assert(!free_ret);
 	}
-	dprintf1("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n", __func__,
-			__LINE__, ret, __rdpkey_reg(), shadow_pkey_reg);
+	dprintf1("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%016lx\n",
+		__func__, __LINE__, ret, __rdpkey_reg(), shadow_pkey_reg);
 	return ret;
 }
 
-- 
1.7.1

