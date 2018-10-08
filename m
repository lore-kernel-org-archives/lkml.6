Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42982C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFAF20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tliDMcDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFAF20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeJIBp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:45:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbeJIBp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:45:58 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6363C20C0A;
        Mon,  8 Oct 2018 18:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023576;
        bh=OQoBZT+CKzHnDhp1MW+GUIWdvWHd10jeaH2tRHlEdGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tliDMcDb1mTR7i/UQOLHwRts0Jmr4WwYlpO0fj/12uVT6JDYzxB+h7wgR7ad2wQZJ
         BWriuzn/62UvZ5yzK82w6HCTb1hPZ/o3gxWHAyLcJ+QR1soQ59kQ78hdu6RfgLiOmm
         ExFHtyekbJaaofxlFp0NCh5Ba3CjSmZGSkWEGs0Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hari Bathini <hbathini@linux.ibm.com>,
        David Gibson <dgibson@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 013/113] powerpc/kdump: Handle crashkernel memory reservation failure
Date:   Mon,  8 Oct 2018 20:30:14 +0200
Message-Id: <20181008175531.514285154@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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


