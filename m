Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86AAC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F26620852
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DVfgvjbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F26620852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbeGZCKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:10:11 -0400
Received: from ozlabs.org ([203.11.71.1]:36227 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbeGZCKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:10:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41bYYj4zv6z9s0n;
        Thu, 26 Jul 2018 10:55:53 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532566554;
        bh=zX/Fs5u4KkkgpQxSzjYGHH14bklQ+Qt5jFAFVIu3iSU=;
        h=Date:From:To:Cc:Subject:From;
        b=DVfgvjbtLflxIJRncCJl/Vkto/6niReJ8r7ya1cHDwHsNThrfCX/u7+Ag+vOezTL4
         UoPR4n/oL6rStAUqYswU8cbTVv5cfdx5nwJqCNaeyOw8DR5zX0vGqgvj5gQG29sKBl
         YjQCjt0jB+L4e471/Qwn5iRg20oe+WpcnedzqtUBj5t0WQ5Bla5Xf2ZlTf+cZ+qZ4V
         PMe+4FXtAG7JKltlQqYqoWeY6RcTiZCMc4DQU2kBo59PE9Sv55EQaTwPKSCVKofFHV
         LA2XuNe15B4Ghw/jJcyussCfkeE4v27LbFxFOf8GPwyJc1+i77kRjof/a90K4mvzKc
         ThrP9A7NFKV/w==
Date:   Thu, 26 Jul 2018 10:55:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: linux-next: build warning after merge of the rdma tree
Message-ID: <20180726105553.00a36e3c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kuj+vr4/UE=Y1Siy_7uRzl7"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kuj+vr4/UE=Y1Siy_7uRzl7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rdma tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

net/sunrpc/xprtrdma/svc_rdma_rw.c: In function 'svc_rdma_post_chunk_ctxt':
net/sunrpc/xprtrdma/svc_rdma_rw.c:350:5: warning: 'bad_wr' may be used unin=
itialized in this function [-Wmaybe-uninitialized]
  if (bad_wr !=3D first_wr)
     ^

Introduced by commit

  ed288d74a9e5 ("net/xprtrdma: Simplify ib_post_(send|recv|srq_recv)() call=
s")

This is an actual problem.

--=20
Cheers,
Stephen Rothwell

--Sig_/kuj+vr4/UE=Y1Siy_7uRzl7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltZHBkACgkQAVBC80lX
0Gw3aAf+JV+KQnRo61WjzWgK6G6qAfhvv3nu/pYhyOS7muHcix6l0yao/T4gxIms
x5IpTsJx/WFgPFZd40cIbQFvqwJ7hOq6nlAV7juIv2cfSWqEHKvW9j107fMvjuoa
GhHSXJY5ZCBAGPEwFJyLtjPEippo4V7wF2lYcWt/454PLLEPj/omzzv4VPrAPMDM
xKD8ntfL3TZnfNPhQPwnvdL9kjyPOoxIIFS6zbmNL3wLTR6qwkCMhN7JYLbh7h8D
mN8QojWiJVifTng5BtgmV5jItYP+IZ6+aRdNXCxtOEznELBAwLKfrzDfhsiyDrnQ
tO6BfM/hiMdsQU05kv+WS/LTh58sFw==
=FzSB
-----END PGP SIGNATURE-----

--Sig_/kuj+vr4/UE=Y1Siy_7uRzl7--
