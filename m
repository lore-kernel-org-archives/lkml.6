Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933603AbeDIA4G (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 20:56:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33124 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933245AbeDIA4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 20:56:03 -0400
X-Google-Smtp-Source: AIpwx4/MEwL26+oNRfqUbF/aqfDas+jHKsRNKOzosT6n/WyGQvi4RL24MswGhkd6Im/ScdBp5fKP5sYljbvaNVJiu74=
MIME-Version: 1.0
In-Reply-To: <20180408084717.62ee4f9e@gandalf.local.home>
References: <1523153783-20579-1-git-send-email-zhaoyang.huang@spreadtrum.com>
 <20180407234812.2bf2b24b@gandalf.local.home> <CAGWkznHVGTpvfQOvaOGP6fYDWh0Os0pYXTC3gG_qvW6mCDuybQ@mail.gmail.com>
 <20180408084717.62ee4f9e@gandalf.local.home>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Mon, 9 Apr 2018 08:56:01 +0800
Message-ID: <CAGWkznEQbaw7HMvE1pbVDMriOL8yW74Ka5UEci4YFRdLnVbFzA@mail.gmail.com>
Subject: Re: [PATCH v1] ringbuffer: Don't choose the process with adj equal OOM_SCORE_ADJ_MIN
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 8, 2018 at 8:47 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> [ Removing kernel-patch-test, because of annoying "moderator" messages ]
>
> On Sun, 8 Apr 2018 13:54:59 +0800
> Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
>> On Sun, Apr 8, 2018 at 11:48 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>> > On Sun,  8 Apr 2018 10:16:23 +0800
>> > Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>> >
>> >> Don't choose the process with adj == OOM_SCORE_ADJ_MIN which
>> >> over-allocating pages for ring buffers.
>> >
>> > Why?
>> >
>> > -- Steve
>> because in oom_evaluate_task, the process with adj == OOM_SCORE_ADJ_MIN will
>> be suppressed by oom_badness, but with applying your latest patch,
>> such process will
>> be selected by oom_task_origin
>>
>>         if (oom_task_origin(task)) {
>>                 points = ULONG_MAX;
>>                 goto select;
>>         }
>>
>>         points = oom_badness(task, NULL, oc->nodemask, oc->totalpages);
>>         if (!points || points < oc->chosen_points)
>>                 goto next;
>
> And what's wrong with that?
>
> -- Steve
I think the original thought of OOM is the flag 'OOM_SCORE_ADJ_MIN' is
most likely to be set by process himself via accessing the proc file,
if it does so, OOM can select it as the victim. except, it is
reluctant to choose the critical process to be killed, so I suggest
not to set such heavy flag as OOM_SCORE_ADJ_MIN on behalf of -1000
process.
