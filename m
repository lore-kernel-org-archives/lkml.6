Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeDJKtF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:49:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:58656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751942AbeDJKtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:49:04 -0400
Date: Tue, 10 Apr 2018 12:49:02 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ringbuffer: Don't choose the process with adj equal
 OOM_SCORE_ADJ_MIN
Message-ID: <20180410104902.GC21835@dhcp22.suse.cz>
References: <20180409231230.1ab99e85@vmware.local.home>
 <CAGWkznG8-zmfE5iqPUVP+sztasa1zLPWE28qBiZ_tq524JznPw@mail.gmail.com>
 <20180410061447.GQ21835@dhcp22.suse.cz>
 <CAGWkznGrugH0VqJyd5ZPiSBMOZ4SbbNpKiHVXM27Q-ep4SYb-Q@mail.gmail.com>
 <20180410074921.GU21835@dhcp22.suse.cz>
 <CAGWkznHQSZ5jPF2njOp0BritTmKiGOToq5bAz1bhzzmFi_01nA@mail.gmail.com>
 <20180410081231.GV21835@dhcp22.suse.cz>
 <CAGWkznEM=AX=3LWDmgyz4GRkWy81TNdFQQXZ7+W4=Ek4ZsnsJw@mail.gmail.com>
 <20180410090128.GY21835@dhcp22.suse.cz>
 <CAGWkznEf0siz1-RFSJwuKCjUtbKM=P1djo2Nc7sU1GS0AgWv2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznEf0siz1-RFSJwuKCjUtbKM=P1djo2Nc7sU1GS0AgWv2w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-04-18 17:32:44, Zhaoyang Huang wrote:
> On Tue, Apr 10, 2018 at 5:01 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Tue 10-04-18 16:38:32, Zhaoyang Huang wrote:
> >> On Tue, Apr 10, 2018 at 4:12 PM, Michal Hocko <mhocko@kernel.org> wrote:
> >> > On Tue 10-04-18 16:04:40, Zhaoyang Huang wrote:
> >> >> On Tue, Apr 10, 2018 at 3:49 PM, Michal Hocko <mhocko@kernel.org> wrote:
> >> >> > On Tue 10-04-18 14:39:35, Zhaoyang Huang wrote:
> >> >> >> On Tue, Apr 10, 2018 at 2:14 PM, Michal Hocko <mhocko@kernel.org> wrote:
> >> > [...]
> >> >> >> > OOM_SCORE_ADJ_MIN means "hide the process from the OOM killer completely".
> >> >> >> > So what exactly do you want to achieve here? Because from the above it
> >> >> >> > sounds like opposite things. /me confused...
> >> >> >> >
> >> >> >> Steve's patch intend to have the process be OOM's victim when it
> >> >> >> over-allocating pages for ring buffer. I amend a patch over to protect
> >> >> >> process with OOM_SCORE_ADJ_MIN from doing so. Because it will make
> >> >> >> such process to be selected by current OOM's way of
> >> >> >> selecting.(consider OOM_FLAG_ORIGIN first before the adj)
> >> >> >
> >> >> > I just wouldn't really care unless there is an existing and reasonable
> >> >> > usecase for an application which updates the ring buffer size _and_ it
> >> >> > is OOM disabled at the same time.
> >> >> There is indeed such kind of test case on my android system, which is
> >> >> known as CTS and Monkey etc.
> >> >
> >> > Does the test simulate a real workload? I mean we have two things here
> >> >
> >> > oom disabled task and an updater of the ftrace ring buffer to a
> >> > potentially large size. The second can be completely isolated to a
> >> > different context, no? So why do they run in the single user process
> >> > context?
> >> ok. I think there are some misunderstandings here. Let me try to
> >> explain more by my poor English. There is just one thing here. The
> >> updater is originally a oom disabled task with adj=OOM_SCORE_ADJ_MIN.
> >> With Steven's patch, it will periodically become a oom killable task
> >> by calling set_current_oom_origin() for user process which is
> >> enlarging the ring buffer. What I am doing here is limit the user
> >> process to the ones that adj > -1000.
> >
> > I've understood that part. And I am arguing whether this is really such
> > an important case to play further tricks. Wouldn't it be much simpler to
> > put the updater out to a separate process? OOM disabled processes
> > shouldn't really do unexpectedly large allocations. Full stop. Otherwise
> > you risk a large system disruptions.
> > --
> It is a real problem(my android system just hung there while running
> the test case for the innocent key process killed by OOM), however,
> the problem is we can not define the userspace's behavior as you
> suggested. What Steven's patch doing here is to keep the system to be
> stable by having the updater to take the responsbility itself. My
> patch is to let the OOM disabled processes remain the unkillable
> status.

But you do realize that what you are proposing is by no means any safer,
don't you? The memory allocated for the ring buffer is _not_ accounted
to any process and as such it is not considered by the oom killer when
picking up an oom victim so you are quite likely to pick up an innocent
process to be killed. So basically you are risking an allocation runaway
completely hidden from the OOM killer. Now, the downside of the patch is
that the OOM_SCORE_ADJ_MIN task might get killed which is something that
shouldn't happen because it is a contract. I would call this an
unsolvable problem and a inherent broken design of the oom disabled
task. So far I haven't heard a single _argument_ why supporting such a
weird cornercase is desirable when your application can trivial do

fork(); set_oom_score_adj(); exec("echo $VAR > $RINGBUFFER_FILE")
-- 
Michal Hocko
SUSE Labs
