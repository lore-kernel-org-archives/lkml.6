Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E55DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0362218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358411;
	bh=JICGhMzBhrbIpY4k5M7UE/yMQwTbNaawYGgghYlbG58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dmESM0pQ/qu15ZZwiojrGL8thfzCe0/Hm5bGMKOU11k45N5v66EZPt/vp0dMsHqVM
	 Q5T2tzpzm522Py/OhdfQG0c4b1AQyLew10I+F6Ej1SbHDQV4zPEU7hgXxBDAL+9gJs
	 fW+qQV1wDWGC+q3QIgM+JtcCFmGOVjKh2i84whcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfAXTd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:33:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731374AbfAXTd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:33:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 522E421902;
        Thu, 24 Jan 2019 19:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358405;
        bh=JICGhMzBhrbIpY4k5M7UE/yMQwTbNaawYGgghYlbG58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cche4g/nPBP/bPQ/cMDW/xGE68IrNFaF0CH7BpXnYhCDun5mO15q8yFJ0st4Y56pN
         JwnmA6i4Y8deMNRl1nnIP+ljrqalQlBo9DYBVzdI4GgtAqPXzYk5HsgTN1HFt6rYzM
         Uvb1t0Fn2yzvJyp9i2PWiJGDEsPeV5l7E8ag7j7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Monroy, Rodrigo Axel" <rodrigo.axel.monroy@intel.com>,
        "Orrala Contreras, Alfredo" <alfredo.orrala.contreras@intel.com>,
        Hang Yuan <hang.yuan@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH 4.14 61/63] drm/i915/gvt: Fix mmap range check
Date:   Thu, 24 Jan 2019 20:20:50 +0100
Message-Id: <20190124190202.399993665@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190155.176570028@linuxfoundation.org>
References: <20190124190155.176570028@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhenyu Wang <zhenyuw@linux.intel.com>

commit 51b00d8509dc69c98740da2ad07308b630d3eb7d upstream.

This is to fix missed mmap range check on vGPU bar2 region
and only allow to map vGPU allocated GMADDR range, which means
user space should support sparse mmap to get proper offset for
mmap vGPU aperture. And this takes care of actual pgoff in mmap
request as original code always does from beginning of vGPU
aperture.

Fixes: 659643f7d814 ("drm/i915/gvt/kvmgt: add vfio/mdev support to KVMGT")
Cc: "Monroy, Rodrigo Axel" <rodrigo.axel.monroy@intel.com>
Cc: "Orrala Contreras, Alfredo" <alfredo.orrala.contreras@intel.com>
Cc: stable@vger.kernel.org # v4.10+
Reviewed-by: Hang Yuan <hang.yuan@intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/gvt/kvmgt.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -807,11 +807,18 @@ write_err:
 	return -EFAULT;
 }
 
+static inline bool intel_vgpu_in_aperture(struct intel_vgpu *vgpu,
+					  unsigned long off)
+{
+	return off >= vgpu_aperture_offset(vgpu) &&
+		off < vgpu_aperture_offset(vgpu) + vgpu_aperture_sz(vgpu);
+}
+
 static int intel_vgpu_mmap(struct mdev_device *mdev, struct vm_area_struct *vma)
 {
 	unsigned int index;
 	u64 virtaddr;
-	unsigned long req_size, pgoff = 0;
+	unsigned long req_size, pgoff, req_start;
 	pgprot_t pg_prot;
 	struct intel_vgpu *vgpu = mdev_get_drvdata(mdev);
 
@@ -829,7 +836,17 @@ static int intel_vgpu_mmap(struct mdev_d
 	pg_prot = vma->vm_page_prot;
 	virtaddr = vma->vm_start;
 	req_size = vma->vm_end - vma->vm_start;
-	pgoff = vgpu_aperture_pa_base(vgpu) >> PAGE_SHIFT;
+	pgoff = vma->vm_pgoff &
+		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
+	req_start = pgoff << PAGE_SHIFT;
+
+	if (!intel_vgpu_in_aperture(vgpu, req_start))
+		return -EINVAL;
+	if (req_start + req_size >
+	    vgpu_aperture_offset(vgpu) + vgpu_aperture_sz(vgpu))
+		return -EINVAL;
+
+	pgoff = (gvt_aperture_pa_base(vgpu->gvt) >> PAGE_SHIFT) + pgoff;
 
 	return remap_pfn_range(vma, virtaddr, pgoff, req_size, pg_prot);
 }


