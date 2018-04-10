Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeDJHtY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:49:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:40258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752052AbeDJHtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:49:23 -0400
Date: Tue, 10 Apr 2018 09:49:21 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ringbuffer: Don't choose the process with adj equal
 OOM_SCORE_ADJ_MIN
Message-ID: <20180410074921.GU21835@dhcp22.suse.cz>
References: <CAGWkznHVGTpvfQOvaOGP6fYDWh0Os0pYXTC3gG_qvW6mCDuybQ@mail.gmail.com>
 <20180408084717.62ee4f9e@gandalf.local.home>
 <CAGWkznEQbaw7HMvE1pbVDMriOL8yW74Ka5UEci4YFRdLnVbFzA@mail.gmail.com>
 <20180409094944.6399b211@gandalf.local.home>
 <CAGWkznEhy7Fard=6E3X_qUezXd33RdKV9CVeONWL=6EQ1bokEw@mail.gmail.com>
 <CAGWkznEuGCZq600XjCtp3hzgN2LrCgwSAfoLwQR7jTw5p=qHoQ@mail.gmail.com>
 <20180409231230.1ab99e85@vmware.local.home>
 <CAGWkznG8-zmfE5iqPUVP+sztasa1zLPWE28qBiZ_tq524JznPw@mail.gmail.com>
 <20180410061447.GQ21835@dhcp22.suse.cz>
 <CAGWkznGrugH0VqJyd5ZPiSBMOZ4SbbNpKiHVXM27Q-ep4SYb-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznGrugH0VqJyd5ZPiSBMOZ4SbbNpKiHVXM27Q-ep4SYb-Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-04-18 14:39:35, Zhaoyang Huang wrote:
> On Tue, Apr 10, 2018 at 2:14 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Tue 10-04-18 11:41:44, Zhaoyang Huang wrote:
> >> On Tue, Apr 10, 2018 at 11:12 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> >> > On Tue, 10 Apr 2018 10:32:36 +0800
> >> > Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> >> >
> >> >> For bellowing scenario, process A have no intension to exhaust the
> >> >> memory, but will be likely to be selected by OOM for we set
> >> >> OOM_CORE_ADJ_MIN for it.
> >> >> process A(-1000)                                          process B
> >> >>
> >> >>   i = si_mem_available();
> >> >>        if (i < nr_pages)
> >> >>            return -ENOMEM;
> >> >>                                                    schedule
> >> >>                                                 --------------->
> >> >> allocate huge memory
> >> >>                                                 <-------------
> >> >> if (user_thread)
> >> >>   set_current_oom_origin();
> >> >>
> >> >>   for (i = 0; i < nr_pages; i++) {
> >> >>          bpage = kzalloc_node
> >> >
> >> > Is this really an issue though?
> >> >
> >> > Seriously, do you think you will ever hit this?
> >> >
> >> > How often do you increase the size of the ftrace ring buffer? For this
> >> > to be an issue, the system has to trigger an OOM at the exact moment
> >> > you decide to increase the size of the ring buffer. That would be an
> >> > impressive attack, with little to gain.
> >> >
> >> > Ask the memory management people. If they think this could be a
> >> > problem, then I'll be happy to take your patch.
> >> >
> >> > -- Steve
> >> add Michael for review.
> >> Hi Michael,
> >> I would like suggest Steve NOT to set OOM_CORE_ADJ_MIN for the process
> >> with adj = -1000 when setting the user space process as potential
> >> victim of OOM.
> >
> > OOM_SCORE_ADJ_MIN means "hide the process from the OOM killer completely".
> > So what exactly do you want to achieve here? Because from the above it
> > sounds like opposite things. /me confused...
> >
> Steve's patch intend to have the process be OOM's victim when it
> over-allocating pages for ring buffer. I amend a patch over to protect
> process with OOM_SCORE_ADJ_MIN from doing so. Because it will make
> such process to be selected by current OOM's way of
> selecting.(consider OOM_FLAG_ORIGIN first before the adj)

I just wouldn't really care unless there is an existing and reasonable
usecase for an application which updates the ring buffer size _and_ it
is OOM disabled at the same time.
-- 
Michal Hocko
SUSE Labs
