Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505CFC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0555F2089A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rRjbeuc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0555F2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbeG0LyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:54:22 -0400
Received: from ozlabs.org ([203.11.71.1]:45931 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730120AbeG0LyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:54:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41cQK90PQKz9ryl;
        Fri, 27 Jul 2018 20:33:00 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532687581;
        bh=NKvtKn/HmsiJzkxMQ8YkE4p7Fbl7qV/P/5hzf+dEy9Q=;
        h=Date:From:To:Cc:Subject:From;
        b=rRjbeuc/q5h43a03+SjaYQIe5Rzv+vrtwD1VXHtz9oT5FzWSvSTY1XETtLjx9m/jb
         wnMCPg37TjuAsRjeHVpk7/5fq2ZDDEpeLJiZX1DiwtVqqPzVP1SxvuLjtcmAF3HTbA
         V9KR0akTvaW6gu4w/2Luo2yBeTu7IUSCYR0v7scl6dloL5/0SKpdtbfLAtO0JzNptT
         /JPofopSbyRuOkY0OU7X2lYyfJx+CQhCCjp0kwaRENjtw12fgXswhCbZ4YhOj+VuU8
         M1jyKLFa5iG1seW7x2AZr8VAyN8Awv13w0NxsrOb1ke4j14hgb+fyD6+AuB4Xl/iEP
         PGpbx2m4HUHlA==
Date:   Fri, 27 Jul 2018 20:32:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20180727203259.4ec64ff9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_dv99.1=q0ScTF2sy9Kfpqg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_dv99.1=q0ScTF2sy9Kfpqg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (powerpc
allyesconfig) failed like this:

hns_roce_hw_v1.c:(.text.hns_roce_v1_reset+0x8c): undefined reference to `.h=
ns_dsaf_roce_reset'
hns_roce_hw_v1.c:(.text.hns_roce_v1_reset+0xdc): undefined reference to `.h=
ns_dsaf_roce_reset'

Caused by commit

  336a443bd9dd ("net: hns: Make many functions static")

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 27 Jul 2018 20:23:20 +1000
Subject: [PATCH] net: hns: make hns_dsaf_roce_reset() not static

This function is declared in a header file and used in a different
source file.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/n=
et/ethernet/hisilicon/hns/hns_dsaf_main.c
index 7afc67510569..619e6ce465c2 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -2836,7 +2836,7 @@ module_platform_driver(g_dsaf_driver);
  * @enable: false - request reset , true - drop reset
  * retuen 0 - success , negative -fail
  */
-static int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool der=
eset)
+int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset)
 {
 	struct dsaf_device *dsaf_dev;
 	struct platform_device *pdev;
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/_dv99.1=q0ScTF2sy9Kfpqg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlta9NsACgkQAVBC80lX
0Gxs5wf/RxhT5fX7lxBv6bFcZH2Phg0/M46YKesxtc7K8s1PNmm7WsncqKdGIZRC
hxo/wfO8cYa2U28jTwZ118kFJbMEP6ULmX1M9G59nXRmYwiePOAW5nJVATZ7N5Ef
zCyNMMhER7bQ0zX4sYXVzHJMM2otUnaU1PcxWXgeeWsgwWHtwQbeqZ1fqSB58jsc
0rqPOEzduyGBjoq/EQv7NvvV/wkC10Wa8xgKI8E8WIANUeyEmHXdNw7RtRTA88Em
mzTWls7FK/LGWreIDAwN9YlyG5fsshfxUNimMIc/RxKDBTBcQF1AYxxMQ6oOfy3H
QDpQzA3tOzS98oLNq9fXxOanzQOl0A==
=ZvRv
-----END PGP SIGNATURE-----

--Sig_/_dv99.1=q0ScTF2sy9Kfpqg--
