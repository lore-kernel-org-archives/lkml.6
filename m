Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25D1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 04:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE46B206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 04:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lodfTIzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfBKEXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 23:23:47 -0500
Received: from ozlabs.org ([203.11.71.1]:46649 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfBKEXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 23:23:47 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43yXj862v8z9s4Z;
        Mon, 11 Feb 2019 15:23:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549859023;
        bh=6tqzogE9lYrheKSWuXi4DSn+LtjJzLCkvoxQbPTazqM=;
        h=Date:From:To:Cc:Subject:From;
        b=lodfTIzmCnqefgykOb9+QRsMxr2pAsZPs9YidDNhhsf8D1m2cVSn62QvohLTjQgTq
         eqXMQqC9QQBjl1oabdOKaCtZsZdzS95n61dCiV6gOToIkZyeB1G0jtcEVqd7/rp4LS
         P2zOCAUKS/1EcAQOR9y4FrSJIGgp3kUqFIF/789IMtrh7hsPreF6NQ2p6KJRv6ckVm
         V3JNqQEL2I8zbOa71GHHhVKEme1KCUrIxE5kgjjEUn/9LDgA65JAsMOa9G+8SMYeOb
         ZbLfv7xSf0Of+7hshbdlthXfPUnBArwG4ztbQTWcOhNsTuHQClVUIeZ4UcnK3vm22F
         XF9H/7obz5K9Q==
Date:   Mon, 11 Feb 2019 15:23:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: linux-next: manual merge of the scsi-mkp tree with the block tree
Message-ID: <20190211152335.61592b65@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=aBZdlW0BRKNqwDjqEDaUDD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=aBZdlW0BRKNqwDjqEDaUDD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  include/linux/blkdev.h

between commit:

  eca7abf31abb ("block: queue flag cleanup")

from the block tree and commit:

  8b3238cabd50 ("scsi: block: remove bidi support")

from the scsi-mkp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/blkdev.h
index 3603270cb82d,21beb456b97a..000000000000
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@@ -572,33 -567,37 +567,32 @@@ struct request_queue=20
  	u64			write_hints[BLK_MAX_WRITE_HINTS];
  };
 =20
 -#define QUEUE_FLAG_STOPPED	1	/* queue is stopped */
 -#define QUEUE_FLAG_DYING	2	/* queue being torn down */
 -#define QUEUE_FLAG_NOMERGES     5	/* disable merge attempts */
 -#define QUEUE_FLAG_SAME_COMP	6	/* complete on same CPU-group */
 -#define QUEUE_FLAG_FAIL_IO	7	/* fake timeout */
 -#define QUEUE_FLAG_NONROT	9	/* non-rotational device (SSD) */
 -#define QUEUE_FLAG_VIRT        QUEUE_FLAG_NONROT /* paravirt device */
 -#define QUEUE_FLAG_IO_STAT     10	/* do disk/partitions IO accounting */
 -#define QUEUE_FLAG_DISCARD     11	/* supports DISCARD */
 -#define QUEUE_FLAG_NOXMERGES   12	/* No extended merges */
 -#define QUEUE_FLAG_ADD_RANDOM  13	/* Contributes to random pool */
 -#define QUEUE_FLAG_SECERASE    14	/* supports secure erase */
 -#define QUEUE_FLAG_SAME_FORCE  15	/* force complete on same CPU */
 -#define QUEUE_FLAG_DEAD        16	/* queue tear-down finished */
 -#define QUEUE_FLAG_INIT_DONE   17	/* queue is initialized */
 -#define QUEUE_FLAG_NO_SG_MERGE 18	/* don't attempt to merge SG segments*/
 -#define QUEUE_FLAG_POLL	       19	/* IO polling enabled if set */
 -#define QUEUE_FLAG_WC	       20	/* Write back caching */
 -#define QUEUE_FLAG_FUA	       21	/* device supports FUA writes */
 -#define QUEUE_FLAG_FLUSH_NQ    22	/* flush not queueuable */
 -#define QUEUE_FLAG_DAX         23	/* device supports DAX */
 -#define QUEUE_FLAG_STATS       24	/* track IO start and completion times =
