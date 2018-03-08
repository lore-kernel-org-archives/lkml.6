Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AG47ELvFXaSvNPD/gVfc3Rq9R4moVpxGbmhSIUfSlny/U0oVSATDOsD/YiZgXIVVFF3suZJpuMK0
ARC-Seal: i=1; a=rsa-sha256; t=1520553224; cv=none;
        d=google.com; s=arc-20160816;
        b=OwI5wxoce8po2D4SXvtnPJQ0f8ASMfgy0h+occSfeN9yQto7kfrX5Zs7EUFHnuOyXZ
         87FM2HOoy1aQX2Ql4rNw8yi7/2vvbMg8JVAmkpG+Ojyag23jOhDvh9yyTWLIKkladLQN
         WqXqTSiJgAO14BFOVbVMH4ZaDvnhzOkGXB7U2ocjflJZKsAVxOHdaCBBM1GAm8qjLwW0
         effnGvPhs1xTlwUf6R/HLU8gvzKCic/OEb/b+A+B3ByJXMO3ks8bdz9go0rch4BS3KqP
         Ua7kGQ66aJKAruEipBCHkiLhYr2gdvtreUvtcl9GPwz1bRDDzn6T4vpR1h+ucYJTRceQ
         S4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=jUKzmUoU0PquRzQa9SDKfKQ3RhsWAfM4cy/ZehbbQIQ=;
        b=MEVfA2iIlQh2hNy3LDyNNfBhvjtd6aDZ4c5e8CmHrcvRAypRGHqVQ2TsNJIIwIkaUp
         O60pt1BLXz7V2sHj3//9/EO9EXSLY6YWuE7DNOE6xvI3//2TBUZkXsjf1/udGgPIvSNr
         UPuF2nSX+mhXugWzS7+4dWEfqxWpFP87fWku16+Ru8GKGoxMX9BPbxOa03cck14AKyuq
         O2gU+Qhp0qp/gm9W6uHAlcEwtt/XMokEegrUIRvT0AuhSiJoi8mx8VUOwyPFQXEZkbAF
         TZlazDle94CwoQMX/JMEkvRAVBIgN6fimp2rszAoVhAVkEBuhjb7kpemjLLwXB0pGsPH
         L4nQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,443,1515484800";
   d="scan'208";a="36651749"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 11/17] staging: lustre: ptlrpc: use workqueue for pinger
Thread-Topic: [PATCH 11/17] staging: lustre: ptlrpc: use workqueue for pinger
Thread-Index: AQHTsbW6JZmkx7V2MkqTbIRpCUMUgKPHlA+A
Date: Thu, 8 Mar 2018 23:53:42 +0000
Message-ID: <63D7C945-5CBC-4434-BAF1-F3EBA912CDEF@intel.com>
References: <151994679573.7628.1024109499321778846.stgit@noble>
 <151994708541.7628.5813099904100247526.stgit@noble>
In-Reply-To: <151994708541.7628.5813099904100247526.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.37.249]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47B5DA3C1F83414487EBADB38E753B14@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780168307156480?=
X-GMAIL-MSGID: =?utf-8?q?1594415618449029603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mar 1, 2018, at 16:31, NeilBrown <neilb@suse.com> wrote:
>=20
> lustre has a "Pinger" kthread which periodically pings peers
> to ensure all hosts are functioning.
>=20
> This can more easily be done using a work queue.
>=20
> As maintaining contact with other peers is import for
> keeping the filesystem running, and as the filesystem might
> be involved in freeing memory, it is safest to have a
> separate WQ_MEM_RECLAIM workqueue.
>=20
> The SVC_EVENT functionality to wake up the thread can be
> replaced with mod_delayed_work().
>=20
> Also use round_jiffies_up_relative() rather than setting a
> minimum of 1 second delay.  The PING_INTERVAL is measured in
> seconds so this meets the need is allow the workqueue to
> keep wakeups synchronized.
>=20
> Signed-off-by: NeilBrown <neilb@suse.com>

