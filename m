Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1F1C5C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C378A208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C378A208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932584AbeFLF0x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:26:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:47453 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932281AbeFLF0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:26:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9BD58AB43;
        Tue, 12 Jun 2018 05:26:51 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Date:   Tue, 12 Jun 2018 15:26:38 +1000
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Oleg Drokin <oleg.drokin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        James Simmons <jsimmons@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        lustre-devel@lists.lustre.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: lustre: add error handling for try_module_get
In-Reply-To: <1528778968-42225-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528778968-42225-1-git-send-email-jiazhouyang09@gmail.com>
Message-ID: <87y3fkinht.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12 2018, Zhouyang Jia wrote:

> When try_module_get fails, the lack of error-handling code may
> cause unexpected results.
>
> This patch adds error-handling code after calling try_module_get.
>
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c b/driver=
s/staging/lustre/lnet/klnds/socklnd/socklnd.c
> index 7086678..72a42bd 100644
> --- a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
> +++ b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
> @@ -2422,7 +2422,10 @@ ksocknal_base_startup(void)
>=20=20
>  	/* flag lists/ptrs/locks initialised */
>  	ksocknal_data.ksnd_init =3D SOCKNAL_INIT_DATA;
> -	try_module_get(THIS_MODULE);
> +	if (!try_module_get(THIS_MODULE)) {
> +		CERROR("%s: cannot get module\n", __func__);
> +		goto failed;
> +	}
>=20=20
>  	ksocknal_data.ksnd_sched_info =3D cfs_percpt_alloc(lnet_cpt_table(),
>  							 sizeof(*info));

Thanks for the patch....
I agree that this is probably a bug, but the code is still buggy after
you patch, just in a different way.
Try following through the code and see what happens when you 'goto
failed'.

NeilBrown



--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsfWY8ACgkQOeye3VZi
gblrxQ/+LaWJKrcgWws5nx3/4yrLdQiRrf/v4VTTxWb/54LKfpHAHMk7lVjujvrC
9ADyEsII3moabv8t/OQtyQZ0FGuH97x5WcwSLAMdfOjM//RzEJ0Iedwl9TxGjLnu
Kqm/G+d+tuP6Izt2Qqhx52nBuWsbkrTw3Lhu3a+Ym7dDQzbbcOF0E1ZMKKXAJgyn
zZwPqJlpz2fXvOVFuuRrgSi+mnwthPaW45ckgcO9zheV0qp11w21qHAR2akHpzdd
0aB91yJrrpeg2/OWqrQg0Pa28Vf8TPFcCzK8qqpjPPbsvmBr84yFeCIPXp5ySgH4
sWm5N+firleXsXc5dNCZ3a8uqCZ5vwxp1wNkLiBC0+lj0WFKvbUPqgJGfAxNHkrH
zu55MMklp+A4p/tL1Z5KtfhMkQBBNaCmCYjk4wryjXuLJ19EL+UxbrsT9Fvbj6eA
H6iy8lj99Pqo+DyjXvBtgff2wClyr63B0HtIl9/fg5wfDyULLuRFc85rUl4yEXHr
PBn9QFd9cN9csBDS7PUICmV3FU/OO9RpBLR1PFV+w2Zs8opjx7eLu9cVQ1+QziuZ
iUWCWsPglja6LlrxojdabcE5Szz4XRVkrdRwqNwMituSiQwSBr+LJPcErCFP6KFG
FEtEqiX/qzRMvhOMhNByKjKma30zf9XAHMqmAta4QAWK8EOdILo=
=2gRt
-----END PGP SIGNATURE-----
--=-=-=--
