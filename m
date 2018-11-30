Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E619DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF27F204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF27F204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbeK3VKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:10:40 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44131 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeK3VKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:10:40 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAUA0voR3262457
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Nov 2018 02:00:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAUA0vtj3262454;
        Fri, 30 Nov 2018 02:00:57 -0800
Date:   Fri, 30 Nov 2018 02:00:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-80424b02d42bb22f8ff8839cb93a84ade53b39c0@git.kernel.org>
Cc:     marc.zyngier@arm.com, peterz@infradead.org, bhsharma@redhat.com,
        jonathanh@nvidia.com, arend.vanspriel@broadcom.com,
        julien.thierry@arm.com, natechancellor@gmail.com, bp@alien8.de,
        torvalds@linux-foundation.org, joe@perches.com, mingo@kernel.org,
        ard.biesheuvel@linaro.org, hpa@zytor.com,
        sai.praneeth.prakhya@intel.com, sedat.dilek@gmail.com,
        eric.snowberg@oracle.com, dave.hansen@intel.com,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        matt@codeblueprint.co.uk, luto@kernel.org, zhuyifei1999@gmail.com,
        tglx@linutronix.de
Reply-To: julien.thierry@arm.com, arend.vanspriel@broadcom.com,
          natechancellor@gmail.com, bp@alien8.de,
          torvalds@linux-foundation.org, bhsharma@redhat.com,
          jonathanh@nvidia.com, peterz@infradead.org, marc.zyngier@arm.com,
          tglx@linutronix.de, luto@kernel.org, matt@codeblueprint.co.uk,
          linux-kernel@vger.kernel.org, hdegoede@redhat.com,
          zhuyifei1999@gmail.com, ard.biesheuvel@linaro.org, hpa@zytor.com,
          sai.praneeth.prakhya@intel.com, sedat.dilek@gmail.com,
          eric.snowberg@oracle.com, dave.hansen@intel.com, joe@perches.com,
          mingo@kernel.org
In-Reply-To: <20181129171230.18699-11-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-11-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: Reduce the amount of memblock reservations for
 persistent allocations
Git-Commit-ID: 80424b02d42bb22f8ff8839cb93a84ade53b39c0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  80424b02d42bb22f8ff8839cb93a84ade53b39c0
Gitweb:     https://git.kernel.org/tip/80424b02d42bb22f8ff8839cb93a84ade53b39c0
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Thu, 29 Nov 2018 18:12:29 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 30 Nov 2018 09:37:57 +0100

efi: Reduce the amount of memblock reservations for persistent allocations

The current implementation of efi_mem_reserve_persistent() is rather
naive, in the sense that for each invocation, it creates a separate
linked list entry to describe the reservation. Since the linked list
entries themselves need to persist across subsequent kexec reboots,
every reservation created this way results in two memblock_reserve()
calls at the next boot.

On arm64 systems with 100s of CPUs, this may result in a excessive
number of memblock reservations, and needless fragmentation.

So instead, make use of the newly updated struct linux_efi_memreserve
layout to put multiple reservations into a single linked list entry.
This should get rid of the numerous tiny memblock reservations, and
effectively cut the total number of reservations in half on arm64
systems with many CPUs.

 [ mingo: build warning fix. ]

Tested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: YiFei Zhu <zhuyifei1999@gmail.com>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20181129171230.18699-11-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/efi.c | 21 +++++++++++++++++----
 include/linux/efi.h        |  3 +++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 80b11521627a..4c46ff6f2242 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -997,8 +997,8 @@ static int __init efi_memreserve_map_root(void)
 int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 {
 	struct linux_efi_memreserve *rsv;
-	int rsvsize = EFI_MEMRESERVE_SIZE(1);
-	int rc;
+	unsigned long prsv;
+	int rc, index;
 
 	if (efi_memreserve_root == (void *)ULONG_MAX)
 		return -ENODEV;
@@ -1009,11 +1009,24 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 			return rc;
 	}
 
-	rsv = kmalloc(rsvsize, GFP_ATOMIC);
+	/* first try to find a slot in an existing linked list entry */
+	for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
+		rsv = __va(prsv);
+		index = atomic_fetch_add_unless(&rsv->count, 1, rsv->size);
+		if (index < rsv->size) {
+			rsv->entry[index].base = addr;
+			rsv->entry[index].size = size;
+
+			return 0;
+		}
+	}
+
+	/* no slot found - allocate a new linked list entry */
+	rsv = (struct linux_efi_memreserve *)__get_free_page(GFP_ATOMIC);
 	if (!rsv)
 		return -ENOMEM;
 
-	rsv->size = 1;
+	rsv->size = EFI_MEMRESERVE_COUNT(PAGE_SIZE);
 	atomic_set(&rsv->count, 1);
 	rsv->entry[0].base = addr;
 	rsv->entry[0].size = size;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 4f27640fdcdc..becd5d76a207 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1724,4 +1724,7 @@ struct linux_efi_memreserve {
 #define EFI_MEMRESERVE_SIZE(count) (sizeof(struct linux_efi_memreserve) + \
 	(count) * sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
 
+#define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
+	/ sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
+
 #endif /* _LINUX_EFI_H */
