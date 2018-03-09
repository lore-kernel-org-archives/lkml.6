Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AG47ELuxG4dsqFSSC+rnMA/Iy2TiTaiPRsDokrop53VrJdQ1Znq7Dzvum2aOGzg78u2cvCuyrNR5
ARC-Seal: i=1; a=rsa-sha256; t=1520555505; cv=none;
        d=google.com; s=arc-20160816;
        b=rVHYLqyC5sXCYSTT9PGs1VCJcvjx9h8zTwUQLZ13aGeyrB/y/U6x5W76SQW1HHwfVe
         fAZ6wLmQhEejqnpAIlb5sLf1ILacb6mTWCd0JmBFm1YY+sHw9y29Co46bibc7VPfevkr
         60pHBAlZrPhf0CeH3eaj086c49Enxm6a+ePv+FvsJj3fn+I887IKTcREXRKS1ruB1Iro
         9AEsOSheH7Wtm7l/EHJl2qPrPwTWWKCBzRmtwPhPUuaZA5IQ14amVLcrk/V+rxc/tmmR
         /Q7xP8CU6hDeCuVLk1wzYsvyGpwRj4NAZDgWJLKS5bqetMHq2mhrbYyB7EYC+DvepVeI
         PsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=CarQ01M9JjwTbibGnvQqePiPpexqCAitQDmvWICjBO8=;
        b=J9MJfx7bU6oTK0UDfMOLXBsXuq2FsQNuVYrCr0ebYZpPwvYA70Ed3STMIvzRtqg0pL
         1q3nI39u50kPJcuCaWVceRMhFbprkXe+IK16d3RV6+ISV+RFWzGf8/7kC7w1nmkNvQho
         G/FwMgi1BaNNJRO0hBMLU2clkE2iKsYwPapI5cz8GwzWyxKREby2h4nGFWx5wpZPOE16
         xG3SCkAzUXhcVVFQx8zJ5DibF+iTf5Fqd3dmN+cyINA1kBjJVWReHsxjOpc4evyRZyX8
         nLCnGoofKEKAb/bjsaufKqPQp7Or29Fp/w76/i2YhkhrhfT2HMUHCz1ezDmbLZG3kVmh
         1yhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,443,1515484800";
   d="scan'208";a="22893579"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 15/17] staging: lustre: ptlrpc: move thread creation out
 of module initialization
Thread-Topic: [PATCH 15/17] staging: lustre: ptlrpc: move thread creation
 out of module initialization
Thread-Index: AQHTsbXRpQsEtwqfkUmpeNeMs23euKPHnrAA
Date: Fri, 9 Mar 2018 00:31:44 +0000
Message-ID: <E9EE2714-9E37-446D-9B74-D444A47A9B45@intel.com>
References: <151994679573.7628.1024109499321778846.stgit@noble>
 <151994708557.7628.14705551472003114360.stgit@noble>
In-Reply-To: <151994708557.7628.14705551472003114360.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.37.249]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A2FD8D57796E94289FD9CECA433E848@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780199707218581?=
X-GMAIL-MSGID: =?utf-8?q?1594418010439311938?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mar 1, 2018, at 16:31, NeilBrown <neilb@suse.com> wrote:
>=20
> When the ptlrpc module is loaded, it starts the pinger thread and
> calls LNetNIInit which starts various threads.
>=20
> We don't need these threads until the module is actually being
> used, such as when a lustre filesystem is mounted.
>=20
> So move the thread creation into new ptlrpc_inc_ref() (modeled on
> ptlrpcd_inc_ref()), and call that when needed, such as at mount time.

