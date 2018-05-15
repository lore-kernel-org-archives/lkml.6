Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeEOG7Q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:59:16 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45924 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbeEOG7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:59:15 -0400
X-Google-Smtp-Source: AB8JxZqmvXVf+9a49jxmJujf1Izh1UkcAJlYQDuHyR09AxLmibd6xQP6IhzPQOtq1pnTjmkxn+cy5i/PlewatsAX9Tw=
MIME-Version: 1.0
In-Reply-To: <1526326267-22501-2-git-send-email-longman@redhat.com>
References: <1526326267-22501-1-git-send-email-longman@redhat.com> <1526326267-22501-2-git-send-email-longman@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 15 May 2018 09:59:14 +0300
Message-ID: <CAOQ4uxgMHKeVNS7Mg2nG=Zt_sGGOr1d20gA-s7Q8hhe-zA+kLw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] locking/rwsem: Add a new RWSEM_WRITER_OWNED_NOSPIN
 flag
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:31 PM, Waiman Long <longman@redhat.com> wrote:
> There are use cases where a rwsem can be acquired by one task, but
> released by another task. In thess cases, it may not be appropriate
> for the lock waiters to spin on the task that acquires the lock.
> One example will be the filesystem freeze/thaw code.
>
> To handle such use cases, a new RWSEM_WRITER_OWNED_NOSPIN
> flag can now be set in the owner field of the rwsem by the new
> rwsem_set_writer_owned_nospin() function to indicate that the rwsem is
> writer owned, but optimistic spinning on the rwsem should be disabled.
>
> Later on, the new rwsem_set_writer_owned() function can be called to
> set the new owner, if it is known. This function should not be called
> without a prior rwsem_set_writer_owned_nospin() call.
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Makes sense to me. one nit.

>
> +static inline void __rwsem_set_writer_owned(struct rw_semaphore *sem,
> +                                           struct task_struct *task)

rwsem_set_owner() doesn't pass in task argument and IMO
__rwsem_set_writer_owned() shouldn't either.

Thanks,
Amir.
