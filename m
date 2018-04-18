Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524077607; cv=none;
        d=google.com; s=arc-20160816;
        b=bl5OIUXJeTmdDwk/69iyzh5u+/AEQqawFJqtCmQmGOX2+36vqBuoatfqg9gFN5j1nk
         R/O06Bgbi0bFbb56K40/b67lfNrH0BjVhpBijcRhw+UqisByAzO/XiW3kW69CLy0SYh3
         hx4ZJlI1YWmd33D9288eCBpToLxiO1+EgWdvvcdQaR+ai4FVoA5DSWqCOaNy9GLslGi+
         bqibLktTY9I4i3c7tafCfwgil+bhTUPuWpoqDey1EeTGTaXWZgp2o5YP/NsY0+iRC2eC
         sPwuG3NxxpZv3WztXimAe0LJhMPvEtbRuQY/grjPDtS0bdFrrfi8Lx75VpjoM/9j4vj6
         j+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=toZBohlOWDiEKrPW3p9JdtOT1z0eiogSGWK/THMLOZ8=;
        b=ttPiUIjsF2sFbwG91HANEwojS00pvftGcvzJTYLW9RoDPROWV6WZOPeEzxSAa6PKT3
         Gs1WyufEGh0dUP5ShHIGliXXHQkAPXBHIhLATGCoehNn7hxB/ROCn4Yb41xNcSG0yTr3
         uMwA5+EFH/Ybb5poBiWZ0qI3CBEeOrnlQ8RUN6fTYvs7CA+6RSnjqO/aPd66xoe2zESD
         +ydRM2JE3TYASXjmnJElHhW9iyO6XfsXPNWvXxIT/KmRWnN70mICaL2N1eFql9FjVuDO
         MPVMLiqTJIFdyFfucAF7i9pyHP7/Cd9hPQWAKFcLssXshgqOog5Vb9UI8v6tcQcToTTl
         Jcvg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=wCsTPP/l;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=wCsTPP/l;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4+S5EFC7jdGqy0sLbR9gOfqpUBQsmSEOETBpuJK0ZJ3gjbYmpNce77c+5swtw0tc6Ghd7tG3Q==
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrey Konovalov <andreyknvl@google.com>,
	James Morse <james.morse@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>,
	Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
Subject: [PATCH 5/6] lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
Date: Wed, 18 Apr 2018 20:53:14 +0200
Message-Id: <82ccccd82c350f9243fc4e1d377cdad9bf23809c.1524077494.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <cover.1524077494.git.andreyknvl@google.com>
References: <cover.1524077494.git.andreyknvl@google.com>
In-Reply-To: <cover.1524077494.git.andreyknvl@google.com>
References: <cover.1524077494.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598111201020642826?=
X-GMAIL-MSGID: =?utf-8?q?1598111201020642826?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

strncpy_from_user and strnlen_user accept user addresses as arguments, and
do not go through the same path as copy_from_user and others, so here we
need to separately handle the case of tagged user addresses as well.

Untag user pointers passed to these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/strncpy_from_user.c | 2 ++
 lib/strnlen_user.c      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index b53e1b5d80f4..97467cd2bc59 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -106,6 +106,8 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	src = untagged_addr(src);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)src;
 	if (likely(src_addr < max_addr)) {
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 60d0bbda8f5e..8b5f56466e00 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -108,6 +108,8 @@ long strnlen_user(const char __user *str, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	str = untagged_addr(str);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)str;
 	if (likely(src_addr < max_addr)) {
-- 
2.17.0.484.g0c8726318c-goog
