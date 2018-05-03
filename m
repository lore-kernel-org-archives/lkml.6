Return-Path: <maco@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525369908; cv=none;
        d=google.com; s=arc-20160816;
        b=Ewh7u0qjodlZd72l9ANWaapA+C+smRH2B/iyqp7mkRUec3fNQYjlZDp+Y7DS3sfMmU
         LQTNJdedrpefMUAk6Go0p/YyunmH6bi9UsTiyj6JBf3Y/AtjKsIChOouXx/BCRpbI2Wn
         E8fKqHbInqNrw3C7hixHa+WOVar4fet0FhGtZstg5Y181shq5QJV5pnJB+n67KNsh5Af
         tWM2uFd+2oMHnX0dC00vxax2puoWk/EgSW4EnQqGqIQ+oHqxHN2ojl2+qkglED/+Egme
         QK5EygDgmdXkRltP7O/23QjTDfwzkV15Vzo1j9KVmwedjypFRP7HJDxXtX9LXwbxCHhH
         mM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=YTrw8bxXLQrhMPLIIFGuzoLoQCAQTIx1wNWD93/tbn8=;
        b=jYuFnzvtj419up6CM0hB6ZnF6016xzUAzM0cHp08I6AHpGr6zzsnJwe0gik2pQrfZk
         vlusyYq77LJZV89bKPemnSuEWUlJby63fftQxU3jGx03JGmzVig3V2svciKyAC0+f7vO
         OkRZqfSEbw6bKh5EVHTxZd781UjKkdFcHyhPplF1D70F5+9SiauxbbAArrjrtjPK4YO5
         d/u6aj3gKaLNvjCeHVVvKqVHhO/Z7cD3cG9Gey1ZumCXQqMGcXFCqdWnz+0xUppjyF2O
         a8N14FAeRaFrlhqQ3srq8O9FHkwENeg3TkNgyxPub8Aelk8ObACIf/Mxftm6eGhxUf4I
         dcGA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=EMJSNU7m;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=EMJSNU7m;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AB8JxZrplIjUPXe2Jf0slr6s4QNj9S2MHrkg2c7B+vrC5f/GMPo/wTNqJJhfSmPFVPowyBwdSodkQpftWk6U5sV0z7w=
MIME-Version: 1.0
In-Reply-To: <20180502143008.25582-1-yuanhuihui@xiaomi.com>
References: <20180502143008.25582-1-yuanhuihui@xiaomi.com>
From: Martijn Coenen <maco@android.com>
Date: Thu, 3 May 2018 10:51:47 -0700
Message-ID: <CAB0TPYGx==vzGDA-Z3bLi1Q+SqJ04NaE6DBgg3b=deX2yJ42aA@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: binder: fix binder work return error is wrongly consumed
To: gityuan@gmail.com
Cc: Greg KH <gregkh@linuxfoundation.org>, Todd Kjos <tkjos@google.com>,
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	"open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
	yuanhuihui <yuanhuihui@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599362997711826317?=
X-GMAIL-MSGID: =?utf-8?q?1599466277804916396?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 2, 2018 at 7:30 AM,  <gityuan@gmail.com> wrote:
> But there is potential risks in the future, future functional extensions
> need to consider nesting issues, maybe extending more methods where we
> push to thread->todo. I think that using queueing return error transaction
> to the head of thread todo list is more appropriate, as follows:

Historically it was not safe to issue binder transactions from death
recipients because of issues like this - though I don't think we've
ever been clear about that in the documentation. "ANDROID: binder:
don't enqueue
death notifications to thread todo" fixes that, and makes it safe to
do - though the current driver may still have an issue if two death
receipts are queued (need to look into that). If we ever were to add
functionality into the driver again that queues something to
thread->todo that could result in nesting, we would need to do more
than just this change to make it safe. Consider this scenario, which
would fail even with your patch:

1) BR_DEAD_BINDER is in thread->todo
2) We issue a new transaction T1 to a different process, which succeeds
3) We queue the reply BR_REPLY for T1 to thread->todo and return to userspace
4) userspace finds BR_DEAD_BINDER first, runs a death recipient which
issues a new binder transaction, T2
5) We find the BR_REPLY for T1 instead of T2, and now we have a problem

So, this fix by itself won't make it safe, so I think instead we
should always prevent such nesting in the driver. That also keeps the
code simpler and easier to understand - just queue things in order.

Thanks,
Martijn

