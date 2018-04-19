Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753273AbeDSFjQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 01:39:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:38787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbeDSFjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 01:39:15 -0400
Message-ID: <1524116324.21378.1.camel@gmx.de>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
From: Mike Galbraith <efault@gmx.de>
To: Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Date: Thu, 19 Apr 2018 07:38:44 +0200
In-Reply-To: <1524030475.5645.2.camel@gmx.de>
References: <20180417142119.GA4511@codeblueprint.co.uk>
         <1524030475.5645.2.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/a3Gli4062q2Tqm8e4UCvdeiasV5CV0qy/zNbgWsT93NOHP2BeT
 YEVauhCXcibscdDI0Wdz2qMkMbjqBJwEIjkQXyC+1X1BmsdNaYBpv06o2SwTp5JNMERA6TC
 KFyxG3zehuTL3WsZc2b49wWewwsBloL6IYmwQZyttpDzevM9H0KadqP3PDfyRDcEMGvmqgs
 kXg2YVaj/x+bQI00aO9ZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:laqmJAs1SVo=:sRAoXUH5QYMnP+H4AKo3A6
 VSsANo8rACmjPiN3qZfmcppfI0R72En9jbF4RID3qmw+Sqwj2p2kymKPz08tWMyX1O1Ne0rLG
 PcML7TH+8EqgIiyB+VODkxxn1xNme72Nkp0KzWyk23Vo22fUSbotqcGW/P5aMnX6KrxrCbPPs
 3GL/DGeN3WGyjfBKC9FiYg5w3yfmePl7e/+7Jo4XyJ2iKRQip2TgcUEkSosCtJHP+o7a/vGqk
 cbPj4gXPuFeIsq4PUIKavQpsRYzvnC5aKaS9RCn7l9F/XI5eCcMQcV3ru8MkaH5PkYT2JuTIR
 Glgab9gko/BhaTgBkNK2XFdHO3XTzw85vyALHfSbo0u0nPGEoWwACJeBAD6DooraB3u8cXnWC
 Rj7gEYkfbgCvwuoqYr8GyvE1BQMweU9+Fyt32kkddo/XsghtBQEWbrlwoUipxVJ3N9pjlGEJR
 Dq392QWqDrZteYkS49myMbjJT9djCYfGUfCSu0QIitnr60/a6JkeF2rD/qe2pYbICc4Tlilaq
 G+v/i3YXoIVI2SNQ26OfDchsUOCs56uGAwe3MmNanES0ABOVpXNBRBm+EiKXCLryjDThCdtEJ
 nZqWi1Jf0RojRxKuS8JtoYtYDpJJHeDXwJKS3+uIerUNbenVyjBzQVaZxHHMDWW02PSBs7APu
 NBFY2jdMBwEg/7nYhc+oUqOxgg1jnp5pdiPLpkwFwp248NjgKFOUcgZpPjU7DmBNGKfKOVMjx
 aDWp72rgpw+rQkqHENX3OB4oJCehUWd2xkobuqt5Kr6q05nuX9nZCURjtVIcNObLZvAurURDt
 UOpUJhMDGt6Tphx6VpV9lP1OAz9mfvII9aiNsOpQwK0pQnQJPc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-18 at 07:47 +0200, Mike Galbraith wrote:
> On Tue, 2018-04-17 at 15:21 +0100, Matt Fleming wrote:
> > Hi guys,
> > 
> > We've seen a bug in one of our SLE kernels where the cpu stopper
> > thread ("migration/15") is entering idle balance. This then triggers
> > active load balance.
> > 
> > At the same time, a task on another CPU triggers a page fault and NUMA
> > balancing kicks in to try and migrate the task closer to the NUMA node
> > for that page (we're inside stop_two_cpus()). This faulting task is
> > spinning in try_to_wake_up() (inside smp_cond_load_acquire(&p->on_cpu,
> > !VAL)), waiting for "migration/15" to context switch.
> > 
> > Unfortunately, because "migration/15" is doing active load balance
> > it's spinning waiting for the NUMA-page-faulting CPU's stopper lock,
> > which is already held (since it's inside stop_two_cpus()).
> > 
> > Deadlock ensues.
> > 
> > This seems like a situation that should be prohibited, but I cannot
> > find any code to prevent it. Is it OK for stopper threads to load
> > balance? Is there something that should prevent this situation from
> > happening?
> 
> I don't see anything to stop the deadlock either, would exclude stop
> class from playing idle balancer entirely...

Bah, insufficient: __do_softirq() -> rebalance_domains() still bites.
