Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AG47ELt0mprKkaSIJ7YW4SbpQtodaOfyunFLm5VbEEk1EXGx+th6F7/P7feglAKSip2R1Lh4HboZ
ARC-Seal: i=1; a=rsa-sha256; t=1520468353; cv=none;
        d=google.com; s=arc-20160816;
        b=Kc7IOgDdnXS9At4W/aR28Z7zY/Ut8687e6uTtZeILeSFvw2/e/c2rwf4O8/1e8rHkk
         fM7KfI1N8thliJzk+gYRHNPLBRxLtkxmXmlKd4S/MyTwJyir9+luwos0sOuVTzc1JVci
         J31uDrXJ4IzmwTHURquLCBt0LiECpUOYWVAejxq8qWFoFluEd5HSAQPTIEPt0aeu3kuX
         sAnS69P9QW0xYOhGfLUFagPO4w7M69UiwlH1OCOWeZ3sjP+QGaIIoAViS0ktWRJPH/gv
         ZkQ+X2B91G41QKo2GJ87VkgcNJbVb9HUbpoFDGCr+KADeRI99itzwHmMxuYrFzfcC5ja
         H6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=7R17IU1PzwQESfkQqnWbu9covVKyNQ1ktuvw+BQlpOA=;
        b=0okEyrfdPJpNCLl/WfbENNCMkG6dAlxvfU3qpvaigBQ/0rm90qj5jZkDdPLjfbsCG4
         utvgw0DRVykvo2k2Jcq0jDRVy1p/I0dKn0ugmvM+p8vFJFEFZZ9LzcWOXpVbyQaIWEnf
         AFjxOrF2PTqiaJAjnYrQojaK8YoIRMrLyEOjF6Fl0KUcXdxgMW++S08TnkioIaq1fV9L
         LhTBroBwNPNV4vWUfTSFsOoOYXbySbDSDkwNInXKtE5ghOyUqM+txKBtirNMxz+4wU/r
         dEUX7sxDO85Fs1DR1Q2Id5yME4NpGppsYIUQFvhNmDTdGWZa+u0DwcDaZYeHAewjWOdd
         2p+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,437,1515484800";
   d="scan'208";a="209703997"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 06/17] staging: lustre: get entropy from nid when nid
 set.
Thread-Topic: [PATCH 06/17] staging: lustre: get entropy from nid when nid
 set.
Thread-Index: AQHTsbWhejTdDYmLxEG1+FANzuvZH6PGCNGA
Date: Thu, 8 Mar 2018 00:19:04 +0000
Message-ID: <DADAE06F-9F73-4C2D-9995-AAD3ABB234CC@intel.com>
References: <151994679573.7628.1024109499321778846.stgit@noble>
 <151994708524.7628.17942703834112140684.stgit@noble>
In-Reply-To: <151994708524.7628.17942703834112140684.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.6.233]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C04174F11357F4B9571E604AB98B183@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780130364339190?=
X-GMAIL-MSGID: =?utf-8?q?1594326624236259967?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mar 1, 2018, at 16:31, NeilBrown <neilb@suse.com> wrote:
>=20
> When the 'lustre' module is loaded, it gets a list of
> net devices and uses the node ids to  add entropy
> to the prng.  This means that the network interfaces need
> to be configured before the module is loaded, which prevents
> the module from being compiled into a monolithic kernel.
>=20
> So move this entropy addition to the moment when
> the interface is imported to LNet and the node id is first known.

It took me a while to convince myself this is correct, but this is
moving the entropy addition earlier in the startup sequence, and
that is a good thing.  The important factor is to ensure that the
client UUID (generated at mount time) is unique across all clients,
and adding the node address to the entropy ensures this, even if many
thousands of identical diskless nodes boot and mount simultaneously.

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
> drivers/staging/lustre/lnet/lnet/api-ni.c     |    7 +++++++
> drivers/staging/lustre/lustre/llite/super25.c |   17 +----------------
> 2 files changed, 8 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/staging/lustre/lnet/lnet/api-ni.c b/drivers/staging/=
lustre/lnet/lnet/api-ni.c
> index 48d25ccadbb3..90266be0132d 100644
> --- a/drivers/staging/lustre/lnet/lnet/api-ni.c
> +++ b/drivers/staging/lustre/lnet/lnet/api-ni.c
> @@ -1214,6 +1214,7 @@ lnet_startup_lndni(struct lnet_ni *ni, struct lnet_=
ioctl_config_data *conf)
> 	struct lnet_lnd *lnd;
> 	struct lnet_tx_queue *tq;
> 	int i;
> +	u32 seed;
>=20
> 	lnd_type =3D LNET_NETTYP(LNET_NIDNET(ni->ni_nid));
>=20
> @@ -1352,6 +1353,12 @@ lnet_startup_lndni(struct lnet_ni *ni, struct lnet=
_ioctl_config_data *conf)
> 		tq->tq_credits =3D lnet_ni_tq_credits(ni);
> 	}
>=20
> +	/* Nodes with small feet have little entropy. The NID for this
> +	 * node gives the most entropy in the low bits.
> +	 */
> +	seed =3D LNET_NIDADDR(ni->ni_nid);
> +	add_device_randomness(&seed, sizeof(seed));
> +
> 	CDEBUG(D_LNI, "Added LNI %s [%d/%d/%d/%d]\n",
> 	       libcfs_nid2str(ni->ni_nid), ni->ni_peertxcredits,
> 	       lnet_ni_tq_credits(ni) * LNET_CPT_NUMBER,
> diff --git a/drivers/staging/lustre/lustre/llite/super25.c b/drivers/stag=
ing/lustre/lustre/llite/super25.c
> index 9b0bb3541a84..861e7a60f408 100644
> --- a/drivers/staging/lustre/lustre/llite/super25.c
> +++ b/drivers/staging/lustre/lustre/llite/super25.c
> @@ -85,8 +85,7 @@ MODULE_ALIAS_FS("lustre");
>=20
> static int __init lustre_init(void)
> {
> -	struct lnet_process_id lnet_id;
> -	int i, rc;
> +	int rc;
>=20
> 	BUILD_BUG_ON(sizeof(LUSTRE_VOLATILE_HDR) !=3D
> 		     LUSTRE_VOLATILE_HDR_LEN + 1);
> @@ -125,20 +124,6 @@ static int __init lustre_init(void)
> 		goto out_debugfs;
> 	}
>=20
> -	/* Nodes with small feet have little entropy. The NID for this
> -	 * node gives the most entropy in the low bits
> -	 */
> -	for (i =3D 0;; i++) {
> -		u32 seed;
> -
> -		if (LNetGetId(i, &lnet_id) =3D=3D -ENOENT)
> -			break;
> -		if (LNET_NETTYP(LNET_NIDNET(lnet_id.nid)) !=3D LOLND) {
> -			 seed =3D LNET_NIDADDR(lnet_id.nid);
> -			 add_device_randomness(&seed, sizeof(seed));
> -		}
> -	}
> -
> 	rc =3D vvp_global_init();
> 	if (rc !=3D 0)
> 		goto out_sysfs;
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