>
> 1) During a transaction, the client will add BINDER_WORK_RETURN_ERROR into
> thread->todo list, however, it would be better to pick up
> BINDER_WORK_RETURN_ERROR firstly and finish the transaction immediately,
> jump out of the nest.
>
> 2) Client pick up the left binder work from thread->todo, using the
> same thread, do not need wake up other idle binder thread.
>
> 3) It works fine in the old binder version (before split big binder
> lock), binder_transaction only set thread return_error when target
> process has dead, do not add BINDER_WORK_RETURN_ERROR into thread->todo,
> but binder_thread_read() check return_error firstly. If occurs return_error,
> finish this transaction and back to userspace immediately.
>
> So I prefer to put the BINDER_WORK_RETURN_ERROR to the head of the
> queue, same as the old version of binder driver, once and for all.
>
> Signed-off-by: yuanhuihui <yuanhuihui@xiaomi.com>
> ---
>  drivers/android/binder.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 4eab5be3d00f..1ed1809b8769 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -861,6 +861,60 @@ binder_enqueue_thread_work(struct binder_thread *thread,
>         binder_inner_proc_unlock(thread->proc);
>  }
>
> +/**
> + * binder_enqueue_work_head_ilocked() - Add an item to the head of work list
> + * @work:         struct binder_work to add to list
> + * @target_list:  list to add work to
> + *
> + * Adds the work to the specified list. Asserts that work
> + * is not already on a list.
> + *
> + * Requires the proc->inner_lock to be held.
> + */
> +static void
> +binder_enqueue_work_head_ilocked(struct binder_work *work,
> +                          struct list_head *target_list)
> +{
> +       BUG_ON(target_list == NULL);
> +       BUG_ON(work->entry.next && !list_empty(&work->entry));
> +       list_add(&work->entry, target_list);
> +}
> +
> +/**
> + * binder_enqueue_thread_work_head_ilocked() - Add an item to the head of thread work list
> + * @thread:       thread to queue work to
> + * @work:         struct binder_work to add to list
> + *
> + * Adds the work to the head of thread todo list, and enables processing
> + * of the todo queue.
> + *
> + * Requires the proc->inner_lock to be held.
> + */
> +static void
> +binder_enqueue_thread_work_head_ilocked(struct binder_thread *thread,
> +                                  struct binder_work *work)
> +{
> +       binder_enqueue_work_head_ilocked(work, &thread->todo);
> +       thread->process_todo = true;
> +}
> +
> +/**
> + * binder_enqueue_thread_work_head() - Add an item to the head of thread work list
> + * @thread:       thread to queue work to
> + * @work:         struct binder_work to add to list
> + *
> + * Adds the work to the head of thread todo list, and enables processing
> + * of the todo queue.
> + */
> +static void
> +binder_enqueue_thread_work_head(struct binder_thread *thread,
> +                          struct binder_work *work)
> +{
> +       binder_inner_proc_lock(thread->proc);
> +       binder_enqueue_thread_work_head_ilocked(thread, work);
> +       binder_inner_proc_unlock(thread->proc);
> +}
> +
>  static void
>  binder_dequeue_work_ilocked(struct binder_work *work)
>  {
> @@ -3287,11 +3341,11 @@ static void binder_transaction(struct binder_proc *proc,
>         BUG_ON(thread->return_error.cmd != BR_OK);
>         if (in_reply_to) {
>                 thread->return_error.cmd = BR_TRANSACTION_COMPLETE;
> -               binder_enqueue_thread_work(thread, &thread->return_error.work);
> +               binder_enqueue_thread_work_head(thread, &thread->return_error.work);
>                 binder_send_failed_reply(in_reply_to, return_error);
>         } else {
>                 thread->return_error.cmd = return_error;
> -               binder_enqueue_thread_work(thread, &thread->return_error.work);
> +               binder_enqueue_thread_work_head(thread, &thread->return_error.work);
>         }
>  }
>
> @@ -3929,6 +3983,7 @@ static int binder_thread_read(struct binder_proc *proc,
>                         ptr += sizeof(uint32_t);
>
>                         binder_stat_br(proc, thread, e->cmd);
> +                       goto done; /* RETURN_ERROR notifications can finish transactions */
>                 } break;
>                 case BINDER_WORK_TRANSACTION_COMPLETE: {
>                         binder_inner_proc_unlock(proc);
> --
> 2.14.1
>
