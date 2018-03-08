Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AG47ELsrgGoXYCN4Sp/Ug/ySdEh7F1cA3rmAWjcUtwHwlU9iH1nUwufVbfw/hGVM7hp29QyTFcdy
ARC-Seal: i=1; a=rsa-sha256; t=1520537019; cv=none;
        d=google.com; s=arc-20160816;
        b=ZWXioLZAUsNsfQxDQtJOp0nyd1eVRu1pt54Dvx1kQqYcpkhinvMgHg74vsMlps4jO1
         cx4b1ra9OC0AV7fn9FM2clzEbbFjVsmXN/zrv+m6kU2fCABdedudl4Vlt5kd/4V5MUFq
         6akPDIVOd88KrITEIgeg6UuKo3KHrKe720Wz8/rEvDDGoLZ1XZNp0fgjB0vfR6eG3jQY
         ZLiKsdoFX4v2xOMhaeUnmNnJDojYgOJ10/xPtvvxj1diXbCZJv+2tB9JKZc11hkX5lZ0
         9vUcZg/6np0bZ4gEzRTi2tmt+8iRZRJ7028p5fsXQ3DZ36l1bWsB0jq1a/YiiXfQFzgr
         oWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=ElZUL1EXq8vqgwd4MSDQSbi9ka52qJ3C2JI4pgZKtaA=;
        b=QhScUfg6+0xw4kboMS8pitsLXQUQh58H3YTQ1QY3yCAL9bClt82pjwABg+sB9IUni2
         v/HPIJbFoCAQS5PVndxh82wrUlzAHZ2FvcivS796VTB5o3yLlolN6a7H/TvJ6QaHEJei
         EUkm3mruds76lLR1a3FcSp5JVn78SBdTp2XujrEfBBzFX9Y4gYR1JwyXZHkysrKoxUzS
         SOlP2pRi2v7xY8D6Sgo+0KvYT1zpwVI1/c3mVk0fVO85X/phxbOv801akvkAGNOwh+K0
         4m/1LkjWKHSbBPQbuE8DRVlzP8hRbQF8kgAwqFTIJjTCa6Q4FPGVIW51oJQtgizkAdZ0
         7CeA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,442,1515484800";
   d="scan'208";a="23622598"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 10/17] staging: lustre: ptlrpc: use delayed_work in
 sec_gc
Thread-Topic: [PATCH 10/17] staging: lustre: ptlrpc: use delayed_work in
 sec_gc
Thread-Index: AQHTsbWzxLXqmzk1sE2umINNS54o4KPHSImA
Date: Thu, 8 Mar 2018 19:23:20 +0000
Message-ID: <D6D3EC01-6338-4285-A4FE-9F9C54EC1586@intel.com>
References: <151994679573.7628.1024109499321778846.stgit@noble>
 <151994708538.7628.11965951418635189732.stgit@noble>
