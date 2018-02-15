Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2266nohpZxeGsCkjlUG51qkq93AANrvGKWUJf0YBv+1NW3xzPaf8oKELY4vZ/80/1rOWJ2dG
ARC-Seal: i=1; a=rsa-sha256; t=1518708652; cv=none;
        d=google.com; s=arc-20160816;
        b=L4cAKjx+BLWUHTfUbPBldZ9Z8E+Zq7lCAgNaIAQ97MGhCc875F665gPmMpHWuDKZIe
         933WmiUzV2xKSpDUhBCgC3TUXTJcvmPRj6vSf5qu+L9nHs1jU53tCjo1qppVtu9P+Wda
         hduJ+HNb85nwLT3RDUqX2T3IeVBfnfyiWI/aGQiXy8F8QTqdSo+6n9ZmqIDAzV0CGPj9
         hlhIRSh42xoGYBZVXosC5sQks2g9PakRHdBw/D3xuHsudapM8P+0JJ9PuLsy1BT5+4nU
         WiwJnX9VUcB+YTEKCZ5z+ZaaX/+pRer+AQk1HRlolku/4q+Wdx1lk0kHsB4hbPNmo+5S
         E7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4IO7XPB6p9zLYkEeU+cOBWJWLkcxKeqKo0KjuHw5Pjc=;
        b=p88PVcXvwkvuj14aDgpH6dDB30OkwPVMvHvj4pC9fulFGf4fiupEX6y0xrJAJkVvn1
         8mrkH1ZpGspUKCHHpfvG4TEooQOOBa7f4Xd2Vlxb3y+e91MDLwI7/Vx4z2LybgbyvkTG
         q7/1H9pANqxkEYYmPRGiw4ZiwLmTqEf5tNBKNn3gQ7MEWrzfNwc91NcOXY3pG6F2hWqa
         f5jvQod/YRqv5a0zr/dOAyYUajIT8B3uKeyaY3BMBFGNnpfhp1JMY/GNXX1JierTNmYx
         jXXpi8TCBj8SLpoddHfPne+nI29FQDDYwcv+E1WzR2jUkiFse104qoXACVM/6hTyETY7
         ubfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 030/195] [Variant 3/Meltdown] arm64: mm: Add arm64_kernel_unmapped_at_el0 helper
Date: Thu, 15 Feb 2018 16:15:21 +0100
Message-Id: <20180215151707.264336550@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481443573794235?=
X-GMAIL-MSGID: =?utf-8?q?1592481443573794235?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit fc0e1299da54 upstream.

In order for code such as TLB invalidation to operate efficiently when
the decision to map the kernel at EL0 is determined at runtime, this
patch introduces a helper function, arm64_kernel_unmapped_at_el0, to
determine whether or not the kernel is mapped whilst running in userspace.

Currently, this just reports the value of CONFIG_UNMAP_KERNEL_AT_EL0,
but will later be hooked up to a fake CPU capability using a static key.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/mmu.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -19,6 +19,8 @@
 #define MMCF_AARCH32	0x1	/* mm context flag for AArch32 executables */
 #define USER_ASID_FLAG	(UL(1) << 48)
 
+#ifndef __ASSEMBLY__
+
 typedef struct {
 	atomic64_t	id;
 	void		*vdso;
@@ -32,6 +34,11 @@ typedef struct {
  */
 #define ASID(mm)	((mm)->context.id.counter & 0xffff)
 
+static inline bool arm64_kernel_unmapped_at_el0(void)
+{
+	return IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0);
+}
+
 extern void paging_init(void);
 extern void bootmem_init(void);
 extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
@@ -42,4 +49,5 @@ extern void create_pgd_mapping(struct mm
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
 extern void mark_linear_text_alias_ro(void);
 
+#endif	/* !__ASSEMBLY__ */
 #endif
