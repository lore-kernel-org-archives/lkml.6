Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbeBIRIy convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 12:08:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:44483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751126AbeBIRIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:08:52 -0500
Message-ID: <1518196102.26824.25.camel@gmx.de>
Subject: Re: [RFC 2/2] Introduce sysctl(s) for the migration costs
From: Mike Galbraith <efault@gmx.de>
To: Steven Sistare <steven.sistare@oracle.com>,
        Rohit Jain <rohit.k.jain@oracle.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, joelaf@google.com,
        jbacik@fb.com, riel@redhat.com, juri.lelli@redhat.com,
        dhaval.giani@oracle.com
Date: Fri, 09 Feb 2018 18:08:22 +0100
In-Reply-To: <dcc94ac7-e910-9114-2976-ac61f0ade215@oracle.com>
References: <1518128395-14606-1-git-send-email-rohit.k.jain@oracle.com>
         <1518128395-14606-3-git-send-email-rohit.k.jain@oracle.com>
         <1518148447.24350.34.camel@gmx.de>
         <dcc94ac7-e910-9114-2976-ac61f0ade215@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:PO+k98JepIfaQBTPVTpWfeHSnuvtdJT3Z1N1sj9c0sTcIS2MD0g
 Zwb/ERYydZA1o8HZ+XVgjzgaSyORDroq6O2GRw0bivW2zDzDc5Y/WA2drrRelHfrpM/SOV1
 GD8ieAVDL380dq/aUhlyLGDPqANIF1/XJ1grcTa7wUuFyHRGUOdPxY+MM2S01Jcn2fpu6Dl
 WHcF/Dx8RXrewXEw3U3/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s/XYc6XB9KI=:gYI3XFP/3Wau2XGHcZuL8E
 9BIF98PCw1V7sSyNFgi0BRyO6KPUuFbSYDnD2IqcNRcQ1ZrCbOa2wDlAPcNYcO5Zjl3b4u//N
 Aea/yUVkMosKlqMbxB4egwx9G6lvhlxOF7SS6Cb5zyIqZ1aEZ2jewU3BD0PQat1aVXlPCJESL
 a1R/zGbtXiz/32gPLljw0Xl16+/4FiWnPEYT2EGotxxwUuEC5tRHCm/BE26qxKskGiGzMQHvi
 71+JgeP2tvKKSEzpkEaNKjJZqT1NnL6sKhYKmWGg40HleAW9DVdjEWcrnaD5e+ScQTXzhMp1n
 6onr4DA0mhVblVy85dUzxQEZkhHhO/fQkMbb7VvnCAXqct03lA+MsuahJlygQ1w+PUGEfmlg5
 9EekMkB0Qo/rUSZV8B5FzT0ewpBZRTUcEC44H0I/0QskdR+4NHyBW1/uz90hvC/ioTIk0hdla
 Df6JuN3pToTToeCyb1SBjkwqIIOvmFJK1elPSOWuZBOs4hzhaA5a3TA1Pk2ipzeasBBD99kPx
 N5zpx44EJd6CI8HhIWqXhZXYVoALEz2uBO0mMFgjz89udgYEQSBhGJYHtzM/T84z+nKPOqIjM
 dqKE7ECtojusfCg8CrcLTTGNDSwt3YzkxcnxWROQ2JhVfBiKutfLm2auNdhRuPXe/X8I/HI/W
 v/1nI74MnNIBqNQCUQgCxcYUwq/vpXcuvulxzh9+cZVtpZ19i55/SsaWa0ONOPsJf2tka4pYA
 aRfiNGeLThXWPsE+/dThig/S4HKyjobRoGGHG6TM8ngnfMhz5szG9rWYG/addSUM4yEk3AVHS
 i+pyjlQEwvKF11alPwzh/En8ZUGoELqQg/OVE8xWVBa4nLbXD0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-09 at 11:10 -0500, Steven Sistare wrote:
> On 2/8/2018 10:54 PM, Mike Galbraith wrote:
> > On Thu, 2018-02-08 at 14:19 -0800, Rohit Jain wrote:
> >> This patch introduces the sysctl for sched_domain based migration costs.
> >> These in turn can be used for performance tuning of workloads.
> > 
> > With this patch, we trade 1 completely bogus constant (cost is really
> > highly variable) for 3, twiddling of which has zero effect unless you
> > trigger a domain rebuild afterward, which is neither mentioned in the
> > changelog, nor documented.
> > 
> > bogo-numbers++ is kinda hard to love.
> 
> Yup, the domain rebuild is missing.
> 
> I am no fan of tunables, the fewer the better, but one of the several flaws
> of the single figure for migration cost is that it ignores the very large
> difference in cost when migrating between near vs far levels of the cache hierarchy.
> Migration between CPUs of the same core should be free, as they share L1 cache.
> Rohit defined a tunable for it, but IMO it could be hard coded to 0.

That cost is never really 0 in the context of load balancing, as the
load balancing machinery is non-free.  When the idle_balance() throttle
was added, that was done to mitigate the (at that time) quite high cost
to high frequency cross core scheduling ala localhost communication.

>  Migration 
> between CPUs in different sockets is the most expensive and is represented by
> the existing sysctl_sched_migration_cost tunable.  Migration between CPUs in
> the same core cluster, or in the same socket, is somewhere in between, as
> they share L2 or L3 cache.  We could avoid a separate tunable by setting it to
> sysctl_sched_migration_cost / 10.

Shrug.  It's bogus no mater what we do.  Once Upon A Time, a cost
number was generated via measurement, but the end result was just as
bogus as a number pulled out of the ether.  How much bandwidth you have
when blasting data to/from wherever says nothing about misses you avoid
vs those you generate.

	-Mike
