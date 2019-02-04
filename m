Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D45C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDCD2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277141;
	bh=q6ISU9kajM/9mLP+uLctL2/SvvPTvQs07iT6V8brb8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QaaModGWI6uC5M29ZTTVlKzUiuzgIn0Dy8tQBXRx+Uo4Udv7Z1g9B4l5sBty3LVyF
	 u1IMk82I2vUUfcpiUCNtaXtNnQlIKd8mmC2fu3OaxvvIv+bpfAotMMSrX50mb9/4qz
	 K4wvRtkjCbEwwMup1pBT5RSEAhSOiLedhISnathk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbfBDKpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:45:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbfBDKph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:45:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39F07217D6;
        Mon,  4 Feb 2019 10:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277136;
        bh=q6ISU9kajM/9mLP+uLctL2/SvvPTvQs07iT6V8brb8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLffwCTtN5WhW8hAR2F/iAgdm0+uELtLr4lOLVqsZ2IeFEFrHtL4tliS4eKBYQHw7
         wnksoBkeSQEzuZISa/jPSKVxkgpqqfxaXJbfk1S2sspPEGMRyFNkwKw5v+4krrAE94
         ZcF6wLjiqgklWbuA+DeKDNwBRC5goev5H7xZCKOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 34/46] IB/hfi1: Remove overly conservative VM_EXEC flag check
Date:   Mon,  4 Feb 2019 11:37:05 +0100
Message-Id: <20190204103614.667880698@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103608.651205056@linuxfoundation.org>
References: <20190204103608.651205056@linuxfoundation.org>
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

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

commit 7709b0dc265f28695487712c45f02bbd1f98415d upstream.

Applications that use the stack for execution purposes cause userspace PSM
jobs to fail during mmap().

Both Fortran (non-standard format parsing) and C (callback functions
located in the stack) applications can be written such that stack
execution is required. The linker notes this via the gnu_stack ELF flag.

This causes READ_IMPLIES_EXEC to be set which forces all PROT_READ mmaps
to have PROT_EXEC for the process.

Checking for VM_EXEC bit and failing the request with EPERM is overly
conservative and will break any PSM application using executable stacks.

Cc: <stable@vger.kernel.org> #v4.14+
Fixes: 12220267645c ("IB/hfi: Protect against writable mmap")
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/file_ops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -605,7 +605,7 @@ static int hfi1_file_mmap(struct file *f
 		vmf = 1;
 		break;
 	case STATUS:
-		if (flags & (unsigned long)(VM_WRITE | VM_EXEC)) {
+		if (flags & VM_WRITE) {
 			ret = -EPERM;
 			goto done;
 		}


