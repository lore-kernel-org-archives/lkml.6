Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbeDINtt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750759AbeDINts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:49:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD6A20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 9 Apr 2018 09:49:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ringbuffer: Don't choose the process with adj equal
 OOM_SCORE_ADJ_MIN
Message-ID: <20180409094944.6399b211@gandalf.local.home>
In-Reply-To: <CAGWkznEQbaw7HMvE1pbVDMriOL8yW74Ka5UEci4YFRdLnVbFzA@mail.gmail.com>
References: <1523153783-20579-1-git-send-email-zhaoyang.huang@spreadtrum.com>
        <20180407234812.2bf2b24b@gandalf.local.home>
        <CAGWkznHVGTpvfQOvaOGP6fYDWh0Os0pYXTC3gG_qvW6mCDuybQ@mail.gmail.com>
        <20180408084717.62ee4f9e@gandalf.local.home>
        <CAGWkznEQbaw7HMvE1pbVDMriOL8yW74Ka5UEci4YFRdLnVbFzA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Apr 2018 08:56:01 +0800
Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:

> >>
> >>         if (oom_task_origin(task)) {
> >>                 points = ULONG_MAX;
> >>                 goto select;
> >>         }
> >>
> >>         points = oom_badness(task, NULL, oc->nodemask, oc->totalpages);
> >>         if (!points || points < oc->chosen_points)
> >>                 goto next;  
> >
> > And what's wrong with that?
> >
> > -- Steve  
> I think the original thought of OOM is the flag 'OOM_SCORE_ADJ_MIN' is
> most likely to be set by process himself via accessing the proc file,
> if it does so, OOM can select it as the victim. except, it is
> reluctant to choose the critical process to be killed, so I suggest
> not to set such heavy flag as OOM_SCORE_ADJ_MIN on behalf of -1000
> process.

Really, I don't think tasks that are setting OOM_CORE_ADJ_MIN should be
allocating a lot of memory in the kernel (via ring buffer). It sounds
like a good way to wreck havoc on the system.

It's basically saying, "I'm going to take up all memory, but don't kill
me, just kill some random user on the system".

-- Steve
