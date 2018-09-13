Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB73C61CF0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10B720854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10B720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbeIMTB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:01:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:28719 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730390AbeIMTB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:01:28 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2018 06:51:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,369,1531810800"; 
   d="scan'208";a="70573476"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.160.116])
  by fmsmga008.fm.intel.com with ESMTP; 13 Sep 2018 06:51:51 -0700
Date:   Thu, 13 Sep 2018 21:58:32 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [PATCH 1/5] PM / hibernate: Create snapshot keys handler
Message-ID: <20180913135832.GA8155@chenyu-desktop>
References: <20180912142337.21955-1-jlee@suse.com>
 <20180912142337.21955-2-jlee@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912142337.21955-2-jlee@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:23:33PM +0800, Lee, Chun-Yi wrote:
> This patch adds a snapshot keys handler for using the key retention
> service api to create keys for snapshot image encryption and
> authentication.
> 
> This handler uses TPM trusted key as the snapshot master key, and the
> encryption key and authentication key are derived from the snapshot
> key. The user defined key can also be used as the snapshot master key
> , but user must be aware that the security of user key relies on user
> space.
> 
In case the kernel provides mechanism to generate key from passphase,
the master key could also be generated in kernel space other than TPM.
It seems than snapshot_key_init() is easy to add the interface for that,
right?
> The name of snapshot key is fixed to "swsusp-kmk". User should use
> the keyctl tool to load the key blob to root's user keyring. e.g.
> 
>  # /bin/keyctl add trusted swsusp-kmk "load `cat swsusp-kmk.blob`" @u
> 
> or create a new user key. e.g.
> 
>  # /bin/keyctl add user swsusp-kmk password @u
> 
> Then the disk_kmk sysfs file can be used to trigger the initialization
> of snapshot key:
> 
>  # echo 1 > /sys/power/disk_kmk
> 
> After the initialization be triggered, the secret in the payload of
> swsusp-key will be copied by hibernation and be erased. Then user can
> use keyctl to remove swsusp-kmk key from root's keyring.
> 
> If user does not trigger the initialization by disk_kmk file after
> swsusp-kmk be loaded to kernel. Then the snapshot key will be
> initialled when hibernation be triggered.
> 
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Chen Yu <yu.c.chen@intel.com>
> Cc: Oliver Neukum <oneukum@suse.com>
> Cc: Ryan Chen <yu.chen.surf@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> ---
>  kernel/power/Kconfig        |  14 +++
>  kernel/power/Makefile       |   1 +
>  kernel/power/hibernate.c    |  36 +++++++
>  kernel/power/power.h        |  16 +++
>  kernel/power/snapshot_key.c | 237 ++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 304 insertions(+)
>  create mode 100644 kernel/power/snapshot_key.c
> 
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 3a6c2f87699e..7c5c30149dbc 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -76,6 +76,20 @@ config HIBERNATION
>  
>  	  For more information take a look at <file:Documentation/power/swsusp.txt>.
>  
> +config HIBERNATION_ENC_AUTH
> + 	bool "Hibernation encryption and authentication"
> + 	depends on HIBERNATION
> + 	depends on TRUSTED_KEYS
> +	select CRYPTO_AES
> + 	select CRYPTO_HMAC
> + 	select CRYPTO_SHA512
> + 	help
> +	  This option will encrypt and authenticate the memory snapshot image
> +	  of hibernation. It prevents that the snapshot image be arbitrary
> +	  modified. User can use TPMs trusted key or user defined key as the
> +	  master key of hibernation. The TPM trusted key depends on TPM. The
> +	  security of user defined key relies on user space.
> +
>  config ARCH_SAVE_PAGE_KEYS
>  	bool
>  
> diff --git a/kernel/power/Makefile b/kernel/power/Makefile
> index a3f79f0eef36..bddca7b79a28 100644
> --- a/kernel/power/Makefile
> +++ b/kernel/power/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_FREEZER)		+= process.o
>  obj-$(CONFIG_SUSPEND)		+= suspend.o
>  obj-$(CONFIG_PM_TEST_SUSPEND)	+= suspend_test.o
>  obj-$(CONFIG_HIBERNATION)	+= hibernate.o snapshot.o swap.o user.o
> +obj-$(CONFIG_HIBERNATION_ENC_AUTH)	+= snapshot_key.o
>  obj-$(CONFIG_PM_AUTOSLEEP)	+= autosleep.o
>  obj-$(CONFIG_PM_WAKELOCKS)	+= wakelock.o
>  
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index abef759de7c8..18d13cbf0591 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -1034,6 +1034,39 @@ static ssize_t disk_store(struct kobject *kobj, struct kobj_attribute *attr,
>  
>  power_attr(disk);
>  
> +#ifdef CONFIG_HIBERNATION_ENC_AUTH
> +static ssize_t disk_kmk_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			     char *buf)
> +{
> +	if (snapshot_key_initialized())
> +		return sprintf(buf, "initialized\n");
> +	else
> +		return sprintf(buf, "uninitialized\n");
> +}
> +
> +static ssize_t disk_kmk_store(struct kobject *kobj, struct kobj_attribute *attr,
> +			      const char *buf, size_t n)
> +{
Does kmk mean kernel master key? It might looks unclear from first glance,
how about disk_genkey_store()?
> +	int error = 0;
> +	char *p;
> +	int len;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	p = memchr(buf, '\n', n);
> +	len = p ? p - buf : n;
> +	if (strncmp(buf, "1", len))
> +		return -EINVAL;
Why user is not allowed to disable(remove) it by
echo 0 ?
> +
> +	error = snapshot_key_init();
> +
> +	return error ? error : n;
> +}
> +
> +power_attr(disk_kmk);
> +#endif /* !CONFIG_HIBERNATION_ENC_AUTH */
> +
>  static ssize_t resume_show(struct kobject *kobj, struct kobj_attribute *attr,
>  			   char *buf)
>  {
> @@ -1138,6 +1171,9 @@ power_attr(reserved_size);
>  
>  static struct attribute * g[] = {
>  	&disk_attr.attr,
> +#ifdef CONFIG_HIBERNATION_ENC_AUTH
> +	&disk_kmk_attr.attr,
> +#endif
>  	&resume_offset_attr.attr,
>  	&resume_attr.attr,
>  	&image_size_attr.attr,
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 9e58bdc8a562..fe2dfa0d4d36 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -4,6 +4,12 @@
>  #include <linux/utsname.h>
>  #include <linux/freezer.h>
>  #include <linux/compiler.h>
> +#include <crypto/sha.h>
> +
> +/* The max size of encrypted key blob */
> +#define KEY_BLOB_BUFF_LEN 512
> +#define SNAPSHOT_KEY_SIZE SHA512_DIGEST_SIZE
> +#define DERIVED_KEY_SIZE SHA512_DIGEST_SIZE
>  
>  struct swsusp_info {
>  	struct new_utsname	uts;
> @@ -20,6 +26,16 @@ struct swsusp_info {
>  extern void __init hibernate_reserved_size_init(void);
>  extern void __init hibernate_image_size_init(void);
>  
> +#ifdef CONFIG_HIBERNATION_ENC_AUTH
> +/* kernel/power/snapshot_key.c */
> +extern int snapshot_key_init(void);
> +extern bool snapshot_key_initialized(void);
> +extern int snapshot_get_auth_key(u8 *auth_key, bool may_sleep);
> +extern int snapshot_get_enc_key(u8 *enc_key, bool may_sleep);
> +#else
> +static inline int snapshot_key_init(void) { return 0; }
> +#endif	/* !CONFIG_HIBERNATION_ENC_AUTH */
> +
>  #ifdef CONFIG_ARCH_HIBERNATION_HEADER
>  /* Maximum size of architecture specific data in a hibernation header */
>  #define MAX_ARCH_HEADER_SIZE	(sizeof(struct new_utsname) + 4)
> diff --git a/kernel/power/snapshot_key.c b/kernel/power/snapshot_key.c
> new file mode 100644
> index 000000000000..091f33929b47
> --- /dev/null
> +++ b/kernel/power/snapshot_key.c
> @@ -0,0 +1,237 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* snapshot keys handler
> + *
> + * Copyright (C) 2018 Lee, Chun-Yi <jlee@suse.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public Licence
> + * as published by the Free Software Foundation; either version
> + * 2 of the Licence, or (at your option) any later version.
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/cred.h>
> +#include <linux/key-type.h>
> +#include <linux/slab.h>
> +#include <crypto/hash.h>
> +#include <crypto/sha.h>
> +#include <keys/trusted-type.h>
> +#include <keys/user-type.h>
> +
> +#include "power.h"
> +
> +static const char hash_alg[] = "sha512";
> +static struct crypto_shash *hash_tfm;
> +
> +/* The master key of snapshot */
> +static struct snapshot_key {
> +	const char *key_name;
> +	bool initialized;
> +	unsigned int key_len;
> +	u8 key[SNAPSHOT_KEY_SIZE];
> +} skey = {
> +	.key_name = "swsusp-kmk",
> +};
> +
> +static int calc_hash(u8 *digest, const u8 *buf, unsigned int buflen,
> +		     bool may_sleep)
calc_hash() is used for both signature and encryption,
could it be integrated in snapshot_key_init() thus
the code could be re-used?
> +{
> +	SHASH_DESC_ON_STACK(desc, hash_tfm);
Per commit c2cd0b08e1efd9ee58d09049a6c77e5efa0ef627
 SHASH_DESC_ON_STACK() should not be used.
> +	int err;
> +
> +	desc->tfm = hash_tfm;
> +	desc->flags = may_sleep ? CRYPTO_TFM_REQ_MAY_SLEEP : 0;
> +
> +	err = crypto_shash_digest(desc, buf, buflen, digest);
Check the err?
> +	shash_desc_zero(desc);
> +	return err;
> +}
> +
> +static int calc_key_hash(u8 *key, unsigned int key_len, const char *salt,
> +			 u8 *hash, bool may_sleep)
> +{
> +	unsigned int salted_buf_len;
> +	u8 *salted_buf;
> +	int ret;
> +
> +	if (!key || !hash_tfm || !hash)
> +		return -EINVAL;
> +
> +	salted_buf_len = strlen(salt) + 1 + SNAPSHOT_KEY_SIZE;
> +	salted_buf = kzalloc(salted_buf_len,
> +			may_sleep ? GFP_KERNEL : GFP_ATOMIC);
> +	if (!salted_buf)
> +		return -ENOMEM;
> +
> +	strcpy(salted_buf, salt);
> +	memcpy(salted_buf + strlen(salted_buf) + 1, key, key_len);
> +
> +	ret = calc_hash(hash, salted_buf, salted_buf_len, may_sleep);
> +	memzero_explicit(salted_buf, salted_buf_len);
> +	kzfree(salted_buf);
> +
> +	return ret;
> +}
> +
> +/* Derive authentication/encryption key */
> +static int get_derived_key(u8 *derived_key, const char *derived_type_str,
> +			   bool may_sleep)
> +{
> +	int ret;
> +
> +	if (!skey.initialized || !hash_tfm)
> +		return -EINVAL;
> +
> +	ret = calc_key_hash(skey.key, skey.key_len, derived_type_str,
> +				derived_key, may_sleep);
> +
> +	return ret;
> +}
> +
> +int snapshot_get_auth_key(u8 *auth_key, bool may_sleep)
> +{
> +	return get_derived_key(auth_key, "AUTH_KEY", may_sleep);
> +}
> +
> +int snapshot_get_enc_key(u8 *enc_key, bool may_sleep)
> +{
> +	return get_derived_key(enc_key, "ENC_KEY", may_sleep);
> +}
> +
> +bool snapshot_key_initialized(void)
> +{
> +	return skey.initialized;
> +}
> +
> +static bool invalid_key(u8 *key, unsigned int key_len)
> +{
> +	int i;
> +
> +	if (!key || !key_len)
> +		return true;
> +
> +	if (key_len > SNAPSHOT_KEY_SIZE) {
> +		pr_warn("Size of swsusp key more than: %d.\n",
> +			SNAPSHOT_KEY_SIZE);
> +		return true;
> +	}
> +
> +	/* zero keyblob is invalid key */
> +	for (i = 0; i < key_len; i++) {
> +		if (key[i] != 0)
> +			return false;
> +	}
> +	pr_warn("The swsusp key should not be zero.\n");
> +
> +	return true;
> +}
> +
> +static int trusted_key_init(void)
> +{
> +	struct trusted_key_payload *tkp;
> +	struct key *key;
> +	int err;
> +
> +	pr_debug("%s\n", __func__);
> +
> +	/* find out swsusp-key */
> +	key = request_key(&key_type_trusted, skey.key_name, NULL);
> +	if (IS_ERR(key)) {
> +		pr_err("Request key error: %ld\n", PTR_ERR(key));
> +		err = PTR_ERR(key);
> +		return err;
> +	}
> +
> +	down_write(&key->sem);
> +	tkp = key->payload.data[0];
> +	if (invalid_key(tkp->key, tkp->key_len)) {
> +		err = -EINVAL;
> +		goto key_invalid;
> +	}
> +	skey.key_len = tkp->key_len;
> +	memcpy(skey.key, tkp->key, tkp->key_len);
> +	/* burn the original key contents */
> +	memzero_explicit(tkp->key, tkp->key_len);
> +
> +key_invalid:
> +	up_write(&key->sem);
> +	key_put(key);
> +
> +	return err;
> +}
> +
> +static int user_key_init(void)
> +{
> +	struct user_key_payload *ukp;
> +	struct key *key;
> +	int err = 0;
> +
> +	pr_debug("%s\n", __func__);
> +
> +	/* find out swsusp-key */
> +	key = request_key(&key_type_user, skey.key_name, NULL);
> +	if (IS_ERR(key)) {
> +		pr_err("Request key error: %ld\n", PTR_ERR(key));
> +		err = PTR_ERR(key);
> +		return err;
> +	}
> +
> +	down_write(&key->sem);
> +	ukp = user_key_payload_locked(key);
> +	if (!ukp) {
> +		/* key was revoked before we acquired its semaphore */
> +		err = -EKEYREVOKED;
> +		goto key_invalid;
> +	}
> +	if (invalid_key(ukp->data, ukp->datalen)) {
> +		err = -EINVAL;
> +		goto key_invalid;
> +	}
> +	skey.key_len = ukp->datalen;
> +	memcpy(skey.key, ukp->data, ukp->datalen);
> +	/* burn the original key contents */
> +	memzero_explicit(ukp->data, ukp->datalen);
> +
> +key_invalid:
> +	up_write(&key->sem);
> +	key_put(key);
> +
> +	return err;
> +}
> +
> +/* this function may sleeps */
> +int snapshot_key_init(void)
> +{
> +	int err;
> +
> +	pr_debug("%s\n", __func__);
> +
> +	if (skey.initialized)
> +		return 0;
> +
> +	hash_tfm = crypto_alloc_shash(hash_alg, 0, CRYPTO_ALG_ASYNC);
> +	if (IS_ERR(hash_tfm)) {
> +		pr_err("Can't allocate %s transform: %ld\n",
> +			hash_alg, PTR_ERR(hash_tfm));
> +		return PTR_ERR(hash_tfm);
> +	}
> +
> +	err = trusted_key_init();
> +	if (err)
> +		err = user_key_init();
> +	if (err)
> +		goto key_fail;
> +
> +	skey.initialized = true;
> +
> +	pr_info("Snapshot key is initialled.\n");
> +
> +	return 0;
> +
> +key_fail:
> +	crypto_free_shash(hash_tfm);
> +	hash_tfm = NULL;
> +
> +	return err;
> +}
> -- 
> 2.13.6
> 