It looks like this is still done early enough in the mount sequence, so the
earlier "[06/17] get entropy from nid when nid set" action is still done
before the client UUID is generated in ll_init_sbi().

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
> drivers/staging/lustre/lustre/include/lustre_net.h |    3 +
> drivers/staging/lustre/lustre/ldlm/ldlm_lockd.c    |   12 ++++
> drivers/staging/lustre/lustre/llite/llite_lib.c    |   18 +++++-
> .../staging/lustre/lustre/ptlrpc/ptlrpc_module.c   |   56 +++++++++++++--=
-----
> 4 files changed, 65 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/staging/lustre/lustre/include/lustre_net.h b/drivers=
/staging/lustre/lustre/include/lustre_net.h
> index 108683c54127..d35ae0cda8d2 100644
> --- a/drivers/staging/lustre/lustre/include/lustre_net.h
> +++ b/drivers/staging/lustre/lustre/include/lustre_net.h
> @@ -1804,6 +1804,9 @@ int ptlrpc_register_rqbd(struct ptlrpc_request_buff=
er_desc *rqbd);
>  */
> void ptlrpc_request_committed(struct ptlrpc_request *req, int force);
>=20
> +int ptlrpc_inc_ref(void);
> +void ptlrpc_dec_ref(void);
> +
> void ptlrpc_init_client(int req_portal, int rep_portal, char *name,
> 			struct ptlrpc_client *);
> struct ptlrpc_connection *ptlrpc_uuid_to_connection(struct obd_uuid *uuid=
);
> diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_lockd.c b/drivers/st=
aging/lustre/lustre/ldlm/ldlm_lockd.c
> index 58913e628124..c772c68e5a49 100644
> --- a/drivers/staging/lustre/lustre/ldlm/ldlm_lockd.c
> +++ b/drivers/staging/lustre/lustre/ldlm/ldlm_lockd.c
> @@ -869,6 +869,10 @@ int ldlm_get_ref(void)
> {
> 	int rc =3D 0;
>=20
> +	rc =3D ptlrpc_inc_ref();
> +	if (rc)
> +		return rc;
> +
> 	mutex_lock(&ldlm_ref_mutex);
> 	if (++ldlm_refcount =3D=3D 1) {
> 		rc =3D ldlm_setup();
> @@ -877,14 +881,18 @@ int ldlm_get_ref(void)
> 	}
> 	mutex_unlock(&ldlm_ref_mutex);
>=20
> +	if (rc)
> +		ptlrpc_dec_ref();
> +
> 	return rc;
> }
>=20
> void ldlm_put_ref(void)
> {
> +	int rc =3D 0;
> 	mutex_lock(&ldlm_ref_mutex);
> 	if (ldlm_refcount =3D=3D 1) {
> -		int rc =3D ldlm_cleanup();
> +		rc =3D ldlm_cleanup();
>=20
> 		if (rc)
> 			CERROR("ldlm_cleanup failed: %d\n", rc);
> @@ -894,6 +902,8 @@ void ldlm_put_ref(void)
> 		ldlm_refcount--;
> 	}
> 	mutex_unlock(&ldlm_ref_mutex);
> +	if (!rc)
> +		ptlrpc_dec_ref();
> }
>=20
> static ssize_t cancel_unused_locks_before_replay_show(struct kobject *kob=
j,
> diff --git a/drivers/staging/lustre/lustre/llite/llite_lib.c b/drivers/st=
aging/lustre/lustre/llite/llite_lib.c
> index 844182ad7dd7..706b14bf8981 100644
> --- a/drivers/staging/lustre/lustre/llite/llite_lib.c
> +++ b/drivers/staging/lustre/lustre/llite/llite_lib.c
> @@ -879,9 +879,15 @@ int ll_fill_super(struct super_block *sb)
>=20
> 	CDEBUG(D_VFSTRACE, "VFS Op: sb %p\n", sb);
>=20
> +	err =3D ptlrpc_inc_ref();
> +	if (err)
> +		return err;
> +
> 	cfg =3D kzalloc(sizeof(*cfg), GFP_NOFS);
> -	if (!cfg)
> -		return -ENOMEM;
> +	if (!cfg) {
> +		err =3D -ENOMEM;
> +		goto out_put;
> +	}
>=20
> 	try_module_get(THIS_MODULE);
>=20
> @@ -891,7 +897,8 @@ int ll_fill_super(struct super_block *sb)
> 	if (!sbi) {
> 		module_put(THIS_MODULE);
> 		kfree(cfg);
> -		return -ENOMEM;
> +		err =3D -ENOMEM;
> +		goto out_put;
> 	}
>=20
> 	err =3D ll_options(lsi->lsi_lmd->lmd_opts, &sbi->ll_flags);
> @@ -958,6 +965,9 @@ int ll_fill_super(struct super_block *sb)
> 		LCONSOLE_WARN("Mounted %s\n", profilenm);
>=20
> 	kfree(cfg);
> +out_put:
> +	if (err)
> +		ptlrpc_dec_ref();
> 	return err;
> } /* ll_fill_super */
>=20
> @@ -1028,6 +1038,8 @@ void ll_put_super(struct super_block *sb)
> 	cl_env_cache_purge(~0);
>=20
> 	module_put(THIS_MODULE);
> +
> +	ptlrpc_dec_ref();
> } /* client_put_super */
>=20
> struct inode *ll_inode_from_resource_lock(struct ldlm_lock *lock)
> diff --git a/drivers/staging/lustre/lustre/ptlrpc/ptlrpc_module.c b/drive=
rs/staging/lustre/lustre/ptlrpc/ptlrpc_module.c
> index 131fc6d9646e..38923418669f 100644
> --- a/drivers/staging/lustre/lustre/ptlrpc/ptlrpc_module.c
> +++ b/drivers/staging/lustre/lustre/ptlrpc/ptlrpc_module.c
> @@ -45,6 +45,42 @@ extern spinlock_t ptlrpc_last_xid_lock;
> extern spinlock_t ptlrpc_rs_debug_lock;
> #endif
>=20
> +DEFINE_MUTEX(ptlrpc_startup);
> +static int ptlrpc_active =3D 0;
> +
> +int ptlrpc_inc_ref(void)
> +{
> +	int rc =3D 0;
> +
> +	mutex_lock(&ptlrpc_startup);
> +	if (ptlrpc_active++ =3D=3D 0) {
> +		ptlrpc_put_connection_superhack =3D ptlrpc_connection_put;
> +
> +		rc =3D ptlrpc_init_portals();
> +		if (!rc) {
> +			rc=3D ptlrpc_start_pinger();
> +			if (rc)
> +				ptlrpc_exit_portals();
> +		}
> +		if (rc)
> +			ptlrpc_active--;
> +	}
> +	mutex_unlock(&ptlrpc_startup);
> +	return rc;
> +}
> +EXPORT_SYMBOL(ptlrpc_inc_ref);
> +
> +void ptlrpc_dec_ref(void)
> +{
> +	mutex_lock(&ptlrpc_startup);
> +	if (--ptlrpc_active =3D=3D 0) {
> +		ptlrpc_stop_pinger();
> +		ptlrpc_exit_portals();
> +	}
> +	mutex_unlock(&ptlrpc_startup);
> +}
> +EXPORT_SYMBOL(ptlrpc_dec_ref);
> +
> static int __init ptlrpc_init(void)
> {
> 	int rc, cleanup_phase =3D 0;
> @@ -71,24 +107,12 @@ static int __init ptlrpc_init(void)
> 	if (rc)
> 		goto cleanup;
>=20
> -	cleanup_phase =3D 2;
> -	rc =3D ptlrpc_init_portals();
> -	if (rc)
> -		goto cleanup;
> -
> 	cleanup_phase =3D 3;
>=20
> 	rc =3D ptlrpc_connection_init();
> 	if (rc)
> 		goto cleanup;
>=20
> -	cleanup_phase =3D 4;
> -	ptlrpc_put_connection_superhack =3D ptlrpc_connection_put;
> -
> -	rc =3D ptlrpc_start_pinger();
> -	if (rc)
> -		goto cleanup;
> -
> 	cleanup_phase =3D 5;
> 	rc =3D ldlm_init();
> 	if (rc)
> @@ -122,15 +146,9 @@ static int __init ptlrpc_init(void)
> 		ldlm_exit();
> 		/* Fall through */
> 	case 5:
> -		ptlrpc_stop_pinger();
> -		/* Fall through */
> -	case 4:
> 		ptlrpc_connection_fini();
> 		/* Fall through */
> 	case 3:
> -		ptlrpc_exit_portals();
> -		/* Fall through */
> -	case 2:
> 		ptlrpc_request_cache_fini();
> 		/* Fall through */
> 	case 1:
> @@ -150,8 +168,6 @@ static void __exit ptlrpc_exit(void)
> 	ptlrpc_nrs_fini();
> 	sptlrpc_fini();
> 	ldlm_exit();
> -	ptlrpc_stop_pinger();
> -	ptlrpc_exit_portals();
> 	ptlrpc_request_cache_fini();
> 	ptlrpc_hr_fini();
> 	ptlrpc_connection_fini();
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
