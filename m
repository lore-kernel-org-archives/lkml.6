Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AG47ELtiKh6YFLUb0SSMXL12GR1sbYDq2oWcMN4s0masChvawoM958VfCPcRg2vHqJ8UV6lHyT1P
ARC-Seal: i=1; a=rsa-sha256; t=1520804281; cv=none;
        d=google.com; s=arc-20160816;
        b=JgNHCi7zfy1HoUE/5SJdFxazNOkgfUVixZiJ3qCJeY6NaOrq9lMU0jQZFre3XynVql
         rvTsob4yTDi+FKVabGIugxqKk8GRGmtQzirH+DmpRtd5IcpwjiEvbxjBY1xUCjhAeghg
         YBmwo1spwPJxsSPrFc+7E5k8Q5y1zcQ4GPvUISQkW3aYc0ZByPI5Q6hIAEngYS0oMXix
         tE1/t5EFv/r2mAUAM/tYznTymN5PKNBGE3vJ05c68xCruS8bQYhEBI8vWtQu8xJoc/gk
         xkOFq2sD78+VGTzyGK3/0to72PJkdf9smcBK1huFPk8eHhT4eyxTcupXvdXyYk2ODfQl
         LK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=fRne6L/yAWrEUwzXwlb++XPdFbREsWDYkL2Z4djSm34=;
        b=q/non18R6nN3FmDq12hAHYLKIgTwFl8FZ4felZMCg45efdMXM4qM/Iil7tcIvtjDRT
         3qfsiyp/PtZg+9kYl5m/EFI1qKdQDn7sdLNQR5JsqqwjidAAymWxdOxpUgBATltW7BH3
         OM1gWpUxHX7bpUYGA0aAk8p95JjHBoZSjziiUgjQmc6arsszdjOIpfiEQ4dw/uzAOODl
         mrfJVmN2hne9BahRozNmTohVFQZW9yYRnUBiaibeuaD8sEzQydEWmNs5aMvkJB05NKsx
         fKcgucMEK8CSjHyyt3k/e5PKeHhMoWnrh+LIVc3jWeYxvJz3m3Cf4gtryADhs2elYTFi
         NyPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: "Dilger\, Andreas" <andreas.dilger@intel.com>
Date: Mon, 12 Mar 2018 08:37:49 +1100
Cc: "Drokin\, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 11/17] staging: lustre: ptlrpc: use workqueue for pinger
In-Reply-To: <63D7C945-5CBC-4434-BAF1-F3EBA912CDEF@intel.com>
References: <151994679573.7628.1024109499321778846.stgit@noble> <151994708541.7628.5813099904100247526.stgit@noble> <63D7C945-5CBC-4434-BAF1-F3EBA912CDEF@intel.com>
Message-ID: <87k1uie1jm.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780168307156480?=
X-GMAIL-MSGID: =?utf-8?q?1594678870387048715?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08 2018, Dilger, Andreas wrote:

> On Mar 1, 2018, at 16:31, NeilBrown <neilb@suse.com> wrote:
>>=20
>> lustre has a "Pinger" kthread which periodically pings peers
>> to ensure all hosts are functioning.
>>=20
>> This can more easily be done using a work queue.
>>=20
>> As maintaining contact with other peers is import for
>> keeping the filesystem running, and as the filesystem might
>> be involved in freeing memory, it is safest to have a
>> separate WQ_MEM_RECLAIM workqueue.
>>=20
>> The SVC_EVENT functionality to wake up the thread can be
>> replaced with mod_delayed_work().
>>=20
>> Also use round_jiffies_up_relative() rather than setting a
>> minimum of 1 second delay.  The PING_INTERVAL is measured in
>> seconds so this meets the need is allow the workqueue to
>> keep wakeups synchronized.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>
> Looks reasonable.  Fortunately, pinging the server does not need
> to be very accurate since it is only done occasionally when the
> client is otherwise idle, so it shouldn't matter if the workqueue
> operation is delayed by a few seconds.
>
> Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

