Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/7xXW8HVrcaTpixN1VPH9bYxsiz0CpqJcyzub+vaZ09kTVV1DabxuQ0Dsp9Rb+FBc7qhJ0
ARC-Seal: i=1; a=rsa-sha256; t=1523021685; cv=none;
        d=google.com; s=arc-20160816;
        b=W3UjMs8XnL6s3D0QXJvDpRmCGIYCF4AjjPz4FRzSFRAQyY2U0fSxUeqDq0mcwaeXq+
         RsoeKKeZ6BhIRryd0iktmCkqzUZkMUD3GGkca6vbkB4REfCJatY5jU/bL/GchLE43MWf
         mzEjQWZJZRKpUzJKIYPUYg5HLK5uSXa1gIjXppaBFWoO20RfM6BewTtEOYLDmzy70wvR
         Oye1CfH+tMTFeX7VPqsCJJN7hA2A/VLndBterJ4rrfk4YgUAAh1OVRPoxqryD3scNBfA
         hN58H0YcjYU2BiSpCxtIbj76orKrwE7ChX/jIEcRjqPVZDeRDn4XYmK5cTk0plFBr/0p
         eeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YoR7v9WYHEodkRO1BWlGXpl+q3v0aGp8Q+uuWx5EkII=;
        b=QwMmRTtx5RRH+7e2Zlss1IikpK46OnuOF7nqZVc2zVq67ORwRZTIkTehkMFsrVagI1
         1ykUepwyPCMOErYd9bGRRoklOmdyS9E7wtTo3zSa9PXH7GkxOlQSetnxULag+GJTIJoj
         p7rxwh65TYzBRWlf6wsOb1Xrgm8F3TZ5dCsB0VeS/hVelOZ2TgYR3EPjUP2bDkxCxYqQ
         tu6So2Gwj5o1Vky/Bw1H97t5bgUx21JpmBLqHn152dEJ5+qmsVN+chW3C54pqfiHzIXp
         wyQ+/7gEZDWmPBVixFomobZ75KVmOMy/zOJuvmEbyvQRrYB7VOouGV0mxDBcnx9gzsmu
         WcfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 4.9 053/102] arm64: mm: Add arm64_kernel_unmapped_at_el0 helper
Date: Fri,  6 Apr 2018 15:23:34 +0200
Message-Id: <20180406084339.098378750@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003986410162375?=
X-GMAIL-MSGID: =?utf-8?q?1597003986410162375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit fc0e1299da54 upstream.

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
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/mmu.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -18,6 +18,8 @@
 
 #define USER_ASID_FLAG	(UL(1) << 48)
 
+#ifndef __ASSEMBLY__
+
 typedef struct {
 	atomic64_t	id;
 	void		*vdso;
@@ -30,6 +32,11 @@ typedef struct {
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
@@ -39,4 +46,5 @@ extern void create_pgd_mapping(struct mm
 			       pgprot_t prot, bool allow_block_mappings);
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
 
+#endif	/* !__ASSEMBLY__ */
 #endif
