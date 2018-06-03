Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750995AbeFCGXf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 02:23:35 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33748 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbeFCGXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 02:23:33 -0400
X-Google-Smtp-Source: ADUXVKJlr9/QuIWBfloK9ggXqWzMqpuM9FqzE8j7wL7hrkyQ8u2tRNCr/E/bIFrb8fndRpsd2aikuA==
Date: Sat, 2 Jun 2018 23:23:30 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Byungchul Park <max.byungchul.park@gmail.com>
Cc: Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>, josh@joshtriplett.org,
        rostedt@goodmis.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH] rcu: Check the range of jiffies_till_{first,next}_fqs
 when setting them
Message-ID: <20180603062330.GA153988@joelaf.mtv.corp.google.com>
References: <1527818589-13476-1-git-send-email-byungchul.park@lge.com>
 <20180603035848.GA76941@joelaf.mtv.corp.google.com>
 <CANrsvRNeMc8JppnP53ordMkzw+HDdPn0VsiF0j3YdWbQe1+sUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANrsvRNeMc8JppnP53ordMkzw+HDdPn0VsiF0j3YdWbQe1+sUg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 03, 2018 at 02:38:04PM +0900, Byungchul Park wrote:
> On Sun, Jun 3, 2018 at 12:58 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Fri, Jun 01, 2018 at 11:03:09AM +0900, Byungchul Park wrote:
> >> Currently, the range of jiffies_till_{first,next}_fqs are checked and
> >> adjusted on and on in the loop of rcu_gp_kthread on runtime.
> >>
> >> However, it's enough to check them only when setting them, not every
> >> time in the loop. So make them handled on a setting time via sysfs.
> >>
> >> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> >> ---
> >>  kernel/rcu/tree.c | 45 ++++++++++++++++++++++++++++++++-------------
> >>  1 file changed, 32 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> index 4e96761..eb54d7d 100644
> >> --- a/kernel/rcu/tree.c
> >> +++ b/kernel/rcu/tree.c
> >> @@ -518,8 +518,38 @@ void rcu_all_qs(void)
> >>  static ulong jiffies_till_next_fqs = ULONG_MAX;
> >>  static bool rcu_kick_kthreads;
> >>
> >> -module_param(jiffies_till_first_fqs, ulong, 0644);
> >> -module_param(jiffies_till_next_fqs, ulong, 0644);
> >> +static int param_set_first_fqs_jiffies(const char *val, const struct kernel_param *kp)
> >> +{
> >> +     ulong j;
> >> +     int ret = kstrtoul(val, 0, &j);
> >> +
> >> +     if (!ret)
> >> +             WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : j);
> >> +     return ret;
> >> +}
> >> +
> >> +static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param *kp)
> >> +{
> >> +     ulong j;
> >> +     int ret = kstrtoul(val, 0, &j);
> >> +
> >> +     if (!ret)
> >> +             WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : (j ?: 1));
> >> +     return ret;
> >> +}
> >
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > Also, can we not combine the 2 param_set_ handlers as well?
> >
> > Only thing we would be giving up is that jiffies_till_first_fqs = 0 wouldn't
> > be allowed (if we go with the param_set_next handler to be the common one)
> > but don't think that's a useful/valid usecase since jiffies_till_first_fqs is
> > set to a sane non-0 value anyway at boot up because of rcu_init_geometry
> > anyway.. Thoughts?
> 
> Excuse me. Which code in rcu_init_geometry() makes jiffies_till_first_fqs
> be a non-zero in case called with jiffies_till_first_fqs == 0?

What do you mean? I think you misunderstood. I didn't say value of 0 is being
handled at boot up. What I said is its initialized to something sane that's
non-zero:

If you see, jiffies_till_first_fqs is assigned to ULONG_MAX at compile time:
static ulong jiffies_till_first_fqs = ULONG_MAX;

Then in rcu_init_geometry, we have:
        d = RCU_JIFFIES_TILL_FORCE_QS + nr_cpu_ids / RCU_JIFFIES_FQS_DIV;
        if (jiffies_till_first_fqs == ULONG_MAX)
	                jiffies_till_first_fqs = d;

On my system, jiffies_till_first_fqs is assigned to 3 because of this at
boot.

> Furthermore, what if we want to change the value through sysfs to zero
> on runtime?

My patch was just a suggestion. I didn't know if anyone would want to force
it to 0 or not and was wondering what the value in doing so was at the cost
of adding one more function to handle it. It basically says if you set to 0,
that you never want to wait for a timeout before forcing a qs for the first
time? Then why are we calling swait_event_idle_timeout anyway? Wouldn't a
saner timeout be something not zero?

thanks,

- Joel
