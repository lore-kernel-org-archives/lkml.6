Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B87C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 04:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90970208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 04:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Df7iNtz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90970208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbeGKET6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 00:19:58 -0400
Received: from ozlabs.org ([203.11.71.1]:54989 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbeGKET6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 00:19:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41QQlP3Zthz9s01;
        Wed, 11 Jul 2018 14:17:37 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531282657;
        bh=Ryip7MfZN+HgAlkrVCX7JYi6YuBvz8Rr7q8qHhcDv9I=;
        h=Date:From:To:Cc:Subject:From;
        b=Df7iNtz03V1GWw7KbQj07SuOxtkSQ0UUFLr3dfpX6i6JxE4tU0zhlCpsEHqNofwV9
         1kvOWpc2cCUynNutIfXO3vqD5mHvzZoCflHf6tRJX50R6tB4XU4sQrvd9s3lQL3HaR
         EF2RNu4FG9pzltMMvxosBM2RdG6ezTM0pbtu2iQs6Q/sdwyP2nos/c2lE1gvCIpGbA
         aBQb1HcrQuW4B60i0t24Zka3WrwqSnGs5uEpeJiC60YxwPYXvZHknv67fI78qOux7E
         DHsnQbQihnEuFYhV0+kmHrMeinbs/k/yIt9a9c72zm6xacaZmn5J/2VFJq8tqkoqB1
         tWVB4ERH9bQMA==
Date:   Wed, 11 Jul 2018 14:17:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jth@kernel.org>
Subject: linux-next: build warning after merge of the scsi-mkp tree
Message-ID: <20180711141737.57c1e26f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/e/xJEvIszopWtj+VmLt.WxF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e/xJEvIszopWtj+VmLt.WxF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scsi-mkp tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

In file included from include/linux/spinlock_types.h:18:0,
                 from include/linux/spinlock.h:82,
                 from drivers/scsi/libfc/fc_rport.c:61:
drivers/scsi/libfc/fc_rport.c: In function 'fc_rport_recv_req':
include/linux/lockdep.h:347:45: warning: 'rdata' may be used uninitialized =
in this function [-Wmaybe-uninitialized]
 #define lockdep_is_held(lock)  lock_is_held(&(lock)->dep_map)
                                             ^
drivers/scsi/libfc/fc_rport.c:1832:24: note: 'rdata' was declared here
  struct fc_rport_priv *rdata;
                        ^~~~~

Introduced by commit

  ee35624e1e4e ("scsi: libfc: Add lockdep annotations")

It is actually complaining about function fc_rport_recv_plogi_req()
(presumably it is being inlined) and this looks like an actual bug :-(



--=20
Cheers,
Stephen Rothwell

--Sig_/e/xJEvIszopWtj+VmLt.WxF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltFhOEACgkQAVBC80lX
0Gw3VQf/bNqPyuTp71IwJs10OABVP4UC7BgpMgnR/RrIe903+Yz+YCcak8AXSAVZ
8klwOYkv3rpTYm8zboCEAeE9k8kqAxLP+QUi9PjAgcoAgozHuDU+Op1qbAzQW53t
Rye7vF+9QOhhA6uBbEFcoyeiK41wpFb5qWYqm04IUKJZOBeGZw3YKiPGdONW4FOa
FTz/LoOLtXvCRPxMogCy14iR9tb5hnNf9q1QhovxU8edw5TK2qEmz8i7SPRQ1Lo7
SIdU8gRwanHCd4LzMWZ8M6I5XTscjYc03F/fFL68gmSqb5laT2R0Wqd2S5WVD01Y
i4nlt7si/UgQj3WGF6MnGAeM4LnoVA==
=2iYZ
-----END PGP SIGNATURE-----

--Sig_/e/xJEvIszopWtj+VmLt.WxF--
