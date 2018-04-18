Return-Path: <kernel-hardening-return-13043-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+6okjCHMcTrhROFmAlDLyUAk86TdLaCYlSOwHL/QrHDxdqAIVu4/Xxcv9RdpbAwl/qflMC
ARC-Seal: i=1; a=rsa-sha256; t=1524071338; cv=none;
        d=google.com; s=arc-20160816;
        b=hmAbq5xBxHk9Bb6ULR/BjaCyZo5kX2GOYlrpVf4PNwclAbqJ8HfaGDwFcPs0UUfbQZ
         eIPulQ+qkdxJ50YbK33opgzWTegfUQD/BAKmeOHHgW7u26NRADd8St4HMar84CWAqq2A
         cQ1rdYGsJ5aHMp6pQV0gdDT2rnpYTsVwQT0D4vK/ih8/vKfVrI7UXrlVq5MI2HwvpLCe
         YIyzwMLQDXxorIvr8aLFAjaLI1Z3+N8K30Q2bOzfyV4GdbpY8b5i8WBWVl7nygPLb34p
         2AlshWKbe49DDb8bH9oXcMNTiENhfCWObW3LVIT/w0nEezPXZaoHk8owKTwzDQsvb8op
         mQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=L0CmRt2Q/6x+b3MBwp7RjVdQoYyRYoWFzN6MBGW1nao=;
        b=lNQnK3qjPmDNk5p+fnSfcmTeA+Zy4UPISu9CCv0fgRsDqo6vbcndSOZYgxdt3FgkMh
         ofbRxJYRoDgvLRzcFoSekRa3eAuvNCcHsHkmVuDs5MBPcBdzzpRqa7X/z8Vs2sWXhoCI
         7IcbZi0tX1z1gqbCpFmu+FImEoF7sqmiIGHFpZEbmk53LbVrOUTBTuWiL/ChTLPyN6fH
         Z+5sgcXOkDiiI0p/WVIal+TZ7ncgYANJWLyqLrpsMWKbc+JcbS1eGhp+e46dbILPKEEk
         jMLMCeC+IHJZ0taixafKljpFeYKJUiitwrUTc+hQu/T8rRxKdroZVzEv+/rszJdak8G9
         AWmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13043-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13043-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13043-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13043-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>
Cc: Laura Abbott <labbott@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCHv2] x86/xen: Remove use of VLAs
Date: Wed, 18 Apr 2018 10:08:32 -0700
Message-Id: <20180418170832.8798-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598104627872343121?=
X-GMAIL-MSGID: =?utf-8?q?1598104627872343121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


There's an ongoing effort to remove VLAs[1] from the kernel to eventually
turn on -Wvla. It turns out, the few VLAs in use in Xen produce only a
single entry array that is always bounded by GDT_SIZE. Clean up the code to
get rid of the VLA and the loop.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Updated the code to reflect that we know size is always bounded by
GDT_SIZE. This gets rid of the array and the loop. I can throw a few
more comments in there if someone thinks they need to be updated.
---
 arch/x86/xen/enlighten_pv.c | 84 ++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 55 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index c36d23aa6c35..1254f2fa3a89 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -421,45 +421,32 @@ static void xen_load_gdt(const struct desc_ptr *dtr)
 {
 	unsigned long va = dtr->address;
 	unsigned int size = dtr->size + 1;
-	unsigned pages = DIV_ROUND_UP(size, PAGE_SIZE);
-	unsigned long frames[pages];
-	int f;
-
-	/*
-	 * A GDT can be up to 64k in size, which corresponds to 8192
-	 * 8-byte entries, or 16 4k pages..
-	 */
+	unsigned long pfn, mfn;
+	int level;
+	pte_t *ptep;
+	void *virt;
 
-	BUG_ON(size > 65536);
+	BUG_ON(size > GDT_SIZE);
 	BUG_ON(va & ~PAGE_MASK);
 
-	for (f = 0; va < dtr->address + size; va += PAGE_SIZE, f++) {
-		int level;
-		pte_t *ptep;
-		unsigned long pfn, mfn;
-		void *virt;
-
-		/*
-		 * The GDT is per-cpu and is in the percpu data area.
-		 * That can be virtually mapped, so we need to do a
-		 * page-walk to get the underlying MFN for the
-		 * hypercall.  The page can also be in the kernel's
-		 * linear range, so we need to RO that mapping too.
-		 */
-		ptep = lookup_address(va, &level);
-		BUG_ON(ptep == NULL);
-
-		pfn = pte_pfn(*ptep);
-		mfn = pfn_to_mfn(pfn);
-		virt = __va(PFN_PHYS(pfn));
+	/*
+	 * The GDT is per-cpu and is in the percpu data area.
+	 * That can be virtually mapped, so we need to do a
+	 * page-walk to get the underlying MFN for the
+	 * hypercall.  The page can also be in the kernel's
+	 * linear range, so we need to RO that mapping too.
+	 */
+	ptep = lookup_address(va, &level);
+	BUG_ON(ptep == NULL);
 
-		frames[f] = mfn;
+	pfn = pte_pfn(*ptep);
+	mfn = pfn_to_mfn(pfn);
+	virt = __va(PFN_PHYS(pfn));
 
-		make_lowmem_page_readonly((void *)va);
-		make_lowmem_page_readonly(virt);
-	}
+	make_lowmem_page_readonly((void *)va);
+	make_lowmem_page_readonly(virt);
 
-	if (HYPERVISOR_set_gdt(frames, size / sizeof(struct desc_struct)))
+	if (HYPERVISOR_set_gdt(&mfn, size / sizeof(struct desc_struct)))
 		BUG();
 }
 
@@ -470,34 +457,21 @@ static void __init xen_load_gdt_boot(const struct desc_ptr *dtr)
 {
 	unsigned long va = dtr->address;
 	unsigned int size = dtr->size + 1;
-	unsigned pages = DIV_ROUND_UP(size, PAGE_SIZE);
-	unsigned long frames[pages];
-	int f;
-
-	/*
-	 * A GDT can be up to 64k in size, which corresponds to 8192
-	 * 8-byte entries, or 16 4k pages..
-	 */
+	unsigned long pfn, mfn;
+	pte_t pte;
 
-	BUG_ON(size > 65536);
+	BUG_ON(size > GDT_SIZE);
 	BUG_ON(va & ~PAGE_MASK);
 
-	for (f = 0; va < dtr->address + size; va += PAGE_SIZE, f++) {
-		pte_t pte;
-		unsigned long pfn, mfn;
+	pfn = virt_to_pfn(va);
+	mfn = pfn_to_mfn(pfn);
 
-		pfn = virt_to_pfn(va);
-		mfn = pfn_to_mfn(pfn);
+	pte = pfn_pte(pfn, PAGE_KERNEL_RO);
 
-		pte = pfn_pte(pfn, PAGE_KERNEL_RO);
-
-		if (HYPERVISOR_update_va_mapping((unsigned long)va, pte, 0))
-			BUG();
-
-		frames[f] = mfn;
-	}
+	if (HYPERVISOR_update_va_mapping((unsigned long)va, pte, 0))
+		BUG();
 
-	if (HYPERVISOR_set_gdt(frames, size / sizeof(struct desc_struct)))
+	if (HYPERVISOR_set_gdt(&mfn, size / sizeof(struct desc_struct)))
 		BUG();
 }
 
-- 
2.14.3
