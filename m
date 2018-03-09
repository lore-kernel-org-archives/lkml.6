Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AG47ELuvzz6hUwF9C8ilso7hfnnFZk7GujZol+dCq4uzZSCztTtJouiQc/Mvqr45Q2hZWJiqMpWo
ARC-Seal: i=1; a=rsa-sha256; t=1520554830; cv=none;
        d=google.com; s=arc-20160816;
        b=wsd8GNzRifXB3rK+DVq8r/+V+XLGNZm6zX55diwytHGRt50EqriviRafXNycuc2zwd
         vPjjHfcGKwbbBlgYzcHa4yYWM2YwgbKcXpKv+GwNK+noXPB6J9u5NUZnkQSt4A3lVN1Y
         uys9QQ8HfDu4wNeuaFbI1ozp9oeIa9jHe2gywy3ncgz3lf7W0PVnJ1iHV0ZZAMRo413H
         ioUFer1Rga6BgOhxdqhai/bpCRP2gSbsEIIdp6AKTdM79da7xuAz8lrLkibUue/ha3Ot
         83s8YiTSoBwSVGJ5smojeWK3tDpZy1fkNL0QCTtEBo1yu+3Qn9l+gF+DXYM0vJ8NY57R
         5Ykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=NjZBLfDie5dF9KPSKaOuEw/0ahTtCXe4JxqAkxJ+JZU=;
        b=cz6BpKweCUvpsuUhynCKzFd8U5iyTxGXWMzlgiqTKdjVSKUJHQSRF+7m/ellaIyn5a
         rGSeuXv58LLrK21EPetQ8hKufNJRQOosJY4Wv+G2ggBAY63oiPDSGC9mq/Dn3RqVet4i
         Kk6lzau9bqE0SPQIfL3dIAjLLMLJ31r0zogde7G26rJkcA0CKQPiepv49j8uNb0CMa2c
         I81Ko+f5II2zCEOziyN6aXpo/zuPutHcS6qtIkdYP1ThzLDcnHKnv0ze5qtuekhQfa8I
         LlZMxoG9QUabkZAi6dygzj+KcIW87qnBE7GYKHvANRcS1jEHYJ5wv+OE3pgCFTIP/70Y
         XChQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,443,1515484800";
   d="scan'208";a="40422668"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>, "Yong, Fan" <fan.yong@intel.com>
Subject: Re: [PATCH 14/17] staging: lustre: change sai_thread to sai_task.
Thread-Topic: [PATCH 14/17] staging: lustre: change sai_thread to sai_task.
Thread-Index: AQHTsbXQSDgx/3sOlU+zYkVjojObd6PHm4mA
Date: Fri, 9 Mar 2018 00:20:27 +0000
Message-ID: <AE605672-FB2F-4B12-8E36-29A93096BF86@intel.com>
References: <151994679573.7628.1024109499321778846.stgit@noble>
 <151994708553.7628.2646121829758742627.stgit@noble>
In-Reply-To: <151994708553.7628.2646121829758742627.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.37.249]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4B69DC9A63AFD644B9885120A8F308DE@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780192181424771?=
X-GMAIL-MSGID: =?utf-8?q?1594417301464343568?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On Mar 1, 2018, at 16:31, NeilBrown <neilb@suse.com> wrote:
>=20
> Rather than allocating a ptlrpc_thread for the
> stat-ahead thread, just use the task_struct provided
> by kthreads directly.
>=20
> As nothing ever waits for the sai_task, it must call do_exit()
> directly rather than simply return from the function.
> Also it cannot use kthread_should_stop() to know when to stop.
>=20
> There is one caller which can ask it to stop so we need a simple
> signaling mechanism.  I've chosen to set ->sai_task to NULL
> when the thread should finish up.  The thread notices this and
> cleans up and exits.
> lli_sa_lock is used to avoid races between waking up the process
> and the process exiting.
>=20
> Signed-off-by: NeilBrown <neilb@suse.com>

