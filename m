Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZqk/AzsLgbhyJPdQFjtV/rIHXZdjxLUHSxuGohuzgOsR8pK56Ri7GvFmX8njNwCjuE8erTZ
ARC-Seal: i=1; a=rsa-sha256; t=1525978515; cv=none;
        d=google.com; s=arc-20160816;
        b=JFy35+EmEhYHR4AxfM6b0PfzfcBVn7DKGNEuUFOdEipKD3bxv/W/7UOF39CdaSxEzU
         MmYgh6FAkGNCXMDgxoxM4vPwYvuCadpSypUvUXA0tGzTiOKSBVmKswZg/mSrDX8GxTG1
         UqAr7lcMwlL6XlrT7PDMga3Aj5rWDvsy+bzsZbtlf2EHjL73LDMO1+TFdmnva43PQ+ZF
         E+G+Fhtc4Ky49J/LVRtOL9XT+NNKTrfrD/pKdceFN1rOXnhNTdEy8Rrez537EUOYp8LO
         SYVx2SmVKv8I/OBRT0h1ir1tN6cF62EoULiqbRCzFHtlBCnKNNjyLhWWJmjmuLvWoIrW
         I87w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=7yyJ0TIX9OyqEfDxugdyXUmzhB1T4tR2oQwLtmWLdP0=;
        b=Wf79f6wTMXCwf3lR8sZTUtEeHxxLMuwjeSTBlbPweGNq0u/QidKSnMZG2jwcO3WcqN
         xau7W5qxvOnZ5QimQuzWr9hwFLBBy+hXK3jDFG8a/rcJaR9wJFx5QYqAmPe2+Hds2I5c
         otrizOnO9AnBI9JRS+gUT9EVuEeA4MS9Xhy0NP5utT7McpuodUhdci5xV07xqW22TnJO
         ydNpsclslZ3014qu+wkQ1S9RDGmXgCTemLy3NJknSEzPKowDR/vayzS7qaIBzCwOAhL2
         aapPavPyBAiQGt7i2USv6cRU5DK4SyrlGtAzpjM26d4DWOrerePyNlNkWz7Vbmb06N8s
         f0pA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Xkzlb682;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Xkzlb682;
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
Subject: [PATCH v3 1/2] mm: provide a fallback for PAGE_KERNEL_RO for architectures
Date: Thu, 10 May 2018 11:55:06 -0700
Message-Id: <20180510185507.2439-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510185507.2439-1-mcgrof@kernel.org>
References: <20180510185507.2439-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600104447995840109?=
X-GMAIL-MSGID: =?utf-8?q?1600104447995840109?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some architectures do not define certain PAGE_KERNEL_* flags, this is
either because:

a) The way to implement some of these flags is *not yet ported*, or
b) The architecture *has no way* to describe them

Over time we have accumulated a few PAGE_KERNEL_* fallback work arounds
for architectures in the kernel which do not define them using *relatively
safe* equivalents. Move these scattered fallback hacks into asm-generic.

We start off with PAGE_KERNEL_RO using PAGE_KERNEL as a fallback. This
has been in place on the firmware loader for years. Move the fallback
into the respective asm-generic header.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/fallback.c |  5 -----
 include/asm-generic/pgtable.h           | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

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
index f59639afaa39..4e310e543fc8 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1083,6 +1083,20 @@ int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
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
+#ifndef PAGE_KERNEL_RO
+# define PAGE_KERNEL_RO PAGE_KERNEL
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 #ifndef io_remap_pfn_range
-- 
2.17.0
