Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19905C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3FF20645
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfAHSRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:17:45 -0500
Received: from mail.hallyn.com ([178.63.66.53]:40998 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfAHSRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:17:44 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id AEDB0107D; Tue,  8 Jan 2019 12:17:42 -0600 (CST)
Date:   Tue, 8 Jan 2019 12:17:42 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, keescook@chromium.org,
        akpm@linux-foundation.org, jannh@google.com, oleg@redhat.com,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, dancol@google.com,
        timmurray@google.com, fweimer@redhat.com, tglx@linutronix.de,
        x86@kernel.org, ebiederm@xmission.com
Subject: Re: [PATCH v7 2/2] selftests: add tests for pidfd_send_signal()
Message-ID: <20190108181742.GA22614@mail.hallyn.com>
References: <20190102161654.9093-1-christian@brauner.io>
 <20190102161654.9093-2-christian@brauner.io>
 <20190108175306.GF29009@cisco>
 <20190108175415.GA22353@mail.hallyn.com>
 <20190108175843.GA26016@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108175843.GA26016@cisco>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 10:58:43AM -0700, Tycho Andersen wrote:
> On Tue, Jan 08, 2019 at 11:54:15AM -0600, Serge E. Hallyn wrote:
> > On Tue, Jan 08, 2019 at 10:53:06AM -0700, Tycho Andersen wrote:
> > > On Wed, Jan 02, 2019 at 05:16:54PM +0100, Christian Brauner wrote:
> > > > +			/*
> > > > +			 * Stop the child so we can inspect whether we have
> > > > +			 * recycled pid PID_RECYCLE.
> > > > +			 */
> > > > +			close(pipe_fds[0]);
> > > > +			ret = kill(recycled_pid, SIGSTOP);
> > > > +			close(pipe_fds[1]);
> > > > +			if (ret) {
> > > > +				(void)wait_for_pid(recycled_pid);
> > > > +				_exit(PIDFD_ERROR);
> > > > +			}
> > > 
> > > Sorry for being late to the party, but I wonder if this whole thing
> > > couldn't be simplified with /proc/sys/kenrel/ns_last_pid?
> > 
> > no, bc it's not namespaced :)
> 
> Huh? It looks like it is...
> 
> static int pid_ns_ctl_handler(struct ctl_table *table, int write,
>                 void __user *buffer, size_t *lenp, loff_t *ppos)
> {
>         struct pid_namespace *pid_ns = task_active_pid_ns(current);
>         struct ctl_table tmp = *table;
>         int ret, next;
> 
>         if (write && !ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
>                 return -EPERM;
> 
>         ...

Oh - hah, but that's ns_last_pid.  You'd want pid_max.  And that one
is not namespaced.
