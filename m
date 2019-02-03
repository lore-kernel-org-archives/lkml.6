Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAF5C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F9A2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfBCOVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:21:38 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55864 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730566AbfBCOVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:34 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIeL-0006SH-JX; Sun, 03 Feb 2019 14:21:33 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9V-0006ru-NU; Sun, 03 Feb 2019 14:49:41 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.242444305@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 059/305] powerpc/pseries: Fix DTL buffer registration
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

commit db787af1b8a6b4be428ee2ea7d409dafcaa4a43c upstream.

When CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set, we register the DTL
buffer for a cpu when the associated file under powerpc/dtl in debugfs
is opened. When doing so, we need to set the size of the buffer being
registered in the second u32 word of the buffer. This needs to be in big
endian, but we are not doing the conversion resulting in the below error
showing up in dmesg:

	dtl_start: DTL registration for cpu 0 (hw 0) failed with -4

Fix this in the obvious manner.

Fixes: 7c105b63bd98 ("powerpc: Add CONFIG_CPU_LITTLE_ENDIAN kernel config option.")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/platforms/pseries/dtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -149,7 +149,7 @@ static int dtl_start(struct dtl *dtl)
 
 	/* Register our dtl buffer with the hypervisor. The HV expects the
 	 * buffer size to be passed in the second word of the buffer */
-	((u32 *)dtl->buf)[1] = DISPATCH_LOG_BYTES;
+	((u32 *)dtl->buf)[1] = cpu_to_be32(DISPATCH_LOG_BYTES);
 
 	hwcpu = get_hard_smp_processor_id(dtl->cpu);
 	addr = __pa(dtl->buf);