*/
 -#define QUEUE_FLAG_POLL_STATS  25	/* collecting stats for hybrid polling =
*/
 -#define QUEUE_FLAG_REGISTERED  26	/* queue has been registered to a disk =
*/
 -#define QUEUE_FLAG_SCSI_PASSTHROUGH 27	/* queue supports SCSI commands */
 -#define QUEUE_FLAG_QUIESCED    28	/* queue has been quiesced */
 -#define QUEUE_FLAG_PCI_P2PDMA  29	/* device supports PCI p2p requests */
 -
 -#define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 -				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
 -				 (1 << QUEUE_FLAG_ADD_RANDOM))
 +#define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
 +#define QUEUE_FLAG_DYING	1	/* queue being torn down */
- #define QUEUE_FLAG_BIDI		2	/* queue supports bidi requests */
 +#define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
 +#define QUEUE_FLAG_SAME_COMP	4	/* complete on same CPU-group */
 +#define QUEUE_FLAG_FAIL_IO	5	/* fake timeout */
 +#define QUEUE_FLAG_NONROT	6	/* non-rotational device (SSD) */
 +#define QUEUE_FLAG_VIRT		QUEUE_FLAG_NONROT /* paravirt device */
 +#define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
 +#define QUEUE_FLAG_DISCARD	8	/* supports DISCARD */
 +#define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
 +#define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
 +#define QUEUE_FLAG_SECERASE	11	/* supports secure erase */
 +#define QUEUE_FLAG_SAME_FORCE	12	/* force complete on same CPU */
 +#define QUEUE_FLAG_DEAD		13	/* queue tear-down finished */
 +#define QUEUE_FLAG_INIT_DONE	14	/* queue is initialized */
 +#define QUEUE_FLAG_NO_SG_MERGE	15	/* don't attempt to merge SG segments*/
 +#define QUEUE_FLAG_POLL		16	/* IO polling enabled if set */
 +#define QUEUE_FLAG_WC		17	/* Write back caching */
 +#define QUEUE_FLAG_FUA		18	/* device supports FUA writes */
 +#define QUEUE_FLAG_DAX		19	/* device supports DAX */
 +#define QUEUE_FLAG_STATS	20	/* track IO start and completion times */
 +#define QUEUE_FLAG_POLL_STATS	21	/* collecting stats for hybrid polling */
 +#define QUEUE_FLAG_REGISTERED	22	/* queue has been registered to a disk */
 +#define QUEUE_FLAG_SCSI_PASSTHROUGH 23	/* queue supports SCSI commands */
 +#define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
 +#define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
 =20
  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
  				 (1 << QUEUE_FLAG_SAME_COMP))

--Sig_/=aBZdlW0BRKNqwDjqEDaUDD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxg+McACgkQAVBC80lX
0Gz5Cwf9EgtzLWrOcUaNyFGTXNyk/g947QOBj0XhtEVUiSeyuUJoojJl4Te2QKQV
OLC2DQ+yIYy5u6XZHsj0JH6mhgKPwP/jkiBlEaFaaCCo3yaJbECgMn56Xutzz1wH
JoV3aJECsZpAnNX8Q2HMVDFtGxbRHPacIJDBS5R+nevWQp0YouLRRoWEhFxo+mtE
ucsU/rL/BQ6QMHj9VMHo0s56QYj76tn4AgcsI/IbCINMCfShv6478gbtM8LZvj2v
BHRA6/laUKYpn8C4/wbEEMzhQKGHICuyTVuhRN6K/e9FF7zNiU7+NB8m2TT5tFwo
yHlJ0TsHsrW0UWMdCr3POFhG3pa0Qg==
=Hcgn
-----END PGP SIGNATURE-----

--Sig_/=aBZdlW0BRKNqwDjqEDaUDD--
