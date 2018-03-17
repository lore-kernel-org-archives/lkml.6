Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuAF/CQC5LPvK3gng962bT1dbQF211WiWmfgTXSl8JVfXdtcH0WQLgrLNVl1l+AXVu4RFiZ
ARC-Seal: i=1; a=rsa-sha256; t=1521300324; cv=none;
        d=google.com; s=arc-20160816;
        b=XuCQskywE2GW+unGK66qlduQ0f2MH5P+YrFblTN3WvlB2GFv+Bav/ahoRRw0R8cgFZ
         0yPLWWTOtwCvqhOt2TzWycsQoD6+aJBNm4d63naSC7yElWnn+XzpT7/5+kjRqQRhrFIs
         TkerF+lHII5/K77bJtBw/ZqcRQaMHNEBRLOG7IItvIJEMUyoj7dJ/bxnTkQxBg37+UWM
         Z/IXa1Qzsm1rqBH44N3d5Ajs7B6sSIUroMmngF8DPg3phTu2Ev7BL/WhTnU8izPvJbLQ
         nb/OzavNZgtjaP7uwOtzRYBENHcmRyWb2d8wcEOAZhjQ/1F91lVSIIuhBCP+8VBdiDau
         OLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=YcAtj3tFZIAaVyleFMIP+qeDwAVQoHnRnmLlThVFQSI=;
        b=GMbLRiUoQ5y9fw7tTuH+4yupH5RmokBblJjBKNDpdEDjkVBWJXuGp/QF++i4EoXxLa
         acWDhIFETOEf2ZNF4WJJIprqxt3wYWtfsY07S4E2SJy7623o5uH2jo64rLeJyXTKCXC6
         9JvXkvK994Y/9/0cEUw/wHcrI0GGIErUBdicckdR5rBMH7z38erJL4ShAETO/6OK2r+I
         KXn6h2FiUsawPTgIIJyexrER0WrQDHYh7Znaez6/yDKikY7aO/InPUz4m3ybKE7PlZ/1
         QUqgW1n18q9CvQwvszCF9FKluwFt1KlYVVL0tDoQC6qejoSeX0My0sy7vUo3GpPGGvSu
         JdvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeCQPZL (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 17 Mar 2018 11:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbeCQPZL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Mar 2018 11:25:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB2A21737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
From: Andy Lutomirski <luto@kernel.org>
To: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, linux-kselftest@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] selftests/x86/ptrace_syscall: Fix for yet more glibc interference
Date: Sat, 17 Mar 2018 08:25:07 -0700
Message-Id: <bc80338b453afa187bc5f895bd8e2c8d6e264da2.1521300271.git.luto@kernel.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595199009159269471?=
X-GMAIL-MSGID: =?utf-8?q?1595199009159269471?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

glibc keeps getting cleverer, and my version now turns raise() into
more than one syscall.  Since the test relies on ptrace seeing an
exact set of syscalls, this breaks the test.  Replace raise(SIGSTOP)
with syscall(SYS_tgkill, ...) to force glibc to get out of our way.

Cc: stable@vger.kernel.org
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/ptrace_syscall.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/ptrace_syscall.c b/tools/testing/selftests/x86/ptrace_syscall.c
index 1ae1c5a7392e..6f22238f3217 100644
--- a/tools/testing/selftests/x86/ptrace_syscall.c
+++ b/tools/testing/selftests/x86/ptrace_syscall.c
@@ -183,8 +183,10 @@ static void test_ptrace_syscall_restart(void)
 		if (ptrace(PTRACE_TRACEME, 0, 0, 0) != 0)
 			err(1, "PTRACE_TRACEME");
 
+		pid_t pid = getpid(), tid = syscall(SYS_gettid);
+
 		printf("\tChild will make one syscall\n");
-		raise(SIGSTOP);
+		syscall(SYS_tgkill, pid, tid, SIGSTOP);
 
 		syscall(SYS_gettid, 10, 11, 12, 13, 14, 15);
 		_exit(0);
@@ -301,9 +303,11 @@ static void test_restart_under_ptrace(void)
 		if (ptrace(PTRACE_TRACEME, 0, 0, 0) != 0)
 			err(1, "PTRACE_TRACEME");
 
+		pid_t pid = getpid(), tid = syscall(SYS_gettid);
+
 		printf("\tChild will take a nap until signaled\n");
 		setsigign(SIGUSR1, SA_RESTART);
-		raise(SIGSTOP);
+		syscall(SYS_tgkill, pid, tid, SIGSTOP);
 
 		syscall(SYS_pause, 0, 0, 0, 0, 0, 0);
 		_exit(0);
-- 
2.14.3

