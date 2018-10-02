Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B10C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7106D20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Y8V37pac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7106D20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJBPf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:35:57 -0400
Received: from ozlabs.org ([203.11.71.1]:52847 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbeJBPf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:35:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42PXxg3Nzsz9sjD;
        Tue,  2 Oct 2018 18:53:43 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538470423;
        bh=I5PcSx0R2KIrk1s7yMxG4407y/cXKwqDkmEJftG8Lqw=;
        h=Date:From:To:Cc:Subject:From;
        b=Y8V37pacLulH0BYy0Jo4htXr/qhtEqMQLaN8JW/VKp7yHOUFtdfdKCUPftj5QKhuz
         vUu5b6jrWNALQISCWVQUCsN4bi8ZbIge9SWLaJYF+QATEdUEoa41QIFMYKMv3IrH3s
         d4SaA5W4Qx05Aue/PYRDdKIX3MAKSoiOfWgWVB81HLmruYL9qIVF8lzCzyz47yL/yy
         v9DpNAI2XR0HD/x8gkgy8QcimqcSA1ta9v5WhZwkLHcOB7e8BSl5mTe3FJKJkG0yDs
         5suYLUjmRB9cz6gmAZN/BnpEjkRXjkn2JZbjxHJIA9XlKty30BfQ8y2M6jGGn4gWaH
         hMvkRTh9j0e/Q==
Date:   Tue, 2 Oct 2018 18:53:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: linux-next: build failure after merge of the akpm tree
Message-ID: <20181002185342.133d1680@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XOzwBmrLsNAlV/2oQwUR6RP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XOzwBmrLsNAlV/2oQwUR6RP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm tree, today's linux-next build (x86_64 allnoconfig)
failed like this:


Caused by commit

  a20bb0583751 ("dma-direct: add an explicit dma_direct_get_required_mask")

from the dma-mappgin tree conflicting with patch

  "mm: remove include/linux/bootmem.h"

I have applied the following merge fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 2 Oct 2018 18:49:02 +1000
Subject: [PATCH] dma-direct: fix up for the removal of linux/bootmem.h

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 kernel/dma/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 170bd322a94a..5a0806b5351b 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -4,7 +4,7 @@
  *
  * DMA operations that map physical memory directly without using an IOMMU.
  */
-#include <linux/bootmem.h> /* for max_pfn */
+#include <linux/memblock.h> /* for max_pfn */
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/dma-direct.h>
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/XOzwBmrLsNAlV/2oQwUR6RP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluzMhYACgkQAVBC80lX
0GwaQggAoSKJfRTylU9H21au6O8T4j6ONyJpznVhZRteE3Gg7UOFI5EzfuGFt5kt
ZDOIAzP3OGWMAO7IZX9qHT/9XCltqNj8Xw2cwGIQQOuR04PfH2qUVHZXRgPmyZBC
G1unOGMYEE393Gp09ZbSgJbp5wE7DIkIcnvq79oBCiUVCdEJUOaWn5K+Jfx2EuKx
lGmuw5i9Yil3tZzA5g6AlqnHqejKX8L8gg5pBDUAzBkmqqhWjy0rH8qrR03J1YFb
QxjrWIQPELldt53gXmu3Rw34xe950Rr+gmmqED8+1t1MHOgQ1FtAz7HlBGMon59d
IRApuehGc1ddzC8RQxO+nZX8PgD4MA==
=xWa1
-----END PGP SIGNATURE-----

--Sig_/XOzwBmrLsNAlV/2oQwUR6RP--
