Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF17C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 06:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAA9208A5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 06:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRSHlxnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAA9208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeGHG42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 02:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751648AbeGHG40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 02:56:26 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8A1C208A5;
        Sun,  8 Jul 2018 06:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531032986;
        bh=UVvt6RRIvTEYzHgb94c5XQK+inFGGGO3kfo5FsBIQKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LRSHlxnpAlkSojuY3RK/e85CT7ELmgN0CZQwnFLHdf+NFHCChlL+xSZx70ydsWOD0
         WbdBJ+gZ+HwDRO2XZgp/rDd/thU87u2jZCsa/7bvlHr1WILNoZBiPrgqX7YQg+EWTf
         SjtouH7x1H6xluTU0wQYc8W/3XFyOGGECRRF1iEg=
Date:   Sun, 8 Jul 2018 09:56:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] IB/mlx5: fix uaccess beyond "count" in debugfs
 read/write handlers
Message-ID: <20180708065623.GK3014@mtr-leonro.mtl.com>
References: <20180706204803.131152-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="olLTNZSltDMg5Vbm"
Content-Disposition: inline
In-Reply-To: <20180706204803.131152-1-jannh@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--olLTNZSltDMg5Vbm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 06, 2018 at 10:48:03PM +0200, Jann Horn wrote:
> In general, accessing userspace memory beyond the length of the supplied
> buffer in VFS read/write handlers can lead to both kernel memory corruption
> (via kernel_read()/kernel_write(), which can e.g. be triggered via
> sys_splice()) and privilege escalation inside userspace.
>
> In this case, the affected files are in debugfs (and should therefore only
> be accessible to root), and the read handlers check that *pos is zero
> (meaning that at least sys_splice() can't trigger kernel memory
> corruption). Because of the root requirement, this is not a security fix,
> but rather a cleanup.
>
> For the read handlers, fix it by using simple_read_from_buffer() instead of
> custom logic. Add min() calls to the write handlers.
>
> changed in v2:
>  - also fix write handlers

No changelog in commit messages, please

>
> Fixes: 4a2da0b8c078 ("IB/mlx5: Add debug control parameters for congestion control")
> Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  drivers/infiniband/hw/mlx5/cong.c |  9 +--------
>  drivers/infiniband/hw/mlx5/mr.c   | 32 ++++++++-----------------------
>  2 files changed, 9 insertions(+), 32 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

--olLTNZSltDMg5Vbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbQbWXAAoJEORje4g2clinPx8P/jNfA93fdBWfoorvH4XIZ2il
JSvBy/KhuY2DjlzWz+NQHmyYBlvFvd/zSz4AANYbsUOAdKwVsIqRqJE3JV2MjrpZ
pgaETsx+z4747a9m8OSBj63dhQ048GufMj7Ml9td5h5XK5ShzcfunanhNodJ5V+0
Rvo/4I4LVx6Yz8lVsPTUz+vRqpXh3zO8CQU4Xh4QzxUoN26ksCUJ/i53gtnvWXO/
ssg+9d1NxSVexJ6Eqg1nYOPqUk+mMMQ00ysUsKQGrrf4SfT1gDsbA3yLv4LkrLIe
kElL7FzuTRuWrvlHe5DH8CzBBBwFCkfzRBfZK4OXIbYiDxc1LL6jkWe+jULhjeBq
fOULh6m8QFdB2LBaZAvFcwhITVh+NxrZCC0PqgZ8lWvw8Fn/RAOWcsshe6nEstym
f0BKrQjp0iAxj8SxajVKsi9Fjhb4AnjAbq24ewsGEXwVe8x9INKkULOh0fMMEf2E
bKWTq+LCxFTPIRJ5+qry29Qezz/YA8YtuKKMGUeC6e5M365HXw47NYJrPEL1Liv2
/dpiv8nRsF3tKqG7UhpqRbCINaOqboEGjGR0bmx5JW9iIa3DDm+0CzOt9jUjicPb
/m9LsSyS2inI5ZZErxRXT92Yq9deiKX5OtyxpNwIEqftAGmSrtVY0cBhvBJTIU9h
17YwCVB4TagZ4k7woMhA
=Tw9m
-----END PGP SIGNATURE-----

--olLTNZSltDMg5Vbm--
