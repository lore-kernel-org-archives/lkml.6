Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523968011; cv=none;
        d=google.com; s=arc-20160816;
        b=DdChCEy6eolywWe6xT49BIDi7Tw+f/O8WmYhSpPvlxQwI8uE/yzeRnv2P678CVWfXw
         PPzJsaKBKRSx9D2SvmRftyZIeU5zt20h//jHHyNyF8weYlEMVYI1LzJtEXGChlLWpaJc
         YtduAOIihNxxVo9kcjsHfLkFonCXV0IRkZ94EjD5nK0gjqhPYTsgbKY56UXPhZNFod4q
         1ENE5S5YAnjDDYpND4+Rq5iRC0lW0ILdguUWJRBFMtG5hbs9VIyYoJd4kcYAwU9lSg+Q
         0TfxRPP35mabc4I0eg2A9KNNGXoow/ZvmIwGesEJgmPuauc4VtzNHBYIVFQ8PQSXp+rk
         j7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=NYHcAdvMVYuE/S/8rdCs6Vy9lOj2ULACE1q6RqB6/e4=;
        b=sMZl25JUGiaLKTjfWA2ANua280nfbsVfV99bvpocaIQtXxq3O8hRn+E+xOErBu5yzW
         HvUXQZe9iG/ypKwF2rsngrDZrTIW5vJmOFgQrIUwpcvkmU4LXADiTHSs2dbVdlMiTdgy
         Afq71H7kG76OuLE6WdnizLGHBFzUtEkisaLu/T9z1HEXIhGKczIqE8V7m/NvjXlytZ1a
         N8S9B1qL5RT1vZqn/Uyo/Rnfy4sVatgfyxh0xOi51YcynK59+a7+1EwUBmDSGEC/wyLT
         pUgSUsIE3YzvM8ANCO2ULtxdzyg+SHW4nEXylviaQ8fQtdw3jAcWr1zbWQVvwRmUzCIG
         lDSw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Hqk7LSAp;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Hqk7LSAp;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx48Ks9QuWgThiJ/hCmRSF733aXS4NgGccmw4yaiBeeGqL3hVXG8GPKCxTsvIGk84R7b2uvfzYA==
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
Subject: [PATCH v2] kasan: add no_sanitize attribute for clang builds
Date: Tue, 17 Apr 2018 14:26:47 +0200
Message-Id: <c79aa31a2a2790f6131ed607c58b0dd45dd62a6c.1523967959.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597996281591103955?=
X-GMAIL-MSGID: =?utf-8?q?1597996281591103955?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

KASAN uses the __no_sanitize_address macro to disable instrumentation
of particular functions. Right now it's defined only for GCC build,
which causes false positives when clang is used.

This patch adds a definition for clang.

Note, that clang's revision 329612 or higher is required.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---

Changes since v1:
- Removed redundant #ifdef CONFIG_KASAN check.

 include/linux/compiler-clang.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index ceb96ecab96e..7d98e263e048 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -25,6 +25,9 @@
 #define __SANITIZE_ADDRESS__
 #endif
 
+#undef __no_sanitize_address
+#define __no_sanitize_address __attribute__((no_sanitize("address")))
+
 /* Clang doesn't have a way to turn it off per-function, yet. */
 #ifdef __noretpoline
 #undef __noretpoline
-- 
2.17.0.484.g0c8726318c-goog
