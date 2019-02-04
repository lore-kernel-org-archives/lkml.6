Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3600AC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A76620820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfBDInu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:43:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:32847 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfBDInt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:43:49 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148h3K9354484
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:43:03 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148gxbk354480;
        Mon, 4 Feb 2019 00:42:59 -0800
Date:   Mon, 4 Feb 2019 00:42:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-5de0fef0230f3c8d75cff450a71740a7bf2db866@git.kernel.org>
Cc:     jhugo@codeaurora.org, bjorn.andersson@linaro.org, agraf@suse.de,
        matt@codeblueprint.co.uk, pjones@redhat.com, lee.jones@linaro.org,
        hpa@zytor.com, xypron.glpk@gmx.de, leif.lindholm@linaro.org,
        sai.praneeth.prakhya@intel.com, bp@alien8.de,
        torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, ard.biesheuvel@linaro.org,
        takahiro.akashi@linaro.org, linux-kernel@vger.kernel.org
Reply-To: lee.jones@linaro.org, bjorn.andersson@linaro.org,
          jhugo@codeaurora.org, pjones@redhat.com, agraf@suse.de,
          matt@codeblueprint.co.uk, mingo@kernel.org, peterz@infradead.org,
          torvalds@linux-foundation.org, bp@alien8.de,
          ard.biesheuvel@linaro.org, takahiro.akashi@linaro.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          sai.praneeth.prakhya@intel.com, xypron.glpk@gmx.de,
          leif.lindholm@linaro.org
In-Reply-To: <20190202094119.13230-4-ard.biesheuvel@linaro.org>
References: <20190202094119.13230-4-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/memattr: Don't bail on zero VA if it equals the
 region's PA
Git-Commit-ID: 5de0fef0230f3c8d75cff450a71740a7bf2db866
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

Commit-ID:  5de0fef0230f3c8d75cff450a71740a7bf2db866
Gitweb:     https://git.kernel.org/tip/5de0fef0230f3c8d75cff450a71740a7bf2db866
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Sat, 2 Feb 2019 10:41:12 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:26:34 +0100

efi/memattr: Don't bail on zero VA if it equals the region's PA

The EFI memory attributes code cross-references the EFI memory map with
the more granular EFI memory attributes table to ensure that they are in
sync before applying the strict permissions to the regions it describes.

Since we always install virtual mappings for the EFI runtime regions to
which these strict permissions apply, we currently perform a sanity check
on the EFI memory descriptor, and ensure that the EFI_MEMORY_RUNTIME bit
is set, and that the virtual address has been assigned.

However, in cases where a runtime region exists at physical address 0x0,
and the virtual mapping equals the physical mapping, e.g., when running
in mixed mode on x86, we encounter a memory descriptor with the runtime
attribute and virtual address 0x0, and incorrectly draw the conclusion
that a runtime region exists for which no virtual mapping was installed,
and give up altogether. The consequence of this is that firmware mappings
retain their read-write-execute permissions, making the system more
vulnerable to attacks.

So let's only bail if the virtual address of 0x0 has been assigned to a
physical region that does not reside at address 0x0.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Alexander Graf <agraf@suse.de>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Fixes: 10f0d2f577053 ("efi: Implement generic support for the Memory ...")
Link: http://lkml.kernel.org/r/20190202094119.13230-4-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/memattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index 8986757eafaf..aac972b056d9 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -94,7 +94,7 @@ static bool entry_is_valid(const efi_memory_desc_t *in, efi_memory_desc_t *out)
 
 		if (!(md->attribute & EFI_MEMORY_RUNTIME))
 			continue;
-		if (md->virt_addr == 0) {
+		if (md->virt_addr == 0 && md->phys_addr != 0) {
 			/* no virtual mapping has been installed by the stub */
 			break;
 		}
