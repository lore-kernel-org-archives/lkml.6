Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755383AbeE2XpU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 19:45:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:50851 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755284AbeE2XpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 19:45:19 -0400
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>
Date: Wed, 30 May 2018 09:45:08 +1000
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>,
        James Simmons <jsimmons@infradead.org>,
        James Simmons <uja.ornl@yahoo.com>,
        Amir Shehata <amir.shehata@intel.com>
Subject: Re: [PATCH v2 01/25] staging: lustre: libcfs: restore UMP handling
In-Reply-To: <1527603725-30560-2-git-send-email-jsimmons@infradead.org>
References: <1527603725-30560-1-git-send-email-jsimmons@infradead.org> <1527603725-30560-2-git-send-email-jsimmons@infradead.org>
Message-ID: <87muwiuiuz.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, May 29 2018, James Simmons wrote:

> With the cleanup of the libcfs SMP handling all UMP handling
> was removed. In the process now various NULL pointers and
> empty fields are return in the UMP case which causes lustre
> to crash hard. Restore the proper UMP handling so Lustre can
> properly function.

Can't we just get lustre to handle the NULL pointer?
Is most cases, the pointer is accessed through an accessor function, and
on !CONFIG_SMP, that can be a static inline that doesn't even look at
the pointer.

I really think this is a step backwards.  If you can identify specific
problems caused by the current code, I'm sure we can fix them.

>
> Signed-off-by: James Simmons <uja.ornl@yahoo.com>
> Signed-off-by: Amir Shehata <amir.shehata@intel.com>
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-7734

This bug doesn't seem to mention this patch at all

> Reviewed-on: http://review.whamcloud.com/18916

Nor does this review.

Thanks,
NeilBrown


