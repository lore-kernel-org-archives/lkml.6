Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AA7C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CBA223E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FI5uKq80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CBA223E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeHJJEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:04:41 -0400
Received: from ozlabs.org ([203.11.71.1]:57475 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725746AbeHJJEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:04:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41mwPS4L0xz9s8k;
        Fri, 10 Aug 2018 16:36:12 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533882972;
        bh=4NKauE2pbpCvqq3RL76e3sEUx7gsCgnH6q56h/FWtAE=;
        h=Date:From:To:Cc:Subject:From;
        b=FI5uKq80PSy2l21icjSq1icigON8SnoJhUtiZrgUfpXY4T49cTP4b5TYmXm0Gt0bN
         RY//k9mhhWkzJuo/cBKXaMEo9sfCcyPg/1qCkHu53WwI7Ks4EfadXOj3m6gCSgxLt+
         jN9jSb4yDMT7SwZJmVQtwJRpGABW7nFJ7jZ75N4l+3Ak1b7FbQ1Y1/4jReWb1dkNse
         db9jLwRquNqs3IikFyDzX5q84CnyggCSbc9GWTbLVD6g0b0Ut1w211OWiVWRPooJB8
         uV6SCZcl5WfsRWmVP540tfWcwNATYOB+q3d+qJ+1c3A5a1P5u1iKWw0cJaxeNFEySZ
         vazvzWdYj9low==
Date:   Fri, 10 Aug 2018 16:36:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Christie <mchristi@redhat.com>
Subject: linux-next: build failure after merge of the ida tree
Message-ID: <20180810163612.39c88e1e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ki8R8ftO+7xfF_spdjNocgV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ki8R8ftO+7xfF_spdjNocgV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

After merging the ida tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/target/iscsi/iscsi_target_login.c: In function 'iscsi_login_zero_ts=
ih_s1':
drivers/target/iscsi/iscsi_target_login.c:376:16: error: 'sess_idr_lock' un=
declared (first use in this function); did you mean 'auth_id_lock'?
  spin_lock_bh(&sess_idr_lock);
                ^~~~~~~~~~~~~
                auth_id_lock
drivers/target/iscsi/iscsi_target_login.c:376:16: note: each undeclared ide=
ntifier is reported only once for each function it appears in
drivers/target/iscsi/iscsi_target_login.c:377:14: error: 'sess_idr' undecla=
red (first use in this function); did you mean 'sess_ida'?
  idr_remove(&sess_idr, sess->session_index);
              ^~~~~~~~
              sess_ida

Caused by commit

  9cd88edeaa9d ("target/iscsi: Allocate session IDs from an IDA")

interacting with commit

  ad86353cbddb ("iscsi target: fix session creation failure handling")

I have reverted commit 9cd88edeaa9d for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/ki8R8ftO+7xfF_spdjNocgV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlttMlwACgkQAVBC80lX
0GwszAf+PsflRtk5GYQPCcOOFQ48Eh/XGIjtacOmVqMFf9u2AYe4FALfC6NqlXvG
oTL89OaQKAiGtyq5EQ5xNJvQKfSwG6hGrBJ9jSsD4UNYza+egUN3FvpgdpoxVH5Q
d0TbPcPHBCfJ7/Tta3/wuBkOj6zxKEu6NK2yISbtqMNMecdmf3/yr1tDenO6X0JN
9zEZL0cy62wNZ2+PrYZp7Hj4HZ/Aeo3N+jJaTO0vBYUasq40uG3FQDv6Jg0Qjfe2
n43srCfRK0SqlyLN+Yp30l3Ahc8l9hQxNTIY/xD78FQ6SwN3UC+ZyFsAZJ2xZcm2
INLVRb9feAr9kqWyJNbmM7LXZl76ZA==
=f9F1
-----END PGP SIGNATURE-----

--Sig_/ki8R8ftO+7xfF_spdjNocgV--
