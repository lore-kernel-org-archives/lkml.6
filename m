Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F0BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFCE2146F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FNmvMj97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFCE2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbeHBKVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:21:21 -0400
Received: from ozlabs.org ([203.11.71.1]:56577 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbeHBKVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:21:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41h3Kr2KkPz9s3q;
        Thu,  2 Aug 2018 18:31:12 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533198673;
        bh=Km7JIRWzx4NLTjo9U0B28/CFvE7+2t/hUp4CUBAZ/vU=;
        h=Date:From:To:Cc:Subject:From;
        b=FNmvMj97Qqi5HG7XvHX768P93W/xpfPFKBSR4MGoOwnThZDjHcht/n9wv588gkH/O
         nEvQPX76x/CwKUzTNxtsEam6pntIeMFi/sJQO/h3ejZak6zZ4b8+YYJxryK8ikr2Ym
         HcjiJ62hJWKEXiVv9UiF3TxxV2IJ8SAGNyLVa/TbY3X5ZFGWiBeuQcDzHZnqfojyQe
         n8li+0ywOl8TIBLeJnI4erDxUGw/p44SUR4IjMtFcgcuWRNA+nrF6X5R2RC8ZGU1Fz
         JXisZlp7rT5A5A8qIyO/5iMEgDhhPx8Vt9w/+Pzn57kboO7Pdxye61Ctmng7nwSYss
         akScjtlgZs/IQ==
Date:   Thu, 2 Aug 2018 18:31:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: linux-next: manual merge of the akpm-current tree with the block
 tree
Message-ID: <20180802183110.1e1ad25b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bf0ktMUeT2FxtmdDwzJUNjv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bf0ktMUeT2FxtmdDwzJUNjv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  kernel/fork.c

between commit:

  2c323017e381 ("blk-cgroup: clear the throttle queue on fork")

from the block tree and commit:

  f3ed47469a7b ("fs: fsnotify: account fsnotify metadata to kmemcg")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/fork.c
index f54c49573139,3913dd898bd4..000000000000
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@@ -867,11 -867,9 +868,14 @@@ static struct task_struct *dup_task_str
  	tsk->fail_nth =3D 0;
  #endif
 =20
 +#ifdef CONFIG_BLK_CGROUP
 +	tsk->throttle_queue =3D NULL;
 +	tsk->use_memdelay =3D 0;
 +#endif
 +
+ #ifdef CONFIG_MEMCG
+ 	tsk->active_memcg =3D NULL;
+ #endif
  	return tsk;
 =20
  free_stack:

--Sig_/bf0ktMUeT2FxtmdDwzJUNjv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltiwU4ACgkQAVBC80lX
0GxH4Qf/cDtoOJbO6LJh1UVykrbIq2Qol0uQoLPQxf/frn+o0WqJFyqf3omyjETq
VjSS9s5wRUFIifIvztNvog6SbbwxH2VS5JgQlaVP6Nr1GpNXJMAJx795vslncC0l
RneBIdbvrVI4jIFdkmk6AV6nEbeJrGA1MH/Qm8t3RI4ZJuC4QE2aAOSvNLVJldXT
2+9rcFryNRh4p3Xnf50tsiQAGhxs2bnUCln6aelP/nyTBnRymiviZZ2QdGHP3lhy
Xf3/YiVabdwsU8u2DuTYGv6ctbi7q9bJtVpmru84chg31T61YgDUdMrUnQ+Fbc++
7Ggh0FEGXgl6jH0nx8wnpvJVWeQpSg==
=558s
-----END PGP SIGNATURE-----

--Sig_/bf0ktMUeT2FxtmdDwzJUNjv--
