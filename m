Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZp48UndNz88A8B6xFBKFeIkuNkAT67M/LhZ6qP4mdtrFvnlxP9yfOWSk/OPfRQhC03pQH0h
ARC-Seal: i=1; a=rsa-sha256; t=1525916690; cv=none;
        d=google.com; s=arc-20160816;
        b=yLVqnWlNmPO3SAsspZQ4rIusgu4/6YL1Xn+7yV5f0JnXiXUUUyYCeO6JzADK7BiOcd
         5xVpgNJzlPTba61Lk15aKZaevTsdFov89l3vyPlFZAc3SCv9iDyRzI67GpevNnvcJtLP
         EYmkATc7u5buNCek57YsgCaJZmndZzkvlvY1KZ5QhKqfCRvfHDGlH/Gw1ksqAuNcayyC
         1n93kN27EpOKaiIE5S3OVTAlzGGC9WVM8B4/zBh8vXRg+wcqE86ebXdudj2aCQLw2li1
         792bY+uJRQ0lzGVrQYO4wxL0D6jww5NQj1u7A7pyDvJ/jJ/S3ouWSC+snPxnE8GXjVRd
         NuMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=1K+9TNjwLVRAkCgZ5vXSneAJWIs9CpFSOGSiRhWSunw=;
        b=SBG3KUu2KVEoinGAOApv0jaGwd8aG3YfDkMH8DIIt6jIjvNfKyMwAoaPyu0wFg65KS
         yfBW8/nbX1a9VG8TNRp6y2PkW5tZD3FHmIvF/uEXlNaIQagdGMG0OroflNzvvn+roDiZ
         9f9D6Q5SKxSsvcka3Qvj5wIThtCmUss0km/3OszCjOSNQsHDSLe5sKdriFHvUf1ODHns
         TiHfa57UGnNaOW48PQN+6uVrtKgAZbcYKVdOZkQnaVP+RaeCN/wU+aTM1dtAVGxpDOKd
         9zNdlylPYyAMGYxr/T2BOJ3YDI6HtzGV65cmmE53CoovHiNQ3M6JwmS8da1bp1w6qXm/
         CK5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=b5llzdOD;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=b5llzdOD;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org,
	willy@infradead.org,
	geert@linux-m68k.org,
	linux-m68k@lists.linux-m68k.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v2 1/2] mm: provide a fallback for PAGE_KERNEL_RO for architectures
Date: Wed,  9 May 2018 18:44:46 -0700
Message-Id: <20180510014447.15989-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510014447.15989-1-mcgrof@kernel.org>
References: <20180510014447.15989-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598946836077947117?=
X-GMAIL-MSGID: =?utf-8?q?1600039619497041853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some architectures do not define certain PAGE_KERNEL_* flags, this is
either because:

a) The way to implement some these flags is *not yet ported*, or
b) The architecture *has no way* to describe them

Over time we have accumulated a few PAGE_KERNEL_* fallback work arounds for
architectures in the kernel which do not define them using *relatively safe*
equivalents. Move these scattered fallback hacks into asm-generic and
document which architectures needs further evaluation for which
PAGE_KERNEL_* flag.

We start off with PAGE_KERNEL_RO using PAGE_KERNEL as a fallback. This
has been in place on the firmware loader for years. Move the fallback
into the respective asm-generic header.

Architectures which don't define this yet:

  o alpha
  o ia64
  o m68k
  o mips
  o sparc64
  o sparc

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/fallback.c |  5 -----
 include/asm-generic/pgtable.h           | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 358354148dec..36f016b753e0 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -219,11 +219,6 @@ static ssize_t firmware_loading_show(struct device *dev,
 	return sprintf(buf, "%d\n", loading);
 }
 
-/* Some architectures don't have PAGE_KERNEL_RO */
-#ifndef PAGE_KERNEL_RO
-#define PAGE_KERNEL_RO PAGE_KERNEL
-#endif
-
 /* one pages buffer should be mapped/unmapped only once */
 static int map_fw_priv_pages(struct fw_priv *fw_priv)
 {
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index f59639afaa39..890fc54f4713 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1083,6 +1083,30 @@ int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
 static inline void init_espfix_bsp(void) { }
 #endif
 
+/*
+ * Architecture PAGE_KERNEL_* fallbacks
+ *
+ * Some architectures don't define certain PAGE_KERNEL_* flags. This is either
+ * because they really don't support them, or the port needs to be updated to
+ * reflect the required functionality. Below are a set of relatively safe
+ * fallbacks, as best effort, which we can count on in lieu of the architectures
+ * not defining them on their own yet.
+ */
+
+/*
+ * Current architectures known to not define PAGE_KERNEL_RO:
+ *
+ *  o alpha
+ *  o ia64
+ *  o m68k
+ *  o mips
+ *  o sparc64
+ *  o sparc
+ */
+#ifndef PAGE_KERNEL_RO
+# define PAGE_KERNEL_RO PAGE_KERNEL
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 #ifndef io_remap_pfn_range
-- 
2.17.0
