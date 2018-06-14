Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 873C5C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA03208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SS6aZKjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA03208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754686AbeFNHBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:01:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752874AbeFNHBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:01:13 -0400
Received: from localhost (unknown [5.29.173.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3000208D7;
        Thu, 14 Jun 2018 07:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528959673;
        bh=9/cj0/b+VI5khug+NgHRh0JUxTC/9pX1LS6mpSrYDUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SS6aZKjOfn7fltTqP4BfKb1rJFWKcDwVr4dD56o43rpG5sEdl/FKS3oJzVVQ0rlCN
         kbOAdY5A7T5gaxPBRBddde7RLKr6Ft2x4xgnYTigV4TOZsIBe+Kq1GyyI43x2D8Sk0
         nFysGe3mafQiD8ou31GmzUTsPVe+m+G+8+kph3Ck=
Date:   Thu, 14 Jun 2018 10:01:08 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH] infiniband: fix a subtle race condition
Message-ID: <20180614070108.GD18426@mtr-leonro.mtl.com>
References: <20180613234947.15767-1-xiyou.wangcong@gmail.com>
 <20180614053446.GB18426@mtr-leonro.mtl.com>
 <CAM_iQpXxHk+yFqqK-Hezsc83_mKfbUXr4=jjNnik5DwGscRKUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <CAM_iQpXxHk+yFqqK-Hezsc83_mKfbUXr4=jjNnik5DwGscRKUA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 13, 2018 at 11:21:54PM -0700, Cong Wang wrote:
> On Wed, Jun 13, 2018 at 10:34 PM, Leon Romanovsky <leon@kernel.org> wrote:
> >
> > Hi Cong,
> >
> > If the compiler optimizes the first line (mutex_lock) as you wrote,
> > it will reuse "f" for the second line (mutex_unlock) too.
>
> Nope, check the assembly if you don't trust me, at least
> my compiler always fetches ctx->file without this patch.
>
> I can show you the assembly code tomorrow (too late to
> access my dev machine now).

I trust you, so don't need to check it however wanted to emphasize
that your solution is compiler specific and not universally true.

>
>
> >
> > You need to ensure that ucma_modify_id() doesn't run in parallel to
> > anything that uses "ctx->file" directly and indirectly.
> >
>
> Talk is easy, show me the code. :) I knew there is probably
> some other race with this code even after my patch, possibly with
> ->close() for example, but for this specific unlock warning, this patch
> is sufficient. I can't solve all the races in one patch.

We do prefer complete solution once the problem is fully understood.

It looks like you are one step away from final patch. It will be conversion
of mutex to be rwlock and separating between read (almost in all places)
and write (in ucma_migrate_id) paths.

Thanks

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbIhK0AAoJEORje4g2clinx5oP/0BVRmUMfmFD+SovKh+/vvi9
fk+FWjWpKcGGgZdEXz44R3L9FEgdl8V+Uwaz6wr9RO87dJ0VDagPYEjvJD6QjfVv
alaDwWU4q+8FKHbUJ66uvKNXKyyDcD1hiaa+dU03oJ6t4oieefotHBtGnhAWfPO8
IsTClsJy3+Kfd902sn4w0ReIcqqTXo6+nhHUEjdCf+JTglIln9qeiDbI/hgZZvw4
Xmsk8aMq3p53s+YE/f2G5XHY9d2viDxN0DOIMTUPHqkWNy8rmYWVKYGKafP/Fl4p
fx71vRVkTmDMGFiyne9iNuiQWGzQBLZaChdKQpurwoIGMUUbJwno9ZA8AUEEFv1D
QIiTt9lo5ZAvirgAOXjDDiU0D1f8FId0WrA5a0UFmsi5UdIgnTv+lWv6EvZjpOn/
1Zb4QYNzTfGqne4NhSdyADYkw+AKCbwpLSwzloU0azwdKrtwavJIqiUGQAaeL7mk
16wNQl+bxBJiGXNMBtYLobc3YudBo3vHsaOB1o4fGhJSxL9jdha0a3i+M9yt7bke
7iBGE3ryzgl1ceKfjIfrA+GPWpBGKmeK2O3OUinIs2xsM3J2P6xi68BbVJm3apZj
1o4yGQkU8K0m/7XA28tLaPoxRoX/9QSTB3/AonM5zUoNhZfPAQgZCaFek9Sq/dx5
PqrswsswWqT/jd3zsTtC
=jfYX
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