Thanks a lot for the thorough review!
The above implies that we don't need WQ_MEM_RECLAIM.  I didn't dig in to
exactly when and why pings happened so I thought having WQ_MEM_RECLAIM
we safest.  If pings only happen when the client is otherwise idle, the
it isn't needed.  I'll remove it.

Thanks,
NeilBrown


>
>> ---
>> drivers/staging/lustre/lustre/ptlrpc/pinger.c |   81 +++++++------------=
------
>> 1 file changed, 24 insertions(+), 57 deletions(-)
>>=20
>> diff --git a/drivers/staging/lustre/lustre/ptlrpc/pinger.c b/drivers/sta=
ging/lustre/lustre/ptlrpc/pinger.c
>> index b5f3cfee8e75..0775b7a048bb 100644
>> --- a/drivers/staging/lustre/lustre/ptlrpc/pinger.c
>> +++ b/drivers/staging/lustre/lustre/ptlrpc/pinger.c
>> @@ -217,21 +217,18 @@ static void ptlrpc_pinger_process_import(struct ob=
d_import *imp,
>> 	}
>> }
>>=20
>> -static int ptlrpc_pinger_main(void *arg)
>> -{
>> -	struct ptlrpc_thread *thread =3D arg;
>> -
>> -	/* Record that the thread is running */
>> -	thread_set_flags(thread, SVC_RUNNING);
>> -	wake_up(&thread->t_ctl_waitq);
>> +static struct workqueue_struct *pinger_wq;
>> +static void ptlrpc_pinger_main(struct work_struct *ws);
>> +static DECLARE_DELAYED_WORK(ping_work, ptlrpc_pinger_main);
>>=20
>> -	/* And now, loop forever, pinging as needed. */
>> -	while (1) {
>> -		unsigned long this_ping =3D cfs_time_current();
>> -		long time_to_next_wake;
>> -		struct timeout_item *item;
>> -		struct obd_import *imp;
>> +static void ptlrpc_pinger_main(struct work_struct *ws)
>> +{
>> +	unsigned long this_ping =3D cfs_time_current();
>> +	long time_to_next_wake;
>> +	struct timeout_item *item;
>> +	struct obd_import *imp;
>>=20
>> +	do {
>> 		mutex_lock(&pinger_mutex);
>> 		list_for_each_entry(item, &timeout_list, ti_chain) {
>> 			item->ti_cb(item, item->ti_cb_data);
>> @@ -260,50 +257,24 @@ static int ptlrpc_pinger_main(void *arg)
>> 		       time_to_next_wake,
>> 		       cfs_time_add(this_ping,
>> 				    PING_INTERVAL * HZ));
>> -		if (time_to_next_wake > 0) {
>> -			wait_event_idle_timeout(thread->t_ctl_waitq,
>> -						thread_is_stopping(thread) ||
>> -						thread_is_event(thread),
>> -						max_t(long, time_to_next_wake, HZ));
>> -			if (thread_test_and_clear_flags(thread, SVC_STOPPING))
>> -				break;
>> -			/* woken after adding import to reset timer */
>> -			thread_test_and_clear_flags(thread, SVC_EVENT);
>> -		}
>> -	}
>> +	} while (time_to_next_wake <=3D 0);
>>=20
>> -	thread_set_flags(thread, SVC_STOPPED);
>> -	wake_up(&thread->t_ctl_waitq);
>> -
>> -	CDEBUG(D_NET, "pinger thread exiting, process %d\n", current_pid());
>> -	return 0;
>> +	queue_delayed_work(pinger_wq, &ping_work,
>> +			   round_jiffies_up_relative(time_to_next_wake));
>> }
>>=20
>> -static struct ptlrpc_thread pinger_thread;
>> -
>> int ptlrpc_start_pinger(void)
>> {
>> -	struct task_struct *task;
>> -	int rc;
>> -
>> -	if (!thread_is_init(&pinger_thread) &&
>> -	    !thread_is_stopped(&pinger_thread))
>> +	if (pinger_wq)
>> 		return -EALREADY;
>>=20
>> -	init_waitqueue_head(&pinger_thread.t_ctl_waitq);
>> -
>> -	strcpy(pinger_thread.t_name, "ll_ping");
>> -
>> -	task =3D kthread_run(ptlrpc_pinger_main, &pinger_thread,
>> -			   pinger_thread.t_name);
>> -	if (IS_ERR(task)) {
>> -		rc =3D PTR_ERR(task);
>> -		CERROR("cannot start pinger thread: rc =3D %d\n", rc);
>> -		return rc;
>> +	pinger_wq =3D alloc_workqueue("ptlrpc_pinger", WQ_MEM_RECLAIM, 1);
>> +	if (!pinger_wq) {
>> +		CERROR("cannot start pinger workqueue\n");
>> +		return -ENOMEM;
>> 	}
>> -	wait_event_idle(pinger_thread.t_ctl_waitq,
>> -			thread_is_running(&pinger_thread));
>>=20
>> +	queue_delayed_work(pinger_wq, &ping_work, 0);
>> 	return 0;
>> }
>>=20
>> @@ -313,16 +284,13 @@ int ptlrpc_stop_pinger(void)
>> {
>> 	int rc =3D 0;
>>=20
>> -	if (thread_is_init(&pinger_thread) ||
>> -	    thread_is_stopped(&pinger_thread))
>> +	if (!pinger_wq)
>> 		return -EALREADY;
>>=20
>> 	ptlrpc_pinger_remove_timeouts();
>> -	thread_set_flags(&pinger_thread, SVC_STOPPING);
>> -	wake_up(&pinger_thread.t_ctl_waitq);
>> -
>> -	wait_event_idle(pinger_thread.t_ctl_waitq,
>> -			thread_is_stopped(&pinger_thread));
>> +	cancel_delayed_work_sync(&ping_work);
>> +	destroy_workqueue(pinger_wq);
>> +	pinger_wq =3D NULL;
>>=20
>> 	return rc;
>> }
>> @@ -505,6 +473,5 @@ static int ptlrpc_pinger_remove_timeouts(void)
>>=20
>> void ptlrpc_pinger_wake_up(void)
>> {
>> -	thread_add_flags(&pinger_thread, SVC_EVENT);
>> -	wake_up(&pinger_thread.t_ctl_waitq);
>> +	mod_delayed_work(pinger_wq, &ping_work, 0);
>> }
>>=20
>>=20
>
> Cheers, Andreas
> --
> Andreas Dilger
> Lustre Principal Architect
> Intel Corporation

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqloa0ACgkQOeye3VZi
gbnang//QXPdz6/jX/KHeJyJqxMdT4jW+hBedU6R2YFQREgi7amLsiJ82be+6e3l
jE4d+A+IPnUwXcemm1l9+3gETKpU8Z4PBi8Piz5/bfOsAdaXqPZmvfLzw+q+sBNL
Po8ercPgHyDAPnuqcu7mOTwbAmvqblpqy0/3xMO/uh7meZfWHwcUpfTgY5B65jny
cy5xb5wQhGznAOp+Zfk67LGQ8eD7bcGxCfVSGjppfc9Zi74icwwRF3DNEEbGmo4i
lctzEihfNWIgtulWQ1uRfGel2tPp298mlPl1eY3taX/PxZ9EjWNUde0umu1b0p3R
Rindf70Gqc+Xo4d50UQ8EFoQNX34BPOIfvPTnB57yJV/apboda4cUMd2gLIzmtUc
4l0KE0QjeKqih9cVR1+Hsb0d8tJ5h428QXWY6G9eCmwqiPwa/qYZEky2Yqt6LFvI
8YP1dXWVYfhSD4OpFX9xBtV23cMdmDKszp/A06hnbh/l0Ye4lhXlV75lCAUwc2xv
k75SpHSuU4ZGZ5AP3xUgXvwPxue5rDdASuWqWI3kCeA9ALlHCuqTY4AderuyNstN
pEeBHZ59lrv94hyRYzaaGRQo1CWL8htACo5C9EI2NL/GGofA+FDbAJZhFHBKaiyJ
ltseGEEk/TSb1pYRcoQKkkMqjo+Cnp4wTSO25RFGQf2H7DjUmnk=
=CzaI
-----END PGP SIGNATURE-----
--=-=-=--
