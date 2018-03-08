Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AG47ELs4LTdKbLFQQwji24nyxuiFstTNwIB97HZImWaax+YElt8ojjO/UcrFEbLQRHf3CEOtsHL/
ARC-Seal: i=1; a=rsa-sha256; t=1520468844; cv=none;
        d=google.com; s=arc-20160816;
        b=cObWC5apOdGbdIY6dBxrCrW/oDvL6ZSdSYf4gwxKrywOuPf4nld4l1TqQtSn7TXlw9
         rDi5GRul1py76NkqIKVDqCQILkkqk5AQXlqnv71KyaDLVseuV3qiqhblEE6qWEoR3WeW
         s+EAynURJ2p5L3Jx2sGC1wv1XpTBPrBs5u6fzx0mOq/Q9HFn9p6CCcoTeJTg98bu+Kgv
         64wkDjTqRkOjJq7T0G7ZtcziKqWV2KkZMWor+nmAH798+AkgS5YYaONUpqp7JTkeWdq1
         Jl+anW3ZkOBQAPf+uNd/ehj1h8ekoy0YeMoPQzr5+vsXBsO2SsMME4hx/wzKDhAub8re
         2idA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=TIYOW9IBw5a4saE2xxkmJPuxUqMi9qrNp0MIVg/I3Ek=;
        b=SMWegLvlI5x7BVyhEsy+yJPN4fl2IN5FtFt+PN69oOf3yE5v+00lLhNiIuNxu1nncW
         z0VQM7zqCYpx+c5Hp0BbfqF+WAkZ1+mwRXHSmbgroyecmJ4lcSbX5icwcr9IpRvfMK7k
         Ix8S+R9FFQu+HZMwLfcQ+dNvkgLpBj0Sh9uqfeJ1tV1wjSX/N/DB6JoDe3t5gROtJVIE
         Jbcwvi3mb1fk1U3vsFDWVURAZCEhBz7mwAPnRCOv9R6BeuwfitNUEehOy5AQXeTjguiW
         +o6l40wLfF3E08iZu6N96S5DCNko7TfpwohpcIxUrAb1xXQi4SWuEHmLnFa/Tz+t5AGn
         2lmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,438,1515484800";
   d="scan'208";a="22614154"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, Alexey
 Lyashkov <alexey.lyashkov@seagate.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 08/17] staging: lustre: obdclass: use workqueue for
 zombie management.
Thread-Topic: [PATCH 08/17] staging: lustre: obdclass: use workqueue for
 zombie management.
Thread-Index: AQHTsbWsJavvYS+F0UyDt/pVRhhai6PGCx2A
Date: Thu, 8 Mar 2018 00:27:17 +0000
Message-ID: <149DEFD8-1595-44FD-A03D-1CBB6CC1FBFB@intel.com>
References: <151994679573.7628.1024109499321778846.stgit@noble>
 <151994708531.7628.4492534610831624607.stgit@noble>
In-Reply-To: <151994708531.7628.4492534610831624607.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.6.233]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FEF4BB9E2DD4994C80BE2C63727CCDE4@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780144996706708?=
X-GMAIL-MSGID: =?utf-8?q?1594327138770932481?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mar 1, 2018, at 16:31, NeilBrown <neilb@suse.com> wrote:
>=20
> obdclass currently maintains two lists of data structures
> (imports and exports), and a kthread which will free
> anything on either list.  The thread is woken whenever
> anything is added to either list.
>=20
> This is exactly the sort of thing that workqueues exist for.
>=20
> So discard the zombie kthread and the lists and locks, and
> create a single workqueue.  Each obd_import and obd_export
> gets a work_struct to attach to this workqueue.
>=20
> This requires a small change to import_sec_validate_get()
> which was testing if an obd_import was on the zombie
> list.  This cannot have every safely found it to be
> on the list (as it could be freed asynchronously)
> so it must be dead code.
>=20
> We could use system_wq instead of creating a dedicated
> zombie_wq, but as we occasionally want to flush all pending
> work, it is a little nicer to only have to wait for our own
> work items.

