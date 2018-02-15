Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166052AbeBOSIP convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:08:15 -0500
Received: from mout.gmx.net ([212.227.15.18]:43823 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164018AbeBOSIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:08:12 -0500
Message-ID: <1518718056.13961.23.camel@gmx.de>
Subject: Re: [RFC 1/2] sched: reduce migration cost between faster caches
 for idle_balance
From: Mike Galbraith <efault@gmx.de>
To: Steven Sistare <steven.sistare@oracle.com>,
        Rohit Jain <rohit.k.jain@oracle.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, joelaf@google.com,
        jbacik@fb.com, riel@redhat.com, juri.lelli@redhat.com,
        dhaval.giani@oracle.com
Date: Thu, 15 Feb 2018 19:07:36 +0100
In-Reply-To: <dd972024-b3d6-fa53-7cc5-9e71a01c1837@oracle.com>
References: <1518128395-14606-1-git-send-email-rohit.k.jain@oracle.com>
         <1518128395-14606-2-git-send-email-rohit.k.jain@oracle.com>
         <1518147735.24350.26.camel@gmx.de>
         <e773350b-dd8c-ab1a-5dae-8f62cea225de@oracle.com>
         <1518244651.10229.66.camel@gmx.de>
         <dd972024-b3d6-fa53-7cc5-9e71a01c1837@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:99bQBNjiirf1hp639aRBgtG7az0sNbnadswG3Zp5/Iy3j4yD5zj
 ocT/NSLU+Cc1CWr+xnP4mJPwfitrz0KWrCQo+H2mVG9YPyKpJ0Qkq1ymV2gZFmLrlOFd4Oi
 FOlOwTu+4RxEwAe0M+c6+/2xSopyBIHdej+bvXZRaeMzF/QbbMaE3ulqzBywJF/ealSrb19
 +EQbdzhQTv2m62OwboNsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U5RYpBZJSdk=:l8B71vhd5tVqbW1LEdo0hK
 etp2PoFBbudh4BTMVaUjEeWWIs1uWDF5kNsPvlGp/ePhZ5YwHb2h+aCrc0/BBEIcK72ywRkp9
 fRHLip1PCrDvKoWdEqUbaD+O5f/A8Ep4Chzrye2Kjb7SX7hfFx9jMxbSckwJJK0f8EsOdssBz
 Fao78GBTr3XmHFhGy5ldnkDcjsVWwHBvaDFZINmd1i/ol+pEDD3zCNGiqEmeEH5cbbaCVoHcy
 ceY3VEeh5ADyH2mFGDGSjkA+crsmT8Eb9pxCQYQX3AW0bUElip2CCi54T+C7Pr0QKw4w/arXa
 G5OVHi85vJ4xtbfjbzWXLn7uG1jbvxOSvMuIjoC9otok5NRdTdv3+IRS0ZnrJ4YbWaeeSvMH/
 d4s9aZuLysJmhTLwoF1P/CoW2M+QwWYVD1QYwzX4cuFFw8rocB5uMnl7OKlAIqKCXrhDMnXOG
 pbzuMlnAfBN+d5Du+p95V+fFHaaEugh7H85aiLXhLc54SBpowkGItWDAvhQ0cEgcjJQS/4cSA
 nXKXrQTHg9T/SAP6/GmG8Sn7ciPJeuzyKhTYUmgSgI2xeWg4+A42lSBhpczYRpa0IRTimOUSw
 wr4dgm8P6C3SC49g1+z4//xzuuco1XIG5jGTpoedNQHmiO/ChhH2i1JVaOT9DNGQz/mUuYbmA
 ASzV2kdrq+D3jI9wG41/yMo08GILzPxotV27xN5pvcSN6AS++AkqX5KHbmCe6iyCvnuQcS0js
 Fvv3AFdr8qsXGxuU3sOFSco0rryZVStMSDgt8SLeMHC92+W24AQVaWdfnflEzF5A8nYPdkJgu
 KGt7GGh/pBXXPfO7DdAtAy3/Dl2SbA0Jqc9vjaKzDiyBKCzFkE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-15 at 11:35 -0500, Steven Sistare wrote:
> On 2/10/2018 1:37 AM, Mike Galbraith wrote:
> > On Fri, 2018-02-09 at 11:08 -0500, Steven Sistare wrote:
> >>>> @@ -8804,7 +8803,8 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
> >>>>  		if (!(sd->flags & SD_LOAD_BALANCE))
> >>>>  			continue;
> >>>>  
> >>>> -		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
> >>>> +		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost +
> >>>> +		    sd->sched_migration_cost) {
> >>>>  			update_next_balance(sd, &next_balance);
> >>>>  			break;
> >>>>  		}
> >>>
> >>> Ditto.
> >>
> >> The old code did not migrate if the expected costs exceeded the expected idle
> >> time.  The new code just adds the sd-specific penalty (essentially loss of cache 
> >> footprint) to the costs.  The for_each_domain loop visit smallest to largest
> >> sd's, hence visiting smallest to largest migration costs (though the tunables do 
> >> not enforce an ordering), and bails at the first sd where the total cost is a lose.
> > 
> > Hrm..
> > 
> > You're now adding a hypothetical cost to the measured cost of running
> > the LB machinery, which implies that the measurement is insufficient,
> > but you still don't say why it is insufficient.  What happens if you
> > don't do that?  I ask, because when I removed the...
> > 
> >    this_rq->avg_idle < sysctl_sched_migration_cost
> > 
> > ...bits to check removal effect for Peter, the original reason for it
> > being added did not re-materialize, making me wonder why you need to
> > make this cutoff more aggressive.
> 
> The current code with sysctl_sched_migration_cost discourages migration
> too much, per our test results.

That's why I asked you what happens if you only whack the _apparently_
(but maybe not) obsolete old throttle, it appeared likely that your win
came from allowing a bit more migration than the simple throttle
allowed, which if true, would obviate the need for anything more.

> Can you provide more details on the sysbench oltp test that motivated you
> to add sysctl_sched_migration_cost to idle_balance, so Rohit can re-test it?

The problem at that time was the cycle overhead of entering that LB
path at high frequency.  Dirt simple.

	-Mike
