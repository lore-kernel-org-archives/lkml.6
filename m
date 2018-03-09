Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AG47ELt303dVmofB42MSmtEQ69XmuOUIlTzwZZPYWOLT67EJmpAp123bmw6gPS/TkYbCHsX+eg0Y
ARC-Seal: i=1; a=rsa-sha256; t=1520554334; cv=none;
        d=google.com; s=arc-20160816;
        b=JNYB5v0f8Fv6lLmJ/ewOOf2iDSlbvC5b2Ov3/CWSbT1Y/ak+lzH9eC9u4aspSj4gD9
         dQJLhItprO1LPJD6XXHoxw7dIS/XQG7/5c+dvN61UhH4JLjS1V641DfOhOopi6KbP6tW
         8/yMGRz/zLmAlY5ubHVbbaIHwnIGC+3ENr/dcwd03M7QdfolyI4NEAOe651Ikgehmmgy
         qzz6CrB7U7rwgl51bX4PaLQgQYZ3ztPcVscDLeuPNZOWWfY1ej8dUScXC56lYE23oY5N
         rX7Oesarx0v2wFDeTLeXol28d7Q+CwjRXsQfABi1MsNq5Q9Xj5TRHH0x+i40laW67NqD
         OGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=tFZ8bp5PrJp8iOR5gAGqZfuK06ZroFiu9ntzEGpElLc=;
        b=SG2bX5a8DxraX6EtXzdQOBLDyo+0oF1HTCNqAODZKiwuk50R3AOYbQGVCiik79Ngxk
         Yqb8u2W7IAHQYWc1u13GsHiSgjt2Ec4llX+2HbYu9OqGRJD8bkgX8n8FSSSjDFRs2Jqr
         lm43b5T/TV9d3nx8d46dC+wEZqcEIHO2yayOgVW2xC2LGuX/TGZ9XiTCZmlPleHxtblw
         ZewJiYlLPLZ6/a5uuv9oNJR82xP1E4ysIRw4awBFbgUW7D2QNRVv0lX7HcB6fngRCQfb
         Jv8rNovUz3rN7EvwyBqRorbmhVVckqXOZzQ3423gKPxpxZaKQj3MOYWunBjvnIhcdPgh
         pHJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,443,1515484800";
   d="scan'208";a="40420738"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>, "Yong, Fan" <fan.yong@intel.com>
Subject: Re: [PATCH 13/17] staging: lustre: remove 'ptlrpc_thread usage' for
 sai_agl_thread
Thread-Topic: [PATCH 13/17] staging: lustre: remove 'ptlrpc_thread usage'
 for sai_agl_thread
Thread-Index: AQHTsbXDyzh0gMmR60mYrILJYhE5yqPHmTqA
Date: Fri, 9 Mar 2018 00:12:12 +0000
Message-ID: <A1BB636C-AB1F-4000-82F5-FFC700BCA3C3@intel.com>
References: <151994679573.7628.1024109499321778846.stgit@noble>
 <151994708549.7628.13268008928655143336.stgit@noble>
In-Reply-To: <151994708549.7628.13268008928655143336.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.37.249]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F4BE42AA8CD06341BD3419BC2BE4A561@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780184664448130?=
X-GMAIL-MSGID: =?utf-8?q?1594416782479001879?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mar 1, 2018, at 16:31, NeilBrown <neilb@suse.com> wrote:
>=20
> Lustre has a 'struct ptlrpc_thread' which provides
> control functionality wrapped around kthreads.
> None of the functionality used in statahead.c requires
> ptlrcp_thread - it can all be done directly with kthreads.
>=20
> So discard the ptlrpc_thread and just use a task_struct directly.
>=20
> One particular change worth noting is that in the current
> code, the thread performs some start-up actions and then
> signals that it is ready to go.  In the new code, the thread
> is first created, then the startup actions are perform, then
> the thread is woken up.  This means there is no need to wait
> any more than kthread_create() already waits.
>=20
> Signed-off-by: NeilBrown <neilb@suse.com>

Looks reasonable, but one minor comment inline below.  Not enough to
make me think the patch is bad, just a minor inefficiency...

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

I've also CC'd Fan Yong, who is the author of this code in case
he has any comments.

