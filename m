Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932506AbeBVNCJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:02:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932199AbeBVNCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:02:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C3E20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 22 Feb 2018 10:02:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Weiping Zhang <zwp10758@gmail.com>
Cc: acme@redhat.com, Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf cgroup: simplify arguments if track multiple
 events for a cgroup
Message-ID: <20180222130203.GC7621@kernel.org>
References: <20180129154805.GA6284@localhost.didichuxing.com>
 <20180131092216.GB3313@krava>
 <CAA70yB5TB3mxL1uN-sXvUsf578k+_GWkq1gHgF_HRa_1p770gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA70yB5TB3mxL1uN-sXvUsf578k+_GWkq1gHgF_HRa_1p770gw@mail.gmail.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 22, 2018 at 06:34:08PM +0800, Weiping Zhang escreveu:
> 2018-01-31 17:22 GMT+08:00 Jiri Olsa <jolsa@redhat.com>:
> > On Mon, Jan 29, 2018 at 11:48:09PM +0800, weiping zhang wrote:
> >> if use -G with one cgroup and -e with multiple events, only the first
> >> event has correct cgroup setting, all events from the second will track
> >> system-wide events.
> >>
> >> if user want track multiple events for a specific cgroup, user must give
> >> parameters like follow:
> >> $ perf stat -e e1 -e e2 -e e3 -G test,test,test
> >> this patch simplify this case, just type one cgroup, like following:
> >> $ perf stat -e e1 -e e2 -e e3 -G test
> >>
> >> $ mkdir -p /sys/fs/cgroup/perf_event/test
> >> $ perf stat -e cycles -e cache-misses  -a -I 1000 -G test
> >>
> >> before:
> >>      1.001007226      <not counted>      cycles                    test
> >>      1.001007226              7,506      cache-misses
> >>
> >> after:
> >>      1.000834097      <not counted>      cycles                    test
> >>      1.000834097      <not counted>      cache-misses              test
> >>
> >> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Hi Arnaldo,

Ok, tested and applied an example for when wanting to monitor for an
specific cgroup and also for system wide:

----
If wanting to monitor, say, 'cycles' for a cgroup and also for system wide, this
command line can be used: 'perf stat -e cycles -G cgroup_name -a -e cycles'.
----

To further clarify what is in the man page already about -G affecting
only the previously defined events in the command line.

Perhaps it would be interesting to automatically detect that the same
event is being read system wide and for an specific cgroup and then,
right after the count for specific cgroups show the percentage?

Thanks,

- Arnaldo

[root@jouet ~]# mkdir -p /sys/fs/cgroup/perf_event/empty_cgroup
[root@jouet ~]# perf stat -e cycles -I 1000 -G empty_cgroup -a -e cycles
#           time             counts unit events
     1.000268091      <not counted>      cycles                    empty_cgroup                                   
     1.000268091         73,159,886      cycles                                                      
     2.000748319      <not counted>      cycles                    empty_cgroup                                   
     2.000748319         70,189,470      cycles                                                      
     3.001196694      <not counted>      cycles                    empty_cgroup                                   
     3.001196694         57,076,551      cycles                                                      
     4.001589957      <not counted>      cycles                    empty_cgroup                                   
     4.001589957        102,118,895      cycles                                                      
     5.002017548      <not counted>      cycles                    empty_cgroup                                   
     5.002017548         66,391,232      cycles                                                      
^C     5.598699824      <not counted>      cycles                    empty_cgroup                                   
     5.598699824        136,313,588      cycles                                                      

[root@jouet ~]# 

- Arnaldo
