Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AG47ELvsyJNUScczSK+cW93RjkVjRM5eLFEFRvmWplanKooDkTHQC/R+Kc4vmAh18onJrDw31cJF
ARC-Seal: i=1; a=rsa-sha256; t=1520536930; cv=none;
        d=google.com; s=arc-20160816;
        b=Pc6u5BpqAbB8t5IQwDTgZRBvMBzuSN6BQ08+Iw+BKSlkyxel7mxdjOu908nkI5kbyM
         gHZdnd4KlNpex+MyictZvRWRZeW8KP/ZiVe/EZArL26e3GHMG2OdOPlMw5JEdT9Op5C8
         cr1Ox0/dMpMvZcitwT6z6ZniBhU6FTb8R+3R3FEkQgMrkshgemy3fDQLSwlZejgaqsE5
         /HImo/42zU9/fUIvpgolo6yDVmFlY/JKA2zvJH2xAvSinZKQx8A/pbMh01ymCtyp/xtT
         Hw6lgcSugltoZTHO/GhLAHdUvmqu4bg1w67/uNnSbqho7bgRZ3cXQy1jG0htXlp0j3iX
         kmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=LOmGlsb/aqiyWxNPKSAcnWuvvSaHhH8HOCna7ZpNsSA=;
        b=xpTqZ2qnwQCDUHpKz/a+8ChCBIavW6WlSDuJT063fCtkr4/WZ/SyQUEFYTCF0ZdIR8
         UFCC9h5sMwsnvYIoeuM55NeR72OHjHtW0JuD+nq0gqZEZnRtuWl+X75hNBtECgcS22uf
         YA9fTOtgz9kZoDUBr5KhvlerDeaNjllPDRTjzL0SvatLml59/lLhL9lqvg73rqAbj8O7
         WVuSotUkggipwPZiTpoziKkbrqNfxvL3bxRNNQW4bQFE7ZE9SEPgrNTG9IObWcLUhApC
         5LpULPJW0t40082sdJ5mooD+rJHI35bcDZx8SeLOS78LoXHmJfmepejC9ZLHZnS15rlT
         a7fw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,441,1515484800";
   d="scan'208";a="23101644"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 09/17] staging: lustre: ldlm: use delayed_work for
 pools_recalc
Thread-Topic: [PATCH 09/17] staging: lustre: ldlm: use delayed_work for
 pools_recalc
Thread-Index: AQHTsbWwcg1PBh1G4kSkB4kmtYsxU6PHSDIA
Date: Thu, 8 Mar 2018 19:22:08 +0000
Message-ID: <45DCA0E5-F003-416C-9CA8-3C9CC7B06CDE@intel.com>
References: <151994679573.7628.1024109499321778846.stgit@noble>
 <151994708534.7628.3824921218925924808.stgit@noble>