> diff --git a/drivers/staging/lustre/lustre/llite/statahead.c b/drivers/st=
aging/lustre/lustre/llite/statahead.c
> index ba00881a5745..39241b952bf4 100644
> --- a/drivers/staging/lustre/lustre/llite/statahead.c
> +++ b/drivers/staging/lustre/lustre/llite/statahead.c
> @@ -861,35 +860,13 @@ static int ll_agl_thread(void *arg)
> 	struct inode	     *dir    =3D d_inode(parent);
> 	struct ll_inode_info     *plli   =3D ll_i2info(dir);
> 	struct ll_inode_info     *clli;
> -	struct ll_sb_info	*sbi    =3D ll_i2sbi(dir);
> -	struct ll_statahead_info *sai;
> -	struct ptlrpc_thread *thread;
> +	/* We already own this reference, so it is safe to take it without a lo=
ck. */
> +	struct ll_statahead_info *sai =3D plli->lli_sai;
>=20
> -	sai =3D ll_sai_get(dir);

Here we used to grab a reference to "sai" from the directory, but you
get it in the calling thread now...

> @@ -937,16 +917,22 @@ static void ll_start_agl(struct dentry *parent, str=
uct ll_statahead_info *sai)
> 	       sai, parent);
>=20
> 	plli =3D ll_i2info(d_inode(parent));
> +	task =3D kthread_create(ll_agl_thread, parent, "ll_agl_%u",
> +			      plli->lli_opendir_pid);
> 	if (IS_ERR(task)) {
> 		CERROR("can't start ll_agl thread, rc: %ld\n", PTR_ERR(task));
> 		return;
> 	}
>=20
> +	sai->sai_agl_task =3D task;
> +	atomic_inc(&ll_i2sbi(d_inode(parent))->ll_agl_total);
> +	spin_lock(&plli->lli_agl_lock);
> +	sai->sai_agl_valid =3D 1;
> +	spin_unlock(&plli->lli_agl_lock);
> +	/* Get an extra reference that the thread holds */
> +	ll_sai_get(d_inode(parent));

Here you get the extra reference, but we already have the pointer to
"sai", do going through "parent->d_inode->lli->lli_sai" to get "sai"
again seems convoluted.  One option is atomic_inc(&sai->sai_refcount),
but given that this is done only once per "ls" call I don't think it
is a huge deal, and not more work than was done before.

Cheers, Andreas

> +
> +	wake_up_process(task);
> }
>=20
> /* statahead thread main function */
> @@ -958,7 +944,6 @@ static int ll_statahead_thread(void *arg)
> 	struct ll_sb_info	*sbi    =3D ll_i2sbi(dir);
> 	struct ll_statahead_info *sai;
> 	struct ptlrpc_thread *sa_thread;
> -	struct ptlrpc_thread *agl_thread;
> 	struct page	      *page =3D NULL;
> 	__u64		     pos    =3D 0;
> 	int		       first  =3D 0;
> @@ -967,7 +952,6 @@ static int ll_statahead_thread(void *arg)
>=20
> 	sai =3D ll_sai_get(dir);
> 	sa_thread =3D &sai->sai_thread;
> -	agl_thread =3D &sai->sai_agl_thread;
> 	sa_thread->t_pid =3D current_pid();
> 	CDEBUG(D_READA, "statahead thread starting: sai %p, parent %pd\n",
> 	       sai, parent);
> @@ -1129,21 +1113,13 @@ static int ll_statahead_thread(void *arg)
> 		sa_handle_callback(sai);
> 	}
> out:
> -	if (sai->sai_agl_valid) {
> -		spin_lock(&lli->lli_agl_lock);
> -		thread_set_flags(agl_thread, SVC_STOPPING);
> -		spin_unlock(&lli->lli_agl_lock);
> -		wake_up(&agl_thread->t_ctl_waitq);
> +	if (sai->sai_agl_task) {
> +		kthread_stop(sai->sai_agl_task);
>=20
> 		CDEBUG(D_READA, "stop agl thread: sai %p pid %u\n",
> -		       sai, (unsigned int)agl_thread->t_pid);
> -		wait_event_idle(agl_thread->t_ctl_waitq,
> -				thread_is_stopped(agl_thread));
> -	} else {
> -		/* Set agl_thread flags anyway. */
> -		thread_set_flags(agl_thread, SVC_STOPPED);
> +		       sai, (unsigned int)sai->sai_agl_task->pid);
> +		sai->sai_agl_task =3D NULL;
> 	}
> -
> 	/*
> 	 * wait for inflight statahead RPCs to finish, and then we can free sai
> 	 * safely because statahead RPC will access sai data
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
