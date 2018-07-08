Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441D8C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 06:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E344B208A5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 06:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sn4/uuAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E344B208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752853AbeGHGvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 02:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751648AbeGHGvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 02:51:17 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 376C4208A5;
        Sun,  8 Jul 2018 06:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531032676;
        bh=x4R9AN+V8goZU8komNzAET/r9HBxr4Ywx5zKjMiTMDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sn4/uuADnlFKkIDkQ60uH+LRE56vJRkNxpiiz1rtYu+M4giK+oCD/gJJj2M5NZOUK
         xt9ANXGhnb/m7O6o3L2aMIaGCXCp9Llrp2kD4Zx/VgEzuXHDd3oHe10L+kaF8c4tgL
         QITUOZK49LX5K+rPvlkqUq97X4T+sT57VaLCRkak=
Date:   Sun, 8 Jul 2018 09:51:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jann Horn <jannh@google.com>, Saeed Mahameed <saeedm@mellanox.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net/mlx5: fix uaccess beyond "count" in debugfs
 read/write handlers
Message-ID: <20180708065113.GJ3014@mtr-leonro.mtl.com>
References: <20180706201809.105152-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Do9hQ/bfCb4zBpLo"
Content-Disposition: inline
In-Reply-To: <20180706201809.105152-1-jannh@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Do9hQ/bfCb4zBpLo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 06, 2018 at 10:18:09PM +0200, Jann Horn wrote:
> In general, accessing userspace memory beyond the length of the supplied
> buffer in VFS read/write handlers can lead to both kernel memory corruption
> (via kernel_read()/kernel_write(), which can e.g. be triggered via
> sys_splice()) and privilege escalation inside userspace.
>
> In this case, the affected files are in debugfs (and should therefore only
> be accessible to root) and check that *pos is zero (which prevents the
> sys_splice() trick). Therefore, this is not a security fix, but rather a
> small cleanup.
>
> For the read handlers, fix it by using simple_read_from_buffer() instead of
> custom logic.
> For the write handler, add a check.
>
> changed in v2:
>  - also fix dbg_write()
>

Thanks Jann,

Next time, please don't put changelog in commit message.

Saeed, are you taking it to mlx5-next? It is cleanup and better to be
sent to -next.

> Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 28 +++++--------------
>  .../net/ethernet/mellanox/mlx5/core/debugfs.c | 22 ++-------------
>  2 files changed, 9 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

--Do9hQ/bfCb4zBpLo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbQbRhAAoJEORje4g2clinu1YP/AvI1s90yyjOwS/8ver6jaFc
7yPyBd1GBoUlRYWVf32siFaBwnPfPOS+pJtovsW66+Lxj0LqYniwPQ68GW8UkkGZ
tf9g8CvAm4mjAOgaJZiR3JB0kArvAeY2hRgyNu7iItp0AeL9WJH0RZONueBCCoqD
jTRW6oB1GsNnCfzbSnrt0ecQTVCidATIfmC5WsSImnkDgXBO4kLM7XZBbZvgmhIv
BoISxh8m7U7iGENTVpY9MdtrRTd7MbH+7eR6z0nGD6FeN/mjkAqjDGq1+Sr1bPBi
z/8Irbi6OXANufG8YNNoXeccoawAWYGpaZCc3VFpYYdrZgFuxnCdSAVXphDmf+6J
X+xeuhZpwjLbcXN6YwT5ZT4mPFDFdyB4o8sJFHrrPHPn0wxtILh0FP8c3H8mak+/
WinknsmOeJpw6pH1hAS3Tk7wRP+2SJ7M565o54G4wRmLxtUhaMG9a75VlzkCmgmP
hT60nwXZb8355FKZjQXZm+ELd2aHfOgIVcsNoA5Ly8h+Qhuch0AXP0eo3sv0qoGW
7Sstx8IbMM9FiMn6sT3I8/Rmcs7bfiXs1fHSC5wZC/cOUmBEhdcH+Oz97N8KDkKn
RdYWtOVnGlUc+DY/9WFtgEwN0m283iO4gAcsipa0vls9fRmP1rgMi0smieIrAsYD
A3GACI8rle0ItZ27XT/W
=mzoB
-----END PGP SIGNATURE-----

--Do9hQ/bfCb4zBpLo--
