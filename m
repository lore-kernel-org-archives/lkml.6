Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225mxoi/LXVoF7vOTe/eoQOo2hd8mcCg4P2pqWY93xE5lbKOhurZ7Qw1vkmHdFSRLwwQvsTs
ARC-Seal: i=1; a=rsa-sha256; t=1519264708; cv=none;
        d=google.com; s=arc-20160816;
        b=mddbXDRtcBcznxVz0IGE6rDqzxmPa9vsIvL7HiVCAazwWTJsJTS12m5vLAhCffuXTr
         DuEUamTDxrzaaRtEWV+YMh1JfoFJQ1yY7b8qESBCVKWqJYOjSbsniO8TCjzRhReAuBe6
         IZ028vk3i/RzRQLn+lemeaM3TG41U7DRkQQ0EBl8GFFP9gGyDjUhkMqh7gFhrZE+rmao
         YvUiz9eSvGCzjEvVsLSoW0pkTJ1CBYlXVVhBHp+EyUJgiBrOhZ6z3qbVupSVI3wBlaVu
         I4vrNqCHH6D9r4EbpI8ExmNuB3XZ2bxcapIXVcywwkF9TFY2QS2nUSO+iPPsSaNqF8Js
         wCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=IzhyD8+9lJa7nIEWOW55PC3YZhpIgOaTDxvdSztOExE=;
        b=kIeH9smg6LYkuXXTDt7QszTd0EMK0dIW47xjRmFIVIjFYiB+CxPYJfIcM5V6khITv2
         dX/EjWFCtKo5xzJnoYn0IfYkEsalTjnFjO4Ronn7PYAHVwtNbF/FKqZztfTRBqe0alkn
         Gd+wuW2/kzKxeoDuiZirOJudTw7Zy2uwKOZSQsNd3GMDfM8uX5Fx3o1q7YAvdWjpFY+h
         drDZphd2Lctkh0LJ3HPNnJzM4Dor9E+MAeV4JyeA4fp0Qj9rEAhL4SzDIRio9I044HWO
         yyRcCnsULVGDTx3sY7zqzYLZC3IRsES+UnuhI3vFxjeFf0Yv4nAimVDNZd6kjYLKLvbM
         mULw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=DDPJqtbe;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=DDPJqtbe;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbeBVB6N (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 20:58:13 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39976 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeBVB50 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:57:26 -0500
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
Subject: [PATCH v12 20/22] selftests/vm: testcases must restore pkey-permissions
Date: Wed, 21 Feb 2018 17:55:39 -0800
Message-Id: <1519264541-7621-21-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064510961959598?=
X-GMAIL-MSGID: =?utf-8?q?1593064510961959598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Generally the signal handler restores the state of the pkey register
before returning. However there are times when the read/write operation
can legitamely fail without invoking the signal handler.  Eg: A
sys_read() operaton to a write-protected page should be disallowed.  In
such a case the state of the pkey register is not restored to its
original state.  The test case is responsible for restoring the key
register state to its original value.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 437ee74..42c068a 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1003,6 +1003,7 @@ void test_read_of_write_disabled_region(int *ptr, u16 pkey)
 	ptr_contents = read_ptr(ptr);
 	dprintf1("*ptr: %d\n", ptr_contents);
 	dprintf1("\n");
+	pkey_write_allow(pkey);
 }
 void test_read_of_access_disabled_region(int *ptr, u16 pkey)
 {
@@ -1082,6 +1083,7 @@ void test_kernel_write_of_access_disabled_region(int *ptr, u16 pkey)
 	ret = read(test_fd, ptr, 1);
 	dprintf1("read ret: %d\n", ret);
 	pkey_assert(ret);
+	pkey_access_allow(pkey);
 }
 void test_kernel_write_of_write_disabled_region(int *ptr, u16 pkey)
 {
@@ -1094,6 +1096,7 @@ void test_kernel_write_of_write_disabled_region(int *ptr, u16 pkey)
 	if (ret < 0 && (DEBUG_LEVEL > 0))
 		perror("verbose read result (OK for this to be bad)");
 	pkey_assert(ret);
+	pkey_write_allow(pkey);
 }
 
 void test_kernel_gup_of_access_disabled_region(int *ptr, u16 pkey)
@@ -1113,6 +1116,7 @@ void test_kernel_gup_of_access_disabled_region(int *ptr, u16 pkey)
 	vmsplice_ret = vmsplice(pipe_fds[1], &iov, 1, SPLICE_F_GIFT);
 	dprintf1("vmsplice() ret: %d\n", vmsplice_ret);
 	pkey_assert(vmsplice_ret == -1);
+	pkey_access_allow(pkey);
 
 	close(pipe_fds[0]);
 	close(pipe_fds[1]);
@@ -1133,6 +1137,7 @@ void test_kernel_gup_write_to_write_disabled_region(int *ptr, u16 pkey)
 	if (DEBUG_LEVEL > 0)
 		perror("futex");
 	dprintf1("futex() ret: %d\n", futex_ret);
+	pkey_write_allow(pkey);
 }
 
 /* Assumes that all pkeys other than 'pkey' are unallocated */
-- 
1.7.1

