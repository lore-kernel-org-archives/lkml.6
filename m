Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADFEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2572082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="udl1i8o9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2572082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbeLCHBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:01:08 -0500
Received: from ozlabs.org ([203.11.71.1]:46475 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbeLCHBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:01:08 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 437bW22r3Hz9s7W;
        Mon,  3 Dec 2018 18:01:02 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543820462;
        bh=g33OozxkX9+wikUEnteWKjGmpFfYYarPZIru/ZqkXew=;
        h=Date:From:To:Cc:Subject:From;
        b=udl1i8o9fkGVQGdPzrRyE2IQ3axNqzPIHRee99aZT4q03UIy1pw1/VMSE1VChHWAL
         N6NwOXpXvK0v7H4ivSqxyjetV11zGzcjA3EfUTr//UBGUjQd1fgdoIVpGuvdsEDRQu
         BbfIdi7I83yBy24pvxox6McUOafnGUYxSnJ3Vg0ielg7EsDiIfxjg+kD61TXaLwXNv
         +r/hZteSu1W1/bJWH1x2M3vZddZTn4k5+22W2EA2JSVg6N6OL+nhRwcgwImAaAJle8
         /X4/GtGvt4XB0tOJADvjE53+45XBEP89DK+ZBseU8AzemBdxNO7oil0o0ii0U2IwUh
         TB6GBzgw/+54Q==
Date:   Mon, 3 Dec 2018 18:00:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: linux-next: build failure after merge of the akpm tree
Message-ID: <20181203180037.0a54279b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hcrQ6VYBsCI2iAv9yWDouQ/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hcrQ6VYBsCI2iAv9yWDouQ/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm tree, today's linux-next build (powerpc_le perf)
failed like this:

bench/numa.c:37:10: fatal error: linux/numa.h: No such file or directory
 #include <linux/numa.h>
          ^~~~~~~~~~~~~~

Caused by patches

  "mm: replace all open encodings for NUMA_NO_NODE"
  "mm-replace-all-open-encodings-for-numa_no_node-fix"

For linux/numa.h to be generally availble to the tools builds, it must
be copied into tools/include/linux ...

I have done that copy for today:

=46rom 6dabc11d5513510d0ec0a6b0a4aa8b9051b71516 Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 3 Dec 2018 17:57:27 +1100
Subject: [PATCH] linux/numa.h is now needed for the perf build

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 tools/include/linux/numa.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 tools/include/linux/numa.h

diff --git a/tools/include/linux/numa.h b/tools/include/linux/numa.h
new file mode 100644
index 000000000000..110b0e5d0fb0
--- /dev/null
+++ b/tools/include/linux/numa.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_NUMA_H
+#define _LINUX_NUMA_H
+
+
+#ifdef CONFIG_NODES_SHIFT
+#define NODES_SHIFT     CONFIG_NODES_SHIFT
+#else
+#define NODES_SHIFT     0
+#endif
+
+#define MAX_NUMNODES    (1 << NODES_SHIFT)
+
+#define	NUMA_NO_NODE	(-1)
+
+#endif /* _LINUX_NUMA_H */
--=20
2.19.1

--=20
Cheers,
Stephen Rothwell

--Sig_/hcrQ6VYBsCI2iAv9yWDouQ/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwE1JUACgkQAVBC80lX
0Gx3uwf/XtKl7r506aQV9Qv4NBzNtutKEKY4JSEbstSzqJHuC0w8ZztfXtk1VIuo
YYMk0m+HHxpjB7fysyspszX3YsQgY/mVyVup8sRF1kqwg4TSxjfNQOcRL2ntJuYu
w8uJKCuhSjBjNHS1GY5EZd1PT8DknHsmMwKJhMu5QKI7zxIrnoGaAd/TH7OpH83i
eCDFMZkjfOup29vpY27yRzSri21D46BOtmQKSrXFU2HC5w3P9JHQObKm4K3AiLzU
VFv7USgo5aq9DCx75/8Vpg/MXZ6583hBw94wkBT5wGfdwGaTcdUDfmPUTdsoNqeW
Y6D/tln0loDaK1PDjyisBmJmTM2xBQ==
=VCno
-----END PGP SIGNATURE-----

--Sig_/hcrQ6VYBsCI2iAv9yWDouQ/--
