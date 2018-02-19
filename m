Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932245AbeBSU55 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:57:57 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60230 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932067AbeBSU5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:57:55 -0500
Date: Mon, 19 Feb 2018 21:57:52 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 06/22] x86/intel_rdt: Create pseudo-locked
 regions
In-Reply-To: <17cceeb077f3ac5f50b110285b36905091a345b0.1518443616.git.reinette.chatre@intel.com>
Message-ID: <alpine.DEB.2.21.1802192138140.1853@nanos.tec.linutronix.de>
References: <cover.1518443616.git.reinette.chatre@intel.com> <17cceeb077f3ac5f50b110285b36905091a345b0.1518443616.git.reinette.chatre@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018, Reinette Chatre wrote:

> System administrator creates/removes pseudo-locked regions by
> creating/removing directories in the pseudo-lock subdirectory of the
> resctrl filesystem. Here we add directory creation and removal support.
> 
> A "pseudo-lock region" is introduced, which represents an
> instance of a pseudo-locked cache region. During mkdir a new region is
> created but since we do not know which cache it belongs to at that time
> we maintain a global pointer to it from where it will be moved to the cache
> (rdt_domain) it belongs to after initialization. This implies that
> we only support one uninitialized pseudo-locked region at a time.

Whats the reason for this restriction? If there are uninitialized
directories, so what?

> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  arch/x86/kernel/cpu/intel_rdt.h             |   3 +
>  arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 220 +++++++++++++++++++++++++++-
>  2 files changed, 222 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
> index 8f5ded384e19..55f085985072 100644
> --- a/arch/x86/kernel/cpu/intel_rdt.h
> +++ b/arch/x86/kernel/cpu/intel_rdt.h
> @@ -352,6 +352,7 @@ extern struct mutex rdtgroup_mutex;
>  extern struct rdt_resource rdt_resources_all[];
>  extern struct rdtgroup rdtgroup_default;
>  DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
> +extern struct kernfs_node *pseudo_lock_kn;
>  
>  int __init rdtgroup_init(void);
>  
> @@ -457,5 +458,7 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
>  void __check_limbo(struct rdt_domain *d, bool force_free);
>  int rdt_pseudo_lock_fs_init(struct kernfs_node *root);
>  void rdt_pseudo_lock_fs_remove(void);
> +int rdt_pseudo_lock_mkdir(const char *name, umode_t mode);
> +int rdt_pseudo_lock_rmdir(struct kernfs_node *kn);
>  
>  #endif /* _ASM_X86_INTEL_RDT_H */
> diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
> index a787a103c432..7a22e367b82f 100644
> --- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
> @@ -20,11 +20,142 @@
>  #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
>  
>  #include <linux/kernfs.h>
> +#include <linux/kref.h>
>  #include <linux/seq_file.h>
>  #include <linux/stat.h>
> +#include <linux/slab.h>
>  #include "intel_rdt.h"
>  
> -static struct kernfs_node *pseudo_lock_kn;
> +struct kernfs_node *pseudo_lock_kn;
> +
> +/*
> + * Protect the pseudo_lock_region access. Since we will link to
> + * pseudo_lock_region from rdt domains rdtgroup_mutex should be obtained
> + * first if needed.
> + */
> +static DEFINE_MUTEX(rdt_pseudo_lock_mutex);
> +
> +/**
> + * struct pseudo_lock_region - pseudo-lock region information
> + * @kn:			kernfs node representing this region in the resctrl
> + *			filesystem
> + * @cbm:		bitmask of the pseudo-locked region
> + * @cpu:		core associated with the cache on which the setup code
> + *			will be run
> + * @minor:		minor number of character device associated with this
> + *			region
> + * @locked:		state indicating if this region has been locked or not
> + * @refcount:		how many are waiting to access this pseudo-lock
> + *			region via kernfs
> + * @deleted:		user requested removal of region via rmdir on kernfs
> + */
> +struct pseudo_lock_region {
> +	struct kernfs_node	*kn;
> +	u32			cbm;
> +	int			cpu;
> +	unsigned int		minor;
> +	bool			locked;
> +	struct kref		refcount;
> +	bool			deleted;
> +};
> +
> +/*
> + * Only one uninitialized pseudo-locked region can exist at a time. An
> + * uninitialized pseudo-locked region is created when the user creates a
> + * new directory within the pseudo_lock subdirectory of the resctrl
> + * filsystem. The user will initialize the pseudo-locked region by writing
> + * to its schemata file at which point this structure will be moved to the
> + * cache domain it belongs to.
> + */
> +static struct pseudo_lock_region *new_plr;

