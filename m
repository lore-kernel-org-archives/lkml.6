Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2248yuckdoZSZQV4NQdg4C6RuB8IMhbPIRsutaQ4KNfdpcnVwaB5kx0nc8IQervcnk9Dl51w
ARC-Seal: i=1; a=rsa-sha256; t=1519264661; cv=none;
        d=google.com; s=arc-20160816;
        b=aiZOqeRMJqcZHwHLuN+RtTunmZBYng9RmRvtpChs30Nx16gkX3FHwbTmXIfXUbuSoJ
         Sdlc+939Rx4G72eYSsS09YjHrQ5GZWROS4HBGGfQ/bmeB/9ZTLJblrWpUVOlLKQrZwQS
         Lv6biHDJkQrFySRDqNxMVIgrjnqhMwhqioXA3FmI2TVkIWIZZEA2VmEoF1z0Hfeiyn/K
         Oh8hKaBrJFqQXPSFVq3fQiMTupJfa7hk31xA3kIygkmIIOsp4lrOmsmRY8R1ul+B3NhN
         zZd1xd//BMW2ut4ZifPrVegT6o+j1h2oCEK+Jkznm+UD0lad7tvo491MMwnrb+cGW1l+
         avhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=CgIXJPd5ygo4C14T+XETcgkVt1EvFj8s8wIsF/6YfLA=;
        b=izm/bNok9HEwAYMpkBr5rwfw59nnlfY3shp4bkF6hwT40ZDcNhfg0kwR5Wa0xWQdoo
         H5OGqYufjjaYzYRsQZR41enb7d41C4w0ZvUfieUtTPCmn4LqsDQOZX9zJ+TO7LHZucN5
         /9FQ39d3z6pTAg5qdGurb+y/fJi4owQ+O+ts/ktRkQfBswPNCjTaNOODrTdUydAhtKpw
         lKGoiQFCA48qXZOUSbLTv1izjF0mcRMbvBjDLJfvfrAPA/viAFTu94Xnp3j7rFDfcLPd
         XHzJMnc+K/J3YqQfCCUtuQVgNq8m2YRUtCS4JPcyoCWMD+ha9nddDXWabCfFK6Hvc9uL
         +6Hw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=AaK3Derw;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=AaK3Derw;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbeBVB5g (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 20:57:36 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33136 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbeBVB5c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:57:32 -0500
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
Subject: [PATCH v12 22/22] selftests/vm: Fix deadlock in protection_keys.c
Date: Wed, 21 Feb 2018 17:55:41 -0800
Message-Id: <1519264541-7621-23-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064461610258751?=
X-GMAIL-MSGID: =?utf-8?q?1593064461610258751?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

The sig_chld() handler calls dprintf2() taking care of setting
dprint_in_signal so that sigsafe_printf() won't call printf().
Unfortunately, this precaution is is negated by dprintf_level(), which
has a call to fflush().

This function acquires a lock, which means that if the signal interrupts an
ongoing fflush() the process will deadlock. At least on powerpc this is
easy to trigger, resulting in the following backtrace when attaching to the
frozen process:

  (gdb) bt
  #0  0x00007fff9f96c7d8 in __lll_lock_wait_private () from /lib64/power8/libc.so.6
  #1  0x00007fff9f8cba4c in _IO_flush_all_lockp () from /lib64/power8/libc.so.6
  #2  0x00007fff9f8cbd1c in __GI__IO_flush_all () from /lib64/power8/libc.so.6
  #3  0x00007fff9f8b7424 in fflush () from /lib64/power8/libc.so.6
  #4  0x00000000100504f8 in sig_chld (x=17) at protection_keys.c:283
  #5  <signal handler called>
  #6  0x00007fff9f8cb8ac in _IO_flush_all_lockp () from /lib64/power8/libc.so.6
  #7  0x00007fff9f8cbd1c in __GI__IO_flush_all () from /lib64/power8/libc.so.6
  #8  0x00007fff9f8b7424 in fflush () from /lib64/power8/libc.so.6
  #9  0x0000000010050b50 in pkey_get (pkey=7, flags=0) at protection_keys.c:379
  #10 0x0000000010050dc0 in pkey_disable_set (pkey=7, flags=2) at protection_keys.c:423
  #11 0x0000000010051414 in pkey_write_deny (pkey=7) at protection_keys.c:486
  #12 0x00000000100556bc in test_ptrace_of_child (ptr=0x7fff9f7f0000, pkey=7) at protection_keys.c:1288
  #13 0x0000000010055f60 in run_tests_once () at protection_keys.c:1414
  #14 0x00000000100561a4 in main () at protection_keys.c:1459

The fix is to refrain from calling fflush() when inside a signal handler.
The output may not be as pretty but at least the testcase will be able to
move on.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

 tools/testing/selftests/vm/pkey-helpers.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---
 tools/testing/selftests/vm/pkey-helpers.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index 67f9b0f..7240598 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -128,7 +128,8 @@ static inline void sigsafe_printf(const char *format, ...)
 #define dprintf_level(level, args...) do {	\
 	if (level <= DEBUG_LEVEL)		\
 		sigsafe_printf(args);		\
-	fflush(NULL);				\
+	if (!dprint_in_signal)			\
+		fflush(NULL);			\
 } while (0)
 #define dprintf0(args...) dprintf_level(0, args)
 #define dprintf1(args...) dprintf_level(1, args)
-- 
1.7.1

