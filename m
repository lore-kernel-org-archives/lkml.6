Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELtsDvEclpS14Bifd4+TX/T3BnC+zk+wPu1G6xdvp7aIZjDSxwqlCvwm36Ug+hBiiZ0FK6wO
ARC-Seal: i=1; a=rsa-sha256; t=1521017320; cv=none;
        d=google.com; s=arc-20160816;
        b=FJ/7g2lkmtgDpzenYTqlLt35QwebGpxASTDsmreczhmc8N3/FtJJI/3/jlcqrf/2n5
         35uyXvaqQedCxoPZ/2Gt8vgLaoW877VyJSzUyC0sdxMPllCRe6Al0GCSp1Ya62AQNQSp
         RJcIhgnJg8BARmKzXv3JFA5fwd0kc2U772wX0+ytuHrXUzq3EY3uFnavt8Sl/i9iOTFt
         h6ozOm5xW4Im5X/pdYhFHzdfx93DDyoYsweHA1Qb2ZpNKBYY2/pzrpu3m6Q0+9lqHWFA
         jFR+TDKxk31wwELOSdmrlYBxX99G4eQAuedkxSrgsJkIudkk4NDDJkoHIlMrycEkDJcJ
         q3Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=BVw4iuMiNOGMGY33ozK4SgLXHGQKcr05wxlxFQTGaKY=;
        b=Dijyn3eTZD8kXNIwwQ3QZq6LNet2COWjqYOMKoTIAPQm4Kid9GKcBXIiyZuwxBa6fR
         EMc76CXNMQZDYD8Hk5PkxMMNiHoKguO/l0QrOGGyLHl1gREBKlJE7FjS2LtniZxYDcV2
         vEuI0eU/Y6WWUCGycPllfoofBX5YcUjaTiv15odLR2UGEmWp8SBB4qfMuljDN+gHVO/5
         kSNozUcjNc/yLGy7yA14oPylVFZqbiHTkdpR7ildOddWgbTbcCIegDK5zivLUTb0bI5C
         J9eDmy4pJJAXd4G+DHLqjAcWXDJVIpdN+L03QjyLYqpd+t7oM4Xa/QbwfPbgSkllDwFD
         vqOA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=D4ozXUjL;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=kAWomCRF;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=D4ozXUjL;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=kAWomCRF;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5205E6016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: catalin.marinas@arm.com,
	will.deacon@arm.com,
	arnd@arndb.de
Cc: mark.rutland@arm.com,
	ard.biesheuvel@linaro.org,
	marc.zyngier@arm.com,
	james.morse@arm.com,
	kristina.martsenko@arm.com,
	takahiro.akashi@linaro.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	akpm@linux-foundation.org,
	toshi.kani@hpe.com,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v1 0/4] Fix issues with huge mapping in ioremap
Date: Wed, 14 Mar 2018 14:18:21 +0530
Message-Id: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594902258124982014?=
X-GMAIL-MSGID: =?utf-8?q?1594902258124982014?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Note: I was working on these patches for quite sometime
and realized that Toshi Kani has shared some patches
addressing the same isssue with subject
"[PATCH 0/2] fix memory leak / panic in ioremap huge pages".
I've taken slightly different approach here, so sending
to the list, finally.

This patch series attempts to fix the issue described in
this discussion: https://lkml.org/lkml/2017/12/23/3

In summary, CONFIG_HAVE_ARCH_HUGE_VMAP has 2 issues
observed on ARM64

 1. Stale TLB entries
 2. Page table leaks

Will Deacon has by-passed huge mapping for ARM64
until these issues are fixed properly.

I've tested these patches on ARM64 based SDM845
with 4.9 kernel. Hanjun Guo <hanjun.guo@linaro.org>
shared test-case to reproduce this issue in
https://patchwork.kernel.org/patch/10134581/

However, I had no luck reproducing this issue with
exactly this test. I added some more code to reproduce
and here is my test which surfaces this issue in some
five hours of testing.

Test Code:

#define pr_fmt(fmt)     "IOREMAP_TEST: " fmt

