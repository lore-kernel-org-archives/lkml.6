Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2589C0044B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990F020857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jm+PBoVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990F020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbeKIIW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:22:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:47434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbeKIHcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:32:20 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4D822133D;
        Thu,  8 Nov 2018 21:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714093;
        bh=TZGqBwCCKb0XF4xOsyyFTGGSKq8DEYmG2qRbGV0N4NA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jm+PBoVHbT2EteoJeyKs8Oqqu8P3tvtu8xRShLnp712M2OB9tLuvrz0v9ecnLoQK4
         XGK6ol6M67RIHf+ozwTdESWt2/9C4ORAyDYfNIA2YSKdR2JbwzGpw+1vQy8F6NwcUp
         05Oi8sbgbD/nOMqrbf0iyIXDRr1ZVLV6yv/yKV6E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Munsie <imunsie@au1.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 036/144] cxl: Fix issues when unmapping contexts
Date:   Thu,  8 Nov 2018 13:50:07 -0800
Message-Id: <20181108215057.476544238@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0712dc7e73e59d79bcead5d5520acf4e9e917e87 ]

An issue was introduced with "cxl: Unmap MMIO regions when detaching a
context" (b123429e6a9e8d03aacf888d23262835f0081448) where closing a
context normally could also unmap the problem state area of other
contexts currently using the AFU.

It was also discovered that after a context's MMIO space had been
unmapped it would read 0s when accessing it, whereas the expected
behaviour was for the access to fail altogether.

In order to address these issues, this patch does two things:

- Forced mmap unmapping is only done when we are forcefully detaching
  all contexts, and not in the normal detach path. Since the normal
  context close path is tied to the file release any mmaps must have
  already been released so we don't need to worry in that case.

- The mmap path now uses a vm_operations_struct with a fault handler.
  The fault handler ensures that the context is in started state,
  otherwise it fails the access attempt with a SIGBUS.

Fixes: b123429e6a9e ("cxl: Unmap MMIO regions when detaching a context")
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/cxl/context.c | 82 +++++++++++++++++++++++++++++---------
 drivers/misc/cxl/file.c    | 14 ++++---
 2 files changed, 71 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 51fd6b524371..d1b55fe62817 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -100,6 +100,46 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
 	return 0;
 }
 
+static int cxl_mmap_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	struct cxl_context *ctx = vma->vm_file->private_data;
+	unsigned long address = (unsigned long)vmf->virtual_address;
+	u64 area, offset;
+
+	offset = vmf->pgoff << PAGE_SHIFT;
+
+	pr_devel("%s: pe: %i address: 0x%lx offset: 0x%llx\n",
+			__func__, ctx->pe, address, offset);
+
+	if (ctx->afu->current_mode == CXL_MODE_DEDICATED) {
+		area = ctx->afu->psn_phys;
+		if (offset > ctx->afu->adapter->ps_size)
+			return VM_FAULT_SIGBUS;
+	} else {
+		area = ctx->psn_phys;
+		if (offset > ctx->psn_size)
+			return VM_FAULT_SIGBUS;
+	}
+
+	mutex_lock(&ctx->status_mutex);
+
+	if (ctx->status != STARTED) {
+		mutex_unlock(&ctx->status_mutex);
+		pr_devel("%s: Context not started, failing problem state access\n", __func__);
+		return VM_FAULT_SIGBUS;
+	}
+
+	vm_insert_pfn(vma, address, (area + offset) >> PAGE_SHIFT);
+
+	mutex_unlock(&ctx->status_mutex);
+
+	return VM_FAULT_NOPAGE;
+}
+
+static const struct vm_operations_struct cxl_mmap_vmops = {
+	.fault = cxl_mmap_fault,
+};
+
 /*
  * Map a per-context mmio space into the given vma.
  */
@@ -108,26 +148,25 @@ int cxl_context_iomap(struct cxl_context *ctx, struct vm_area_struct *vma)
 	u64 len = vma->vm_end - vma->vm_start;
 	len = min(len, ctx->psn_size);
 
-	if (ctx->afu->current_mode == CXL_MODE_DEDICATED) {
-		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-		return vm_iomap_memory(vma, ctx->afu->psn_phys, ctx->afu->adapter->ps_size);
-	}
+	if (ctx->afu->current_mode != CXL_MODE_DEDICATED) {
+		/* make sure there is a valid per process space for this AFU */
+		if ((ctx->master && !ctx->afu->psa) || (!ctx->afu->pp_psa)) {
+			pr_devel("AFU doesn't support mmio space\n");
+			return -EINVAL;
+		}
 
-	/* make sure there is a valid per process space for this AFU */
-	if ((ctx->master && !ctx->afu->psa) || (!ctx->afu->pp_psa)) {
-		pr_devel("AFU doesn't support mmio space\n");
-		return -EINVAL;
+		/* Can't mmap until the AFU is enabled */
+		if (!ctx->afu->enabled)
+			return -EBUSY;
 	}
 
-	/* Can't mmap until the AFU is enabled */
-	if (!ctx->afu->enabled)
-		return -EBUSY;
-
 	pr_devel("%s: mmio physical: %llx pe: %i master:%i\n", __func__,
 		 ctx->psn_phys, ctx->pe , ctx->master);
 
+	vma->vm_flags |= VM_IO | VM_PFNMAP;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	return vm_iomap_memory(vma, ctx->psn_phys, len);
+	vma->vm_ops = &cxl_mmap_vmops;
+	return 0;
 }
 
 /*
@@ -150,12 +189,6 @@ static void __detach_context(struct cxl_context *ctx)
 	afu_release_irqs(ctx);
 	flush_work(&ctx->fault_work); /* Only needed for dedicated process */
 	wake_up_all(&ctx->wq);
-
-	/* Release Problem State Area mapping */
-	mutex_lock(&ctx->mapping_lock);
-	if (ctx->mapping)
-		unmap_mapping_range(ctx->mapping, 0, 0, 1);
-	mutex_unlock(&ctx->mapping_lock);
 }
 
 /*
@@ -184,6 +217,17 @@ void cxl_context_detach_all(struct cxl_afu *afu)
 		 * created and torn down after the IDR removed
 		 */
 		__detach_context(ctx);
+
+		/*
+		 * We are force detaching - remove any active PSA mappings so
+		 * userspace cannot interfere with the card if it comes back.
+		 * Easiest way to exercise this is to unbind and rebind the
+		 * driver via sysfs while it is in use.
+		 */
+		mutex_lock(&ctx->mapping_lock);
+		if (ctx->mapping)
+			unmap_mapping_range(ctx->mapping, 0, 0, 1);
+		mutex_unlock(&ctx->mapping_lock);
 	}
 	mutex_unlock(&afu->contexts_lock);
 }
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index e9f2f10dbb37..b15d8113877c 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -140,18 +140,20 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 
 	pr_devel("%s: pe: %i\n", __func__, ctx->pe);
 
-	mutex_lock(&ctx->status_mutex);
-	if (ctx->status != OPENED) {
-		rc = -EIO;
-		goto out;
-	}
-
+	/* Do this outside the status_mutex to avoid a circular dependency with
+	 * the locking in cxl_mmap_fault() */
 	if (copy_from_user(&work, uwork,
 			   sizeof(struct cxl_ioctl_start_work))) {
 		rc = -EFAULT;
 		goto out;
 	}
 
+	mutex_lock(&ctx->status_mutex);
+	if (ctx->status != OPENED) {
+		rc = -EIO;
+		goto out;
+	}
+
 	/*
 	 * if any of the reserved fields are set or any of the unused
 	 * flags are set it's invalid
-- 
2.17.1