Why isn't the struct pointer not stored in the corresponding kernfs's node->priv?

> +static void __pseudo_lock_region_release(struct pseudo_lock_region *plr)
> +{
> +	bool is_new_plr = (plr == new_plr);
> +
> +	WARN_ON(!plr->deleted);
> +	if (!plr->deleted)
> +		return;

  	if (WARN_ON(...))
		return;

> +
> +	kfree(plr);
> +	if (is_new_plr)
> +		new_plr = NULL;
> +}
> +
> +static void pseudo_lock_region_release(struct kref *ref)
> +{
> +	struct pseudo_lock_region *plr = container_of(ref,
> +						      struct pseudo_lock_region,
> +						      refcount);

You simply can avoid those line breaks by:

	struct pseudo_lock_region *plr;

	plr = container_of(ref, struct pseudo_lock_region, refcount);

Hmm?

> +	mutex_lock(&rdt_pseudo_lock_mutex);
> +	__pseudo_lock_region_release(plr);
> +	mutex_unlock(&rdt_pseudo_lock_mutex);
> +}
> +
> +/**
> + * pseudo_lock_region_kn_lock - Obtain lock to pseudo-lock region kernfs node
> + *
> + * This is called from the kernfs related functions which are called with
> + * an active reference to the kernfs_node that contains a valid pointer to
> + * the pseudo-lock region it represents. We can thus safely take an active
> + * reference to the pseudo-lock region before dropping the reference to the
> + * kernfs_node.
> + *
> + * We need to handle the scenarios where the kernfs directory representing
> + * this pseudo-lock region can be removed while an application still has an
> + * open handle to one of the directory's files and operations on this
> + * handle are attempted.
> + * To support this we allow a file operation to drop its reference to the
> + * kernfs_node so that the removal can proceed, while using the mutex to
> + * ensure these operations on the pseudo-lock region are serialized. At the
> + * time an operation does obtain access to the region it may thus have been
> + * deleted.
> + */
> +static struct pseudo_lock_region *pseudo_lock_region_kn_lock(
> +						struct kernfs_node *kn)
> +{
> +	struct pseudo_lock_region *plr = (kernfs_type(kn) == KERNFS_DIR) ?
> +						kn->priv : kn->parent->priv;

See above.

> +int rdt_pseudo_lock_mkdir(const char *name, umode_t mode)
> +{
> +	struct pseudo_lock_region *plr;
> +	struct kernfs_node *kn;
> +	int ret = 0;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +	mutex_lock(&rdt_pseudo_lock_mutex);
> +
> +	if (new_plr) {
> +		ret = -ENOSPC;
> +		goto out;
> +	}
> +
> +	plr = kzalloc(sizeof(*plr), GFP_KERNEL);
> +	if (!plr) {
> +		ret = -ENOSPC;

  ENOMEM is the proper error code here.

> +		goto out;
> +	}
> +
> +	kn = kernfs_create_dir(pseudo_lock_kn, name, mode, plr);
> +	if (IS_ERR(kn)) {
> +		ret = PTR_ERR(kn);
> +		goto out_free;
> +	}
> +
> +	plr->kn = kn;
> +	ret = rdtgroup_kn_set_ugid(kn);
> +	if (ret)
> +		goto out_remove;
> +
> +	kref_init(&plr->refcount);
> +	kernfs_activate(kn);
> +	new_plr = plr;
> +	ret = 0;
> +	goto out;
> +
> +out_remove:
> +	kernfs_remove(kn);
> +out_free:
> +	kfree(plr);
> +out:
> +	mutex_unlock(&rdt_pseudo_lock_mutex);
> +	mutex_unlock(&rdtgroup_mutex);
> +	return ret;
> +}
> +
> +/*
> + * rdt_pseudo_lock_rmdir - Remove pseudo-lock region
> + *
> + * LOCKING:
> + * Since the pseudo-locked region can be associated with a RDT domain at
> + * removal we take both rdtgroup_mutex and rdt_pseudo_lock_mutex to protect
> + * the rdt_domain access as well as the pseudo_lock_region access.

Is there a real reason / benefit for having this second mutex?

Thanks,

	tglx
