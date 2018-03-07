Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AG47ELuuBrDrIglXeAtMfBacesS5knN1RJ2YUY1LCw4afKKdKtRUHGP16tfpP8E3hKYHJTcIAKXf
ARC-Seal: i=1; a=rsa-sha256; t=1520455745; cv=none;
        d=google.com; s=arc-20160816;
        b=PSQyuPEGHkN9SgzkiFupDdzf8BMeAZkqZTCRvm7e5EB4YBj2RHrmiulkM4RAI7WZUy
         9IfKxpFlfU5yujP7+dzphz3VjqwGPxAShfgCjBfnMtcweyoJGEraq5HoAvOwtf1WmA3U
         /6xmuLMD4mjiLMb5x94W4xvrAmdowcDn2hamXIAZ2zfZJTrUKmu2i7vNzMHtu3UXEDfQ
         VFHBNje0lsL4Icf4SjXjObPQbHmtJNPbF/cVTqw3ipqMxaT/34Z1G53/nWcbgCVvTbdB
         3MTUhvtE8WNSTt31YNNiUZmOiB4YAP75n2mYOaITOlGbEyZqjqXS0mxSNg+5olPGexLt
         yw7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=TESclTA7mRE6OwyIj43qSDc3qNW7TPwKKYp0A5sVfpI=;
        b=Uwplrtg2Wa0NgQ+eq9djJth1I7ZvhA9exo0FHaXFmWtItPL2GWR3Dsrm1pqHAB/sbg
         KtKC6adn3BoF5ZtoeGSWKYIyA+E45cRVICl8tuQIO0yZNSI41DKbMbp/R7D/bEKnkqIu
         QYPyRAv11mvneF9M7oSmY0OEeZ3nNO6slWIFK4GXEKb9kw5VcRZxPAOR1ihPZp0Yu2MF
         lCzhKeXkngpVZVPRLgFZMyY30b2zzrqiGsxllPAqrv7kW8q11RKDXDJA2MDN3Ji9BCdO
         RUUE9buLizzA7Jo5r4uiPMLEwI4a21X5Yee/sTI/K1ebpF5HsomZFyhRa7XCcB7NwpAY
         wHRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,437,1515484800";
   d="scan'208";a="26085698"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 01/17] staging: lustre: obd_mount: use correct niduuid
 suffix.
Thread-Topic: [PATCH 01/17] staging: lustre: obd_mount: use correct niduuid
 suffix.
Thread-Index: AQHTsbWTgrGGbDRuDketpUA6hpf1WqPFziMA
Date: Wed, 7 Mar 2018 20:49:03 +0000
Message-ID: <4F9BD297-F7B5-4F10-B700-2806FAEA9359@intel.com>
References: <151994679573.7628.1024109499321778846.stgit@noble>
 <151994708505.7628.14486515694497834046.stgit@noble>
In-Reply-To: <151994708505.7628.14486515694497834046.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.6.233]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A7E2836C105BE44796400CD025D4E4CC@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780092789969683?=
X-GMAIL-MSGID: =?utf-8?q?1594313403472182281?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mar 1, 2018, at 16:31, NeilBrown <neilb@suse.com> wrote:
>=20
> Commit 4f016420d368 ("Staging: lustre: obdclass: Use kasprintf") moved
> some sprintf() calls earlier in the code to combine them with
> memory allocation and create kasprintf() calls.
>=20
> In one case, this code movement moved the sprintf to a location where the
> values being formatter were different.
> In particular
>       sprintf(niduuid, "%s_%x", mgcname, i);
> was move from *after* the line
>        i =3D 0;
> to a location where the value of 'i' was at least 1.
>=20
> This cause the wrong name to be formatted, and triggers
>=20
>       CERROR("del MDC UUID %s failed: rc =3D %d\n",
>              niduuid, rc);
>=20
> at unmount time.
>=20
> So use '0' instead of 'i'.
>=20
> Fixes: 4f016420d368 ("Staging: lustre: obdclass: Use kasprintf")
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> ---
> drivers/staging/lustre/lustre/obdclass/obd_mount.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/lustre/lustre/obdclass/obd_mount.c b/drivers=
/staging/lustre/lustre/obdclass/obd_mount.c
> index acc1ea773c9c..f5e8214ac37b 100644
> --- a/drivers/staging/lustre/lustre/obdclass/obd_mount.c
> +++ b/drivers/staging/lustre/lustre/obdclass/obd_mount.c
> @@ -243,7 +243,7 @@ int lustre_start_mgc(struct super_block *sb)
> 	libcfs_nid2str_r(nid, nidstr, sizeof(nidstr));
> 	mgcname =3D kasprintf(GFP_NOFS,
> 			    "%s%s", LUSTRE_MGC_OBDNAME, nidstr);
> -	niduuid =3D kasprintf(GFP_NOFS, "%s_%x", mgcname, i);
> +	niduuid =3D kasprintf(GFP_NOFS, "%s_%x", mgcname, 0);
> 	if (!mgcname || !niduuid) {
> 		rc =3D -ENOMEM;
> 		goto out_free;
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
