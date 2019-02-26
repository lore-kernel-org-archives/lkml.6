Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3861AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 04:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19BA21841
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 04:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Qzbe9C9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfBZEYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 23:24:25 -0500
Received: from ozlabs.org ([203.11.71.1]:46075 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfBZEYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 23:24:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 447m11105Vz9s9L;
        Tue, 26 Feb 2019 15:24:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551155061;
        bh=JRrW7srsccmisM2McWw6klmwzqYKrP4nWLiOlXoOtLE=;
        h=Date:From:To:Cc:Subject:From;
        b=Qzbe9C9m9uDmwPCTFuCqTmB2orDcr/w4mqBcFW5sMY0mrE+209/8lihiC3lt1B700
         /VrbkRMg2xtv69Rf1xIu1qN3az9dKtYO4q5/rBvUOVBzrQjDjhByiHQgIKuMbE1T26
         Gke18z5MwBR6bM+Rtu4fw0Hb4FDWHzoK5DS0SR1phmZRJZUWuz4dadq/TT42BIvlsx
         KSu/8TWeWtGMWISyBI3cu/hBYMZBXK0V4u8NDyvcRWkcZuFG8/0g97mTFJVoRlIqOZ
         JeUbM/VtcM46nVx3XPpsev4V1B8hWXujhrM5JzVTBxZdLa/E9VLcatoolgmK5o34k4
         0UWSV5si2hayQ==
Date:   Tue, 26 Feb 2019 15:24:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: linux-next: manual merge of the slave-dma tree with Linus' tree
Message-ID: <20190226152417.29e1f3ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/or3Yj8eI6cD4fmdn5sj9.mo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/or3Yj8eI6cD4fmdn5sj9.mo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vinod,

Today's linux-next merge of the slave-dma tree got a conflict in:

  drivers/dma/dmatest.c

between commit:

  6454368a804c ("dmaengine: dmatest: Abort test in case of mapping error")

from Linus' tree and commit:

  361deb7243d2 ("dmaengine: dmatest: wrap src & dst data into a struct")

from the slave-dma tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/dma/dmatest.c
index 6511928b4cdf,50221d467d86..000000000000
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@@ -708,12 -726,14 +726,12 @@@ static int dmatest_func(void *data
 =20
  			um->addr[i] =3D dma_map_page(dev->dev, pg, pg_off,
  						   um->len, DMA_TO_DEVICE);
- 			srcs[i] =3D um->addr[i] + src_off;
+ 			srcs[i] =3D um->addr[i] + src->off;
  			ret =3D dma_mapping_error(dev->dev, um->addr[i]);
  			if (ret) {
 -				dmaengine_unmap_put(um);
  				result("src mapping error", total_tests,
- 				       src_off, dst_off, len, ret);
+ 				       src->off, dst->off, len, ret);
 -				failed_tests++;
 -				continue;
 +				goto error_unmap_continue;
  			}
  			um->to_cnt++;
  		}
@@@ -728,9 -748,11 +746,9 @@@
  					       DMA_BIDIRECTIONAL);
  			ret =3D dma_mapping_error(dev->dev, dsts[i]);
  			if (ret) {
 -				dmaengine_unmap_put(um);
  				result("dst mapping error", total_tests,
- 				       src_off, dst_off, len, ret);
+ 				       src->off, dst->off, len, ret);
 -				failed_tests++;
 -				continue;
 +				goto error_unmap_continue;
  			}
  			um->bidi_cnt++;
  		}
@@@ -758,10 -780,12 +776,10 @@@
  		}
 =20
  		if (!tx) {
- 			result("prep error", total_tests, src_off,
- 			       dst_off, len, ret);
 -			dmaengine_unmap_put(um);
+ 			result("prep error", total_tests, src->off,
+ 			       dst->off, len, ret);
  			msleep(100);
 -			failed_tests++;
 -			continue;
 +			goto error_unmap_continue;
  		}
 =20
  		done->done =3D false;
@@@ -770,10 -794,12 +788,10 @@@
  		cookie =3D tx->tx_submit(tx);
 =20
  		if (dma_submit_error(cookie)) {
- 			result("submit error", total_tests, src_off,
- 			       dst_off, len, ret);
 -			dmaengine_unmap_put(um);
+ 			result("submit error", total_tests, src->off,
+ 			       dst->off, len, ret);
  			msleep(100);
 -			failed_tests++;
 -			continue;
 +			goto error_unmap_continue;
  		}
  		dma_async_issue_pending(chan);
 =20
@@@ -782,23 -808,25 +800,23 @@@
 =20
  		status =3D dma_async_is_tx_complete(chan, cookie, NULL, NULL);
 =20
 -		dmaengine_unmap_put(um);
 -
  		if (!done->done) {
- 			result("test timed out", total_tests, src_off, dst_off,
+ 			result("test timed out", total_tests, src->off, dst->off,
  			       len, 0);
 -			failed_tests++;
 -			continue;
 +			goto error_unmap_continue;
  		} else if (status !=3D DMA_COMPLETE) {
  			result(status =3D=3D DMA_ERROR ?
  			       "completion error status" :
- 			       "completion busy status", total_tests, src_off,
- 			       dst_off, len, ret);
+ 			       "completion busy status", total_tests, src->off,
+ 			       dst->off, len, ret);
 -			failed_tests++;
 -			continue;
 +			goto error_unmap_continue;
  		}
 =20
 +		dmaengine_unmap_put(um);
 +
  		if (params->noverify) {
- 			verbose_result("test passed", total_tests, src_off,
- 				       dst_off, len, 0);
+ 			verbose_result("test passed", total_tests, src->off,
+ 				       dst->off, len, 0);
  			continue;
  		}
 =20
@@@ -833,15 -861,9 +851,15 @@@
  			       len, error_count);
  			failed_tests++;
  		} else {
- 			verbose_result("test passed", total_tests, src_off,
- 				       dst_off, len, 0);
+ 			verbose_result("test passed", total_tests, src->off,
+ 				       dst->off, len, 0);
  		}
 +
 +		continue;
 +
 +error_unmap_continue:
 +		dmaengine_unmap_put(um);
 +		failed_tests++;
  	}
  	ktime =3D ktime_sub(ktime_get(), ktime);
  	ktime =3D ktime_sub(ktime, comparetime);

--Sig_/or3Yj8eI6cD4fmdn5sj9.mo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx0v3EACgkQAVBC80lX
0GzuVAf9HZmOLMLMwBBosxqdXQaqZ8obSDn4PUDPv7MebxfSJVVXSmrVCLAosFcJ
iasZTl5C9Ul7uPU7Zrt7ndbZsfnuLgHGhEywyQMSPvOW0xiknUoVGVReoZxtgUSN
oxwy7Tl26WhqjfR6Ph6rERoAXhh2EL7EghGxMHbkZ8fZLBWUm1Rav6G8olFzxJ4u
yA+hNVwht+AtdMZzg4ZPb4MKtw631qFa8opNyA4wx46bEY5cCkrY9o6SRoT6X0kN
sWdLAO+4zkHxLq9Ci7caAm50LCLBUeJx1LElUbHpTvdvuXuJm5vNbQgAj4S5ayUh
cy+gK5cWMy8m/hz3HldJULtZeONjpQ==
=vDkp
-----END PGP SIGNATURE-----

--Sig_/or3Yj8eI6cD4fmdn5sj9.mo--