Nice cleanup.  Lustre definitely has too many threads, but
kernel work queues didn't exist in the dark ages.

I CC'd Alexey, since he wrote this code initially, in case
there is anything special to be aware of.

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
> .../staging/lustre/lustre/include/lustre_export.h  |    2=20
> .../staging/lustre/lustre/include/lustre_import.h  |    4=20
> drivers/staging/lustre/lustre/obdclass/genops.c    |  193 ++-------------=
-----
> drivers/staging/lustre/lustre/ptlrpc/sec.c         |    6 -
> 4 files changed, 30 insertions(+), 175 deletions(-)
>=20
> diff --git a/drivers/staging/lustre/lustre/include/lustre_export.h b/driv=
ers/staging/lustre/lustre/include/lustre_export.h
> index 66ac9dc7302a..40cd168ed2ea 100644
> --- a/drivers/staging/lustre/lustre/include/lustre_export.h
> +++ b/drivers/staging/lustre/lustre/include/lustre_export.h
> @@ -87,6 +87,8 @@ struct obd_export {
> 	struct obd_uuid	   exp_client_uuid;
> 	/** To link all exports on an obd device */
> 	struct list_head		exp_obd_chain;
> +	/** work_struct for destruction of export */
> +	struct work_struct	exp_zombie_work;
> 	struct hlist_node	  exp_uuid_hash; /** uuid-export hash*/
> 	/** Obd device of this export */
> 	struct obd_device	*exp_obd;
> diff --git a/drivers/staging/lustre/lustre/include/lustre_import.h b/driv=
ers/staging/lustre/lustre/include/lustre_import.h
> index ea158e0630e2..1731048f1ff2 100644
> --- a/drivers/staging/lustre/lustre/include/lustre_import.h
> +++ b/drivers/staging/lustre/lustre/include/lustre_import.h
> @@ -162,8 +162,8 @@ struct obd_import {
> 	struct ptlrpc_client     *imp_client;
> 	/** List element for linking into pinger chain */
> 	struct list_head		imp_pinger_chain;
> -	/** List element for linking into chain for destruction */
> -	struct list_head		imp_zombie_chain;
> +	/** work struct for destruction of import */
> +	struct work_struct		imp_zombie_work;
>=20
> 	/**
> 	 * Lists of requests that are retained for replay, waiting for a reply,
> diff --git a/drivers/staging/lustre/lustre/obdclass/genops.c b/drivers/st=
aging/lustre/lustre/obdclass/genops.c
> index 8f776a4058a9..63ccbabb4c5a 100644
> --- a/drivers/staging/lustre/lustre/obdclass/genops.c
> +++ b/drivers/staging/lustre/lustre/obdclass/genops.c
> @@ -48,10 +48,7 @@ struct kmem_cache *obdo_cachep;
> EXPORT_SYMBOL(obdo_cachep);
> static struct kmem_cache *import_cachep;
>=20
> -static struct list_head      obd_zombie_imports;
> -static struct list_head      obd_zombie_exports;
> -static spinlock_t  obd_zombie_impexp_lock;
> -static void obd_zombie_impexp_notify(void);
> +static struct workqueue_struct *zombie_wq;
> static void obd_zombie_export_add(struct obd_export *exp);
> static void obd_zombie_import_add(struct obd_import *imp);
>=20
> @@ -701,6 +698,13 @@ void class_export_put(struct obd_export *exp)
> }
> EXPORT_SYMBOL(class_export_put);
>=20
> +static void obd_zombie_exp_cull(struct work_struct *ws)
> +{
> +	struct obd_export *export =3D container_of(ws, struct obd_export, exp_z=
ombie_work);
> +
> +	class_export_destroy(export);
> +}
> +
> /* Creates a new export, adds it to the hash table, and returns a
>  * pointer to it. The refcount is 2: one for the hash reference, and
>  * one for the pointer returned by this function.
> @@ -741,6 +745,7 @@ struct obd_export *class_new_export(struct obd_device=
 *obd,
> 	INIT_HLIST_NODE(&export->exp_uuid_hash);
> 	spin_lock_init(&export->exp_bl_list_lock);
> 	INIT_LIST_HEAD(&export->exp_bl_list);
> +	INIT_WORK(&export->exp_zombie_work, obd_zombie_exp_cull);
>=20
> 	export->exp_sp_peer =3D LUSTRE_SP_ANY;
> 	export->exp_flvr.sf_rpc =3D SPTLRPC_FLVR_INVALID;
> @@ -862,7 +867,6 @@ EXPORT_SYMBOL(class_import_get);
>=20
> void class_import_put(struct obd_import *imp)
> {
> -	LASSERT(list_empty(&imp->imp_zombie_chain));
> 	LASSERT_ATOMIC_GT_LT(&imp->imp_refcount, 0, LI_POISON);
>=20
> 	CDEBUG(D_INFO, "import %p refcount=3D%d obd=3D%s\n", imp,
> @@ -894,6 +898,13 @@ static void init_imp_at(struct imp_at *at)
> 	}
> }
>=20
> +static void obd_zombie_imp_cull(struct work_struct *ws)
> +{
> +	struct obd_import *import =3D container_of(ws, struct obd_import, imp_z=
ombie_work);
> +
> +	class_import_destroy(import);
> +}
> +
> struct obd_import *class_new_import(struct obd_device *obd)
> {
> 	struct obd_import *imp;
> @@ -903,7 +914,6 @@ struct obd_import *class_new_import(struct obd_device=
 *obd)
> 		return NULL;
>=20
> 	INIT_LIST_HEAD(&imp->imp_pinger_chain);
> -	INIT_LIST_HEAD(&imp->imp_zombie_chain);
> 	INIT_LIST_HEAD(&imp->imp_replay_list);
> 	INIT_LIST_HEAD(&imp->imp_sending_list);
> 	INIT_LIST_HEAD(&imp->imp_delayed_list);
> @@ -917,6 +927,7 @@ struct obd_import *class_new_import(struct obd_device=
 *obd)
> 	imp->imp_obd =3D class_incref(obd, "import", imp);
> 	mutex_init(&imp->imp_sec_mutex);
> 	init_waitqueue_head(&imp->imp_recovery_waitq);
> +	INIT_WORK(&imp->imp_zombie_work, obd_zombie_imp_cull);
>=20
> 	atomic_set(&imp->imp_refcount, 2);
> 	atomic_set(&imp->imp_unregistering, 0);
> @@ -1098,81 +1109,6 @@ EXPORT_SYMBOL(class_fail_export);
> void (*class_export_dump_hook)(struct obd_export *) =3D NULL;
> #endif
>=20
> -/* Total amount of zombies to be destroyed */
> -static int zombies_count;
> -
> -/**
> - * kill zombie imports and exports
> - */
> -static void obd_zombie_impexp_cull(void)
> -{
> -	struct obd_import *import;
> -	struct obd_export *export;
> -
> -	do {
> -		spin_lock(&obd_zombie_impexp_lock);
> -
> -		import =3D NULL;
> -		if (!list_empty(&obd_zombie_imports)) {
> -			import =3D list_entry(obd_zombie_imports.next,
> -					    struct obd_import,
> -					    imp_zombie_chain);
> -			list_del_init(&import->imp_zombie_chain);
> -		}
> -
> -		export =3D NULL;
> -		if (!list_empty(&obd_zombie_exports)) {
> -			export =3D list_entry(obd_zombie_exports.next,
> -					    struct obd_export,
> -					    exp_obd_chain);
> -			list_del_init(&export->exp_obd_chain);
> -		}
> -
> -		spin_unlock(&obd_zombie_impexp_lock);
> -
> -		if (import) {
> -			class_import_destroy(import);
> -			spin_lock(&obd_zombie_impexp_lock);
> -			zombies_count--;
> -			spin_unlock(&obd_zombie_impexp_lock);
> -		}
> -
> -		if (export) {
> -			class_export_destroy(export);
> -			spin_lock(&obd_zombie_impexp_lock);
> -			zombies_count--;
> -			spin_unlock(&obd_zombie_impexp_lock);
> -		}
> -
> -		cond_resched();
> -	} while (import || export);
> -}
> -
> -static struct completion	obd_zombie_start;
> -static struct completion	obd_zombie_stop;
> -static unsigned long		obd_zombie_flags;
> -static wait_queue_head_t		obd_zombie_waitq;
> -static pid_t			obd_zombie_pid;
> -
> -enum {
> -	OBD_ZOMBIE_STOP		=3D 0x0001,
> -};
> -
> -/**
> - * check for work for kill zombie import/export thread.
> - */
> -static int obd_zombie_impexp_check(void *arg)
> -{
> -	int rc;
> -
> -	spin_lock(&obd_zombie_impexp_lock);
> -	rc =3D (zombies_count =3D=3D 0) &&
> -	     !test_bit(OBD_ZOMBIE_STOP, &obd_zombie_flags);
> -	spin_unlock(&obd_zombie_impexp_lock);
> -
> -	return rc;
> -}
> -
> /**
>  * Add export to the obd_zombie thread and notify it.
>  */
> @@ -1182,12 +1118,7 @@ static void obd_zombie_export_add(struct obd_expor=
t *exp)
> 	LASSERT(!list_empty(&exp->exp_obd_chain));
> 	list_del_init(&exp->exp_obd_chain);
> 	spin_unlock(&exp->exp_obd->obd_dev_lock);
> -	spin_lock(&obd_zombie_impexp_lock);
> -	zombies_count++;
> -	list_add(&exp->exp_obd_chain, &obd_zombie_exports);
> -	spin_unlock(&obd_zombie_impexp_lock);
> -
> -	obd_zombie_impexp_notify();
> +	queue_work(zombie_wq, &exp->exp_zombie_work);
> }
>=20
> /**
> @@ -1196,40 +1127,7 @@ static void obd_zombie_export_add(struct obd_expor=
t *exp)
> static void obd_zombie_import_add(struct obd_import *imp)
> {
> 	LASSERT(!imp->imp_sec);
> -	spin_lock(&obd_zombie_impexp_lock);
> -	LASSERT(list_empty(&imp->imp_zombie_chain));
> -	zombies_count++;
> -	list_add(&imp->imp_zombie_chain, &obd_zombie_imports);
> -	spin_unlock(&obd_zombie_impexp_lock);
> -
> -	obd_zombie_impexp_notify();
> -}
> -
> -/**
> - * notify import/export destroy thread about new zombie.
> - */
> -static void obd_zombie_impexp_notify(void)
> -{
> -	/*
> -	 * Make sure obd_zombie_impexp_thread get this notification.
> -	 * It is possible this signal only get by obd_zombie_barrier, and
> -	 * barrier gulps this notification and sleeps away and hangs ensues
> -	 */
> -	wake_up_all(&obd_zombie_waitq);
> -}
> -
> -/**
> - * check whether obd_zombie is idle
> - */
> -static int obd_zombie_is_idle(void)
> -{
> -	int rc;
> -
> -	LASSERT(!test_bit(OBD_ZOMBIE_STOP, &obd_zombie_flags));
> -	spin_lock(&obd_zombie_impexp_lock);
> -	rc =3D (zombies_count =3D=3D 0);
> -	spin_unlock(&obd_zombie_impexp_lock);
> -	return rc;
> +	queue_work(zombie_wq, &imp->imp_zombie_work);
> }
>=20
> /**
> @@ -1237,60 +1135,19 @@ static int obd_zombie_is_idle(void)
>  */
> void obd_zombie_barrier(void)
> {
> -	if (obd_zombie_pid =3D=3D current_pid())
> -		/* don't wait for myself */
> -		return;
> -	wait_event_idle(obd_zombie_waitq, obd_zombie_is_idle());
> +	flush_workqueue(zombie_wq);
> }
> EXPORT_SYMBOL(obd_zombie_barrier);
>=20
> -/**
> - * destroy zombie export/import thread.
> - */
> -static int obd_zombie_impexp_thread(void *unused)
> -{
> -	unshare_fs_struct();
> -	complete(&obd_zombie_start);
> -
> -	obd_zombie_pid =3D current_pid();
> -
> -	while (!test_bit(OBD_ZOMBIE_STOP, &obd_zombie_flags)) {
> -		wait_event_idle(obd_zombie_waitq,
> -				!obd_zombie_impexp_check(NULL));
> -		obd_zombie_impexp_cull();
> -
> -		/*
> -		 * Notify obd_zombie_barrier callers that queues
> -		 * may be empty.
> -		 */
> -		wake_up(&obd_zombie_waitq);
> -	}
> -
> -	complete(&obd_zombie_stop);
> -
> -	return 0;
> -}
> -
> /**
>  * start destroy zombie import/export thread
>  */
> int obd_zombie_impexp_init(void)
> {
> -	struct task_struct *task;
> -
> -	INIT_LIST_HEAD(&obd_zombie_imports);
> -	INIT_LIST_HEAD(&obd_zombie_exports);
> -	spin_lock_init(&obd_zombie_impexp_lock);
> -	init_completion(&obd_zombie_start);
> -	init_completion(&obd_zombie_stop);
> -	init_waitqueue_head(&obd_zombie_waitq);
> -	obd_zombie_pid =3D 0;
> -
> -	task =3D kthread_run(obd_zombie_impexp_thread, NULL, "obd_zombid");
> -	if (IS_ERR(task))
> -		return PTR_ERR(task);
> +	zombie_wq =3D alloc_workqueue("obd_zombid", 0, 0);
> +	if (!zombie_wq)
> +		return -ENOMEM;
>=20
> -	wait_for_completion(&obd_zombie_start);
> 	return 0;
> }
>=20
> @@ -1299,9 +1156,7 @@ int obd_zombie_impexp_init(void)
>  */
> void obd_zombie_impexp_stop(void)
> {
> -	set_bit(OBD_ZOMBIE_STOP, &obd_zombie_flags);
> -	obd_zombie_impexp_notify();
> -	wait_for_completion(&obd_zombie_stop);
> +	destroy_workqueue(zombie_wq);
> }
>=20
> struct obd_request_slot_waiter {
> diff --git a/drivers/staging/lustre/lustre/ptlrpc/sec.c b/drivers/staging=
/lustre/lustre/ptlrpc/sec.c
> index f152ba1af0fc..3cb1e075f077 100644
> --- a/drivers/staging/lustre/lustre/ptlrpc/sec.c
> +++ b/drivers/staging/lustre/lustre/ptlrpc/sec.c
> @@ -339,11 +339,9 @@ static int import_sec_validate_get(struct obd_import=
 *imp,
> 	}
>=20
> 	*sec =3D sptlrpc_import_sec_ref(imp);
> -	/* Only output an error when the import is still active */
> 	if (!*sec) {
> -		if (list_empty(&imp->imp_zombie_chain))
> -			CERROR("import %p (%s) with no sec\n",
> -			       imp, ptlrpc_import_state_name(imp->imp_state));
> +		CERROR("import %p (%s) with no sec\n",
> +		       imp, ptlrpc_import_state_name(imp->imp_state));
> 		return -EACCES;
> 	}
>=20
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
