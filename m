Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751003AbeBJGiF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 01:38:05 -0500
Received: from mout.gmx.net ([212.227.15.15]:44003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750775AbeBJGiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 01:38:03 -0500
Message-ID: <1518244651.10229.66.camel@gmx.de>
Subject: Re: [RFC 1/2] sched: reduce migration cost between faster caches
 for idle_balance
From: Mike Galbraith <efault@gmx.de>
To: Steven Sistare <steven.sistare@oracle.com>,
        Rohit Jain <rohit.k.jain@oracle.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, joelaf@google.com,
        jbacik@fb.com, riel@redhat.com, juri.lelli@redhat.com,
        dhaval.giani@oracle.com
Date: Sat, 10 Feb 2018 07:37:31 +0100
In-Reply-To: <e773350b-dd8c-ab1a-5dae-8f62cea225de@oracle.com>
References: <1518128395-14606-1-git-send-email-rohit.k.jain@oracle.com>
         <1518128395-14606-2-git-send-email-rohit.k.jain@oracle.com>
         <1518147735.24350.26.camel@gmx.de>
         <e773350b-dd8c-ab1a-5dae-8f62cea225de@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:VYkmj2eNqJx78FQ9J22NOOHMjIbJiQxvbrsar2oOiwy1b5k6uuV
 2zgfv1L09e+P6nyToslRIjfKXG13wlExFNLfLSLipCxHKErWMVvQi/5KCYW4Q4flH5fGae1
 xuyEdwbAy6+UtUBnaMukxEQw/klLMouDtfYrgFcxAj1V1MBj6OaKU92EiLTglwUcGhSup3N
 VlgHUeeU6IZP76wn+y1Yg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e5rPzkXXsIU=:8BIEYmNRA1ccq2ly4RXf29
 rZNIgyMbVTnOgw2Ts2wAYzAeGzp1RXt31Z/CqujDLbUrbecAdp5RfYHv07NGTJd8MKRiKQhDR
 5p3ThoChTZwTb3EF4xPiWz3S8ZObosD1tqlzgoqVpk6Ij8gL+yET5z3OFk5EZzlt5pMMT3XdP
 gjY1tBXiqjbsauA5+ROOFgXLA5k2WNRCJjL2QQUlQR67//QiVBfW5HE4csPJ03mWgZRD8Pt18
 xCoOMX07jI6WpsvzzTABJz+RO+wDC8OFHFkv0aiw0e4nrl5ynIIZuF9hbXvxJ6pJB4gO9eO+c
 KgQtr3UhbV8nEInlq/w/NqmNXQPdE8WG5JgCujSEr84pnCDB+3A+lzbnErFbeFpJhkWnSQq6x
 tqy9C3QEZgbyYpzesthouo5DXr1Tm8bKirejuaC6FjcHLi8ky1UVJDBsWZUFjBPNJJKbRzVAI
 RQP/pcDIEPtM7GZKdm0C1TPa1iBel+VBWnySZplOW9JrCAH9gF69nkJZZngqis3hbJmA5efLS
 8jejRTuUsvO90qZljuou9toYyEHrZtbKEb4iJmNgeJxPMuh5HNzc6CW6RXqHgbYEz9Z0R0eJ7
 ruR+efxuAN6mvx1ajjy1FihWjkwAEU1Sz9I/i0QdkL1YP1NmFK1oxmBYnDERZSJ+XREdhJJs4
 uTHOrYs1t0PgfggjYAvTGvZer4XQkMcNOwIk/im34jGfORCCBPF6j3oMRLknoJnVsebwEBOgY
 xMkv6Vwn5gPZBNJoVNN+OTPlxq6Y1LrPvR44t82VwJ+LHl3AMQ46Fwy8n7hwhKKxjIE8C3/bK
 rOBrCFGOphjZ1r0HYHtmctqDOkhhbh9QwPxu7FBBm0DkZSgnWU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-09 at 11:08 -0500, Steven Sistare wrote:
> >> @@ -8804,7 +8803,8 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
> >>  		if (!(sd->flags & SD_LOAD_BALANCE))
> >>  			continue;
> >>  
> >> -		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
> >> +		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost +
> >> +		    sd->sched_migration_cost) {
> >>  			update_next_balance(sd, &next_balance);
> >>  			break;
> >>  		}
> > 
> > Ditto.
> 
> The old code did not migrate if the expected costs exceeded the expected idle
> time.  The new code just adds the sd-specific penalty (essentially loss of cache 
> footprint) to the costs.  The for_each_domain loop visit smallest to largest
> sd's, hence visiting smallest to largest migration costs (though the tunables do 
> not enforce an ordering), and bails at the first sd where the total cost is a lose.

Hrm..

You're now adding a hypothetical cost to the measured cost of running
the LB machinery, which implies that the measurement is insufficient,
but you still don't say why it is insufficient.  What happens if you
don't do that?  I ask, because when I removed the...

   this_rq->avg_idle < sysctl_sched_migration_cost

...bits to check removal effect for Peter, the original reason for it
being added did not re-materialize, making me wonder why you need to
make this cutoff more aggressive.

	-Mike
