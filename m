Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeEBOfs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:35:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:56939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750936AbeEBOfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:35:44 -0400
Message-ID: <1525271702.4975.3.camel@gmx.de>
Subject: Re: [PATCH v7 2/5] cpuset: Add cpuset.sched_load_balance to v2
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>, Juri Lelli <juri.lelli@redhat.com>
Date: Wed, 02 May 2018 16:35:02 +0200
In-Reply-To: <20180502140226.GU12217@hirez.programming.kicks-ass.net>
References: <1524145624-23655-1-git-send-email-longman@redhat.com>
         <1524145624-23655-3-git-send-email-longman@redhat.com>
         <20180502102416.GJ12180@hirez.programming.kicks-ass.net>
         <14d7604c-1254-1146-e2b6-23f4cc020b34@redhat.com>
         <20180502134225.GR12217@hirez.programming.kicks-ass.net>
         <94c80e1c-049d-6ec3-8e8c-40eb88d1341d@redhat.com>
         <20180502140226.GU12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zEAieqQMBsuU9mkUlzU7cM4ZhLBj9AKeFJ4tDfwPOf+yuOehqN2
 jM47W3pvYdw1vatfNrsSLBj7tgIknHDA/H3iC389u/qTl9qpsmJJaPFAb9t1VeyWyvNnXbK
 BEBkhppNzW1SCQ7CdpOiTWQAhGtoXXu4ybM8IWXGrgNxvtMBTVaYJYqzVcOymqBMtg4M2DU
 W17PKy50U+hTkj1LDTwWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/HeTV7Ohtmc=:D2DYh1zeJwuqDrCuQN0G/U
 3sATyrc/rriSpfI0QVU1cHKdd4xztKjclC4ltAl2InMbs8tgAy+cpYaoxej6xBqfrcFSBIQou
 NVRRYvU6mp8jahASSfQ8EwdAgbEvH+AZ2T3ctM2aFUJxflTnbuvX8au3YlZaC/eiJYHJpa1SW
 Ps7qy3D7FB3vSuSIvq+2p5lHqJWDCVjBiHsPXAlcEn9/KJoDmHGDzfchfGdK7Zc6sp5eck9fr
 BSNySXIgJhwmazOTGh3n8UTi/EtDdKArXsYL8gJz2P8GpcU/ys675QtAZY6Tk+QtSjULrXXAX
 IT9E8ZhybvAXuuaksbUqPFAeyuRTQ9t1LvqqdN7jSNroBv2KzLLqQuFqUok4l1ykU4IpdRiup
 Vwc0L71FDlnFAOXOThHUjKTfZAx9uPPGTxMbesGqCn13m0Er6J5cTJ25cVZXKxlEwfe/LSu9+
 8fUQrxytoZC6dcS6mWvFxWx4gEnsVDg2rvUJrlURu2hK2ZlgpW4Cbzzu9U3o751DLheHX6ycS
 z4hGTukN9+PWi5QafbuBWspfKhqtF2uhZosrFimPBaMs4IsiuFmwjcaQ0P4Rf133KYfTxVpWy
 ihfoJL3iO0FyQeUtJZXCXfL9NCcgEyztgT8ddlLn7RlKpkSMAJrM+yAOirIAcH/+PkO/5TMBC
 6CdLUaHsHZLPwadDNfSUW2jF8ox30pjLzaRjn9fa2q3u7Vhf32xSb4t4vxg5/LMeGSj1X5IAb
 /hNozgMzYxUouI3/H6gy1QT96Tv7WFOfMYAWwTtqvubxelEdrQxqjPk6sejB7miWq+Z3aJDoo
 kKZpbx/
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-02 at 16:02 +0200, Peter Zijlstra wrote:
> On Wed, May 02, 2018 at 09:47:00AM -0400, Waiman Long wrote:
> 
> > > I've read half of the next patch that adds the isolation thing. And
> > > while that kludges around the whole root cgorup is magic thing, it
> > > doesn't help if you move the above scenario on level down:
> > >
> > >
> > > 	R
> > >      /    \
> > >    A        B
> > >           /   \
> > >         C       D
> > >
> > >
> > > R: cpus=0-7, load_balance=0
> > > A: cpus=0-1, load_balance=1
> > > B: cpus=2-7, load_balance=0
> > > C: cpus=2-3, load_balance=1
> > > D: cpus=4-7, load_balance=1
> > >
> > >
> > > Also, I feel we should strive to have a minimal amount of tasks that
> > > cannot be moved out of the root group; the current set is far too large.
> > 
> > What exactly is the use case you have in mind with loading balancing
> > disabled in B, but enabled in C and D? We would like to support some
> > sensible use cases, but not every possible combinations.
> 
> Suppose A is your system group, and C and D are individual RT workloads
> or something.

Yeah, it does have a distinct "640K ought to be enough for anybody"
flavor to it.

	-Mike
