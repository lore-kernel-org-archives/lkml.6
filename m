Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227+zpgzzKQuJlw6DFuFBDxtR3/1NXeVa+DvruoTo+ytwEP4Ln8fMgvcV/edja7yHdaLhWFa
ARC-Seal: i=1; a=rsa-sha256; t=1518709170; cv=none;
        d=google.com; s=arc-20160816;
        b=lLsVkXBecweo8zxbTw19DqyPWzedkqCl1T5rMUq1gAUr5uekeTtb8FMnhpapUVcv9w
         S7qrhA7l2NVWB6FFiEqCMuXRf19pj9d1Ve4Sb1jEzpkDSrR1RJjWszYPzLvPPMbtXuUr
         TavOvZcBmo6i8fo84MO98wVjCu4B4FEf7BxiP7v7dzpz9EGrymz02gXYWsQy64rgjqTq
         nKEJd4k5YkQrn+qpR3ofwuqvLeozHYLKyzJQJwWWgEWrGB2S0X+b/9PiR7cnaodDiLEM
         6FO5wZJBDI73BN/WOrQ9Quz7rR3EXlgasL4cHl0+xQbWAmJ/c0OTrBQDrS6c1xzb2wmu
         LSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rMPH2i7DuX8+uT21mEDoezp0o2wH46f/sEUnnoEyxHk=;
        b=ymEIb9iAdjFek+3GsbYAbfG126rncIXpWuLAeV+LXhB9CNuQTxUY36e86PEr1szBBs
         eoX56vgsJFFC6OZEq45lCfvJWcI8hZaCP1zAZRV83Uy9oxyKq7s/GGlRIX9YrvMKkfcX
         mRa7uaQa2t14tgj3wCbk4vG4+njFNKFaQdTnU+zOe5YitTQ3is+SPc08FE3XgP3j7bNz
         oIQhpWFISh1eFfWc4vmbVLjfM4HhTuEH0rcuu8cqTop3q4jnNFgEPNz4Ih0Ruv8SP7pS
         OQP78hAjhBOJhFceoADLjJDrjxmybAndwtp0ow1TOq+PtWJYpH4t+NH/GWPqqNK1xxEt
         4zyQ==
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
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 022/202] [Variant 3/Meltdown] arm64: mm: Add arm64_kernel_unmapped_at_el0 helper
Date: Thu, 15 Feb 2018 16:15:22 +0100
Message-Id: <20180215151714.063533844@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481443573794235?=
X-GMAIL-MSGID: =?utf-8?q?1592481986785862744?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
