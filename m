Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BD8A7C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1A4208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aor8shvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1A4208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeFNGIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:08:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751883AbeFNGIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:08:49 -0400
Received: from localhost (unknown [5.29.173.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82128208D7;
        Thu, 14 Jun 2018 06:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528956529;
        bh=UW95jnfFiyIlQz4p9zrw64pOKLcJY39aqynD9QK4XFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aor8shvKLvzHF503dTf5alGv7oBLl7Lx2Fq3H0MstCTSN/iq8PdZkJJnhHc1gZFJD
         5bPBXhoI8rPKuSD+zH8a572inByqsa/U9nulTLxV5zfgm4bXpexk1rRoxAlDV250jJ
         VW+Miu9mk0GXZeMPG4SzWgqQEi1+U4Rpnx90KKe0=
Date:   Thu, 14 Jun 2018 08:34:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH] infiniband: fix a subtle race condition
Message-ID: <20180614053446.GB18426@mtr-leonro.mtl.com>
References: <20180613234947.15767-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20180613234947.15767-1-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 13, 2018 at 04:49:47PM -0700, Cong Wang wrote:
> In ucma_event_handler() we lock the mutex like this:
>
> mutex_lock(&ctx->file->mut);
> ...
> mutex_unlock(&ctx->file->mut);
>
> which seems correct, but we could translate it into this:
>
> f = ctx->file;
> mutex_lock(&f->mut);
> ...
> f = ctx->file;
> mutex_unlock(&f->mut);
>
> as the compiler does. And, because ucma_event_handler() is
> called in a workqueue so it could race with ucma_migrate_id(),
> so the following race condition could happen:
>
> CPU0			CPU1
> f = ctx->file;
> 			ucma_lock_files(f, new_file);
> 			ctx->file = new_file
> 			ucma_lock_files(f, new_file);
> mutex_lock(&f->mut); // still the old file!
> ...
> f = ctx->file; // now the new one!!
> mutex_unlock(&f->mut); // unlock new file!
>
> Fix this by reading ctx->file once before mutex_lock(), so we
> won't unlock a different mutex any more.

Hi Cong,

If the compiler optimizes the first line (mutex_lock) as you wrote,
it will reuse "f" for the second line (mutex_unlock) too.

You need to ensure that ucma_modify_id() doesn't run in parallel to
anything that uses "ctx->file" directly and indirectly.

Thanks

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbIf52AAoJEORje4g2clingTYP/2XQ/+vf4MVPCPrygtLQtMMC
3Wl229zSPmitY7vcmOEDxZRmf+rKPsrAIvJzhTOFg7KI4JFEzu4xRTx4xSHafTsF
LNhO6uTqkbWYim06ORL2+YTwYQuR7bcvRA0CdO6bhWaPaMTDKcodwKzMfhFLh5ST
fQ+O224B5mKvfRGPE76JWHKrT97PqpXNLzwSVeva4xazRo0IOPJ3AQqHRGUoe8Nx
a9TY2/uY/qxvDUlTLayk1hFoTYyhGMURZfswGta+eQGhDxoFcIpOv0aI4GlbxVUY
TjQVXMd+TAngmhq85hFg6uhhQfFugnMiTWSVkbEiODUUNf/rG/O98T/zEph3SsEm
dolpvRjXYvzCE+zNpW47Bly6P5Ymgqkwnn9hgUs7tGWR8Ac7ghARv7DPXgUmccZh
hRi5XreJpBgVeVwmVi7PiCsbf5lRiYmVA4m97szuNfFXfoMa0LMBPpnd9+EVJiIg
M5m4jWcRxK1RHloaAQlO812a1VMDLmq1wsBHykSCH240paF1YKuokR6ifOQVjQNf
40mIUleXtuRE+d5qOVCC/x0qM/E1xHz0pVpdV9Wgr3wkoK9llnKSkmcCblU27Dlf
TujtZafMUCBU86QGlNoZMoxdRB6UCnioCH0l1J3eb6bFdS8Z/KIhwlRU5wjGhxru
Xk7aGdHsqg77fQ97OW/L
=SGVL
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
