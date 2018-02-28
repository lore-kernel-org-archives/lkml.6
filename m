Return-Path: <jinb.park7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519828201; cv=none;
        d=google.com; s=arc-20160816;
        b=nVlDoc3v4kgYkir0c6JfUz64B+ceo6xnFOsNAy1QytfMyc4rN2T+ztpO1BFd0WWENs
         xxW1EhcAjVM0sbyCzJ3AsN0oQPfC/GmCHo5VXKUREOl9cgpq9w3N4y2uarHI9c3CI0/u
         lzuHR+Y51cmPZQvUKDtSyUm4yqdLYJamBp9eqnRr635GYhtvWieBJYvOId7SSyACR09Z
         i2QrCH6EMn74+Rlzh3OkalsdKyrQ2HsQt3jEC6p0Jb3OtJHWy4ZphLkWlj0W/gbdFlBN
         +3hz3lba+gMoE1I5I/m8m7m57/mHCdHlJqjFjTuX+C3eLeWyRWCkf0/JQZrJh3WVLx03
         S9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=PAXcxfqKsRssBG3g9JLPQQTJ+xYxS8QQMlC/qiutrtM=;
        b=F3i9/nnNAuK4CgBVzVFwxts2megObyc17EV5C9asTJypSbIqceag/Ket3tLhp2BJq1
         nngbEkr4tmQE4sXgVK0wVx7/ulmSZY6lpeyiUPbam2ZR9uZ32zxsqgALM4hMYh0R4Ic7
         fy/ull58NUcGyQDUClqsZDtekrrJKQR5zaKtJljN9FHD93r9MZfYDAJ0On/XEGCZ6rhu
         3l7Csyk0ifcA84CCq083WND56EhTPkA4NFj0zmrmLZbvF3hUtozOZvHANPXjC3qfUm6d
         zR76yXgCRVv/gF28wPCVp1fb+FlGCwLUsOaCAXxtziOVwdYLrBP5RiNFsyF4vOu7x3ny
         ykFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ql1ekRva;
       spf=pass (google.com: domain of jinb.park7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jinb.park7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ql1ekRva;
       spf=pass (google.com: domain of jinb.park7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jinb.park7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELttwvPDhysQ33Z1ojYmqlU6h5EgDUuVgL0DEcz97pb8QEIQHyy56i4Q74qAtycRhBIDbea6wg==
Date: Wed, 28 Feb 2018 23:29:51 +0900
From: Jinbum Park <jinb.park7@gmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Cc: pombredanne@nexb.co, gregkh@linuxfoundation.org, tglx@linutronix.de,
	kstewart@linuxfoundation.org, luto@amacapital.net,
	dsafonov@virtuozzo.com, keescook@chromium.org, will.deacon@arm.com,
	mark.rutland@arm.com, danielmicay@gmail.com, arnd@arndb.de,
	catalin.marinas@arm.com
Subject: [kernel-hardening] [PATCH 1/2] arm: mm: Define vdso_start, vdso_end
 as array
Message-ID: <20180228142951.GA3136@pjb1027-Latitude-E5410>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593655376108279325?=
X-GMAIL-MSGID: =?utf-8?q?1593655376108279325?=
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

Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
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
