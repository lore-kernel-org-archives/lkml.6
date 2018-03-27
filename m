Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48xZcbauO85/d7sHhyV4+0cP2MQp62HR5xgF4aPynxZDTuDCVeaDpMg01+2fEz2qUB43xiL
ARC-Seal: i=1; a=rsa-sha256; t=1522168387; cv=none;
        d=google.com; s=arc-20160816;
        b=gAx6njMb+29hnEKlCsD/J+uFDKw9jHyyb9A1S1WiOy3mWCa2ZWgjeS0wdPLorcrO6H
         N9PgyCqyyNO3Mnf2AGywsKor5q2RXTRLjhjUXYm03da80YnC5Fy/pp1GWYzpsdNypkcf
         rJ3SZgZKnrWJWC/xNFIHGsDsQ2R7uAg3NKp40TiYXNJdA3lohS050uB1Gdz8Rdm+Ioie
         eic1EZ2AQbc4puaAkkUk8jQsdvRr0Zwm9ZcdJq4pScpmdvF8d0wABYipms6eYuJB3lyn
         1k5ptViSvjlb+CrgM4m0sDLLs9m8upJ/4EagktIilE/kdkbgJ5HI+ioluoSVMjiFm176
         r32w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7jUaMHxAW7aYARxVRhGZxGnK+kiyfNI4XD8UMBgr1H0=;
        b=eV8oTdovOpf/+wnX0ql0wvTCpz01Wq2C/96ydWTzz66Y8PwMaJj0fjqWWJHCR1jHT4
         zkDOM/8gnug+0UFDDz6zITbf8dAPlN9cBrEJSB2HkdHv1lShZRYMoJ6yWDyONIZGgxJA
         TrA/DRO2lgcQDl3STnkyE/ONpw8P+I5nA21vvBSTmLVTXAPfQyHoXdgDBIaAzZEXB0Pv
         /GYhxDGhFebju3Q6GcIr2r9yScvquStZjrHlo1IoYa7cIiqiM9z62mvJQwmp1Lu2yVw9
         nmf7JeG8gvX4ubfiYW1Z0AgozURfoSC6akwGzUS+0Va0Xgk7SWqlGsPTghctg+q9mXqG
         h28g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bpetkov@suse.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 61/67] selftests/x86/protection_keys: Fix syscall NR redefinition warnings
Date: Tue, 27 Mar 2018 18:27:53 +0200
Message-Id: <20180327162730.988300693@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109239532697349?=
X-GMAIL-MSGID: =?utf-8?q?1596109239532697349?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit 693cb5580fdb026922363aa103add64b3ecd572e upstream.

On new enough glibc, the pkey syscalls numbers are available.  Check
first before defining them to avoid warnings like:

protection_keys.c:198:0: warning: "SYS_pkey_alloc" redefined

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1fbef53a9e6befb7165ff855fc1a7d4788a191d6.1509794321.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/protection_keys.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -188,17 +188,29 @@ void lots_o_noops_around_write(int *writ
 #define u64 uint64_t
 
 #ifdef __i386__
-#define SYS_mprotect_key 380
-#define SYS_pkey_alloc	 381
-#define SYS_pkey_free	 382
+
+#ifndef SYS_mprotect_key
+# define SYS_mprotect_key 380
+#endif
+#ifndef SYS_pkey_alloc
+# define SYS_pkey_alloc	 381
+# define SYS_pkey_free	 382
+#endif
 #define REG_IP_IDX REG_EIP
 #define si_pkey_offset 0x14
+
 #else
-#define SYS_mprotect_key 329
-#define SYS_pkey_alloc	 330
-#define SYS_pkey_free	 331
+
+#ifndef SYS_mprotect_key
+# define SYS_mprotect_key 329
+#endif
+#ifndef SYS_pkey_alloc
+# define SYS_pkey_alloc	 330
+# define SYS_pkey_free	 331
+#endif
 #define REG_IP_IDX REG_RIP
 #define si_pkey_offset 0x20
+
 #endif
 
 void dump_mem(void *dumpme, int len_bytes)
