Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032581AbeCAPnL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:43:11 -0500
Received: from sonic316-19.consmr.mail.bf2.yahoo.com ([74.6.130.193]:36332
        "EHLO sonic316-19.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1031902AbeCAPnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:43:09 -0500
X-YMail-OSG: 8SjNeWIVM1lrkVft3wiol7xXS0QYqxilAvVYSzvqHHdtH8zTMsmYrTnEvKQYBTh
 TPV.qaue23y3JhqalOwH6Y_czuCOrsHWxGK5.ubFqExP5zBVhoJT1vRvcnDzf_dfF9O2eUz.5Bh1
 VEpAbELEAX21avSe98dK6mFB29BKLlFGxDSZ8umiaxbdAOeNQhyPDnncOjlyfCKpj5HKUufkK.JK
 44_HTaqylNuFUIci.AagUBuEqAvEoOyOJwXKfyAifT1_59vYoMYkkeCIe2lqoCyEk.2uOEs7msHQ
 wYLr9.Cwko0_GBOBfhYFYoGQ.Qno9jYN5CgE.UgO1U7W1KqtrAuPGoi3oSNIMVJzx7.LzkVBU5ib
 PiFVKIKbOnzMVtc1Fz7VSxGQitcONgQpxIIuYGNCLmQAtBCIGf3V41zpTxkcldl4_tZtg6KFwzyE
 7eZQD28OEgGuWHiZ3aZ9RV7Vne.zF5.T2zD1FlD5yb8QIzLE4.UDUhuIu0X02jWJWMfSXu0uFxmo
 H4QIX6j.wUqVkMem0FQ6qC_vobydyMfAEf1i9E_jzKB2IHaU-
Subject: Re: [RFC v2 1/2] WhiteEgret: Add WhiteEgret core functions.
To: Masanobu Koike <masanobu2.koike@toshiba.co.jp>, jmorris@namei.org,
        serge@hallyn.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180301073830.2551-1-masanobu2.koike@toshiba.co.jp>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <458a466a-78bc-80d4-4d52-64b92d39f416@schaufler-ca.com>
Date: Thu, 1 Mar 2018 07:43:04 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301073830.2551-1-masanobu2.koike@toshiba.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/2018 11:38 PM, Masanobu Koike wrote:
> This RFC provides implementation of WhiteEgret.
>
> Signed-off-by: Masanobu Koike <masanobu2.koike@toshiba.co.jp>
> ---
>  security/Kconfig                   |   6 +
>  security/Makefile                  |   2 +
>  security/whiteegret/Kconfig        |  11 ++
>  security/whiteegret/Makefile       |   2 +
>  security/whiteegret/init.c         |  75 ++++++++++
>  security/whiteegret/main.c         | 251 +++++++++++++++++++++++++++++++++
>  security/whiteegret/request.c      | 151 ++++++++++++++++++++
>  security/whiteegret/request.h      |  52 +++++++
>  security/whiteegret/we.h           |  66 +++++++++
>  security/whiteegret/we_fs.c        | 280 +++++++++++++++++++++++++++++++++++++
>  security/whiteegret/we_fs.h        |  23 +++
>  security/whiteegret/we_fs_common.h |  36 +++++
>  12 files changed, 955 insertions(+)
>  create mode 100644 security/whiteegret/Kconfig
>  create mode 100644 security/whiteegret/Makefile
>  create mode 100644 security/whiteegret/init.c
>  create mode 100644 security/whiteegret/main.c
>  create mode 100644 security/whiteegret/request.c
>  create mode 100644 security/whiteegret/request.h
>  create mode 100644 security/whiteegret/we.h
>  create mode 100644 security/whiteegret/we_fs.c
>  create mode 100644 security/whiteegret/we_fs.h
>  create mode 100644 security/whiteegret/we_fs_common.h
>
> diff --git a/security/Kconfig b/security/Kconfig
> index c4302067a3ad..f17fefecaf84 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -237,6 +237,7 @@ source security/tomoyo/Kconfig
>  source security/apparmor/Kconfig
>  source security/loadpin/Kconfig
>  source security/yama/Kconfig
> +source security/whiteegret/Kconfig
>  
>  source security/integrity/Kconfig
>  
> @@ -246,6 +247,7 @@ choice
>  	default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
>  	default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
>  	default DEFAULT_SECURITY_APPARMOR if SECURITY_APPARMOR
> +	default DEFAULT_SECURITY_WHITEEGRET if SECURITY_WHITEEGRET
>  	default DEFAULT_SECURITY_DAC
>  
>  	help
> @@ -264,6 +266,9 @@ choice
>  	config DEFAULT_SECURITY_APPARMOR
>  		bool "AppArmor" if SECURITY_APPARMOR=y
>  
> +	config DEFAULT_SECURITY_WHITEEGRET
> +		bool "WhiteEgret" if SECURITY_WHITEEGRET=y
> +

I don't see this module using any security blobs. Is there
a reason you're not making this a minor (like yama) module
instead of a major (like AppArmor) module?

>  	config DEFAULT_SECURITY_DAC
>  		bool "Unix Discretionary Access Controls"
>  
> @@ -275,6 +280,7 @@ config DEFAULT_SECURITY
>  	default "smack" if DEFAULT_SECURITY_SMACK
>  	default "tomoyo" if DEFAULT_SECURITY_TOMOYO
>  	default "apparmor" if DEFAULT_SECURITY_APPARMOR
> +	default "whiteegret" if DEFAULT_SECURITY_WHITEEGRET
>  	default "" if DEFAULT_SECURITY_DAC
>  
>  endmenu
> diff --git a/security/Makefile b/security/Makefile
> index 4d2d3782ddef..3a8249c77288 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -10,6 +10,7 @@ subdir-$(CONFIG_SECURITY_TOMOYO)        += tomoyo
>  subdir-$(CONFIG_SECURITY_APPARMOR)	+= apparmor
>  subdir-$(CONFIG_SECURITY_YAMA)		+= yama
>  subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
> +subdir-$(CONFIG_SECURITY_WHITEEGRET)	+= whiteegret
>  
>  # always enable default capabilities
>  obj-y					+= commoncap.o
> @@ -25,6 +26,7 @@ obj-$(CONFIG_SECURITY_TOMOYO)		+= tomoyo/
>  obj-$(CONFIG_SECURITY_APPARMOR)		+= apparmor/
>  obj-$(CONFIG_SECURITY_YAMA)		+= yama/
>  obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
> +obj-$(CONFIG_SECURITY_WHITEEGRET)	+= whiteegret/
>  obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
>  
>  # Object integrity file lists
> diff --git a/security/whiteegret/Kconfig b/security/whiteegret/Kconfig
> new file mode 100644
> index 000000000000..32845977745f
> --- /dev/null
> +++ b/security/whiteegret/Kconfig
> @@ -0,0 +1,11 @@
> +config SECURITY_WHITEEGRET
> +        bool "WhiteEgret support"
> +        depends on SECURITY
> +        default n
> +        help
> +	  This enables the WhiteEgret security module.
> +	  WhiteEgret provides a whitelisting execution control capability,
> +	  which helps stop the execution of unauthorized software
> +	  such as malware.
> +	  You will also need a user application and an execution whitelist.
> +          If you are unsure how to answer this question, answer N.
> diff --git a/security/whiteegret/Makefile b/security/whiteegret/Makefile
> new file mode 100644
> index 000000000000..16bd3afd9324
> --- /dev/null
> +++ b/security/whiteegret/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_SECURITY_WHITEEGRET) += whiteegret.o
> +whiteegret-y := init.o main.o request.o we_fs.o
> diff --git a/security/whiteegret/init.c b/security/whiteegret/init.c
> new file mode 100644
> index 000000000000..3691cca6bc27
> --- /dev/null
> +++ b/security/whiteegret/init.c
> @@ -0,0 +1,75 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017-2018 Toshiba Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation, version 2.
> + */
> +
> +#define pr_fmt(fmt) "WhiteEgret: " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/security.h>
> +#include <linux/fs.h>
> +#include "we.h"
> +
> +#include <linux/lsm_hooks.h>
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("WhiteEgret Linux Security Module");
> +
> +static int we_security_bprm_check(struct linux_binprm *bprm)
> +{
> +	if (we_security_bprm_check_main(bprm) == -EACCES)
> +		return -EACCES;
> +
> +	return 0;
> +}
> +
> +static int we_security_mmap_check(struct file *file, unsigned long reqprot,
> +		unsigned long prot, unsigned long flags)
> +{
> +	if (we_security_mmap_check_main(file, reqprot, flags) == -EACCES)
> +		return -EACCES;
> +
> +	return 0;
> +}
> +
> +static struct security_hook_list we_hooks[] = {
> +	LSM_HOOK_INIT(bprm_check_security, we_security_bprm_check),
> +	LSM_HOOK_INIT(mmap_file, we_security_mmap_check),
> +};
> +
> +static int __init we_init(void)
> +{
> +	int rc;
> +
> +	if (!security_module_enable("whiteegret"))
> +		return 0;
> +
> +	security_add_hooks(we_hooks, ARRAY_SIZE(we_hooks), "whiteegret");
> +
> +	rc = we_specific_init();
> +	if (rc) {
> +		pr_err("error %d at %d in %s\n", rc, __LINE__, __FILE__);
> +		return rc;
> +	}
> +
> +	pr_warn("WhiteEgret (LSM) initialized.\n");
> +
> +	return 0;
> +}
> +
> +static void __exit we_exit(void)
> +{
> +	we_specific_exit();
> +
> +	pr_warn("WhiteEgret (LSM) exited.\n");
> +}
> +
> +module_init(we_init);
> +module_exit(we_exit);
> diff --git a/security/whiteegret/main.c b/security/whiteegret/main.c
> new file mode 100644
> index 000000000000..f60e1d325011
> --- /dev/null
> +++ b/security/whiteegret/main.c
> @@ -0,0 +1,251 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017-2018 Toshiba Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation, version 2.
> + */
> +
> +#define pr_fmt(fmt) "WhiteEgret: " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/semaphore.h>
> +#include <linux/binfmts.h>
> +#include <linux/dcache.h>
> +#include <linux/fs.h>
> +#include <linux/mman.h>
> +#include "we.h"
> +#include "request.h"
> +
> +#include <linux/sched.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include "we_fs.h"
> +
> +
> +static int send_receive_we_obj_info(
> +		struct we_obj_info *we_obj_info, int *checkresult);
> +
> +/**
> + * we_specific_init - Initialize fs.
> + *
> + * Returns 0.
> + */
> +int we_specific_init(void)
> +{
> +	int rc = 0;
> +
> +	rc = we_fs_init();
> +	if (rc < 0) {
> +		pr_err("error %d at %d in %s\n", rc, __LINE__, __FILE__);
> +		return rc;
> +	}
> +
> +	we_req_q_head_init();
> +
> +	return 0;
> +}
> +
> +/**
> + * we_specific_exit - Nothing to do in the implementation.
> + *
> + * Returns 0.
> + */
> +int we_specific_exit(void)
> +{
> +	return 0;
> +}
> +
> +/**
> + * we_check_main - Common function for security_bprm_check and mmap_file.
> + *
> + * @file: Pointer to struct file.
> + *
> + * Returns 0 if succeeded, < 0 otherwise.
> + */
> +int we_check_main(struct file *file)
> +{
> +	struct inode *inode;
> +	struct we_obj_info we_obj_info;
> +	char *pathnamebuf;
> +	char *new_pathnamebuf;
> +	char *pathname;
> +	char *shortnamebuf;
> +	int pathsize;
> +	int rc;
> +	int i;
> +	int checkresult;
> +
> +	if (unlikely(file == NULL))
> +		return 0;
> +
> +	pathsize = EXPECTPATHSIZE;
> +	pathnamebuf = kmalloc(pathsize, GFP_KERNEL);
> +	if (unlikely(!pathnamebuf)) {
> +		rc = -ENOMEM;
> +		pr_err("error %d at %d in %s\n", rc, __LINE__, __FILE__);
> +		goto failure;
> +	}
> +	while (pathsize <= MAXPATHSIZE) {
> +		pathname = d_absolute_path(&file->f_path, pathnamebuf,
> +				pathsize-1);
> +		if (!IS_ERR(pathname))
> +			break;
> +
> +		pathsize += ADDEDEXPECTPATHSIZE;
> +		new_pathnamebuf = krealloc(pathnamebuf, pathsize,
> +				GFP_KERNEL);
> +		if (unlikely(!new_pathnamebuf)) {
> +			rc = -ENOMEM;
> +			pr_err("error %d at %d in %s\n", rc,
> +					__LINE__, __FILE__);
> +			goto failure;
> +		}
> +		pathnamebuf = new_pathnamebuf;
> +	}
> +	if (unlikely(pathsize >= MAXPATHSIZE)) {
> +		rc = -ENOMEM;
> +		pr_err("error %d at %d in %s\n", rc, __LINE__, __FILE__);
> +		goto failure;
> +	}
> +
> +	shortnamebuf = pathname;
> +	for (i = 0; i < pathsize; i++) {
> +		if (pathname[i] == '\0')
> +			break;
> +		if (pathname[i] == '/')
> +			shortnamebuf = pathname + (i + 1);
> +	}
> +	strncpy(we_obj_info.shortname, shortnamebuf, SHORTNAMELENGTH);
> +	we_obj_info.path = pathname;
> +	inode = file_inode(file);
> +	we_obj_info.ino = inode->i_ino;
> +	we_obj_info.dmajor = MAJOR(inode->i_sb->s_dev);
> +	we_obj_info.dminor = MINOR(inode->i_sb->s_dev);
> +	we_obj_info.pid = current->pid;
> +	we_obj_info.pathsize = strlen(pathname);
> +	we_obj_info.ppid = current->tgid;
> +
> +	rc = send_receive_we_obj_info(&we_obj_info, &checkresult);
> +	if (rc < 0)
> +		goto failure;
> +
> +	rc = checkresult;
> +
> +	if (rc == -EACCES)
> +		pr_warn("block %s, ino=%ld, devno=0x%x.\n",
> +			pathname, we_obj_info.ino,
> +			MKDEV(we_obj_info.dmajor, we_obj_info.dminor));
> +	else
> +		pr_info("permit %s, ino=%ld, devno=0x%x.\n",
> +			pathname, we_obj_info.ino,
> +			MKDEV(we_obj_info.dmajor, we_obj_info.dminor));
> +
> +failure:
> +	if (pathnamebuf != NULL) {
> +		kfree(pathnamebuf);
> +		pathnamebuf = NULL;
> +	}
> +
> +	if ((rc != 0) && (rc != -EACCES))
> +		pr_warn("Checking white list does not work.\n");
> +
> +	return rc;
> +}
> +
> +/**
> + * send_receive_we_obj_info - Send message and wait.
> + *
> + * @we_obj_info: Pointer to struct we_obj_info.
> + * @result: Pointer to result of matching to white list.
> + *
> + * Returns 0 if succeeded, < 0 otherwise.
> + */
> +static int send_receive_we_obj_info(
> +		struct we_obj_info *we_obj_info, int *checkresult)
> +{
> +	int i;
> +	int rc;
> +	struct we_req_q req;
> +
> +	we_req_q_init(&req, we_obj_info);
> +
> +	if ((we_req_q_search(&(req.data))) == NULL) {
> +		rc = we_req_q_push(&req);
> +		if (rc < 0) {
> +			pr_err("error %d at %d in %s\n", rc,
> +					__LINE__, __FILE__);
> +			goto failure;
> +		}
> +	}
> +
> +	for (i = 0; i < MAXCOMRETRY; i++) {
> +		rc = send_we_obj_info(&req);
> +
> +		if (likely(req.finish_flag == START_EXEC)) {
> +			break;
> +		} else if (unlikely(rc == -ERESTARTSYS)) {
> +			pr_info("Signal detected (%d)\n", rc);
> +			break;
> +		}
> +	}
> +
> +	we_req_q_pop(&req);
> +
> +	if (unlikely(i >= MAXCOMRETRY) && req.finish_flag != START_EXEC) {
> +		rc = -EINVAL;
> +		pr_err("error %d at %d in %s\n", rc, __LINE__, __FILE__);
> +	}
> +
> +	*checkresult = req.permit;
> +
> +failure:
> +	return rc;
> +}
> +
> +/**
> + * we_security_bprm_check_main - Target for security_bprm_check.
> + *
> + * @bprm: Pointer to struct linux_binprm.
> + *
> + * Returns 0 if succeeded, < 0 otherwise.
> + */
> +int we_security_bprm_check_main(struct linux_binprm *bprm)
> +{
> +	if (unlikely(!from_task))
> +		return 0;
> +
> +	return we_check_main(bprm->file);
> +}
> +
> +/**
> + * we_security_mmap_check_main - Target for mmap_file.
> + *
> + * @file: Pointer to struct file to map.
> + * @reqprot: Protection requested by the application.
> + * @flags: Operational flags.
> + *
> + * Returns 0 if succeeded, < 0 otherwise.
> + */
> +int we_security_mmap_check_main(struct file *file,
> +		unsigned long reqprot, unsigned long flags)
> +{
> +	if (unlikely(!from_task))
> +		return 0;
> +
> +	if (!(reqprot & PROT_EXEC))
> +		return 0;
> +
> +	if ((flags & MAP_EXECUTABLE))
> +		return 0;
> +
> +	if (!file)
> +		return 0;
> +
> +	if (!file->f_path.dentry)
> +		return 0;
> +
> +	return we_check_main(file);
> +}
> diff --git a/security/whiteegret/request.c b/security/whiteegret/request.c
> new file mode 100644
> index 000000000000..7d28e133ebd6
> --- /dev/null
> +++ b/security/whiteegret/request.c
> @@ -0,0 +1,151 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017-2018 Toshiba Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation, version 2.
> + */
> +
> +#include <linux/list.h>
> +#include <linux/spinlock.h>
> +#include <linux/rwlock_types.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include "request.h"
> +
> +struct we_req_q_head we_q_head;
> +
> +static int match_we_req_data(struct we_req_data *data1,
> +		struct we_req_data *data2);
> +
> +/**
> + * we_req_q_init - Initialize the global variable we_q_head.
> + *
> + * Returns 0.
> + */
> +int we_req_q_head_init(void)
> +{
> +	rwlock_init(&(we_q_head.lock));
> +	INIT_LIST_HEAD(&(we_q_head.head));
> +	init_waitqueue_head(&(we_q_head.waitq));
> +
> +	return 0;
> +}
> +
> +/**
> + * we_req_q_push - Add queue to tail of the list.
> + *
> + * @queue: Pointer to we_req_q to be added to the list.
> + *
> + * Returns 0.
> + */
> +int we_req_q_push(struct we_req_q *queue)
> +{
> +	write_lock(&(we_q_head.lock));
> +	list_add_tail(&(queue->queue), &we_q_head.head);
> +	write_unlock(&(we_q_head.lock));
> +
> +	return 0;
> +}
> +
> +/**
> + * we_req_q_search - Search data in the list.
> + *
> + * @data: Pointer to we_req_data to be searched in the list.
> + *
> + * Returns pointer to data if data is found in the list,
> + * NULL otherwise.
> + */
> +struct we_req_q *we_req_q_search(struct we_req_data *data)
> +{
> +	struct list_head *p;
> +	struct we_req_q *req;
> +
> +	read_lock(&(we_q_head.lock));
> +
> +	list_for_each(p, &(we_q_head.head)) {
> +		req = list_entry(p, struct we_req_q, queue);
> +
> +		if (match_we_req_data(data, &(req->data))) {
> +			read_unlock(&(we_q_head.lock));
> +			return req;
> +		}
> +	}
> +
> +	read_unlock(&(we_q_head.lock));
> +
> +	return NULL;
> +}
> +
> +/**
> + * we_req_q_init - Initialize queue.
> + *
> + * @req: Pointer to we_req_q to be initialized.
> + * @info: Pointer to we_obj_info.
> + *
> + * Returns 0.
> + */
> +int we_req_q_init(struct we_req_q *req, struct we_obj_info *info)
> +{
> +	req->finish_flag = STOP_EXEC;
> +	req->data.we_obj_info = info;
> +	req->permit = -EACCES;
> +	init_waitqueue_head(&req->waitq);
> +
> +	return 0;
> +}
> +
> +/**
> + * we_req_q_pop - Delete queue in the list.
> + *
> + * Returns 0.
> + */
> +int we_req_q_pop(struct we_req_q *queue)
> +{
> +	write_lock(&(we_q_head.lock));
> +	list_del(&queue->queue);
> +	write_unlock(&(we_q_head.lock));
> +
> +	return 0;
> +}
> +
> +/**
> + * match_we_req_data - Compare two we_req_data data.
> + *
> + * @data1: Pointer to we_req_data
> + * @data2: Pointer to we_req_data
> + *
> + * Returns 1 if ppid of both we_req_data data are equal,
> + * 0 otherwise.
> + */
> +static int match_we_req_data(struct we_req_data *data1,
> +		struct we_req_data *data2)
> +{
> +	if (data1->we_obj_info->ppid == data2->we_obj_info->ppid)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/**
> + * we_req_q_cleanup - Cleaning up queues.
> + *
> + * Returns 0.
> + */
> +int we_req_q_cleanup(void)
> +{
> +	struct list_head *p;
> +	struct we_req_q *req;
> +
> +	write_lock(&(we_q_head.lock));
> +	list_for_each(p, &we_q_head.head) {
> +		req = list_entry(p, struct we_req_q, queue);
> +		req->finish_flag = START_EXEC;
> +		req->permit = -EINVAL;
> +	}
> +	write_unlock(&(we_q_head.lock));
> +
> +	return 0;
> +}
> diff --git a/security/whiteegret/request.h b/security/whiteegret/request.h
> new file mode 100644
> index 000000000000..4a735fc70c63
> --- /dev/null
> +++ b/security/whiteegret/request.h
> @@ -0,0 +1,52 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017-2018 Toshiba Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation, version 2.
> + */
> +
> +#ifndef _REQUEST_H
> +#define _REQUEST_H
> +
> +#include <linux/sched.h>
> +#include <linux/wait.h>
> +
> +#include "we.h"
> +
> +struct we_req_q_head {
> +	struct list_head head;
> +	rwlock_t lock;
> +	wait_queue_head_t waitq;
> +};
> +
> +
> +#define STOP_EXEC  0
> +#define START_EXEC 1
> +
> +extern struct we_req_q_head we_q_head;
> +
> +/* Structure for information of request from kernel space to user space */
> +struct we_req_data {
> +	struct we_obj_info *we_obj_info;
> +};
> +
> +struct we_req_q {
> +	struct list_head queue;
> +	int finish_flag;
> +	struct we_req_data data;
> +	int permit;
> +	wait_queue_head_t waitq;
> +};
> +
> +int we_req_q_pop(struct we_req_q *queue);
> +int we_req_q_cleanup(void);
> +
> +int we_req_q_head_init(void);
> +int we_req_q_init(struct we_req_q *req, struct we_obj_info *info);
> +int we_req_q_push(struct we_req_q *queue);
> +struct we_req_q *we_req_q_search(struct we_req_data *data);
> +
> +#endif  /* _REQUEST_H */
> diff --git a/security/whiteegret/we.h b/security/whiteegret/we.h
> new file mode 100644
> index 000000000000..fc14e67d4f7d
> --- /dev/null
> +++ b/security/whiteegret/we.h
> @@ -0,0 +1,66 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017-2018 Toshiba Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation, version 2.
> + */
> +
> +#ifndef _WE_H
> +#define _WE_H
> +
> +#include <linux/binfmts.h>
> +
> +/*
> + * Initial size in byte of memory allocation to store the path
> + * of an object file
> + */
> +#define EXPECTPATHSIZE 1023
> +
> +/*
> + * Default size in byte to expand block that stores the path
> + * of an object file when the memory block is too small
> + * to store the path
> + */
> +#define ADDEDEXPECTPATHSIZE 1023
> +
> +/* Maximum length in byte of path of object file */
> +#define MAXPATHSIZE 8184
> +
> +/* Maximum length in byte of name of executable file */
> +#define SHORTNAMELENGTH 256
> +
> +/*
> + * Maximum number of retry for sending the same message
> + * to user whitelisting application
> + */
> +#define MAXCOMRETRY 10
> +
> +/* Timeout value in millisecond to aquire the semaphore */
> +#define WERESULTTIMEOUT 1000
> +
> +/*
> + * Structure for an object to be tested whether it is contained
> + * in the whitelist or not
> + */
> +struct we_obj_info {
> +	unsigned long ino;                /* inode number */
> +	unsigned int dmajor;              /* major version of device number */
> +	unsigned int dminor;              /* minor version of device number */
> +	char shortname[SHORTNAMELENGTH];  /* short name for the object */
> +	int pathsize;
> +	char *path;                       /* full path to the object */
> +	pid_t pid;
> +	pid_t ppid;
> +};
> +
> +int we_security_bprm_check_main(struct linux_binprm *bprm);
> +int we_security_mmap_check_main(struct file *file,
> +		unsigned long reqprot, unsigned long flags);
> +
> +int we_specific_init(void);
> +int we_specific_exit(void);
> +
> +#endif  /* _WE_H */
> diff --git a/security/whiteegret/we_fs.c b/security/whiteegret/we_fs.c
> new file mode 100644
> index 000000000000..27b76f093814
> --- /dev/null
> +++ b/security/whiteegret/we_fs.c
> @@ -0,0 +1,280 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017-2018 Toshiba Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation, version 2.
> + */
> +
> +#define pr_fmt(fmt) "WhiteEgret: " fmt
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/security.h>
> +#include <linux/init.h>
> +#include <linux/fs.h>
> +#include <linux/wait.h>
> +#include <linux/sched.h>
> +#include <linux/uaccess.h>
> +#include <linux/cdev.h>
> +
> +#include "we_fs.h"
> +
> +#define static_assert(constexpr) \
> +	char dummy[(constexpr) ? 1 : -1] __attribute__((unused))
> +
> +#define WE_COPY_TO_USER(to, from, ret) \
> +	do { \
> +		static_assert(sizeof((to)) == sizeof((from))); \
> +		(ret) = copy_to_user(&(to), &(from), sizeof(to)); \
> +	} while (0)
> +
> +#define WE_COPY_FROM_USER(to, from, ret) \
> +	do { \
> +		static_assert(sizeof((to)) == sizeof((from))); \
> +		(ret) = copy_from_user(&(to), &(from), sizeof(to)); \
> +	} while (0)
> +
> +static struct we_req_q_head *root;
> +struct task_struct *from_task;
> +static DEFINE_RWLOCK(from_task_lock);
> +
> +static int check_we_pathsize(struct we_req_q *we_req, int size)
> +{
> +	if (size - sizeof(*we_req)
> +			> we_req->data.we_obj_info->pathsize)
> +		return 0;
> +	else
> +		return -1;
> +}
> +
> +static int set_we_req_info(struct we_req_user *user,
> +		struct we_obj_info *info)
> +{
> +	unsigned long ret;
> +
> +	WE_COPY_TO_USER(user->ino, info->ino, ret);
> +	if (ret != 0)
> +		return -EFAULT;
> +	WE_COPY_TO_USER(user->dmajor, info->dmajor, ret);
> +	if (ret != 0)
> +		return -EFAULT;
> +	WE_COPY_TO_USER(user->dminor, info->dminor, ret);
> +	if (ret != 0)
> +		return -EFAULT;
> +	WE_COPY_TO_USER(user->pid, info->pid, ret);
> +	if (ret != 0)
> +		return -EFAULT;
> +	WE_COPY_TO_USER(user->ppid, info->ppid, ret);
> +	if (ret != 0)
> +		return -EFAULT;
> +	WE_COPY_TO_USER(user->shortname, info->shortname, ret);
> +	if (ret != 0)
> +		return -EFAULT;
> +	WE_COPY_TO_USER(user->pathsize, info->pathsize, ret);
> +	if (ret != 0)
> +		return -EFAULT;
> +	ret = copy_to_user(user->path, info->path, info->pathsize + 1);
> +	if (ret != 0)
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int set_we_ack(struct we_ack *to, struct we_ack *from)
> +{
> +	unsigned long ret;
> +
> +	WE_COPY_FROM_USER(to->pid, from->pid, ret);
> +	if (ret != 0)
> +		return -EFAULT;
> +	WE_COPY_FROM_USER(to->permit, from->permit, ret);
> +	if (ret != 0)
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static struct we_req_user *get_alive_we_req(struct we_req_q_head *root,
> +		void *buf, int size)
> +{
> +	int pathsize;
> +	struct list_head *p;
> +	struct we_req_q *req;
> +	struct we_req_user *user = NULL;
> +
> +	write_lock(&root->lock);
> +	list_for_each(p, &root->head) {
> +		req = list_entry(p, struct we_req_q, queue);
> +		if (req->finish_flag == STOP_EXEC) {
> +			if (unlikely(check_we_pathsize(req, size)))
> +				goto SIZE_ERROR;
> +			user = (struct we_req_user *)buf;
> +			set_we_req_info(user, req->data.we_obj_info);
> +			break;
> +		}
> +	}
> +	write_unlock(&root->lock);
> +
> +	return user;
> +SIZE_ERROR:
> +	pathsize = req->data.we_obj_info->pathsize;
> +	req->permit = -EACCES;
> +	req->finish_flag = START_EXEC;
> +	write_unlock(&root->lock);
> +	pr_err("Path length of exec is too long (%d).\n", pathsize);
> +	return NULL;
> +}
> +
> +static ssize_t send_ack(struct we_req_q_head *root, struct we_ack *ack)
> +{
> +	struct list_head *p;
> +	struct we_req_q *req = NULL, *temp;
> +
> +	write_lock(&root->lock);
> +	list_for_each(p, &root->head) {
> +		temp = list_entry(p, struct we_req_q, queue);
> +		if (temp->data.we_obj_info->pid == ack->pid) {
> +			req = temp;
> +			req->permit = ack->permit;
> +			wake_up_interruptible_sync(&req->waitq);
> +			req->finish_flag = START_EXEC;
> +		}
> +	}
> +	write_unlock(&root->lock);
> +
> +	if (unlikely(!req)) {
> +		pr_warn("%s: can not find we_req. pid(%d)\n",
> +			__func__, ack->pid);
> +		return -EACCES;
> +	}
> +	return sizeof(*ack);
> +}
> +
> +static ssize_t we_driver_read(struct file *file, char *buf,
> +		size_t size, loff_t *off)
> +{
> +	int ret;
> +	struct we_req_user *user;
> +
> +	while (1) {
> +		ret = wait_event_interruptible(root->waitq,
> +				(user = get_alive_we_req(root, buf, size)));
> +		if (unlikely(ret < 0)) {
> +			pr_info("%s: signal (%d)", __func__, ret);
> +			return 0;
> +		}
> +		if (likely(user))
> +			break;
> +	}
> +
> +	return sizeof(*user) + user->pathsize + 1;
> +}
> +
> +static ssize_t we_driver_write(struct file *file, const char *buf,
> +		size_t size, loff_t *off)
> +{
> +	int rc;
> +	ssize_t ret;
> +	struct we_ack ack;
> +
> +	rc = set_we_ack(&ack, (struct we_ack *)((void *)buf));
> +	if (rc < 0)
> +		return (ssize_t)rc;
> +	ret = send_ack(root, &ack);
> +
> +	return ret;
> +}
> +
> +static long we_driver_ioctl(struct file *file,
> +		unsigned int arg0, unsigned long arg1)
> +{
> +	return 0;
> +}
> +
> +static int we_driver_release(struct inode *inode, struct file *filp)
> +{
> +	int ret = 0;
> +
> +	write_lock(&from_task_lock);
> +	if (!from_task) {
> +		pr_warn("WhiteEgret has not started.\n");
> +		ret =  -EACCES;
> +		goto END;
> +	}
> +	if (from_task != current) {
> +		pr_warn("This task is not registered to WhiteEgret.\n");
> +		ret = -EACCES;
> +		goto END;
> +	}
> +	from_task = NULL;
> +	we_req_q_cleanup();
> +END:
> +	write_unlock(&from_task_lock);
> +	return ret;
> +}
> +
> +static int we_driver_open(struct inode *inode, struct file *filp)
> +{
> +	write_lock(&from_task_lock);
> +	if (from_task) {
> +		write_unlock(&(from_task_lock));
> +		pr_warn("WhiteEgret has already started.\n");
> +		return -EACCES;
> +	}
> +
> +	from_task = current;
> +	root = &we_q_head;
> +	write_unlock(&from_task_lock);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations we_driver_fops = {
> +	.owner = THIS_MODULE,
> +	.read = we_driver_read,
> +	.write = we_driver_write,
> +	.unlocked_ioctl = we_driver_ioctl,
> +	.open =  we_driver_open,
> +	.release = we_driver_release,
> +};
> +
> +int we_fs_init(void)
> +{
> +	struct dentry *we_dir;
> +	struct dentry *wecom;
> +
> +	we_dir = securityfs_create_dir(WE_FS_DIR_NAME, NULL);
> +	if (IS_ERR(we_dir))
> +		return PTR_ERR(we_dir);
> +
> +	wecom = securityfs_create_file(WE_DEV_NAME, 0600, we_dir, NULL, &we_driver_fops);
> +	if (IS_ERR(wecom)) {
> +		securityfs_remove(we_dir);
> +		return PTR_ERR(wecom);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * send_we_obj_info - Wait response from user's whitelisting application.
> + *
> + * @req: Pointer to struct we_req_q.
> + *
> + * Returns 0 if succeeded, < 0 otherwise.
> + */
> +int send_we_obj_info(struct we_req_q *req)
> +{
> +	/* If there exists queue waiting for this request req done,
> +	 * then wake it up.
> +	 */
> +	if (waitqueue_active(&(we_q_head.waitq)))
> +		wake_up(&(we_q_head.waitq));
> +
> +	return wait_event_interruptible_timeout(req->waitq,
> +			(req->finish_flag == START_EXEC),
> +			WERESULTTIMEOUT);
> +}
> diff --git a/security/whiteegret/we_fs.h b/security/whiteegret/we_fs.h
> new file mode 100644
> index 000000000000..9af245d7aca4
> --- /dev/null
> +++ b/security/whiteegret/we_fs.h
> @@ -0,0 +1,23 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017-2018 Toshiba Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation, version 2.
> + */
> +
> +#ifndef _WE_FS_H
> +#define _WE_FS_H
> +
> +#include "request.h"
> +#include "we_fs_common.h"
> +
> +extern struct task_struct *from_task;
> +
> +int we_fs_init(void);
> +
> +int send_we_obj_info(struct we_req_q *req);
> +
> +#endif  /* _WE_FS_H */
> diff --git a/security/whiteegret/we_fs_common.h b/security/whiteegret/we_fs_common.h
> new file mode 100644
> index 000000000000..259f300d9738
> --- /dev/null
> +++ b/security/whiteegret/we_fs_common.h
> @@ -0,0 +1,36 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017-2018 Toshiba Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation, version 2.
> + */
> +
> +#ifndef _WE_FS_COMMON_H
> +#define _WE_FS_COMMON_H
> +
> +#define WE_FS_DIR_NAME "whiteegret"
> +#define WE_DEV_NAME "wecom"
> +#define WE_DEV_PATH "/sys/kernel/security/"WE_FS_DIR_NAME"/"WE_DEV_NAME
> +
> +#define SHORTNAMELENGTH 256
> +
> +struct we_req_user {
> +	unsigned long ino;
> +	unsigned int dmajor;
> +	unsigned int dminor;
> +	pid_t pid;
> +	pid_t ppid;
> +	char shortname[SHORTNAMELENGTH];
> +	int pathsize;
> +	char path[0];
> +};
> +
> +struct we_ack {
> +	int permit;
> +	pid_t pid;
> +};
> +
> +#endif  /* _WE_FS_COMMON_H */
