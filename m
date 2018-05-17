Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752420AbeEQPlr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:41:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752358AbeEQPln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:41:43 -0400
Date: Thu, 17 May 2018 17:41:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.ws>
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
Message-ID: <20180517154139.GB8586@redhat.com>
References: <20180517151218.12850-1-tycho@tycho.ws>
 <20180517151218.12850-4-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517151218.12850-4-tycho@tycho.ws>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

again, I don't understand this code yet, but

On 05/17, Tycho Andersen wrote:
>
> +long seccomp_get_listener(struct task_struct *task,
> +			  unsigned long filter_off)
> +{
> +	struct seccomp_filter *filter;
> +	struct file *listener;
> +	int fd;
> +
> +	filter = get_nth_filter(task, filter_off);
> +	if (IS_ERR(filter))
> +		return PTR_ERR(filter);
> +
> +	fd = get_unused_fd_flags(O_RDWR);
> +	if (fd < 0) {
> +		__put_seccomp_filter(filter);
> +		return fd;
> +	}
> +
> +	listener = init_listener(task, task->seccomp.filter);
> +	if (IS_ERR(listener)) {
> +		put_unused_fd(fd);
> +		return PTR_ERR(listener);

__put_seccomp_filter() ?

and since init_listener() does __get_seccomp_filter() on sucess, it is needed
uncondtitionally?

Oleg.
