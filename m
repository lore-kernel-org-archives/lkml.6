Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010CCC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DEB2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="q0CQ6aDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DEB2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeI1GWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 02:22:35 -0400
Received: from ozlabs.org ([203.11.71.1]:34739 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbeI1GWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 02:22:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42LsKd1Hg4z9s3x;
        Fri, 28 Sep 2018 10:01:41 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538092901;
        bh=yyhhwUZtzW14RGF9ullIlt+mzm9C7Ziqc3k7vsqY4fo=;
        h=Date:From:To:Cc:Subject:From;
        b=q0CQ6aDNHcDVkB8CDZhFFHknd5cmidu6HmkWJYwLpjZKdeUhKNAG4DP1D9OMg9D9z
         GrxpuxFnKO01xUfmiwpNmKlGgdWZbXQXpzcF1vGsMNlW67D8iWt35O0Ac1DwiLzz1J
         ma6UFA+c0O7TmTicakz9RvdkUrWVaWnP3wh9PTjnxZfL+4dqXhcfob3ZAGfJ03DJdT
         J7FPSyVFJLO8XhJo0EZ3+T52CLUljUqO96ERxQJbaSFl7hu+bgmB2foVpgasoKn9Y7
         yUiU0YK29cNSYOGICCfRj56GTIfKvaLXFdEirDfey3FxjOsrvzyVaunkTGLZaM0OWO
         kG0Uhs8CZwvgQ==
Date:   Fri, 28 Sep 2018 10:01:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: linux-next: manual merge of the rdma tree with Linus' tree
Message-ID: <20180928100125.61d3e9b6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/H7eBr65DM_xMh3ydIUsjR_Y"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H7eBr65DM_xMh3ydIUsjR_Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rdma tree got a conflict in:

  drivers/infiniband/core/cache.c

between commit:

  5c5702e259dc ("RDMA/core: Set right entry state before releasing referenc=
e")

from Linus' tree and commit:

  43c7c851b9bc ("RDMA/core: Use dev_err/dbg/etc instead of pr_* + ibdev->na=
me")

from the rdma tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/infiniband/core/cache.c
index 3208ad6ad540,ebc64418d809..000000000000
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@@ -337,39 -335,6 +335,38 @@@ static int add_roce_gid(struct ib_gid_t
  	return 0;
  }
 =20
 +/**
 + * del_gid - Delete GID table entry
 + *
 + * @ib_dev:	IB device whose GID entry to be deleted
 + * @port:	Port number of the IB device
 + * @table:	GID table of the IB device for a port
 + * @ix:		GID entry index to delete
 + *
 + */
 +static void del_gid(struct ib_device *ib_dev, u8 port,
 +		    struct ib_gid_table *table, int ix)
 +{
 +	struct ib_gid_table_entry *entry;
 +
 +	lockdep_assert_held(&table->lock);
 +
- 	pr_debug("%s device=3D%s port=3D%d index=3D%d gid %pI6\n", __func__,
- 		 ib_dev->name, port, ix,
- 		 table->data_vec[ix]->attr.gid.raw);
++	dev_dbg(&ib_dev->dev, "%s port=3D%d index=3D%d gid %pI6\n", __func__, po=
rt,
++		ix, table->data_vec[ix]->attr.gid.raw);
 +
 +	write_lock_irq(&table->rwlock);
 +	entry =3D table->data_vec[ix];
 +	entry->state =3D GID_TABLE_ENTRY_PENDING_DEL;
 +	/*
 +	 * For non RoCE protocol, GID entry slot is ready to use.
 +	 */
 +	if (!rdma_protocol_roce(ib_dev, port))
 +		table->data_vec[ix] =3D NULL;
 +	write_unlock_irq(&table->rwlock);
 +
 +	put_gid_entry_locked(entry);
 +}
 +
  /**
   * add_modify_gid - Add or modify GID table entry
   *

--Sig_/H7eBr65DM_xMh3ydIUsjR_Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlutb1UACgkQAVBC80lX
0Gyh+QgAiWrgB9Q4RxX4q4SK3g+9/UzHcT/wXrHxYpfxKzTPRRAl8BMp+IeRtXI8
3MrQtx94DaVl6nYhT1b4VLKxf0dZaQrivI3Rbfw4IpeR2WfCs6mwK5KVEBoCFlMr
O+2ErFkqX+KP5zX0VYd/K8fSey8pu/kteiZmIZBTDfE8gwf0RNSzy+QsqdRghx0q
+WLaiKUQPXE+T+JYqNSqxEVivM0+JP3QIY85TDkizRCXteW3WGNw5kFmlWJ5HtbA
FnUq18k0O1osoTCSh3/Qywu1GfFAIOkPTOp6BVnODS6qB5ArNvwFBFoxLQgJTvMV
QGuXa+rt7+lqbNN4aDd/Pn2lyPPjmA==
=ba80
-----END PGP SIGNATURE-----

--Sig_/H7eBr65DM_xMh3ydIUsjR_Y--
