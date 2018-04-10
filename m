Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeDJCcj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 22:32:39 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35879 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751919AbeDJCci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 22:32:38 -0400
X-Google-Smtp-Source: AIpwx49eu0NgqvISg7MUzt4JEXp1roeslZ7OD+e6/IoWxvfBgf49JmjGulwrCZjOzzyawgTMmqKmn3VqY1OsfI22Dr8=
MIME-Version: 1.0
In-Reply-To: <CAGWkznEhy7Fard=6E3X_qUezXd33RdKV9CVeONWL=6EQ1bokEw@mail.gmail.com>
References: <1523153783-20579-1-git-send-email-zhaoyang.huang@spreadtrum.com>
 <20180407234812.2bf2b24b@gandalf.local.home> <CAGWkznHVGTpvfQOvaOGP6fYDWh0Os0pYXTC3gG_qvW6mCDuybQ@mail.gmail.com>
 <20180408084717.62ee4f9e@gandalf.local.home> <CAGWkznEQbaw7HMvE1pbVDMriOL8yW74Ka5UEci4YFRdLnVbFzA@mail.gmail.com>
 <20180409094944.6399b211@gandalf.local.home> <CAGWkznEhy7Fard=6E3X_qUezXd33RdKV9CVeONWL=6EQ1bokEw@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 10 Apr 2018 10:32:36 +0800
Message-ID: <CAGWkznEuGCZq600XjCtp3hzgN2LrCgwSAfoLwQR7jTw5p=qHoQ@mail.gmail.com>
Subject: Re: [PATCH v1] ringbuffer: Don't choose the process with adj equal OOM_SCORE_ADJ_MIN
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 8:32 AM, Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> On Mon, Apr 9, 2018 at 9:49 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>> On Mon, 9 Apr 2018 08:56:01 +0800
>> Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>>
>>> >>
>>> >>         if (oom_task_origin(task)) {
>>> >>                 points = ULONG_MAX;
>>> >>                 goto select;
>>> >>         }
>>> >>
>>> >>         points = oom_badness(task, NULL, oc->nodemask, oc->totalpages);
>>> >>         if (!points || points < oc->chosen_points)
>>> >>                 goto next;
>>> >
>>> > And what's wrong with that?
>>> >
>>> > -- Steve
>>> I think the original thought of OOM is the flag 'OOM_SCORE_ADJ_MIN' is
>>> most likely to be set by process himself via accessing the proc file,
>>> if it does so, OOM can select it as the victim. except, it is
>>> reluctant to choose the critical process to be killed, so I suggest
>>> not to set such heavy flag as OOM_SCORE_ADJ_MIN on behalf of -1000
>>> process.
>>
>> Really, I don't think tasks that are setting OOM_CORE_ADJ_MIN should be
>> allocating a lot of memory in the kernel (via ring buffer). It sounds
>> like a good way to wreck havoc on the system.
>>
>> It's basically saying, "I'm going to take up all memory, but don't kill
>> me, just kill some random user on the system".
>>
>> -- Steve
> Sure, but the memory status is dynamic, the process could also exceed the limit
> at the moment even it check the available memory before. We have to
> add protection
> for such kind of risk. It could also happen that the critical process
> be preempted by
> another huge memory allocating process, which may cause insufficient memory when
> it schedule back.

For bellowing scenario, process A have no intension to exhaust the
memory, but will be likely to be selected by OOM for we set
OOM_CORE_ADJ_MIN for it.
process A(-1000)                                          process B

  i = si_mem_available();
       if (i < nr_pages)
           return -ENOMEM;
                                                   schedule
                                                --------------->
allocate huge memory
                                                <-------------
if (user_thread)
  set_current_oom_origin();

  for (i = 0; i < nr_pages; i++) {
         bpage = kzalloc_node
