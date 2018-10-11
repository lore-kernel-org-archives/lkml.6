Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E900C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FD121470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSrbaPOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FD121470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbeJKXGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:06:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbeJKXGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:06:18 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E077213A2;
        Thu, 11 Oct 2018 15:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272315;
        bh=AHtaBdBa2vy0JQsd5lWKFZ6GwzqthADE/55kyfol1lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cSrbaPOsVlnDogf1rkSO6KLhOgE2ZJ0tn/MouH4BYhzqgpAWpTuis3yc0H2W1+dfT
         DmK7/EH7eX+hqnpOkfZTZUNtOrKApDC46nh8fmJdS3SMKnoVpd5CVrY2o644i6Hsbt
         mBm9OReKrl5kwmpOC3XkbxgqQzTCsWcNLbxtZjG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hari Bathini <hbathini@linux.ibm.com>,
        David Gibson <dgibson@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 026/120] powerpc/kdump: Handle crashkernel memory reservation failure
Date:   Thu, 11 Oct 2018 17:33:27 +0200
Message-Id: <20181011152550.721617557@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
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

From: Hari Bathini <hbathini@linux.ibm.com>

[ Upstream commit 8950329c4a64c6d3ca0bc34711a1afbd9ce05657 ]

Memory reservation for crashkernel could fail if there are holes around
kdump kernel offset (128M). Fail gracefully in such cases and print an
error message.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Tested-by: David Gibson <dgibson@redhat.com>
Reviewed-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/machine_kexec.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -186,7 +186,12 @@ void __init reserve_crashkernel(void)
 			(unsigned long)(crashk_res.start >> 20),
 			(unsigned long)(memblock_phys_mem_size() >> 20));
 
-	memblock_reserve(crashk_res.start, crash_size);
+	if (!memblock_is_region_memory(crashk_res.start, crash_size) ||
+	    memblock_reserve(crashk_res.start, crash_size)) {
+		pr_err("Failed to reserve memory for crashkernel!\n");
+		crashk_res.start = crashk_res.end = 0;
+		return;
+	}
 }
 
 int overlaps_crashkernel(unsigned long start, unsigned long size)


