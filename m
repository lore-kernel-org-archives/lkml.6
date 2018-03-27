Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeC0XDJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 19:03:09 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:47590 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbeC0XDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 19:03:06 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        tycho@docker.com, serge@hallyn.com, sunyuqiong1988@gmail.com,
        david.safford@ge.com, mkayaalp@cs.binghamton.edu,
        James.Bottomley@HansenPartnership.com, zohar@linux.vnet.ibm.com,
        Yuqiong Sun <suny@us.ibm.com>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
References: <1522159038-14175-1-git-send-email-stefanb@linux.vnet.ibm.com>
        <1522159038-14175-2-git-send-email-stefanb@linux.vnet.ibm.com>
Date: Tue, 27 Mar 2018 18:01:44 -0500
In-Reply-To: <1522159038-14175-2-git-send-email-stefanb@linux.vnet.ibm.com>
        (Stefan Berger's message of "Tue, 27 Mar 2018 09:57:16 -0400")
Message-ID: <87sh8lcecn.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f0xc6-00037Q-47;;;mid=<87sh8lcecn.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+TSejap2eSWkKbVlkDcdX3aj6gkvlIDBI=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15038 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 2.5 (0.0%), b_tie_ro: 1.61 (0.0%), parse: 1.93 (0.0%),
        extract_message_metadata: 14 (0.1%), get_uri_detail_list: 11 (0.1%),
        tests_pri_-1000: 4.6 (0.0%), tests_pri_-950: 1.75 (0.0%), tests_pri_-900:
        1.56 (0.0%), tests_pri_-400: 78 (0.5%), check_bayes: 76 (0.5%), b_tokenize:
        41 (0.3%), b_tok_get_all: 16 (0.1%), b_comp_prob: 7 (0.0%), b_tok_touch_all:
        8 (0.1%), b_finish: 1.98 (0.0%), tests_pri_0: 672 (4.5%),
        check_dkim_signature: 0.81 (0.0%), check_dkim_adsp: 4.2 (0.0%),
        tests_pri_500: 14248 (94.7%), poll_dns_idle: 14239 (94.7%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [RFC PATCH v3 1/3] ima: extend clone() with IMA namespace support
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Berger <stefanb@linux.vnet.ibm.com> writes:

> From: Yuqiong Sun <suny@us.ibm.com>
>
> Add new CONFIG_IMA_NS config option.  Let clone() create a new IMA
> namespace upon CLONE_NEWUSER flag. Attach the ima_ns data structure
> to user_namespace. ima_ns is allocated and freed upon IMA namespace
> creation and exit, which is tied to USER namespace creation and exit.
> Currently, the ima_ns contains no useful IMA data but only a dummy
> interface. This patch creates the framework for namespacing the different
> aspects of IMA (eg. IMA-audit, IMA-measurement, IMA-appraisal).

Tying IMA to the user namespace is far better than tying IMA
to the mount namespace.  It may even be the proper answer.


You had asked what it would take to unstick this so you won't have
problems next time you post and I did not get as far as answering.

I had a conversation a while back with Mimi and I believe what was
agreed was that IMA to start doing it's thing early needs a write
to securityfs/imafs.

As such I expect the best way to create the ima namespace is by simply
writing to securityfs/imafs.  Possibly before the user namespace is
even unshared.  That would allow IMA to keep track of things from
before a container is created.

Eric

> Changelog:
> v3:
> * Use CLONE_NEWUSER instead of CLONE_NEWNW flag
>
> v2:
> * Moved ima_init_ns and related functions into own file that is
>   always compiled; init_ima_ns will always be there
> * Fixed putting of imans->parent
> * Move IMA namespace creation from nsproxy into mount namespace
>   code; get rid of procfs operations for IMA namespace
>
> v1:
> * Use CLONE_NEWNS instead of a new CLONE_NEWIMA flag
> * Use existing ima.h headers
> * Move the ima_namespace.c to security/integrity/ima/ima_ns.c
> * Fix typo INFO->INO
> * Each namespace free's itself, removed recursively free'ing
>   until init_ima_ns from free_ima_ns()
>
> Signed-off-by: Yuqiong Sun <suny@us.ibm.com>
> Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  include/linux/ima.h                      | 64 ++++++++++++++++++++++++
>  include/linux/user_namespace.h           |  4 ++
>  init/Kconfig                             |  8 +++
>  kernel/user.c                            |  7 +++
>  kernel/user_namespace.c                  | 18 +++++++
>  security/integrity/ima/Makefile          |  3 +-
>  security/integrity/ima/ima.h             |  4 ++
>  security/integrity/ima/ima_init.c        |  4 ++
>  security/integrity/ima/ima_init_ima_ns.c | 37 ++++++++++++++
>  security/integrity/ima/ima_ns.c          | 86 ++++++++++++++++++++++++++++++++
>  10 files changed, 234 insertions(+), 1 deletion(-)
>  create mode 100644 security/integrity/ima/ima_init_ima_ns.c
>  create mode 100644 security/integrity/ima/ima_ns.c
>
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 0e4647e0eb60..8bca67df0ad3 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -12,6 +12,7 @@
>  
>  #include <linux/fs.h>
>  #include <linux/kexec.h>
> +#include <linux/user_namespace.h>
>  struct linux_binprm;
>  
>  #ifdef CONFIG_IMA
> @@ -105,4 +106,67 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
>  	return 0;
>  }
>  #endif /* CONFIG_IMA_APPRAISE */
> +
> +struct ima_namespace {
> +	struct kref kref;
> +	struct ima_namespace *parent;
> +};
> +
> +extern struct ima_namespace init_ima_ns;
> +
> +void imans_install(struct ns_common *new);
> +
> +static inline struct ima_namespace *to_ima_ns(struct ns_common *ns)
> +{
> +	return container_of(ns, struct user_namespace, ns)->ima_ns;
> +}
> +
> +#ifdef CONFIG_IMA_NS
> +
> +void free_ima_ns(struct kref *kref);
> +
> +static inline struct ima_namespace *get_ima_ns(struct ima_namespace *ns)
> +{
> +	BUG_ON(!ns);
> +	if (ns)
> +		kref_get(&ns->kref);
> +	return ns;
> +}
> +
> +static inline void put_ima_ns(struct ima_namespace *ns)
> +{
> +	BUG_ON(!ns);
> +	if (ns)
> +		kref_put(&ns->kref, free_ima_ns);
> +}
> +
> +struct ima_namespace *copy_ima(struct ima_namespace *old_ns);
> +
> +static inline struct ima_namespace *get_current_ns(void)
> +{
> +	return current_user_ns()->ima_ns;
> +}
> +
> +#else
> +
> +static inline struct ima_namespace *get_ima_ns(struct ima_namespace *ns)
> +{
> +	return ns;
> +}
> +
> +static inline void put_ima_ns(struct ima_namespace *ns)
> +{
> +	return;
> +}
> +
> +static inline struct ima_namespace *copy_ima(struct ima_namespace *old_ns)
> +{
> +	return old_ns;
> +}
> +
> +static inline struct ima_namespace *get_current_ns(void)
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_IMA_NS */
>  #endif /* _LINUX_IMA_H */
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index d6b74b91096b..8884b22d991c 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -36,6 +36,7 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
>  #define USERNS_INIT_FLAGS USERNS_SETGROUPS_ALLOWED
>  
>  struct ucounts;
> +struct ima_namespace;
>  
>  enum ucount_type {
>  	UCOUNT_USER_NAMESPACES,
> @@ -76,6 +77,9 @@ struct user_namespace {
>  #endif
>  	struct ucounts		*ucounts;
>  	int ucount_max[UCOUNT_COUNTS];
> +#ifdef CONFIG_IMA
> +	struct ima_namespace	*ima_ns;
> +#endif
>  } __randomize_layout;
>  
>  struct ucounts {
> diff --git a/init/Kconfig b/init/Kconfig
> index a9a2e2c86671..a1ad5384e081 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -931,6 +931,14 @@ config NET_NS
>  	help
>  	  Allow user space to create what appear to be multiple instances
>  	  of the network stack.
> +config IMA_NS
> +	bool "IMA namespace"
> +	depends on IMA
> +	default y
> +	help
> +	  Allow the creation of IMA namespaces for each mount namespace.
> +	  Namespaced IMA data enables having IMA features work separately
> +	  for each mount namespace.
>  
>  endif # NAMESPACES
>  
> diff --git a/kernel/user.c b/kernel/user.c
> index 9a20acce460d..31c946f3adce 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -19,6 +19,10 @@
>  #include <linux/user_namespace.h>
>  #include <linux/proc_ns.h>
>  
> +#ifdef CONFIG_IMA
> +extern struct ima_namespace init_ima_ns;
> +#endif
> +
>  /*
>   * userns count is 1 for root user, 1 for init_uts_ns,
>   * and 1 for... ?
> @@ -66,6 +70,9 @@ struct user_namespace init_user_ns = {
>  	.persistent_keyring_register_sem =
>  	__RWSEM_INITIALIZER(init_user_ns.persistent_keyring_register_sem),
>  #endif
> +#ifdef CONFIG_IMA
> +	.ima_ns = &init_ima_ns,
> +#endif
>  };
>  EXPORT_SYMBOL_GPL(init_user_ns);
>  
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 246d4d4ce5c7..7d6e7d6e6a34 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -25,6 +25,7 @@
>  #include <linux/fs_struct.h>
>  #include <linux/bsearch.h>
>  #include <linux/sort.h>
> +#include <linux/ima.h>
>  
>  static struct kmem_cache *user_ns_cachep __read_mostly;
>  static DEFINE_MUTEX(userns_state_mutex);
> @@ -140,8 +141,20 @@ int create_user_ns(struct cred *new)
>  	if (!setup_userns_sysctls(ns))
>  		goto fail_keyring;

Having the functions be #ifdef'd rather than the code would
be preferabble.
>  
> +#if CONFIG_IMA
> +	ns->ima_ns = copy_ima(parent_ns->ima_ns);
> +	if (IS_ERR(ns->ima_ns)) {
> +		ret = PTR_ERR(ns->ima_ns);
> +		goto fail_userns_sysctls;
> +	}
> +#endif
> +
>  	set_cred_user_ns(new, ns);
>  	return 0;
> +#if CONFIG_IMA
> +fail_userns_sysctls:
> +	retire_userns_sysctls(ns);
> +#endif
>  fail_keyring:
>  #ifdef CONFIG_PERSISTENT_KEYRINGS
>  	key_put(ns->persistent_keyring_register);
> @@ -195,6 +208,9 @@ static void free_user_ns(struct work_struct *work)
>  			kfree(ns->projid_map.forward);
>  			kfree(ns->projid_map.reverse);
>  		}
> +#ifdef CONFIG_IMA
> +		put_ima_ns(ns->ima_ns);
> +#endif
>  		retire_userns_sysctls(ns);
>  #ifdef CONFIG_PERSISTENT_KEYRINGS
>  		key_put(ns->persistent_keyring_register);
> @@ -1285,6 +1301,8 @@ static int userns_install(struct nsproxy *nsproxy, struct ns_common *ns)
>  	put_user_ns(cred->user_ns);
>  	set_cred_user_ns(cred, get_user_ns(user_ns));
>  
> +	imans_install(ns);
> +
>  	return commit_creds(cred);
>  }
>  
> diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
> index d921dc4f9eb0..cc60f726e651 100644
> --- a/security/integrity/ima/Makefile
> +++ b/security/integrity/ima/Makefile
> @@ -7,7 +7,8 @@
>  obj-$(CONFIG_IMA) += ima.o
>  
>  ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
> -	 ima_policy.o ima_template.o ima_template_lib.o
> +	 ima_policy.o ima_template.o ima_template_lib.o ima_init_ima_ns.o
>  ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
> +ima-$(CONFIG_IMA_NS) += ima_ns.o
>  ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
>  obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index d52b487ad259..e98c11c7cf75 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -291,6 +291,10 @@ static inline int ima_read_xattr(struct dentry *dentry,
>  
>  #endif /* CONFIG_IMA_APPRAISE */
>  
> +int ima_ns_init(void);
> +struct ima_namespace;
> +int ima_init_namespace(struct ima_namespace *ns);
> +
>  /* LSM based policy rules require audit */
>  #ifdef CONFIG_IMA_LSM_RULES
>  
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 2967d497a665..7f884a71fa1c 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -137,5 +137,9 @@ int __init ima_init(void)
>  
>  	ima_init_policy();
>  
> +	rc = ima_ns_init();
> +	if (rc != 0)
> +		return rc;
> +
>  	return ima_fs_init();
>  }
> diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
> new file mode 100644
> index 000000000000..52cb94b1d392
> --- /dev/null
> +++ b/security/integrity/ima/ima_init_ima_ns.c
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright (C) 2016-2018 IBM Corporation
> + * Author:
> + *   Yuqiong Sun <suny@us.ibm.com>
> + *   Stefan Berger <stefanb@linux.vnet.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, version 2 of the License.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/user_namespace.h>
> +#include <linux/ima.h>
> +
> +int ima_init_namespace(struct ima_namespace *ns)
> +{
> +	return 0;
> +}
> +
> +int __init ima_ns_init(void)
> +{
> +	return ima_init_namespace(&init_ima_ns);
> +}
> +
> +struct ima_namespace init_ima_ns = {
> +	.kref = KREF_INIT(1),
> +	.parent = NULL,
> +};
> +EXPORT_SYMBOL(init_ima_ns);
> +
> +void imans_install(struct ns_common *new)
> +{
> +	struct ima_namespace *ns = to_ima_ns(new);
> +
> +	get_ima_ns(ns);
> +}
> diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
> new file mode 100644
> index 000000000000..62148908015a
> --- /dev/null
> +++ b/security/integrity/ima/ima_ns.c
> @@ -0,0 +1,86 @@
> +/*
> + * Copyright (C) 2016-2018 IBM Corporation
> + * Author:
> + *  Yuqiong Sun <suny@us.ibm.com>
> + *  Stefan Berger <stefanb@linux.vnet.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, version 2 of the License.
> + */
> +
> +#include <linux/kref.h>
> +#include <linux/slab.h>
> +#include <linux/ima.h>
> +#include <linux/mount.h>
> +
> +#include "ima.h"
> +
> +static struct ima_namespace *create_ima_ns(void)
> +{
> +	struct ima_namespace *ima_ns;
> +
> +	ima_ns = kmalloc(sizeof(*ima_ns), GFP_KERNEL);
> +	if (ima_ns)
> +		kref_init(&ima_ns->kref);
> +
> +	return ima_ns;
> +}
> +
> +/**
> + * Clone a new ns copying an original ima namespace, setting refcount to 1
> + *
> + * @old_ns: old ima namespace to clone
> + * Return ERR_PTR(-ENOMEM) on error (failure to kmalloc), new ns otherwise
> + */
> +static struct ima_namespace *clone_ima_ns(struct ima_namespace *old_ns)
> +{
> +	struct ima_namespace *ns;
> +
> +	ns = create_ima_ns();
> +	if (!ns)
> +		return ERR_PTR(-ENOMEM);
> +
> +	get_ima_ns(old_ns);
> +	ns->parent = old_ns;
> +
> +	ima_init_namespace(ns);
> +
> +	return ns;
> +}
> +
> +/**
> + * Copy task's ima namespace, or clone it if flags specifies CLONE_NEWNS.
> + *
> + * @flags: flags used in the clone syscall
> + * @old_ns: old ima namespace to clone
> + */
> +
> +struct ima_namespace *copy_ima(struct ima_namespace *old_ns)
> +{
> +	struct ima_namespace *new_ns;
> +
> +	BUG_ON(!old_ns);
> +	get_ima_ns(old_ns);
> +
> +	new_ns = clone_ima_ns(old_ns);
> +	put_ima_ns(old_ns);
> +
> +	return new_ns;
> +}
> +
> +static void destroy_ima_ns(struct ima_namespace *ns)
> +{
> +	put_ima_ns(ns->parent);
> +	kfree(ns);
> +}
> +
> +void free_ima_ns(struct kref *kref)
> +{
> +	struct ima_namespace *ns;
> +
> +	ns = container_of(kref, struct ima_namespace, kref);
> +	BUG_ON(ns == &init_ima_ns);
> +
> +	destroy_ima_ns(ns);
> +}