CC'd Fan Yong, who is the author for this code.

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> ---
> .../staging/lustre/lustre/llite/llite_internal.h   |    2=20
> drivers/staging/lustre/lustre/llite/statahead.c    |  118 +++++++++------=
-----
> 2 files changed, 54 insertions(+), 66 deletions(-)
>=20
> diff --git a/drivers/staging/lustre/lustre/llite/llite_internal.h b/drive=
rs/staging/lustre/lustre/llite/llite_internal.h
> index 0c2d717fd526..d46bcf71b273 100644
> --- a/drivers/staging/lustre/lustre/llite/llite_internal.h
> +++ b/drivers/staging/lustre/lustre/llite/llite_internal.h
> @@ -1070,7 +1070,7 @@ struct ll_statahead_info {
> 				sai_agl_valid:1,/* AGL is valid for the dir */
> 				sai_in_readpage:1;/* statahead in readdir() */
> 	wait_queue_head_t	sai_waitq;      /* stat-ahead wait queue */
> -	struct ptlrpc_thread    sai_thread;     /* stat-ahead thread */
> +	struct task_struct     *sai_task;       /* stat-ahead thread */
> 	struct task_struct     *sai_agl_task;   /* AGL thread */
> 	struct list_head	sai_interim_entries; /* entries which got async
> 						      * stat reply, but not
> diff --git a/drivers/staging/lustre/lustre/llite/statahead.c b/drivers/st=
aging/lustre/lustre/llite/statahead.c
> index 39241b952bf4..155ce3cf6f60 100644
> --- a/drivers/staging/lustre/lustre/llite/statahead.c
> +++ b/drivers/staging/lustre/lustre/llite/statahead.c
> @@ -267,7 +267,7 @@ sa_kill(struct ll_statahead_info *sai, struct sa_entr=
y *entry)
>=20
> /* called by scanner after use, sa_entry will be killed */
> static void
> -sa_put(struct ll_statahead_info *sai, struct sa_entry *entry)
> +sa_put(struct ll_statahead_info *sai, struct sa_entry *entry, struct ll_=
inode_info *lli)
> {
> 	struct sa_entry *tmp, *next;
>=20
> @@ -295,7 +295,11 @@ sa_put(struct ll_statahead_info *sai, struct sa_entr=
y *entry)
> 		sa_kill(sai, tmp);
> 	}
>=20
> -	wake_up(&sai->sai_thread.t_ctl_waitq);
> +	spin_lock(&lli->lli_sa_lock);
> +	if (sai->sai_task)
> +		wake_up_process(sai->sai_task);
> +	spin_unlock(&lli->lli_sa_lock);
> +
> }
>=20
> /*
> @@ -403,7 +407,6 @@ static struct ll_statahead_info *ll_sai_alloc(struct =
dentry *dentry)
> 	sai->sai_max =3D LL_SA_RPC_MIN;
> 	sai->sai_index =3D 1;
> 	init_waitqueue_head(&sai->sai_waitq);
> -	init_waitqueue_head(&sai->sai_thread.t_ctl_waitq);
>=20
> 	INIT_LIST_HEAD(&sai->sai_interim_entries);
> 	INIT_LIST_HEAD(&sai->sai_entries);
> @@ -465,7 +468,7 @@ static void ll_sai_put(struct ll_statahead_info *sai)
> 		lli->lli_sai =3D NULL;
> 		spin_unlock(&lli->lli_sa_lock);
>=20
> -		LASSERT(thread_is_stopped(&sai->sai_thread));
> +		LASSERT(sai->sai_task =3D=3D NULL);
> 		LASSERT(sai->sai_agl_task =3D=3D NULL);
> 		LASSERT(sai->sai_sent =3D=3D sai->sai_replied);
> 		LASSERT(!sa_has_callback(sai));
> @@ -646,7 +649,6 @@ static int ll_statahead_interpret(struct ptlrpc_reque=
st *req,
> 	struct ll_inode_info     *lli =3D ll_i2info(dir);
> 	struct ll_statahead_info *sai =3D lli->lli_sai;
> 	struct sa_entry *entry =3D (struct sa_entry *)minfo->mi_cbdata;
> -	wait_queue_head_t *waitq =3D NULL;
> 	__u64 handle =3D 0;
>=20
> 	if (it_disposition(it, DISP_LOOKUP_NEG))
> @@ -657,7 +659,6 @@ static int ll_statahead_interpret(struct ptlrpc_reque=
st *req,
> 	 * sai should be always valid, no need to refcount
> 	 */
> 	LASSERT(sai);
> -	LASSERT(!thread_is_stopped(&sai->sai_thread));
> 	LASSERT(entry);
>=20
> 	CDEBUG(D_READA, "sa_entry %.*s rc %d\n",
> @@ -681,8 +682,9 @@ static int ll_statahead_interpret(struct ptlrpc_reque=
st *req,
> 	spin_lock(&lli->lli_sa_lock);
> 	if (rc) {
> 		if (__sa_make_ready(sai, entry, rc))
> -			waitq =3D &sai->sai_waitq;
> +			wake_up(&sai->sai_waitq);
> 	} else {
> +		int first =3D 0;
> 		entry->se_minfo =3D minfo;
> 		entry->se_req =3D ptlrpc_request_addref(req);
> 		/*
> @@ -693,14 +695,15 @@ static int ll_statahead_interpret(struct ptlrpc_req=
uest *req,
> 		 */
> 		entry->se_handle =3D handle;
> 		if (!sa_has_callback(sai))
> -			waitq =3D &sai->sai_thread.t_ctl_waitq;
> +			first =3D 1;
>=20
> 		list_add_tail(&entry->se_list, &sai->sai_interim_entries);
> +
> +		if (first && sai->sai_task)
> +			wake_up_process(sai->sai_task);
> 	}
> 	sai->sai_replied++;
>=20
> -	if (waitq)
> -		wake_up(waitq);
> 	spin_unlock(&lli->lli_sa_lock);
>=20
> 	return rc;
> @@ -942,17 +945,13 @@ static int ll_statahead_thread(void *arg)
> 	struct inode	     *dir    =3D d_inode(parent);
> 	struct ll_inode_info     *lli   =3D ll_i2info(dir);
> 	struct ll_sb_info	*sbi    =3D ll_i2sbi(dir);
> -	struct ll_statahead_info *sai;
> -	struct ptlrpc_thread *sa_thread;
> +	struct ll_statahead_info *sai =3D lli->lli_sai;
> 	struct page	      *page =3D NULL;
> 	__u64		     pos    =3D 0;
> 	int		       first  =3D 0;
> 	int		       rc     =3D 0;
> 	struct md_op_data *op_data;
>=20
> -	sai =3D ll_sai_get(dir);
> -	sa_thread =3D &sai->sai_thread;
> -	sa_thread->t_pid =3D current_pid();
> 	CDEBUG(D_READA, "statahead thread starting: sai %p, parent %pd\n",
> 	       sai, parent);
>=20
> @@ -965,21 +964,7 @@ static int ll_statahead_thread(void *arg)
>=20
> 	op_data->op_max_pages =3D ll_i2sbi(dir)->ll_md_brw_pages;
>=20
> -	if (sbi->ll_flags & LL_SBI_AGL_ENABLED)
> -		ll_start_agl(parent, sai);
> -
> -	atomic_inc(&sbi->ll_sa_total);
> -	spin_lock(&lli->lli_sa_lock);
> -	if (thread_is_init(sa_thread))
> -		/* If someone else has changed the thread state
> -		 * (e.g. already changed to SVC_STOPPING), we can't just
> -		 * blindly overwrite that setting.
> -		 */
> -		thread_set_flags(sa_thread, SVC_RUNNING);
> -	spin_unlock(&lli->lli_sa_lock);
> -	wake_up(&sa_thread->t_ctl_waitq);
> -
> -	while (pos !=3D MDS_DIR_END_OFF && thread_is_running(sa_thread)) {
> +	while (pos !=3D MDS_DIR_END_OFF && sai->sai_task) {
> 		struct lu_dirpage *dp;
> 		struct lu_dirent  *ent;
>=20
> @@ -996,7 +981,7 @@ static int ll_statahead_thread(void *arg)
>=20
> 		dp =3D page_address(page);
> 		for (ent =3D lu_dirent_start(dp);
> -		     ent && thread_is_running(sa_thread) && !sa_low_hit(sai);
> +		     ent && sai->sai_task && !sa_low_hit(sai);
> 		     ent =3D lu_dirent_next(ent)) {
> 			struct lu_fid fid;
> 			__u64 hash;
> @@ -1046,13 +1031,7 @@ static int ll_statahead_thread(void *arg)
>=20
> 			fid_le_to_cpu(&fid, &ent->lde_fid);
>=20
> -			/* wait for spare statahead window */
> 			do {
> -				wait_event_idle(sa_thread->t_ctl_waitq,
> -						!sa_sent_full(sai) ||
> -						sa_has_callback(sai) ||
> -						!list_empty(&sai->sai_agls) ||
> -						!thread_is_running(sa_thread));
> 				sa_handle_callback(sai);
>=20
> 				spin_lock(&lli->lli_agl_lock);
> @@ -1072,8 +1051,16 @@ static int ll_statahead_thread(void *arg)
> 					spin_lock(&lli->lli_agl_lock);
> 				}
> 				spin_unlock(&lli->lli_agl_lock);
> -			} while (sa_sent_full(sai) &&
> -				 thread_is_running(sa_thread));
> +
> +				set_current_state(TASK_IDLE);
> +				if (sa_sent_full(sai) &&
> +				    !sa_has_callback(sai) &&
> +				    agl_list_empty(sai) &&
> +				    sai->sai_task)
> +					/* wait for spare statahead window */
> +					schedule();
> +				__set_current_state(TASK_RUNNING);
> +			} while (sa_sent_full(sai) && sai->sai_task);
>=20
> 			sa_statahead(parent, name, namelen, &fid);
> 		}
> @@ -1096,7 +1083,7 @@ static int ll_statahead_thread(void *arg)
>=20
> 	if (rc < 0) {
> 		spin_lock(&lli->lli_sa_lock);
> -		thread_set_flags(sa_thread, SVC_STOPPING);
> +		sai->sai_task =3D NULL;
> 		lli->lli_sa_enabled =3D 0;
> 		spin_unlock(&lli->lli_sa_lock);
> 	}
> @@ -1105,12 +1092,14 @@ static int ll_statahead_thread(void *arg)
> 	 * statahead is finished, but statahead entries need to be cached, wait
> 	 * for file release to stop me.
> 	 */
> -	while (thread_is_running(sa_thread)) {
> -		wait_event_idle(sa_thread->t_ctl_waitq,
> -				sa_has_callback(sai) ||
> -				!thread_is_running(sa_thread));
> -
> +	while (sai->sai_task) {
> 		sa_handle_callback(sai);
> +
> +		set_current_state(TASK_IDLE);
> +		if (!sa_has_callback(sai) &&
> +		    sai->sai_task)
> +			schedule();
> +		__set_current_state(TASK_RUNNING);
> 	}
> out:
> 	if (sai->sai_agl_task) {
> @@ -1126,26 +1115,23 @@ static int ll_statahead_thread(void *arg)
> 	 */
> 	while (sai->sai_sent !=3D sai->sai_replied) {
> 		/* in case we're not woken up, timeout wait */
> -		wait_event_idle_timeout(sa_thread->t_ctl_waitq,
> -					sai->sai_sent =3D=3D sai->sai_replied,
> -					HZ>>3);
> +		schedule_timeout_idle(HZ>>3);
> 	}
>=20
> 	/* release resources held by statahead RPCs */
> 	sa_handle_callback(sai);
>=20
> -	spin_lock(&lli->lli_sa_lock);
> -	thread_set_flags(sa_thread, SVC_STOPPED);
> -	spin_unlock(&lli->lli_sa_lock);
> -
> 	CDEBUG(D_READA, "statahead thread stopped: sai %p, parent %pd\n",
> 	       sai, parent);
>=20
> +	spin_lock(&lli->lli_sa_lock);
> +	sai->sai_task =3D NULL;
> +	spin_unlock(&lli->lli_sa_lock);
> +
> 	wake_up(&sai->sai_waitq);
> -	wake_up(&sa_thread->t_ctl_waitq);
> 	ll_sai_put(sai);
>=20
> -	return rc;
> +	do_exit(rc);
> }
>=20
> /* authorize opened dir handle @key to statahead */
> @@ -1187,13 +1173,13 @@ void ll_deauthorize_statahead(struct inode *dir, =
void *key)
> 	lli->lli_opendir_pid =3D 0;
> 	lli->lli_sa_enabled =3D 0;
> 	sai =3D lli->lli_sai;
> -	if (sai && thread_is_running(&sai->sai_thread)) {
> +	if (sai && sai->sai_task) {
> 		/*
> 		 * statahead thread may not quit yet because it needs to cache
> 		 * entries, now it's time to tell it to quit.
> 		 */
> -		thread_set_flags(&sai->sai_thread, SVC_STOPPING);
> -		wake_up(&sai->sai_thread.t_ctl_waitq);
> +		wake_up_process(sai->sai_task);
> +		sai->sai_task =3D NULL;
> 	}
> 	spin_unlock(&lli->lli_sa_lock);
> }
> @@ -1463,7 +1449,7 @@ static int revalidate_statahead_dentry(struct inode=
 *dir,
> 	 */
> 	ldd =3D ll_d2d(*dentryp);
> 	ldd->lld_sa_generation =3D lli->lli_sa_generation;
> -	sa_put(sai, entry);
> +	sa_put(sai, entry, lli);
> 	return rc;
> }
>=20
> @@ -1483,7 +1469,6 @@ static int start_statahead_thread(struct inode *dir=
, struct dentry *dentry)
> {
> 	struct ll_inode_info *lli =3D ll_i2info(dir);
> 	struct ll_statahead_info *sai =3D NULL;
> -	struct ptlrpc_thread *thread;
> 	struct task_struct *task;
> 	struct dentry *parent =3D dentry->d_parent;
> 	int rc;
> @@ -1523,18 +1508,21 @@ static int start_statahead_thread(struct inode *d=
ir, struct dentry *dentry)
> 	CDEBUG(D_READA, "start statahead thread: [pid %d] [parent %pd]\n",
> 	       current_pid(), parent);
>=20
> -	task =3D kthread_run(ll_statahead_thread, parent, "ll_sa_%u",
> -			   lli->lli_opendir_pid);
> -	thread =3D &sai->sai_thread;
> +	task =3D kthread_create(ll_statahead_thread, parent, "ll_sa_%u",
> +			      lli->lli_opendir_pid);
> 	if (IS_ERR(task)) {
> 		rc =3D PTR_ERR(task);
> 		CERROR("can't start ll_sa thread, rc : %d\n", rc);
> 		goto out;
> 	}
>=20
> -	wait_event_idle(thread->t_ctl_waitq,
> -			thread_is_running(thread) || thread_is_stopped(thread));
> -	ll_sai_put(sai);
> +	if (ll_i2sbi(parent->d_inode)->ll_flags & LL_SBI_AGL_ENABLED)
> +		ll_start_agl(parent, sai);
> +
> +	atomic_inc(&ll_i2sbi(parent->d_inode)->ll_sa_total);
> +	sai->sai_task =3D task;
> +
> +	wake_up_process(task);
>=20
> 	/*
> 	 * We don't stat-ahead for the first dirent since we are already in
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
