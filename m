Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeBENzU convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 08:55:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:59574 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752980AbeBENzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 08:55:13 -0500
Message-ID: <1517838889.6939.16.camel@gmx.de>
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>,
        Steven Sistare <steven.sistare@oracle.com>
Cc: subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        dhaval.giani@oracle.com
Date: Mon, 05 Feb 2018 14:54:49 +0100
In-Reply-To: <20180205124854.GX2269@hirez.programming.kicks-ass.net>
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
         <20180201123335.GV2249@hirez.programming.kicks-ass.net>
         <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
         <20180202195943.GR2269@hirez.programming.kicks-ass.net>
         <25d67bd2-cbe7-2c2a-e89a-13a7ca5adc10@oracle.com>
         <20180205124854.GX2269@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:QH7MUatEa7EuIps694DwZiy3a570eH18EHRP9fhLBrZ+EvIvy87
 DUGj+XoNdCyNegDD9WoKZev8F+tKBMnU3C3/lDaX+W2n7v8s5bUNVM0B3wuwSFoJRH9hOAV
 IJTApFVI1JkmCJGOn1p3GzMG1j0T+1QKQQ9rd3cxEZzNh81zdhjdb+4Bja/xInz+ZK9RunA
 BQV4QqwM9EnXoA9ZR06Jw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2PGz5mBiB/0=:fGY79HNuEx6f+HMIiXIes5
 0QmJpOpYJre8qkVCf2UKZNvx1iWUwrBXeo4kvY6zN4dn6QAuPLnf+31q3AwPIrmPEVIe5jKjP
 a5icQDFVBLlj8pz54pCbE+Z0Kf6Ew7Ykcw2rz2q4gCg5UI667EY4G7Le51zU253wG8Izc75NE
 NzcdGH6GeOic8u1RMhHdiHYgzlKhl9APUCq/JEK0WDaXAfYWwXX/8wOvAE7btkzVd53DhP1/i
 XZGL2zkA/TuMlSy7c9bsUmdK4jm0JonKBJvrtmGus/icA++nHj0vZ6v+VyIYH27QyHrq5hSpM
 9hj23YmqwBbY0Fuet6Yqe4IOUnQeEKGpGIc/jvZw678ocMAQfdI0ExkHlMGyuJMQw0Iey8V/z
 UjuQVJHG4RvTxNXFugUyF3xr8To3zJHjsb3HTFAIYcbgdwWvBz594TuNFHMmLKe50KJa9NiXU
 XqsrUiZaZdjBl2rwDOQ+ISPf0dHQXOH3f2mJqgxdYbk8TieIxnqqgeuwwFS6Zr9XG0DwRDYSP
 CtcEbbuLCGM/12wrdEgUG5bRDnF9s0xlmCstc5M64PybGs/cuparnQUj0Dl0N7oDKFUGusr38
 IibQxU9a9c+iY6HPAD2jKp9i9yV9cOCRyngddD7KnmIttgHhWIQwois4bv9TZ1h+mxsmsZ/OH
 efe2KMblVQKj94h/cmQEZJ8bzlkZ/zMcjL1y3wXutuYwZ9egus6lbGTEzZi0/8XophvFEY5Zv
 DPQX8vjePVBU/wySYJ7A8Sq3PUpEI6os06Dlz8DVmV1fdjt5YlFoGjvrOSYwLyMNI/KYViAb8
 nE4ZgRXkH2tDLMyW3fSCIwUslpZ1slLh5mZF8ML4AQOLKL9XTk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-05 at 13:48 +0100, Peter Zijlstra wrote:
> On Fri, Feb 02, 2018 at 04:06:32PM -0500, Steven Sistare wrote:
> > On 2/2/2018 2:59 PM, Peter Zijlstra wrote:
> 
> > > But then you get that atomic crud to contend on the cluster level, which
> > > is even worse than it contending on the core level.
> > 
> > True, but it can still be a net win if we make better scheduling decisions.
> > A saving grace is that the atomic counter is only updated if the cpu
> > makes a transition from idle to busy or vice versa.
> 
> Which can still be a very high rate for some workloads. I always forget
> which, but there are plenty workloads that have very frequenct very
> short idle times. Mike, do you remember what comes apart when we take
> out the sysctl_sched_migration_cost test in idle_balance()?

Used to be anything scheduling cross-core heftily suffered, ie pretty
much any localhost communication heavy load.  I just tried disabling it
in 4.13 though (pre pti cliff), tried tbench, and it made zip squat
difference.  I presume that's due to the meanwhile added this_rq->rd-
>overload and/or curr_cost checks.  I don't recall the original cost
details beyond it having been "a sh*tload".

	-Mike
