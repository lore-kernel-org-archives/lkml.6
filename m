Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F610C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45D420659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AWbsrqSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfAOAyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:54:40 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:46383 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbfAOAyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:54:39 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2019 19:54:38 EST
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 09d0ecfe;
        Tue, 15 Jan 2019 00:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=672UyKEKNu6gN3BZ012tnuPoaAQ=; b=AWbsrqSCvzOY7MG+3xOi
        md7pIUY6hB1/IqC42IAqe3ZNlc8sd4Cmc4/B2Lef9bbxCxcYd+1O1YkZ47HWY12A
        JckiVlccXUGofm35pt77WA6GJOYiohKGyrebfioVF8IOcaUSyKm0F5Ntjfn0Fj+T
        EbRxLjjzpBallNOsMcTGKSyC6+fhe/FBgGpO/aZZHDFzunWRvjExLcf2/wcI5bc/
        AF31t9tknfqXXJfA983ptNX5uFHagE+fNi+0FJerYhnfs1MJJTfBw0dgw9ECdEeO
        XGZyGRNemGP7XTI0+q9PaZBWOeymNfZ4XaCjTYwTO6FB1iQF5KJKHAPKzD66UIdw
        9Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e163c3bc (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 15 Jan 2019 00:34:44 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] powerpc: PCI does not require PowerNV
Date:   Mon, 14 Jan 2019 16:47:45 -0800
Message-Id: <20190115004745.9996-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0e759bd75285 moved around the declaration of pnv_npu2_init, but
did not conditionalize it inside of the PCI pSeries driver. This meant
that CONFIG_PCI && CONFIG_PPC_PSERIES && !CONFIG_PPC_POWERNV resulted
in:

powerpc64le-pc-linux-gnu-ld: arch/powerpc/platforms/pseries/pci.o: in function `pSeries_final_fixup':
pci.c:(.init.text+0x1b0): undefined reference to `pnv_npu2_init'

This commit therefore wraps that line in an ifdef, so that PCI works
without PowerNV.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Fixes: 0e759bd75285 ("powerpc/powernv/npu: Move OPAL calls away from context manipulation")
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 7725825d887d..37a77e57893e 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -264,7 +264,9 @@ void __init pSeries_final_fixup(void)
 			if (!of_device_is_compatible(nvdn->parent,
 						"ibm,power9-npu"))
 				continue;
+#ifdef CONFIG_PPC_POWERNV
 			WARN_ON_ONCE(pnv_npu2_init(hose));
+#endif
 			break;
 		}
 	}
-- 
2.20.1

