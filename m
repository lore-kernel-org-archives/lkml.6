Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeEQPkF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:40:05 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40560 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeEQPkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:40:03 -0400
X-Google-Smtp-Source: AB8JxZrQ9owrN5mOyDt90RYugy3dSgV3RmEdvdBriCCY3FEOq3QB55ZG/krJithBg0hnMv99ae9WYg==
Date: Thu, 17 May 2018 09:39:57 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH v2 1/4] seccomp: add a return code to trap to userspace
Message-ID: <20180517153957.GA3831@cisco>
References: <20180517151218.12850-1-tycho@tycho.ws>
 <20180517151218.12850-2-tycho@tycho.ws>
 <20180517153323.GA8586@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517153323.GA8586@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

Thanks for taking a look!

On Thu, May 17, 2018 at 05:33:24PM +0200, Oleg Nesterov wrote:
> I didn't read this series yet, and I don't even understand what are you
> trying to do, just one question...
> 
> On 05/17, Tycho Andersen wrote:
> >
> > +static struct file *init_listener(struct task_struct *task,
> > +				  struct seccomp_filter *filter)
> > +{
> > +	struct file *ret = ERR_PTR(-EBUSY);
> > +	struct seccomp_filter *cur;
> > +	bool have_listener = false;
> > +
> > +	for (cur = task->seccomp.filter; cur; cur = cur->prev) {
> > +		mutex_lock(&cur->notify_lock);
> 
> Did you test this patch with CONFIG_LOCKDEP ?

Yes, with,

CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y

> From lockdep pov this loop tries to take the same lock twice or more, it shoul
> complain.

I didn't, but I guess that's because it's not trying to take the same lock
twice -- the pointer cur is changing in the loop. Unless I'm misunderstanding
what you're saying.

The idea behind this code is to lock the entire chain of filters up to the
parent so that we can ensure none of them have a listener installed. This is
based on a suggestion from Andy last review cycle to not allow two listeners,
since nesting would be confusing.

Tycho
