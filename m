Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeEQP5k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:57:40 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37344 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752180AbeEQP5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:57:38 -0400
X-Google-Smtp-Source: AB8JxZqSKDRwjBryDMw73sRsL8A2bBObaneKjKjEx8whORZr4zANoExXs0B55iZytc6hRm+5zUmu8g==
Date: Thu, 17 May 2018 09:57:33 -0600
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
Subject: Re: [PATCH v2 3/4] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20180517155733.GB3831@cisco>
References: <20180517151218.12850-1-tycho@tycho.ws>
 <20180517151218.12850-4-tycho@tycho.ws>
 <20180517154139.GB8586@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517154139.GB8586@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 05:41:39PM +0200, Oleg Nesterov wrote:
> again, I don't understand this code yet, but
> 
> On 05/17, Tycho Andersen wrote:
> >
> > +long seccomp_get_listener(struct task_struct *task,
> > +			  unsigned long filter_off)
> > +{
> > +	struct seccomp_filter *filter;
> > +	struct file *listener;
> > +	int fd;
> > +
> > +	filter = get_nth_filter(task, filter_off);
> > +	if (IS_ERR(filter))
> > +		return PTR_ERR(filter);
> > +
> > +	fd = get_unused_fd_flags(O_RDWR);
> > +	if (fd < 0) {
> > +		__put_seccomp_filter(filter);
> > +		return fd;
> > +	}
> > +
> > +	listener = init_listener(task, task->seccomp.filter);
> > +	if (IS_ERR(listener)) {
> > +		put_unused_fd(fd);
> > +		return PTR_ERR(listener);
> 
> __put_seccomp_filter() ?

Yes, I think you're right here.

> and since init_listener() does __get_seccomp_filter() on sucess, it is needed
> uncondtitionally?

I think there does need to be a __get_seccomp_filter() on success in
init_listener(), because it's paired with the __put_seccomp_filter in
seccomp_notify_release. The listener fd has a reference to the filter,
and that shouldn't go away until after the fd is freed.

Tycho
