Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE23FFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E9D20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E9D20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeINNZe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:25:34 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:28592 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeINNZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:25:34 -0400
X-IronPort-AV: E=Sophos;i="5.53,372,1531785600"; 
   d="scan'208";a="79046966"
From:   Paul Durrant <Paul.Durrant@citrix.com>
To:     'Dongli Zhang' <dongli.zhang@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>, Wei Liu <wei.liu2@citrix.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        "srinivas.eeda@oracle.com" <srinivas.eeda@oracle.com>
Subject: RE: [PATCH 1/6] xenbus: prepare data structures and parameter for
 xenwatch multithreading
Thread-Topic: [PATCH 1/6] xenbus: prepare data structures and parameter for
 xenwatch multithreading
Thread-Index: AQHUS/1KIp73h3xTd02qYMZ3GAH4yqTvZ8iA
Date:   Fri, 14 Sep 2018 08:11:59 +0000
Message-ID: <15e757cf57c241768d188470420b447c@AMSPEX02CL03.citrite.net>
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
 <1536910456-13337-2-git-send-email-dongli.zhang@oracle.com>
In-Reply-To: <1536910456-13337-2-git-send-email-dongli.zhang@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Dongli Zhang [mailto:dongli.zhang@oracle.com]
> Sent: 14 September 2018 08:34
> To: xen-devel@lists.xenproject.org; linux-kernel@vger.kernel.org
> Cc: boris.ostrovsky@oracle.com; jgross@suse.com; Paul Durrant
> <Paul.Durrant@citrix.com>; Wei Liu <wei.liu2@citrix.com>;
> konrad.wilk@oracle.com; Roger Pau Monne <roger.pau@citrix.com>;
> srinivas.eeda@oracle.com
> Subject: [PATCH 1/6] xenbus: prepare data structures and parameter for
> xenwatch multithreading
> 
> This is the 1st patch of a (6-patch) patch set.
> 
> This patch set of six patches introduces xenwatch multithreading (or
> multithreaded xenwatch, abbreviated as 'mtwatch') to dom0 kernel. In
> addition to the existing single xenwatch thread, each domU has its own
> kernel thread ([xen-mtwatch-<domid>]) to process its xenwatch event.
> 

^ You need to put comments like this in a cover letter. Each patch needs to stand on its own merit and the comments should only relate to the context of that patch or a 'subsequent patch'.

> A kernel parameter 'xen_mtwatch' is introduced to control whether the
> feature is enabled or not during dom0 kernel boot. The feature is disabled
> by default if 'xen_mtwatch' is not set in grub. 

Why is it disabled by default? Concerns about resource consumption?

> In addition, this patch
> also introduces the data structures to maintain the status of each per-
> domU
> xenwatch thread. The status of each xenwatch thread (except the default
> one) is maintained by a mtwatch domain.
> 
> The feature is available only on dom0.

Whilst I can see it is intended for a backend domain, why limit it to dom0? What about driver domains?

> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  3 ++
>  drivers/xen/xenbus/xenbus_xs.c                  | 31 ++++++++++++
>  include/xen/xenbus.h                            | 65
> +++++++++++++++++++++++++
>  3 files changed, 99 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index 64a3bf5..fc295ef 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4992,6 +4992,9 @@
>  				the unplug protocol
>  			never -- do not unplug even if version check succeeds
> 
> +	xen_mtwatch     [KNL,XEN]
> +			Enables the multithreaded xenwatch (mtwatch).
> +
>  	xen_nopvspin	[X86,XEN]
>  			Disables the ticketlock slowpath using Xen PV
>  			optimizations.
> diff --git a/drivers/xen/xenbus/xenbus_xs.c
> b/drivers/xen/xenbus/xenbus_xs.c
> index 49a3874..3f137d2 100644
> --- a/drivers/xen/xenbus/xenbus_xs.c
> +++ b/drivers/xen/xenbus/xenbus_xs.c
> @@ -95,6 +95,19 @@ static pid_t xenwatch_pid;
>  static DEFINE_MUTEX(xenwatch_mutex);
>  static DECLARE_WAIT_QUEUE_HEAD(watch_events_waitq);
> 
> +bool xen_mtwatch;
> +EXPORT_SYMBOL_GPL(xen_mtwatch);
> +
> +struct mtwatch_info *mtwatch_info;
> +
> +static bool param_xen_mtwatch;
> +static __init int xen_parse_mtwatch(char *arg)
> +{
> +	param_xen_mtwatch = true;
> +	return 0;
> +}
> +early_param("xen_mtwatch", xen_parse_mtwatch);
> +
>  static void xs_suspend_enter(void)
>  {
>  	spin_lock(&xs_state_lock);
> @@ -929,6 +942,24 @@ int xs_init(void)
>  	if (err)
>  		return err;
> 
> +	if (xen_initial_domain() && param_xen_mtwatch) {
> +		int i;
> +
> +		mtwatch_info = kmalloc(sizeof(*mtwatch_info), GFP_KERNEL);
> +
> +		for (i = 0; i < MTWATCH_HASH_SIZE; i++)
> +			INIT_HLIST_HEAD(&mtwatch_info->domain_hash[i]);
> +		spin_lock_init(&mtwatch_info->domain_lock);
> +		INIT_LIST_HEAD(&mtwatch_info->domain_list);
> +
> +		spin_lock_init(&mtwatch_info->purge_lock);
> +		INIT_LIST_HEAD(&mtwatch_info->purge_list);
> +
> +		xen_mtwatch = true;
> +
> +		pr_info("xenwatch multithreading is enabled\n");
> +	}
> +
>  	task = kthread_run(xenwatch_thread, NULL, "xenwatch");
>  	if (IS_ERR(task))
>  		return PTR_ERR(task);
> diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> index 869c816..e807114 100644
> --- a/include/xen/xenbus.h
> +++ b/include/xen/xenbus.h
> @@ -62,6 +62,13 @@ struct xenbus_watch
>  	/* Callback (executed in a process context with no locks held). */
>  	void (*callback)(struct xenbus_watch *,
>  			 const char *path, const char *token);
> +
> +	/* Callback to help calculate the domid the path belongs to */
> +	domid_t (*get_domid)(struct xenbus_watch *watch,
> +			     const char *path, const char *token);
> +
> +	/* The owner's domid if the watch is for a specific domain */
> +	domid_t owner_id;
>  };
> 
> 
> @@ -93,6 +100,7 @@ struct xenbus_device_id
>  struct xenbus_driver {
>  	const char *name;       /* defaults to ids[0].devicetype */
>  	const struct xenbus_device_id *ids;
> +	bool use_mtwatch;
>  	int (*probe)(struct xenbus_device *dev,
>  		     const struct xenbus_device_id *id);
>  	void (*otherend_changed)(struct xenbus_device *dev,
> @@ -233,4 +241,61 @@ extern const struct file_operations xen_xenbus_fops;
>  extern struct xenstore_domain_interface *xen_store_interface;
>  extern int xen_store_evtchn;
> 
> +extern bool xen_mtwatch;
> +
> +#define MTWATCH_HASH_SIZE 256
> +#define MTWATCH_HASH(_id) ((int)(_id)&(MTWATCH_HASH_SIZE-1))
> +
> +struct mtwatch_info {
> +	/*
> +	 * The mtwatch_domain is put on both a hash table and a list.
> +	 * domain_list is used to optimize xenbus_watch un-registration.
> +	 *
> +	 * The mtwatch_domain is removed from domain_hash (with state set
> +	 * to MTWATCH_DOMAIN_DOWN) when its refcnt is zero. However, it is
> +	 * left on domain_list until all events belong to such
> +	 * mtwatch_domain are processed in mtwatch_thread().
> +	 *
> +	 * While there may exist two mtwatch_domain with the same domid on
> +	 * domain_list simultaneously, all mtwatch_domain on hash_hash
> +	 * should have unique domid.
> +	 */
> +	spinlock_t domain_lock;
> +	struct hlist_head domain_hash[MTWATCH_HASH_SIZE];
> +	struct list_head domain_list;
> +
> +	/*
> +	 * When a per-domU 

'per-frontend-domain' to be more descriptive?

  Paul

> kthread is going to be destroyed, it is put
> +	 * on the purge_list, and will be flushed by purge_work later.
> +	 */
> +	struct work_struct purge_work;
> +	spinlock_t purge_lock;
> +	struct list_head purge_list;
> +};
> +
> +enum mtwatch_domain_state {
> +	MTWATCH_DOMAIN_UP = 1,
> +	MTWATCH_DOMAIN_DOWN = 2,
> +};
> +
> +struct mtwatch_domain {
> +	domid_t domid;
> +	struct task_struct *task;
> +	atomic_t refcnt;
> +
> +	pid_t pid;
> +	struct mutex domain_mutex;
> +	struct rcu_head rcu;
> +
> +	struct hlist_node hash_node;
> +	struct list_head list_node;
> +	struct list_head purge_node;
> +
> +	wait_queue_head_t events_wq;
> +
> +	spinlock_t events_lock;
> +	struct list_head events;
> +	enum mtwatch_domain_state state;
> +};
> +
>  #endif /* _XEN_XENBUS_H */
> --
> 2.7.4

