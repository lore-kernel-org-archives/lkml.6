Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BF2C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E3B20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080273;
	bh=BjsFRr/PDfdin9dDxK55UhjIMSY6isErClRiQO3pgs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0oEOpnXvBM/Ehc9ijeTZoBVNRDpL21tkyaO9TM/RjNn6kCUKrmRdqRrVI0zybSgRn
	 R01+edw2nj6Pgdbf6JSKOiM7f2NQ0FmPnIfkIjuCIcL8AxPhPVBzZ+MYestb31Sq2Q
	 xTrSh3DMEu+t4pJkD6eBD9tmSuOeoTS/Nfcf+O5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbfAUORv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:17:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730445AbfAUNuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:50:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 711E220879;
        Mon, 21 Jan 2019 13:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078601;
        bh=BjsFRr/PDfdin9dDxK55UhjIMSY6isErClRiQO3pgs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mrEnrMOTx4FBqCO0yUT+wSxQy+j3BVnzt60SubovtSlqSXcw4oDjA38DUr/0XHMUO
         8DNKJ6vEbP0sdQTNoWu3RPiwWosauz/shBdTiXubrbDGMrMTRGg4GKrinHmoQSNyCU
         pXwaSy9PHVKpXaR7vGU5aCdDSOXbcNGOzH9j6U80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Monroy, Rodrigo Axel" <rodrigo.axel.monroy@intel.com>,
        "Orrala Contreras, Alfredo" <alfredo.orrala.contreras@intel.com>,
        Hang Yuan <hang.yuan@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH 4.20 052/111] drm/i915/gvt: Fix mmap range check
Date:   Mon, 21 Jan 2019 14:42:46 +0100
Message-Id: <20190121122501.654829291@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/gpu/drm/i915/gvt/kvmgt.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -996,7 +996,7 @@ static int intel_vgpu_mmap(struct mdev_d
 {
 	unsigned int index;
 	u64 virtaddr;
-	unsigned long req_size, pgoff = 0;
+	unsigned long req_size, pgoff, req_start;
 	pgprot_t pg_prot;
 	struct intel_vgpu *vgpu = mdev_get_drvdata(mdev);
 
@@ -1014,7 +1014,17 @@ static int intel_vgpu_mmap(struct mdev_d
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


