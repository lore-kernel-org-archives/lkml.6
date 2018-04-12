Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523554175; cv=none;
        d=google.com; s=arc-20160816;
        b=W/zHIf1mBSGST0OjyHINE0vDvAheVS0niHYYwUBfj8In6VIM0uw2NxXVQ0ajf4bpbd
         agy5K6lmwyhyfcocejudqmfh38Lzsp0kSXIvCd25JTTZ6tER2IJlbEUqylh7cV5Gbm1k
         EE8GMS00Yv/58AqnUDUKaYysB8Ho5CHSy7TUWzM0SKB9x+shfuyoJM5KI47PbXLvpTEN
         LoymYKFE+s6VUp4xTj1IyIp8rYty1BiJ7mvWfulVVRykQKykHZ02Z0CYZyGCKPxIR5LC
         7gvWIaCZ9d81hW/XlNdE0h4e3ZFAj2myj6UPcYO+MSaU/FeBi5/vtXuw6vAY4yUTpxim
         tkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=a7Z90e3PWOCEsizE3PXB8sB96UCDSytF1xmCR2dQ2D8=;
        b=TKB40S3PqnJnYJIP2GKCTw2MrfMQq+Li5DT2c+Dg2jco52Ug+lp0nV99K0Bpo5Qg22
         L53xpYcyUitJbWnlX/7WgKT1S6G9SQLbbgB1TotLUjdcfhcdo7iUknPQXGiiGPyFkzg/
         8K7reJrVBmbHAUzeA++KH6qcsNQZ1kZvQ1EgYs297svOCnSfdiZS8/vbLdfL4TG1NnB/
         8dpBWLG7Xgpj9dTY4x3tq9GuLj2jz0I8oVJwtrAQ5EpMlFg35cECX3lk8bZIf5R1jV1E
         ch3sWEugX7hxjHv5fRHrqtoqcjPZmZEFGqzY6g+wlMWgxCh60eXxOg5A2FYQsgSRcpc3
         /AKw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=MJ2BQoF2;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=MJ2BQoF2;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4/NZKplZcMHp1ZOTXT3vKOPyDy0wzbDM8k8/FTuu6NbC+sEnqF+9frxQJDSldUKRbWjeZMSrQ==
From: Andrey Konovalov <andreyknvl@google.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Rientjes <rientjes@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Andrey Konovalov <andreyknvl@google.com>,
	Will Deacon <will.deacon@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paul Lawrence <paullawrence@google.com>,
	Sandipan Das <sandipan@linux.vnet.ibm.com>,
	Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Cc: Kostya Serebryany <kcc@google.com>
Subject: [PATCH] kasan: add no_sanitize attribute for clang builds
Date: Thu, 12 Apr 2018 19:29:31 +0200
Message-Id: <4ad725cc903f8534f8c8a60f0daade5e3d674f8d.1523554166.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597562343326181438?=
X-GMAIL-MSGID: =?utf-8?q?1597562343326181438?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

KASAN uses the __no_sanitize_address macro to disable instrumentation
of particular functions. Right now it's defined only for GCC build,
which causes false positives when clang is used.

This patch adds a definition for clang.

Note, that clang's revision 329612 or higher is required.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/compiler-clang.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index ceb96ecab96e..5a1d8580febe 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -25,6 +25,11 @@
 #define __SANITIZE_ADDRESS__
 #endif
 
+#ifdef CONFIG_KASAN
+#undef __no_sanitize_address
+#define __no_sanitize_address __attribute__((no_sanitize("address")))
+#endif
+
 /* Clang doesn't have a way to turn it off per-function, yet. */
 #ifdef __noretpoline
 #undef __noretpoline
-- 
2.17.0.484.g0c8726318c-goog
