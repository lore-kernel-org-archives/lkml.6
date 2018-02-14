Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754572AbeBNHv2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 02:51:28 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37983 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754536AbeBNHv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 02:51:26 -0500
X-Google-Smtp-Source: AH8x224DSpd3NG33uDTdFER9U9jX1/Mdkb3k0GgGQx+HPCmZbo2UOiYPFZ+wLb7aLP9M6b5rvkJ2eg==
Date: Wed, 14 Feb 2018 08:51:22 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: rostedt@goodmis.org, daniel@iogearbox.net, songliubraving@fb.com,
        yhs@fb.com, ast@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, davem@davemloft.net, jbacik@fb.com
Subject: Re: [tip:perf/core] perf/headers: Sync new perf_event.h with the
 tools/include/uapi version
Message-ID: <20180214075122.yr3pxtoegwgehshu@gmail.com>
References: <20171206224518.3598254-5-songliubraving@fb.com>
 <tip-0d8dd67be013727ae57645ecd3ea2c36365d7da8@git.kernel.org>
 <20180213223827.wq4y6xemor6xj4gp@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213223827.wq4y6xemor6xj4gp@ast-mbp.dhcp.thefacebook.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Tue, Feb 06, 2018 at 03:52:59AM -0800, tip-bot for Song Liu wrote:
> > Commit-ID:  0d8dd67be013727ae57645ecd3ea2c36365d7da8
> > Gitweb:     https://git.kernel.org/tip/0d8dd67be013727ae57645ecd3ea2c36365d7da8
> > Author:     Song Liu <songliubraving@fb.com>
> > AuthorDate: Wed, 6 Dec 2017 14:45:14 -0800
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Tue, 6 Feb 2018 10:18:05 +0100
> 
> any chance these patches can still make into this release considering
> they were ready back in December ?

The actual kernel side patches were only applied a week ago:

 33ea4b24277b: perf/core: Implement the 'perf_uprobe' PMU

 include/linux/trace_events.h    |  4 ++++
 kernel/events/core.c            | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_event_perf.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h      |  4 ++++
 kernel/trace/trace_uprobe.c     | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 5 files changed, 186 insertions(+), 9 deletions(-)

 e12f03d7031a: perf/core: Implement the 'perf_kprobe' PMU

 include/linux/trace_events.h    |   4 ++++
 kernel/events/core.c            | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
 kernel/trace/trace_event_perf.c |  49 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_kprobe.c     |  91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 kernel/trace/trace_probe.h      |   7 +++++++
 5 files changed, 250 insertions(+), 43 deletions(-)

 Commit:     Ingo Molnar <mingo@kernel.org>
 CommitDate: Tue Feb 6 11:29:28 2018 +0100

They are also large and complex, so I can only send this to Linus in the v4.17 
merge window.

> We have few followups for them and if we don't get them via Linus's tree
> into net-next/bpf-next we cannot really proceed further.
> The other option would be to cherry-pick them into bpf-next/net-next,
> but also a bit scary due to potential conflicts?

No cherry-picking of such large patches please.

But I suppose you could git-pull tip:perf/core into the BPF tree, it only has 
these changes:

  33ea4b24277b: perf/core: Implement the 'perf_uprobe' PMU
  e12f03d7031a: perf/core: Implement the 'perf_kprobe' PMU
  0d8dd67be013: perf/headers: Sync new perf_event.h with the tools/include/uapi version
  65074d43fc77: perf/core: Prepare perf_event.h for new types: 'perf_kprobe' and 'perf_uprobe'

... on top of an upstream commit (59410f5ac70a).

The risks are:

 - In the v4.17 merge window the BPF tree should only be sent to Linus once he has 
   pulled the perf tree - i.e. there's a dependency.

 - If any of these commits needs serious fixes or a revert then that would have to 
   be pulled into the BPF tree too later on. (I don't expect there to be many
   problems though, no regression was reported so far.)

Thanks,

	Ingo
