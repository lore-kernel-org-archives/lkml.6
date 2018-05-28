Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968654AbeE1Par (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968545AbeE1KT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:19:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 122/268] KVM: PPC: Book3S HV: Fix VRMA initialization with 2MB or 1GB memory backing
Date: Mon, 28 May 2018 12:01:36 +0200
Message-Id: <20180528100215.927437114@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Mackerras <paulus@ozlabs.org>

[ Upstream commit debd574f4195e205ba505b25e19b2b797f4bcd94 ]

The current code for initializing the VRMA (virtual real memory area)
for HPT guests requires the page size of the backing memory to be one
of 4kB, 64kB or 16MB.  With a radix host we have the possibility that
the backing memory page size can be 2MB or 1GB.  In these cases, if the
guest switches to HPT mode, KVM will not initialize the VRMA and the
guest will fail to run.

In fact it is not necessary that the VRMA page size is the same as the
backing memory page size; any VRMA page size less than or equal to the
backing memory page size is acceptable.  Therefore we now choose the
largest page size out of the set {4k, 64k, 16M} which is not larger
than the backing memory page size.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kvm/book3s_hv.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3002,15 +3002,17 @@ static int kvmppc_hv_setup_htab_rma(stru
 		goto up_out;
 
 	psize = vma_kernel_pagesize(vma);
-	porder = __ilog2(psize);
 
 	up_read(&current->mm->mmap_sem);
 
 	/* We can handle 4k, 64k or 16M pages in the VRMA */
-	err = -EINVAL;
-	if (!(psize == 0x1000 || psize == 0x10000 ||
-	      psize == 0x1000000))
-		goto out_srcu;
+	if (psize >= 0x1000000)
+		psize = 0x1000000;
+	else if (psize >= 0x10000)
+		psize = 0x10000;
+	else
+		psize = 0x1000;
+	porder = __ilog2(psize);
 
 	/* Update VRMASD field in the LPCR */
 	senc = slb_pgsize_encoding(psize);