> Reviewed-by: Olaf Weber <olaf@sgi.com>
> Reviewed-by: Doug Oucharek <dougso@me.com>
> Signed-off-by: James Simmons <jsimmons@infradead.org>
> ---
> Changelog:
>
> v1) New patch to handle the disappearence of UMP support
>
>  .../lustre/include/linux/libcfs/libcfs_cpu.h       | 87 ++++++++++++++++=
------
>  drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c    |  4 -
>  drivers/staging/lustre/lnet/libcfs/module.c        |  4 +
>  3 files changed, 69 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h b/d=
rivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
> index 61641c4..2ad12a6 100644
> --- a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
> +++ b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
> @@ -74,6 +74,7 @@
>=20=20
>  #include <linux/cpu.h>
>  #include <linux/cpuset.h>
> +#include <linux/slab.h>
>  #include <linux/topology.h>
>=20=20
>  /* any CPU partition */
> @@ -89,10 +90,11 @@ struct cfs_cpu_partition {
>  	/* spread rotor for NUMA allocator */
>  	unsigned int			cpt_spread_rotor;
>  };
> -
> +#endif /* CONFIG_SMP */
>=20=20
>  /** descriptor for CPU partitions */
>  struct cfs_cpt_table {
> +#ifdef CONFIG_SMP
>  	/* version, reserved for hotplug */
>  	unsigned int			ctb_version;
>  	/* spread rotor for NUMA allocator */
> @@ -103,14 +105,26 @@ struct cfs_cpt_table {
>  	struct cfs_cpu_partition	*ctb_parts;
>  	/* shadow HW CPU to CPU partition ID */
>  	int				*ctb_cpu2cpt;
> -	/* all cpus in this partition table */
> -	cpumask_var_t			ctb_cpumask;
>  	/* all nodes in this partition table */
>  	nodemask_t			*ctb_nodemask;
> +#else
> +	nodemask_t			ctb_nodemask;
> +#endif /* CONFIG_SMP */
> +	/* all cpus in this partition table */
> +	cpumask_var_t			ctb_cpumask;
>  };
>=20=20
>  extern struct cfs_cpt_table	*cfs_cpt_tab;
>=20=20
> +#ifdef CONFIG_SMP
> +/**
> + * destroy a CPU partition table
> + */
> +void cfs_cpt_table_free(struct cfs_cpt_table *cptab);
> +/**
> + * create a cfs_cpt_table with \a ncpt number of partitions
> + */
> +struct cfs_cpt_table *cfs_cpt_table_alloc(unsigned int ncpt);
>  /**
>   * return cpumask of CPU partition \a cpt
>   */
> @@ -208,20 +222,52 @@ void cfs_cpt_unset_nodemask(struct cfs_cpt_table *c=
ptab,
>  void cfs_cpu_fini(void);
>=20=20
>  #else /* !CONFIG_SMP */
> -struct cfs_cpt_table;
> -#define cfs_cpt_tab ((struct cfs_cpt_table *)NULL)
>=20=20
> -static inline cpumask_var_t *
> -cfs_cpt_cpumask(struct cfs_cpt_table *cptab, int cpt)
> +static inline void cfs_cpt_table_free(struct cfs_cpt_table *cptab)
>  {
> -	return NULL;
> +	kfree(cptab);
>  }
>=20=20
> -static inline int
> -cfs_cpt_table_print(struct cfs_cpt_table *cptab, char *buf, int len)
> +static inline struct cfs_cpt_table *cfs_cpt_table_alloc(int ncpt)
>  {
> -	return 0;
> +	struct cfs_cpt_table *cptab;
> +
> +	if (ncpt !=3D 1)
> +		return NULL;
> +
> +	cptab =3D kzalloc(sizeof(*cptab), GFP_NOFS);
> +	if (!cptab)
> +		return NULL;
> +
> +	if (!zalloc_cpumask_var(&cptab->ctb_cpumask, GFP_NOFS)) {
> +		kfree(cptab);
> +		return NULL;
> +	}
> +	cpumask_set_cpu(0, cptab->ctb_cpumask);
> +	node_set(0, cptab->ctb_nodemask);
> +
> +	return cptab;
> +}
> +
> +static inline int cfs_cpt_table_print(struct cfs_cpt_table *cptab,
> +				      char *buf, int len)
> +{
> +	int rc;
> +
> +	rc =3D snprintf(buf, len, "0\t: 0\n");
> +	len -=3D rc;
> +	if (len <=3D 0)
> +		return -EFBIG;
> +
> +	return rc;
>  }
> +
> +static inline cpumask_var_t *
> +cfs_cpt_cpumask(struct cfs_cpt_table *cptab, int cpt)
> +{
> +	return &cptab->ctb_cpumask;
> +}
> +
>  static inline int
>  cfs_cpt_number(struct cfs_cpt_table *cptab)
>  {
> @@ -243,7 +289,7 @@ void cfs_cpt_unset_nodemask(struct cfs_cpt_table *cpt=
ab,
>  static inline nodemask_t *
>  cfs_cpt_nodemask(struct cfs_cpt_table *cptab, int cpt)
>  {
> -	return NULL;
> +	return &cptab->ctb_nodemask;
>  }
>=20=20
>  static inline int
> @@ -328,24 +374,21 @@ void cfs_cpt_unset_nodemask(struct cfs_cpt_table *c=
ptab,
>  static inline int
>  cfs_cpu_init(void)
>  {
> -	return 0;
> +	cfs_cpt_tab =3D cfs_cpt_table_alloc(1);
> +
> +	return cfs_cpt_tab ? 0 : -1;
>  }
>=20=20
>  static inline void cfs_cpu_fini(void)
>  {
> +	if (cfs_cpt_tab) {
> +		cfs_cpt_table_free(cfs_cpt_tab);
> +		cfs_cpt_tab =3D NULL;
> +	}
>  }
>=20=20
>  #endif /* CONFIG_SMP */
>=20=20
> -/**
> - * destroy a CPU partition table
> - */
> -void cfs_cpt_table_free(struct cfs_cpt_table *cptab);
> -/**
> - * create a cfs_cpt_table with \a ncpt number of partitions
> - */
> -struct cfs_cpt_table *cfs_cpt_table_alloc(unsigned int ncpt);
> -
>  /*
>   * allocate per-cpu-partition data, returned value is an array of pointe=
rs,
>   * variable can be indexed by CPU ID.
> diff --git a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c b/drivers/st=
aging/lustre/lnet/libcfs/libcfs_cpu.c
> index 3d1cf45..803fc58 100644
> --- a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
> +++ b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
> @@ -41,10 +41,6 @@
>  #include <linux/libcfs/libcfs_string.h>
>  #include <linux/libcfs/libcfs.h>
>=20=20
> -/** Global CPU partition table */
> -struct cfs_cpt_table   *cfs_cpt_tab __read_mostly;
> -EXPORT_SYMBOL(cfs_cpt_tab);
> -
>  /**
>   * modparam for setting number of partitions
>   *
> diff --git a/drivers/staging/lustre/lnet/libcfs/module.c b/drivers/stagin=
g/lustre/lnet/libcfs/module.c
> index 5dc7de9..b438d456 100644
> --- a/drivers/staging/lustre/lnet/libcfs/module.c
> +++ b/drivers/staging/lustre/lnet/libcfs/module.c
> @@ -66,6 +66,10 @@ struct lnet_debugfs_symlink_def {
>=20=20
>  static struct dentry *lnet_debugfs_root;
>=20=20
> +/** Global CPU partition table */
> +struct cfs_cpt_table  *cfs_cpt_tab __read_mostly;
> +EXPORT_SYMBOL(cfs_cpt_tab);
> +
>  BLOCKING_NOTIFIER_HEAD(libcfs_ioctl_list);
>  EXPORT_SYMBOL(libcfs_ioctl_list);
>=20=20
> --=20
> 1.8.3.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsN5gQACgkQOeye3VZi
gbmP7xAAnceAd+IR4qhrmMl0I7tKBVPOUjiSU6hqr8kUbTljqQosTYZAxlU63eBH
wO2nrqM4vFbjZ6l5rq8Hvbb2y0xD78xmsqbP5zOwK9UrvPsERoTsBZWDZulTCI1q
anODSpshQrMDvzpnxD+unTubXcuDmpJwRh/H4L0Sb91HQjlql0d8O2pk/ohH8Dqx
KPVeamB6CaYbJo7h9Y2nDZ1Km5mpWZgeiTG9ttHqQjHEDl65V5U+LEGovgy8nNQu
1mu1x1wlqBnRkSb1Q6UlWFoFBG1dG8Hh1Lf7Py3fEkwRmgahOMw1XCaRHDx/JCi0
Y9/0fMRPYAxhS/IIgeIckgcjGGxDi9qhUcAMC2qZWEzAq/qoT38h30dTFJqJ+6VM
PavfWybn/mna9KB0Ixal2YYB0ghYh0JhQJ1555sc/mNIkxh5VBNfNcxYdVt7f2cg
6ZACnCXKH7x1+ooofEtfz1Uz0+yXq7J0puvMykWrLqg8o2EDj/cYPjlHotKdD4dC
9svHSpdYnhSWq91BfRMnAJ/L9ThLn6FRxAqQdfXwdrPyH7tSD/W7b8bNWIBB4PyV
5mUquCjnBOhQK/0Gvxs0fh1uTZM80qhMIgfjDpp9TBoe79DMvxS0ImbB9Wat/yKq
rGxNFVaLw08L+97Vzr8S5FqQwVdIvOFoG3D0Rxrs6Jps6zrSNbk=
=Yfuh
-----END PGP SIGNATURE-----
--=-=-=--
