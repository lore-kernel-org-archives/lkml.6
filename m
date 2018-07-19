Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFC5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125E820856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125E820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbeGSPTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:19:52 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:40128 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730899AbeGSPTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:19:52 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 60040413EB;
        Thu, 19 Jul 2018 16:36:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id XDiF46qDUI89; Thu, 19 Jul 2018 16:36:20 +0200 (CEST)
Date:   Thu, 19 Jul 2018 16:36:16 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Tyler Hicks <tyhicks@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        netdev@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH net-next v2 6/7] net: Create reusable function for
 getting ownership info of sysfs inodes
Message-ID: <20180719143616.GA29715@mailbox.org>
References: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
 <1531497949-1766-7-git-send-email-tyhicks@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <1531497949-1766-7-git-send-email-tyhicks@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 13, 2018 at 04:05:48PM +0000, Tyler Hicks wrote:
> Make net_ns_get_ownership() reusable by networking code outside of core.
> This is useful, for example, to allow bridge related sysfs files to be
> owned by container root.
>=20
> Add a function comment since this is a potentially dangerous function to
> use given the way that kobject_get_ownership() works by initializing uid
> and gid before calling .get_ownership().
>=20
> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
> ---
>  include/net/net_namespace.h |  7 +++++++
>  net/core/net-sysfs.c        | 15 ---------------
>  net/core/net_namespace.c    | 25 +++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 15 deletions(-)
>=20
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index a71264d75d7f..a257710527ce 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -170,6 +170,8 @@ extern struct net init_net;
>  struct net *copy_net_ns(unsigned long flags, struct user_namespace *user=
_ns,
>  			struct net *old_net);
> =20
> +void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t *gi=
d);
> +
>  void net_ns_barrier(void);
>  #else /* CONFIG_NET_NS */
>  #include <linux/sched.h>
> @@ -182,6 +184,11 @@ static inline struct net *copy_net_ns(unsigned long =
flags,
>  	return old_net;
>  }
> =20
> +static inline void net_ns_get_ownership(const struct net *net,
> +					kuid_t *uid, kgid_t *gid)
> +{
> +}
> +
>  static inline void net_ns_barrier(void) {}
>  #endif /* CONFIG_NET_NS */
> =20
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 41d84c40fe51..a3ad8108d296 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -656,21 +656,6 @@ static const struct attribute_group wireless_group =
=3D {
>  #define net_class_groups	NULL
>  #endif /* CONFIG_SYSFS */
> =20
> -static void net_ns_get_ownership(const struct net *net,
> -				 kuid_t *uid, kgid_t *gid)
> -{
> -	if (net) {
> -		kuid_t ns_root_uid =3D make_kuid(net->user_ns, 0);
> -		kgid_t ns_root_gid =3D make_kgid(net->user_ns, 0);
> -
> -		if (uid_valid(ns_root_uid))
> -			*uid =3D ns_root_uid;
> -
> -		if (gid_valid(ns_root_gid))
> -			*gid =3D ns_root_gid;
> -	}
> -}
> -
>  #ifdef CONFIG_SYSFS
>  #define to_rx_queue_attr(_attr) \
>  	container_of(_attr, struct rx_queue_attribute, attr)
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index a11e03f920d3..5257875fa84d 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -448,6 +448,31 @@ struct net *copy_net_ns(unsigned long flags,
>  	return net;
>  }
> =20
> +/**
> + * net_ns_get_ownership - get sysfs ownership data for @net
> + * @net: network namespace in question (can be NULL)
> + * @uid: kernel user ID for sysfs objects (must be GLOBAL_ROOT_UID)
> + * @gid: kernel group ID for sysfs objects (must be GLOBAL_ROOT_GID)
> + *
> + * Returns the uid/gid pair of root in the user namespace associated wit=
h the
> + * given network namespace. The caller must initialize @uid and @gid to
> + * GLOBAL_ROOT_UID/GLOBAL_ROOT_GID before calling this function.

If they must be so initialized why not just enforce this directly in the
function? This way callers can rely on always getting back the correct
permissions and the comment can be removed as well.

Christian

> + */
> +void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t *gi=
d)
> +{
> +	if (net) {
> +		kuid_t ns_root_uid =3D make_kuid(net->user_ns, 0);
> +		kgid_t ns_root_gid =3D make_kgid(net->user_ns, 0);
> +
> +		if (uid_valid(ns_root_uid))
> +			*uid =3D ns_root_uid;
> +
> +		if (gid_valid(ns_root_gid))
> +			*gid =3D ns_root_gid;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(net_ns_get_ownership);
> +
>  static void unhash_nsid(struct net *net, struct net *last)
>  {
>  	struct net *tmp;
> --=20
> 2.7.4
>=20
> _______________________________________________
> Containers mailing list
> Containers@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/containers

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7btrcuORLb1XUhEwjrBW1T7ssS0FAltQod4ACgkQjrBW1T7s
sS2uPhAAqn0X9OEVlw+nqjAGYf+tQur3pO1AfL2dC1aPMl7qe1iJ2aPUjdA+sdeC
ro2yibV11AXWBkwxBB/d2Djm9FmN2yObQEJJgRu70Lp+pWyij6GzWJSfP4yVZfs4
ltbtpbGlDb41j9gdKultK3XfMmcqf28GyOY8ekHbHQWvnw/Uu8mVIoI0AP7DEzlA
H1WuIyAsFdQVjxqGxDb74aEtVD/krRMgpopzvkOmx0rrRW0xciLFBfQ1sk6Y/Y6w
md5HxNo5Gn4hiv+UFQM6B7nrXpCaZQzAysWC+UxvFNuDz9QcLr4j/F1OaDOEbTB3
EDRhcQn+zB3+TAIsycFe7D7XJuuLXoloHDVK97wGureATf5/S2XLeyXM3b3kvErh
UivdKJ1k226t+aNzgUGfznyqdTBFDJRJOnUeqZMDwKBbdwHx+d8y3ZsZiUNm0Oqc
YVpY6JzTFEcRsJdBpqX5uJVefFMHVEPnGq07HbjXHzZezfzbn3ypY+DyrYaReE0m
8ZlOZadfBGshyBcAnnkkj5bWIkGomS0czy30OmBtoY0qzFatiIyxyJIUI/HpZC7f
v8LwRoyG26MLqP6nuIkM/KINkZ+Qk3vyBGnZYyQAWbIbcNtcYxoe6/Nbd2uKSjMU
l5lDlrqsfmzlnhes+e9dc3u82SganNGi9NrDLIKMckzhjz9/emI=
=HB6L
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
