Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752371AbeERPVz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:21:55 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43611 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752306AbeERPVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:21:49 -0400
X-Google-Smtp-Source: AB8JxZoqILS8i1wt+FCDcerpzIRkdrhRb6x8JawyDYKgjmSW4yRXeDuTErhg2RsRvfwGpAcQ+gwkXw==
Date: Fri, 18 May 2018 09:21:45 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        "Tobin C . Harding" <me@tobin.cc>, Kees Cook <keescook@chromium.org>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH v2 1/4] seccomp: add a return code to trap to userspace
Message-ID: <20180518152145.GB7699@cisco>
References: <20180517151218.12850-1-tycho@tycho.ws>
 <20180517151218.12850-2-tycho@tycho.ws>
 <20180518140415.GB26297@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518140415.GB26297@mailbox.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 04:04:16PM +0200, Christian Brauner wrote:
> On Thu, May 17, 2018 at 09:12:15AM -0600, Tycho Andersen wrote:
> > +#ifdef CONFIG_SECCOMP_USER_NOTIFICATION
> > +static u64 seccomp_next_notify_id(struct seccomp_filter *filter)
> > +{
> > +	u64 ret = filter->next_id;
> > +
> > +	/* Note: overflow is ok here, the id just needs to be unique */
> > +	filter->next_id++;
> > +
> > +	return ret;
> > +}
> 
> Nit: Depending on how averse people are to relying on side-effects this
> could be simplified to:
> 
> static inline u64 seccomp_next_notify_id(struct seccomp_filter *filter)
> {
>         /* Note: Overflow is ok. The id just needs to be unique. */
>         return filter->next_id++;
> }

Oh, yes, definitely. I think this is leftover from when this function
worked a different way.

> > +
> > +static void seccomp_do_user_notification(int this_syscall,
> > +					 struct seccomp_filter *match,
> > +					 const struct seccomp_data *sd)
> > +{
> > +	int err;
> > +	long ret = 0;
> > +	struct seccomp_knotif n = {};
> > +
> > +	mutex_lock(&match->notify_lock);
> > +	if (!match->has_listener) {
> > +		err = -ENOSYS;
> > +		goto out;
> > +	}
> 
> Nit:
> 
> err = -ENOSYS;
> mutex_lock(&match->notify_lock);
> if (!match->has_listener)
>         goto out;
> 
> looks cleaner to me or you do the err initalization at the top of the
> function. :)

Ok :)

> > +
> > +	n.pid = current->pid;
> > +	n.state = SECCOMP_NOTIFY_INIT;
> > +	n.data = sd;
> > +	n.id = seccomp_next_notify_id(match);
> > +	init_completion(&n.ready);
> > +
> > +	list_add(&n.list, &match->notifications);
> > +
> > +	mutex_unlock(&match->notify_lock);
> > +	up(&match->request);
> > +
> > +	err = wait_for_completion_interruptible(&n.ready);
> > +	mutex_lock(&match->notify_lock);
> > +
> > +	/*
> > +	 * Here it's possible we got a signal and then had to wait on the mutex
> > +	 * while the reply was sent, so let's be sure there wasn't a response
> > +	 * in the meantime.
> > +	 */
> > +	if (err < 0 && n.state != SECCOMP_NOTIFY_REPLIED) {
> > +		/*
> > +		 * We got a signal. Let's tell userspace about it (potentially
> > +		 * again, if we had already notified them about the first one).
> > +		 */
> > +		if (n.state == SECCOMP_NOTIFY_SENT) {
> > +			n.state = SECCOMP_NOTIFY_INIT;
> > +			up(&match->request);
> > +		}
> > +		mutex_unlock(&match->notify_lock);
> > +		err = wait_for_completion_killable(&n.ready);
> > +		mutex_lock(&match->notify_lock);
> > +		if (err < 0)
> > +			goto remove_list;
> > +	}
> > +
> > +	ret = n.val;
> > +	err = n.error;
> > +
> > +	WARN(n.state != SECCOMP_NOTIFY_REPLIED,
> > +	     "notified about write complete when state is not write");
> 
> Nit: That message seems a little cryptic.

Perhaps we can just drop it. It's just a sanity check, but given the
tests above, it doesn't seem likely.

> > +
> > +remove_list:
> > +	list_del(&n.list);
> > +out:
> > +	mutex_unlock(&match->notify_lock);
> > +	syscall_set_return_value(current, task_pt_regs(current),
> > +				 err, ret);
> > +}
> > +#else
> > +static void seccomp_do_user_notification(int this_syscall,
> > +					 u32 action,
> > +					 struct seccomp_filter *match,
> > +					 const struct seccomp_data *sd)
> > +{
> > +	WARN(1, "user notification received, but disabled");
> 
> Nit: "received unexpected user notification" might be clearer

Yes, I wonder if we shouldn't just drop this too -- it's not a kernel
bug, but a userspace bug that they're using features that aren't
enabled.

We could enhance the verifier with a static check for
BPF_RET | BPF_K == SECCOMPO_RET_USER_NOTIF and reject such programs if
user notification isn't enabled. Of course, it wouldn't handle the
dynamic case, but it might be useful.

Tycho