Looks reasonable.  Fortunately, pinging the server does not need
to be very accurate since it is only done occasionally when the
client is otherwise idle, so it shouldn't matter if the workqueue
operation is delayed by a few seconds.

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> ---
> drivers/staging/lustre/lustre/ptlrpc/pinger.c |   81 +++++++-------------=
-----
> 1 file changed, 24 insertions(+), 57 deletions(-)
>=20
> diff --git a/drivers/staging/lustre/lustre/ptlrpc/pinger.c b/drivers/stag=
ing/lustre/lustre/ptlrpc/pinger.c
> index b5f3cfee8e75..0775b7a048bb 100644
> --- a/drivers/staging/lustre/lustre/ptlrpc/pinger.c
> +++ b/drivers/staging/lustre/lustre/ptlrpc/pinger.c
> @@ -217,21 +217,18 @@ static void ptlrpc_pinger_process_import(struct obd=
_import *imp,
> 	}
> }
>=20
> -static int ptlrpc_pinger_main(void *arg)
> -{
> -	struct ptlrpc_thread *thread =3D arg;
> -
> -	/* Record that the thread is running */
> -	thread_set_flags(thread, SVC_RUNNING);
> -	wake_up(&thread->t_ctl_waitq);
> +static struct workqueue_struct *pinger_wq;
> +static void ptlrpc_pinger_main(struct work_struct *ws);
> +static DECLARE_DELAYED_WORK(ping_work, ptlrpc_pinger_main);
>=20
> -	/* And now, loop forever, pinging as needed. */
> -	while (1) {
> -		unsigned long this_ping =3D cfs_time_current();
> -		long time_to_next_wake;
> -		struct timeout_item *item;
> -		struct obd_import *imp;
> +static void ptlrpc_pinger_main(struct work_struct *ws)
> +{
> +	unsigned long this_ping =3D cfs_time_current();
> +	long time_to_next_wake;
> +	struct timeout_item *item;
> +	struct obd_import *imp;
>=20
> +	do {
> 		mutex_lock(&pinger_mutex);
> 		list_for_each_entry(item, &timeout_list, ti_chain) {
> 			item->ti_cb(item, item->ti_cb_data);
> @@ -260,50 +257,24 @@ static int ptlrpc_pinger_main(void *arg)
> 		       time_to_next_wake,
> 		       cfs_time_add(this_ping,
> 				    PING_INTERVAL * HZ));
> -		if (time_to_next_wake > 0) {
> -			wait_event_idle_timeout(thread->t_ctl_waitq,
> -						thread_is_stopping(thread) ||
> -						thread_is_event(thread),
> -						max_t(long, time_to_next_wake, HZ));
> -			if (thread_test_and_clear_flags(thread, SVC_STOPPING))
> -				break;
> -			/* woken after adding import to reset timer */
> -			thread_test_and_clear_flags(thread, SVC_EVENT);
> -		}
> -	}
> +	} while (time_to_next_wake <=3D 0);
>=20
> -	thread_set_flags(thread, SVC_STOPPED);
> -	wake_up(&thread->t_ctl_waitq);
> -
> -	CDEBUG(D_NET, "pinger thread exiting, process %d\n", current_pid());
> -	return 0;
> +	queue_delayed_work(pinger_wq, &ping_work,
> +			   round_jiffies_up_relative(time_to_next_wake));
> }
>=20
> -static struct ptlrpc_thread pinger_thread;
> -
> int ptlrpc_start_pinger(void)
> {
> -	struct task_struct *task;
> -	int rc;
> -
> -	if (!thread_is_init(&pinger_thread) &&
> -	    !thread_is_stopped(&pinger_thread))
> +	if (pinger_wq)
> 		return -EALREADY;
>=20
> -	init_waitqueue_head(&pinger_thread.t_ctl_waitq);
> -
> -	strcpy(pinger_thread.t_name, "ll_ping");
> -
> -	task =3D kthread_run(ptlrpc_pinger_main, &pinger_thread,
> -			   pinger_thread.t_name);
> -	if (IS_ERR(task)) {
> -		rc =3D PTR_ERR(task);
> -		CERROR("cannot start pinger thread: rc =3D %d\n", rc);
> -		return rc;
> +	pinger_wq =3D alloc_workqueue("ptlrpc_pinger", WQ_MEM_RECLAIM, 1);
> +	if (!pinger_wq) {
> +		CERROR("cannot start pinger workqueue\n");
> +		return -ENOMEM;
> 	}
> -	wait_event_idle(pinger_thread.t_ctl_waitq,
> -			thread_is_running(&pinger_thread));
>=20
> +	queue_delayed_work(pinger_wq, &ping_work, 0);
> 	return 0;
> }
>=20
> @@ -313,16 +284,13 @@ int ptlrpc_stop_pinger(void)
> {
> 	int rc =3D 0;
>=20
> -	if (thread_is_init(&pinger_thread) ||
> -	    thread_is_stopped(&pinger_thread))
> +	if (!pinger_wq)
> 		return -EALREADY;
>=20
> 	ptlrpc_pinger_remove_timeouts();
> -	thread_set_flags(&pinger_thread, SVC_STOPPING);
> -	wake_up(&pinger_thread.t_ctl_waitq);
> -
> -	wait_event_idle(pinger_thread.t_ctl_waitq,
> -			thread_is_stopped(&pinger_thread));
> +	cancel_delayed_work_sync(&ping_work);
> +	destroy_workqueue(pinger_wq);
> +	pinger_wq =3D NULL;
>=20
> 	return rc;
> }
> @@ -505,6 +473,5 @@ static int ptlrpc_pinger_remove_timeouts(void)
>=20
> void ptlrpc_pinger_wake_up(void)
> {
> -	thread_add_flags(&pinger_thread, SVC_EVENT);
> -	wake_up(&pinger_thread.t_ctl_waitq);
> +	mod_delayed_work(pinger_wq, &ping_work, 0);
> }
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