In-Reply-To: <151994708538.7628.11965951418635189732.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.37.249]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D7D963FEBC7FF4BAE2B88465E0C7FC3@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780160747933116?=
X-GMAIL-MSGID: =?utf-8?q?1594398626055304175?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mar 1, 2018, at 16:31, NeilBrown <neilb@suse.com> wrote:
>=20
> The garbage collection for security contexts currently
> has a dedicated kthread which wakes up every 30 minutes
> to discard old garbage.
>=20
> Replace this with a simple delayed_work item on the
> system work queue.
>=20
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> ---
> drivers/staging/lustre/lustre/ptlrpc/sec_gc.c |   90 ++++++++------------=
-----
> 1 file changed, 28 insertions(+), 62 deletions(-)
>=20
> diff --git a/drivers/staging/lustre/lustre/ptlrpc/sec_gc.c b/drivers/stag=
ing/lustre/lustre/ptlrpc/sec_gc.c
> index 48f1a72afd77..2c8bad7b7877 100644
> --- a/drivers/staging/lustre/lustre/ptlrpc/sec_gc.c
> +++ b/drivers/staging/lustre/lustre/ptlrpc/sec_gc.c
> @@ -55,7 +55,6 @@ static spinlock_t sec_gc_list_lock;
> static LIST_HEAD(sec_gc_ctx_list);
> static spinlock_t sec_gc_ctx_list_lock;
>=20
> -static struct ptlrpc_thread sec_gc_thread;
> static atomic_t sec_gc_wait_del =3D ATOMIC_INIT(0);
>=20
> void sptlrpc_gc_add_sec(struct ptlrpc_sec *sec)
> @@ -139,86 +138,53 @@ static void sec_do_gc(struct ptlrpc_sec *sec)
> 	sec->ps_gc_next =3D ktime_get_real_seconds() + sec->ps_gc_interval;
> }
>=20
> -static int sec_gc_main(void *arg)
> -{
> -	struct ptlrpc_thread *thread =3D arg;
> -
> -	unshare_fs_struct();
> +static void sec_gc_main(struct work_struct *ws);
> +static DECLARE_DELAYED_WORK(sec_gc_work, sec_gc_main);
>=20
> -	/* Record that the thread is running */
> -	thread_set_flags(thread, SVC_RUNNING);
> -	wake_up(&thread->t_ctl_waitq);
> -
> -	while (1) {
> -		struct ptlrpc_sec *sec;
> +static void sec_gc_main(struct work_struct *ws)
> +{
> +	struct ptlrpc_sec *sec;
>=20
> -		sec_process_ctx_list();
> +	sec_process_ctx_list();
> again:
> -		/* go through sec list do gc.
> -		 * FIXME here we iterate through the whole list each time which
> -		 * is not optimal. we perhaps want to use balanced binary tree
> -		 * to trace each sec as order of expiry time.
> -		 * another issue here is we wakeup as fixed interval instead of
> -		 * according to each sec's expiry time
> +	/* go through sec list do gc.
> +	 * FIXME here we iterate through the whole list each time which
> +	 * is not optimal. we perhaps want to use balanced binary tree
> +	 * to trace each sec as order of expiry time.
> +	 * another issue here is we wakeup as fixed interval instead of
> +	 * according to each sec's expiry time
> +	 */
> +	mutex_lock(&sec_gc_mutex);
> +	list_for_each_entry(sec, &sec_gc_list, ps_gc_list) {
> +		/* if someone is waiting to be deleted, let it
> +		 * proceed as soon as possible.
> 		 */
> -		mutex_lock(&sec_gc_mutex);
> -		list_for_each_entry(sec, &sec_gc_list, ps_gc_list) {
> -			/* if someone is waiting to be deleted, let it
> -			 * proceed as soon as possible.
> -			 */
> -			if (atomic_read(&sec_gc_wait_del)) {
> -				CDEBUG(D_SEC, "deletion pending, start over\n");
> -				mutex_unlock(&sec_gc_mutex);
> -				goto again;
> -			}
> -
> -			sec_do_gc(sec);
> +		if (atomic_read(&sec_gc_wait_del)) {
> +			CDEBUG(D_SEC, "deletion pending, start over\n");
> +			mutex_unlock(&sec_gc_mutex);
> +			goto again;
> 		}
> -		mutex_unlock(&sec_gc_mutex);
> -
> -		/* check ctx list again before sleep */
> -		sec_process_ctx_list();
> -		wait_event_idle_timeout(thread->t_ctl_waitq,
> -					thread_is_stopping(thread),
> -					SEC_GC_INTERVAL * HZ);
>=20
> -		if (thread_test_and_clear_flags(thread, SVC_STOPPING))
> -			break;
> +		sec_do_gc(sec);
> 	}
> +	mutex_unlock(&sec_gc_mutex);
>=20
> -	thread_set_flags(thread, SVC_STOPPED);
> -	wake_up(&thread->t_ctl_waitq);
> -	return 0;
> +	/* check ctx list again before sleep */
> +	sec_process_ctx_list();
> +	schedule_delayed_work(&sec_gc_work, SEC_GC_INTERVAL * HZ);
> }
>=20
> int sptlrpc_gc_init(void)
> {
> -	struct task_struct *task;
> -
> 	mutex_init(&sec_gc_mutex);
> 	spin_lock_init(&sec_gc_list_lock);
> 	spin_lock_init(&sec_gc_ctx_list_lock);
>=20
> -	/* initialize thread control */
> -	memset(&sec_gc_thread, 0, sizeof(sec_gc_thread));
> -	init_waitqueue_head(&sec_gc_thread.t_ctl_waitq);
> -
> -	task =3D kthread_run(sec_gc_main, &sec_gc_thread, "sptlrpc_gc");
> -	if (IS_ERR(task)) {
> -		CERROR("can't start gc thread: %ld\n", PTR_ERR(task));
> -		return PTR_ERR(task);
> -	}
> -
> -	wait_event_idle(sec_gc_thread.t_ctl_waitq,
> -			thread_is_running(&sec_gc_thread));
> +	schedule_delayed_work(&sec_gc_work, 0);
> 	return 0;
> }
>=20
> void sptlrpc_gc_fini(void)
> {
> -	thread_set_flags(&sec_gc_thread, SVC_STOPPING);
> -	wake_up(&sec_gc_thread.t_ctl_waitq);
> -
> -	wait_event_idle(sec_gc_thread.t_ctl_waitq,
> -			thread_is_stopped(&sec_gc_thread));
> +	cancel_delayed_work_sync(&sec_gc_work);
> }
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
