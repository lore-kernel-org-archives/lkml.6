Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AG47ELsC+C4DZqxI3JNJN5QxqRZ2aHX/8/VTALRA63/FUuOGzdaQTODblLaI9rIIlXJkwRXdmLw8
ARC-Seal: i=1; a=rsa-sha256; t=1520455901; cv=none;
        d=google.com; s=arc-20160816;
        b=zOkPhxjb3o6pOLtfQJKF6Mm5wqUgBEK/KJAeVI8Pk0tt3P0X2uZ5Lu17/wrVFoYYzh
         nUeB0Ud7dF74Ek9CCXT1DEwfVfEodlyBg0Roo4gd0FbUc+ysWgodu/bK+QuxR8gOz6c+
         NDXtmmnXtTq12NkhR5t9++Z9iFObQ+//yVVk5D7nJyJx69A4cmrGveTn9QxvjzHbnD9N
         AosF9L9ThCDiQ1MiQF5zs2lhppII2072ATOOxPnQ07YFvAiQ8argFJABC+f0hbvqELJL
         nwybQyD8S0Ex9DTYo9vXOlazEspUv5iRz4I56FwWUnRpWopb06psxRJaLmsK9vHcCjWe
         P1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=VUujfzlXN68i14FZ8YQ8fQ8O7aArMs66Y6U0SMyjHPk=;
        b=oDvL04u8rEYh8Xrj/YFVWUqScWoisNir/7jwMjMAFJuz8HE4Q7+aIP3dfFACFAxiNX
         Lisd6YViRBRS2/2RI7ZTKrel0WKT2mcAFVUw+zQmT8k3iplg6BgqT64anASbB8mvCj6Y
         X+4a4wY2uQK98qozSNK774Zs3IZWBME2XB2C35o47IIctFgpIkCThZlvB7hn5zin3sWn
         1DM8h5OD6U2hUljRD4WR+ic1BtKyRICVgBy4rUz3RWHifJ+F/PEv2d/MaxNlwLm74Mdy
         dwPEILNh19tn3g9INzyfFIpIjJd8U6n5ij/nRPqKgNowlIZB0bR/X7zzmvZJ/Q9YHg51
         n1GA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,437,1515484800";
   d="scan'208";a="36801494"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 02/17] staging: lustre: fix bug in osc_enter_cache_try
Thread-Topic: [PATCH 02/17] staging: lustre: fix bug in osc_enter_cache_try
Thread-Index: AQHTsbWQ2ccTLeOOBkq/nm4mGZ8D5KPFzt6A
Date: Wed, 7 Mar 2018 20:51:39 +0000
Message-ID: <0512F618-CADE-434F-83F9-0452680BFF33@intel.com>
References: <151994679573.7628.1024109499321778846.stgit@noble>
 <151994708510.7628.7308229784516417641.stgit@noble>
In-Reply-To: <151994708510.7628.7308229784516417641.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.6.233]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <217D8EB40089774A9E6BF9AE695A666C@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780100194865307?=
X-GMAIL-MSGID: =?utf-8?q?1594313568089560796?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mar 1, 2018, at 16:31, NeilBrown <neilb@suse.com> wrote:
>=20
> The lustre-release patch commit bdc5bb52c554 ("LU-4933 osc:
> Automatically increase the max_dirty_mb") changed
>=20
> -       if (cli->cl_dirty + PAGE_CACHE_SIZE <=3D cli->cl_dirty_max &&
> +       if (cli->cl_dirty_pages < cli->cl_dirty_max_pages &&
>=20
> When this patch landed in Linux a couple of years later, it landed as
>=20
> -       if (cli->cl_dirty + PAGE_SIZE <=3D cli->cl_dirty_max &&
> +       if (cli->cl_dirty_pages <=3D cli->cl_dirty_max_pages &&
>=20
> which is clearly different ('<=3D' vs '<'), and allows cl_dirty_pages to
> increase beyond cl_dirty_max_pages - which causes a latter assertion
> to fails.
>=20
> Fixes: 3147b268400a ("staging: lustre: osc: Automatically increase the ma=
x_dirty_mb")
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> ---
> drivers/staging/lustre/lustre/include/obd.h   |    2 +-
> drivers/staging/lustre/lustre/osc/osc_cache.c |    2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/lustre/lustre/include/obd.h b/drivers/stagin=
g/lustre/lustre/include/obd.h
> index 4368f4e9f208..f1233ca7d337 100644
> --- a/drivers/staging/lustre/lustre/include/obd.h
> +++ b/drivers/staging/lustre/lustre/include/obd.h
> @@ -191,7 +191,7 @@ struct client_obd {
> 	struct sptlrpc_flavor    cl_flvr_mgc;   /* fixed flavor of mgc->mgs */
>=20
> 	/* the grant values are protected by loi_list_lock below */
> -	unsigned long		 cl_dirty_pages;	/* all _dirty_ in pahges */
> +	unsigned long		 cl_dirty_pages;	/* all _dirty_ in pages */
> 	unsigned long		 cl_dirty_max_pages;	/* allowed w/o rpc */
> 	unsigned long		 cl_dirty_transit;	/* dirty synchronous */
> 	unsigned long		 cl_avail_grant;	/* bytes of credit for ost */
> diff --git a/drivers/staging/lustre/lustre/osc/osc_cache.c b/drivers/stag=
ing/lustre/lustre/osc/osc_cache.c
> index 1c70a504ee89..459503727ce3 100644
> --- a/drivers/staging/lustre/lustre/osc/osc_cache.c
> +++ b/drivers/staging/lustre/lustre/osc/osc_cache.c
> @@ -1529,7 +1529,7 @@ static int osc_enter_cache_try(struct client_obd *c=
li,
> 	if (rc < 0)
> 		return 0;
>=20
> -	if (cli->cl_dirty_pages <=3D cli->cl_dirty_max_pages &&
> +	if (cli->cl_dirty_pages < cli->cl_dirty_max_pages &&
> 	    atomic_long_read(&obd_dirty_pages) + 1 <=3D obd_max_dirty_pages) {
> 		osc_consume_write_grant(cli, &oap->oap_brw_page);
> 		if (transient) {
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