#include <linux/console.h>
#include <linux/module.h>
#include <linux/string.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/random.h>
#include <linux/io.h>
#include <linux/kthread.h>

static int io_remap_test(void *arg)
{
       phys_addr_t phy_addr_1 = 0x98000000;
       unsigned long block_size = 0x200000;
       unsigned long total_size = 0x400000;
       unsigned long va_addr_3;
       unsigned long va_addr_4;

       struct vm_struct *area;

       /*
        * run this test for 10 hours
        */
       u32 times_ms = 10 * 60 * 60 * 1000;
       unsigned long timeout = jiffies + msecs_to_jiffies(times_ms);
       int rand_type;
       int rand_value;
       u32 mem_size;
       int i;

       area = get_vm_area(total_size, VM_IOREMAP);
       va_addr_3 = (unsigned long)area->addr;
       va_addr_4 = va_addr_3 + block_size;
       pr_err("Virtual area %lx -- %lx\n", va_addr_3, va_addr_3 + total_size);

       ioremap_page_range(va_addr_3, va_addr_3 + block_size, phy_addr_1, __pgprot(PROT_DEVICE_nGnRE));
       pr_err("My tests will run now 2\n");
       do {
               get_random_bytes(&rand_value, sizeof(u32));

               rand_type = rand_value % 6;
               switch (rand_type) {
               case 0:
                       mem_size = 0x1000;
                       break;
               case 1:
                       mem_size = 0x8000;
                       break;
               case 2:
                       mem_size = 0x200000;
                       break;
               case 3:
                       mem_size = 0x30000;
                       break;
               case 4:
                       mem_size = 0x10000;
                       break;
               case 5:
                       mem_size = 0x40000;
                       break;
               default:
                       mem_size = 0x4000;
                       break;
               }

               /*
                * Prompt TLB to speculatively pre-fetch
                */
               readq(va_addr_3 + block_size - 0x20);
               readq(va_addr_3 + block_size - 0x18);
               readq(va_addr_3 + block_size - 0x10);
               readq(va_addr_3 + block_size - 0x8);

               ioremap_page_range(va_addr_4, va_addr_4 + mem_size, phy_addr_1, __pgprot(PROT_DEVICE_nGnRE));

               if (mem_size >= 0x200000 && !(rand_value%10000)) {
                       schedule();
                       pr_err("possible error case\n");
               }

               /*
                * Make CPU aware about our access pattern
                * Also, these accesses should lead to crash
                */
               for (i = 0; i < 5; i++ ) {
                       readq(va_addr_3 + block_size - 0x20);
                       readq(va_addr_3 + block_size - 0x18);
                       readq(va_addr_3 + block_size - 0x10);
                       readq(va_addr_3 + block_size - 0x8);
                       // Crash is expected here  
                       readq(va_addr_4);
                       readq(va_addr_4 + 0x8);
                       readq(va_addr_4 + 0x10);
                       readq(va_addr_4 + 0x18);
                       readq(va_addr_4 + 0x20);
               }

               unmap_kernel_range(va_addr_4, mem_size);
       } while (time_before(jiffies, timeout));

       pr_err("my tests ended now\n");
       return 0;
}

static int __init ioremap_testing_init(void)
{
       struct task_struct *t;
       pr_err("my tests will run now 1\n");

       t = kthread_create(&io_remap_test, NULL, "ioremap-testing");
       /*
        * Do this so that we can run this thread on GOLD cores
        */
       kthread_bind(t, 6);
       wake_up_process(t);
       return 0;
}
late_initcall(ioremap_testing_init);


Chintan Pandya (4):
  asm/tlbflush: Add flush_tlb_pgtable() for ARM64
  ioremap: Invalidate TLB after huge mappings
  arm64: Fix the page leak in pud/pmd_set_huge
  Revert "arm64: Enforce BBM for huge IO/VMAP mappings"

 arch/arm64/include/asm/tlbflush.h |  5 +++++
 arch/arm64/mm/mmu.c               | 17 ++++++++---------
 include/asm-generic/tlb.h         |  6 ++++++
 lib/ioremap.c                     |  9 +++++++--
 4 files changed, 26 insertions(+), 11 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
