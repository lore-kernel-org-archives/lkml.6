Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A295C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B752220882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wovoEIIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B752220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeIMK5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 06:57:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeIMK5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 06:57:15 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D70E720861;
        Thu, 13 Sep 2018 05:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536817758;
        bh=KbtETZ11+nmo0wPC+IU9DvqxUaflT9wzKN34GPWH7ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wovoEIIQj751BM5xxGV0SauLOkWqlEJCRo7sJ+34oVT2gTEi1g1yDdc9lPxq7q2sM
         nA0lVA1It78z5y3RqVveLncXZ5P7fsBDtDQIGkcsFAbSSYJXuI8NKbFKTf0neLjD7y
         loc/tti3GOyd/Haro3VIXEyO+eVHpmEjvE/lhQKw=
Date:   Thu, 13 Sep 2018 08:49:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] ucma: fix a use-after-free in ucma_resolve_ip()
Message-ID: <20180913054915.GF5257@mtr-leonro.mtl.com>
References: <20180912232744.12693-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
In-Reply-To: <20180912232744.12693-1-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 12, 2018 at 04:27:44PM -0700, Cong Wang wrote:
> There is a race condition between ucma_close() and ucma_resolve_ip():
>
> CPU0				CPU1
> ucma_resolve_ip():		ucma_close():
>
> ctx = ucma_get_ctx(file, cmd.id);
>
>         list_for_each_entry_safe(ctx, tmp, &file->ctx_list, list) {
>                 mutex_lock(&mut);
>                 idr_remove(&ctx_idr, ctx->id);
>                 mutex_unlock(&mut);
> 		...
>                 mutex_lock(&mut);
>                 if (!ctx->closing) {
>                         mutex_unlock(&mut);
>                         rdma_destroy_id(ctx->cm_id);
> 		...
>                 ucma_free_ctx(ctx);
>
> ret = rdma_resolve_addr();
> ucma_put_ctx(ctx);
>
> Before idr_remove(), ucma_get_ctx() could still find the ctx
> and after rdma_destroy_id(), rdma_resolve_addr() may still
> access id_priv pointer. Also, ucma_put_ctx() may use ctx after
> ucma_free_ctx() too.
>
> ucma_close() should call ucma_put_ctx() too which tests the
> refcnt and waits for the last one releasing it. The similar
> pattern is already used by ucma_destroy_id().
>
> Reported-and-tested-by: syzbot+da2591e115d57a9cbb8b@syzkaller.appspotmail.com
> Reported-by: syzbot+cfe3c1e8ef634ba8964b@syzkaller.appspotmail.com
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  drivers/infiniband/core/ucma.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbmfpbAAoJEORje4g2clinQaUP/0d6dV3SRWyPjtGDleFGTWZG
xSFbQte4gMTtF2PODzDPFz8TsNinHYzq/8x7Vxpabx0h9eOPkJiIqp9Wo6oEaysm
XB63Pw6+3FPRJWpDJyy365N80cNb0TMSQGs1gtbduU+Gpa4x7UapF4swstpSxsrd
9+2pGr+OcrQhq6kVwVxxrUF9dEiHFXbaA1aUZvcA400ISTjfZYCpoprB39g3DtwQ
tmBKo6kaKjZaHSEE6Du18FwqTSYB2DU+MlsU5w3AJzEIGfj422dSMBwgeHz9KCJL
vSfdXXoj3Se02NuVD3ccaxkI+mabscOx/jPUkqRnd29Uc0Y8oJW9xvu63yy4NlX3
uCeoSmdpA2gmukIFSj0VUyxBIYlaLPjhpuzIg4H1YWl//OlFNHEle4b5JVeL7ley
lZzmLHY6aYHaat8lUtTZtoaIyam9o6tjgRheA4jK4QhLqdjtDptvJalI0QZWwY7c
tp0cMEnyNNNNGBV98fg/eXznXdozi/v77XML+i9YjvPWRsfuZECFwXKKt1YC9O2e
Fpsa5XBlYEc1/upWffiGhORLY5tbjYXDDlD8E6nWHRBG8wkBZUkBbNqLKtdISB+J
VccJI+9/O7TxW8XSXqLvBzq1VEH1f7K6po0X0wTK5qqdcKXFTs+YWxPl8XidgcXc
zgp5ff7BE5wDRapJJbYe
=iuSW
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
