Return-Path: <jinb.park7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520248673; cv=none;
        d=google.com; s=arc-20160816;
        b=LfBdVoMRsg9RHnJaE3knyV4HjRvabpIEPHLr2tCfnvtulcZjj+y40agvIsjklOs73P
         yNVLkhKqACtF4kN5zvh/yTqRUX+F35BNGMqPgEF0Zm507F/yR8Wy/hXYZaj3IUz4A+yi
         i87yFSzhQkFfK4gVD//71378jywOsCn29Ix12PKmT7EfU/2knU4BnqiOSpPl2+EgYe6l
         UkiMqumbwazv+qSdRGkBN1MGxN+xn4oeJvTIrfmsYwLya9J9ATQLgHwaAAI38QnpyeWx
         lF946SpK1f5cXTEqL3e/7oqP33rWSu9duPrheNnQToE1LAboz/LOoJ9hFaFcEwl9ytxn
         RHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=A8iIm/CXEgV3m1ADZaTfq8VgkAJiYbJddmzSFFnPJp4=;
        b=Q70Th0bc+rKNGP+jVvLvhKL3Sx1Xf1KnzLkoP/ZMZ6orP5RofUfIpfazZGRJqazJdP
         6YPmwlnLz9dV6aTe0LM/IYZLkNfeil6Z5tl692t1NjsUDQ5s1WvZ/kuCVk3eCi7cBjVw
         E6965df2hUxMO6j3sGPIJ/1qe55UREq8ufNYn7rkI4Pp1n9Bq2l+An0Z51f/tTmYsH8A
         07Rroz6QQwFZUPeW2YPGNYex5tHwYo+JL82SPLsAMF5S78OSJ3iDEWuABd6ujBbgaoB4
         v62Ti/cWnhLOo+UcemjsylTDiWjaign0j6ASyvLuwfWC82TQ3w2KYM4VIhyZeVIu1nqB
         K7aw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YJFponBO;
       spf=pass (google.com: domain of jinb.park7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jinb.park7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YJFponBO;
       spf=pass (google.com: domain of jinb.park7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jinb.park7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELubqxMeIDbSVhJK439vs90xfFafutWnnkUYgYX2cVOth7JzYCkG7w6VqUg/NA68zLerYjbBBg==
Date: Mon, 5 Mar 2018 20:17:45 +0900
From: Jinbum Park <jinb.park7@gmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org, tglx@linutronix.de,
	kstewart@linuxfoundation.org, luto@amacapital.net,
	dsafonov@virtuozzo.com, keescook@chromium.org, will.deacon@arm.com,
	mark.rutland@arm.com, danielmicay@gmail.com, arnd@arndb.de,
	catalin.marinas@arm.com
Subject: [PATCH v2 1/2] arm: mm: Define vdso_start, vdso_end as array
Message-ID: <20180305111745.GA4193@pjb1027-Latitude-E5410>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594096273275024076?=
X-GMAIL-MSGID: =?utf-8?q?1594096273275024076?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Define vdso_start, vdso_end as array to avoid compile-time analysis error
for the case of built with CONFIG_FORTIFY_SOURCE.

and, since vdso_start, vdso_end are used in vdso.c only,
move extern-declaration from vdso.h to vdso.c.

If kernel is built with CONFIG_FORTIFY_SOURCE,
compile-time error happens at this code.
- if (memcmp(&vdso_start, "\177ELF", 4))

The size of "&vdso_start" is recognized as 1 byte, but n is 4,
So that compile-time error is reported.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
---
v2: No changes
---
 arch/arm/include/asm/vdso.h |  2 --
 arch/arm/kernel/vdso.c      | 12 +++++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/vdso.h b/arch/arm/include/asm/vdso.h
index 9c99e81..5b85889 100644
--- a/arch/arm/include/asm/vdso.h
+++ b/arch/arm/include/asm/vdso.h
@@ -12,8 +12,6 @@
 
 void arm_install_vdso(struct mm_struct *mm, unsigned long addr);
 
-extern char vdso_start, vdso_end;
-
 extern unsigned int vdso_total_pages;
 
 #else /* CONFIG_VDSO */
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index a4d6dc0..f4dd7f9 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -39,6 +39,8 @@
 
 static struct page **vdso_text_pagelist;
 
+extern char vdso_start[], vdso_end[];
+
 /* Total number of pages needed for the data and text portions of the VDSO. */
 unsigned int vdso_total_pages __ro_after_init;
 
@@ -197,13 +199,13 @@ static int __init vdso_init(void)
 	unsigned int text_pages;
 	int i;
 
-	if (memcmp(&vdso_start, "\177ELF", 4)) {
+	if (memcmp(vdso_start, "\177ELF", 4)) {
 		pr_err("VDSO is not a valid ELF object!\n");
 		return -ENOEXEC;
 	}
 
-	text_pages = (&vdso_end - &vdso_start) >> PAGE_SHIFT;
-	pr_debug("vdso: %i text pages at base %p\n", text_pages, &vdso_start);
+	text_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
+	pr_debug("vdso: %i text pages at base %p\n", text_pages, vdso_start);
 
 	/* Allocate the VDSO text pagelist */
 	vdso_text_pagelist = kcalloc(text_pages, sizeof(struct page *),
@@ -218,7 +220,7 @@ static int __init vdso_init(void)
 	for (i = 0; i < text_pages; i++) {
 		struct page *page;
 
-		page = virt_to_page(&vdso_start + i * PAGE_SIZE);
+		page = virt_to_page(vdso_start + i * PAGE_SIZE);
 		vdso_text_pagelist[i] = page;
 	}
 
@@ -229,7 +231,7 @@ static int __init vdso_init(void)
 
 	cntvct_ok = cntvct_functional();
 
-	patch_vdso(&vdso_start);
+	patch_vdso(vdso_start);
 
 	return 0;
 }
-- 
1.9.1