In-Reply-To: <151994708534.7628.3824921218925924808.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.37.249]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BF8AD65AE135EC4389377400BA0723F3@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780153084905668?=
X-GMAIL-MSGID: =?utf-8?q?1594398533000083752?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mar 1, 2018, at 16:31, NeilBrown <neilb@suse.com> wrote:
>=20
> ldlm currenty has a kthread which wakes up every so often
> and calls ldlm_pools_recalc().
> The thread is started and stopped, but no other external interactions
> happen.
>=20
> This can trivially be replaced by a delayed_work if we have
> ldlm_pools_recalc() reschedule the work rather than just report
> when to do that.
>=20
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> ---
> drivers/staging/lustre/lustre/ldlm/ldlm_pool.c |   99 +++----------------=
-----
> 1 file changed, 11 insertions(+), 88 deletions(-)
>=20
> diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_pool.c b/drivers/sta=
ging/lustre/lustre/ldlm/ldlm_pool.c
> index a0e486b57e08..53b8f33e54b5 100644
> --- a/drivers/staging/lustre/lustre/ldlm/ldlm_pool.c
> +++ b/drivers/staging/lustre/lustre/ldlm/ldlm_pool.c
> @@ -784,9 +784,6 @@ static int ldlm_pool_granted(struct ldlm_pool *pl)
> 	return atomic_read(&pl->pl_granted);
> }
>=20
> -static struct ptlrpc_thread *ldlm_pools_thread;
> -static struct completion ldlm_pools_comp;
> -
> /*
>  * count locks from all namespaces (if possible). Returns number of
>  * cached locks.
> @@ -899,8 +896,12 @@ static unsigned long ldlm_pools_cli_scan(struct shri=
nker *s,
> 			       sc->gfp_mask);
> }
>=20
> -static int ldlm_pools_recalc(enum ldlm_side client)
> +static void ldlm_pools_recalc(struct work_struct *ws);
> +static DECLARE_DELAYED_WORK(ldlm_recalc_pools, ldlm_pools_recalc);
> +
> +static void ldlm_pools_recalc(struct work_struct *ws)
> {
> +	enum ldlm_side client =3D LDLM_NAMESPACE_CLIENT;
> 	struct ldlm_namespace *ns;
> 	struct ldlm_namespace *ns_old =3D NULL;
> 	/* seconds of sleep if no active namespaces */
> @@ -982,92 +983,19 @@ static int ldlm_pools_recalc(enum ldlm_side client)
> 	/* Wake up the blocking threads from time to time. */
> 	ldlm_bl_thread_wakeup();
>=20
> -	return time;
> -}
> -
> -static int ldlm_pools_thread_main(void *arg)
> -{
> -	struct ptlrpc_thread *thread =3D (struct ptlrpc_thread *)arg;
> -	int c_time;
> -
> -	thread_set_flags(thread, SVC_RUNNING);
> -	wake_up(&thread->t_ctl_waitq);
> -
> -	CDEBUG(D_DLMTRACE, "%s: pool thread starting, process %d\n",
> -	       "ldlm_poold", current_pid());
> -
> -	while (1) {
> -		/*
> -		 * Recal all pools on this tick.
> -		 */
> -		c_time =3D ldlm_pools_recalc(LDLM_NAMESPACE_CLIENT);
> -
> -		/*
> -		 * Wait until the next check time, or until we're
> -		 * stopped.
> -		 */
> -		wait_event_idle_timeout(thread->t_ctl_waitq,
> -					thread_is_stopping(thread) ||
> -					thread_is_event(thread),
> -					c_time * HZ);
> -
> -		if (thread_test_and_clear_flags(thread, SVC_STOPPING))
> -			break;
> -		thread_test_and_clear_flags(thread, SVC_EVENT);
> -	}
> -
> -	thread_set_flags(thread, SVC_STOPPED);
> -	wake_up(&thread->t_ctl_waitq);
> -
> -	CDEBUG(D_DLMTRACE, "%s: pool thread exiting, process %d\n",
> -	       "ldlm_poold", current_pid());
> -
> -	complete_and_exit(&ldlm_pools_comp, 0);
> +	schedule_delayed_work(&ldlm_recalc_pools, time * HZ);
> }
>=20
> static int ldlm_pools_thread_start(void)
> {
> -	struct task_struct *task;
> -
> -	if (ldlm_pools_thread)
> -		return -EALREADY;
> -
> -	ldlm_pools_thread =3D kzalloc(sizeof(*ldlm_pools_thread), GFP_NOFS);
> -	if (!ldlm_pools_thread)
> -		return -ENOMEM;
> -
> -	init_completion(&ldlm_pools_comp);
> -	init_waitqueue_head(&ldlm_pools_thread->t_ctl_waitq);
> +	schedule_delayed_work(&ldlm_recalc_pools, 0);
>=20
> -	task =3D kthread_run(ldlm_pools_thread_main, ldlm_pools_thread,
> -			   "ldlm_poold");
> -	if (IS_ERR(task)) {
> -		CERROR("Can't start pool thread, error %ld\n", PTR_ERR(task));
> -		kfree(ldlm_pools_thread);
> -		ldlm_pools_thread =3D NULL;
> -		return PTR_ERR(task);
> -	}
> -	wait_event_idle(ldlm_pools_thread->t_ctl_waitq,
> -			thread_is_running(ldlm_pools_thread));
> 	return 0;
> }
>=20
> static void ldlm_pools_thread_stop(void)
> {
> -	if (!ldlm_pools_thread)
> -		return;
> -
> -	thread_set_flags(ldlm_pools_thread, SVC_STOPPING);
> -	wake_up(&ldlm_pools_thread->t_ctl_waitq);
> -
> -	/*
> -	 * Make sure that pools thread is finished before freeing @thread.
> -	 * This fixes possible race and oops due to accessing freed memory
> -	 * in pools thread.
> -	 */
> -	wait_for_completion(&ldlm_pools_comp);
> -	kfree(ldlm_pools_thread);
> -	ldlm_pools_thread =3D NULL;
> +	cancel_delayed_work_sync(&ldlm_recalc_pools);
> }
>=20
> static struct shrinker ldlm_pools_cli_shrinker =3D {
> @@ -1081,20 +1009,15 @@ int ldlm_pools_init(void)
> 	int rc;
>=20
> 	rc =3D ldlm_pools_thread_start();
> -	if (rc)
> -		return rc;
> -
> -	rc =3D register_shrinker(&ldlm_pools_cli_shrinker);
> -	if (rc)
> -		ldlm_pools_thread_stop();
> +	if (!rc)
> +		rc =3D register_shrinker(&ldlm_pools_cli_shrinker);
>=20
> 	return rc;
> }
>=20
> void ldlm_pools_fini(void)
> {
> -	if (ldlm_pools_thread)
> -		unregister_shrinker(&ldlm_pools_cli_shrinker);
> +	unregister_shrinker(&ldlm_pools_cli_shrinker);
>=20
> 	ldlm_pools_thread_stop();
> }
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
