Return-Path: <mpatocka@redhat.com>
X-Google-Smtp-Source: AG47ELtJWVFQgl3DhV6JbkFhm4q4JbL6pegebK8F/xJa9o6oa3e7kYNI7VI7SNtlrPR/MPYVzMoc
ARC-Seal: i=1; a=rsa-sha256; t=1520489488; cv=none;
        d=google.com; s=arc-20160816;
        b=MNuaeT5qsN3urmAptYmyVY+UlMH81o64pNY8RDD2uONZnawXC1h+vHsTgYTgJKtRAZ
         uyvDSU1DciWX59rb5QrUXTA3iV+L4qRDc6WyR08NCo2Qq7heXYFiXtx3S+89/cUC+aHG
         q+4+vrwHNFBaNzpaYkurqV4Oh5ysjs4Bk3S+AtJzvcujwr8Jl/KpssRub+b+GL7N7ZhD
         6LupXYAFyWFq2gcEZiIfTPlfM+N5rT1qHqOZN1eZ7Io49uzuGe076yy2BTgWFhfxOaUk
         7PriTlCGVxAwANZoebU5eeElz48CO8mTjNI22mZl2qAz6Xlrlb6j5ao7zqGdJaJykhTA
         Az3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=92/JbIJ3PXJ7SNM67BLg4WAMe526jskGIt/WdA/nDAk=;
        b=sIPUHPdaIifRFoO+rskqmeYhXAGKw5SMKKkbPk3yg779EHor8jQhPOpWza0dAETGUF
         YSQuQl72dVPEan1IxYz13jkKWAQ93HQb7RX8CWYzTzdBZCJy3H1nwIn/DtJ2/jGeWwF+
         x6uLt4RUxRjL3hbI+laKP5gOlLpBvVOcCRF7wVGy4/rt84453jWXzZY+lNRzcj7jv4k3
         lGHTr6Fhln/MAIGzS9wTAMWKeQ6zSzYuS5CXYMGU6bRxXKR/awrrEi+dWbcNK6L3aRVl
         awRQmZVCk1QjD6ANQuZc/zvcQXrrTK+xXI6mQFIQpVn7npyeuJIcqTQYsT1TyBMkPlvI
         Rpbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mpatocka@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=mpatocka@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mpatocka@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=mpatocka@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 8 Mar 2018 01:11:26 -0500 (EST)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Peter Zijlstra <peterz@infradead.org>
cc: David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix compilation of 64-bit kernel with 32-bit compiler
Message-ID: <alpine.LRH.2.02.1803080107001.7847@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594348785980298320?=
X-GMAIL-MSGID: =?utf-8?q?1594348785980298320?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch b5bc2231b8ad4387c9641f235ca0ad8cd300b6df ("objtool: Add 
retpoline validation") broke compiling 64-bit kernel with 32-bit compiler.

This patch fixes the following error and a large number of "can't find
rela for retpoline_safe" errors that occur when using x32 or i386 gcc.

You shouldn't use the type 'unsigned long' in objtool at all - because its
size depends on the compiler and not on the kernel you are compiling.

In file included from check.c:26:0:
check.c: In function 'read_retpoline_hints':
warn.h:57:3: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'unsigned int' [-Werror=format=]
   "%s: warning: objtool: " format "\n", \
   ^
check.c:1135:3: note: in expansion of macro 'WARN'
   WARN("retpoline_safe size mismatch: %d %ld", sec->len, sizeof(unsigned long));
   ^~~~
check.c:1135:44: note: format string is defined here
   WARN("retpoline_safe size mismatch: %d %ld", sec->len, sizeof(unsigned long));
                                          ~~^
                                          %d

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: b5bc2231b8ad ("objtool: Add retpoline validation")

---
 tools/objtool/check.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6/tools/objtool/check.c
===================================================================
--- linux-2.6.orig/tools/objtool/check.c	2018-03-08 06:53:03.535471000 +0100
+++ linux-2.6/tools/objtool/check.c	2018-03-08 06:56:32.975471000 +0100
@@ -1131,13 +1131,13 @@ static int read_retpoline_hints(struct o
 		return -1;
 	}
 
-	if (sec->len % sizeof(unsigned long)) {
-		WARN("retpoline_safe size mismatch: %d %ld", sec->len, sizeof(unsigned long));
+	if (sec->len % sizeof(uint64_t)) {
+		WARN("retpoline_safe size mismatch: %d %d", sec->len, (int)sizeof(uint64_t));
 		return -1;
 	}
 
-	for (i = 0; i < sec->len / sizeof(unsigned long); i++) {
-		rela = find_rela_by_dest(sec, i * sizeof(unsigned long));
+	for (i = 0; i < sec->len / sizeof(uint64_t); i++) {
+		rela = find_rela_by_dest(sec, i * sizeof(uint64_t));
 		if (!rela) {
 			WARN("can't find rela for retpoline_safe[%d]", i);
 			return -1;
