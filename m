Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeDJDlq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 23:41:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52605 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbeDJDlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 23:41:45 -0400
X-Google-Smtp-Source: AIpwx48gDT8AaC75aKS9yQuO1igoLrApJWV/c14LFJ7BtlXc6Ht4ntAGH85CTDdOcelIf9XdUfo5qyFPSAGnRpVSVEw=
MIME-Version: 1.0
In-Reply-To: <20180409231230.1ab99e85@vmware.local.home>
References: <1523153783-20579-1-git-send-email-zhaoyang.huang@spreadtrum.com>
 <20180407234812.2bf2b24b@gandalf.local.home> <CAGWkznHVGTpvfQOvaOGP6fYDWh0Os0pYXTC3gG_qvW6mCDuybQ@mail.gmail.com>
 <20180408084717.62ee4f9e@gandalf.local.home> <CAGWkznEQbaw7HMvE1pbVDMriOL8yW74Ka5UEci4YFRdLnVbFzA@mail.gmail.com>
 <20180409094944.6399b211@gandalf.local.home> <CAGWkznEhy7Fard=6E3X_qUezXd33RdKV9CVeONWL=6EQ1bokEw@mail.gmail.com>
 <CAGWkznEuGCZq600XjCtp3hzgN2LrCgwSAfoLwQR7jTw5p=qHoQ@mail.gmail.com> <20180409231230.1ab99e85@vmware.local.home>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 10 Apr 2018 11:41:44 +0800
Message-ID: <CAGWkznG8-zmfE5iqPUVP+sztasa1zLPWE28qBiZ_tq524JznPw@mail.gmail.com>
Subject: Re: [PATCH v1] ringbuffer: Don't choose the process with adj equal OOM_SCORE_ADJ_MIN
To: Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 11:12 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 10 Apr 2018 10:32:36 +0800
> Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
>> For bellowing scenario, process A have no intension to exhaust the
>> memory, but will be likely to be selected by OOM for we set
>> OOM_CORE_ADJ_MIN for it.
>> process A(-1000)                                          process B
>>
>>   i = si_mem_available();
>>        if (i < nr_pages)
>>            return -ENOMEM;
>>                                                    schedule
>>                                                 --------------->
>> allocate huge memory
>>                                                 <-------------
>> if (user_thread)
>>   set_current_oom_origin();
>>
>>   for (i = 0; i < nr_pages; i++) {
>>          bpage = kzalloc_node
>
> Is this really an issue though?
>
> Seriously, do you think you will ever hit this?
>
> How often do you increase the size of the ftrace ring buffer? For this
> to be an issue, the system has to trigger an OOM at the exact moment
> you decide to increase the size of the ring buffer. That would be an
> impressive attack, with little to gain.
>
> Ask the memory management people. If they think this could be a
> problem, then I'll be happy to take your patch.
>
> -- Steve
add Michael for review.
Hi Michael,
I would like suggest Steve NOT to set OOM_CORE_ADJ_MIN for the process
with adj = -1000 when setting the user space process as potential
victim of OOM. Steve doubts about the possibility of the scenario. In
my opinion, we should NOT break the original concept of the OOM, that
is, OOM would not select -1000 process unless it config it itself.
With regard to the possibility, in memory thirsty system such as
android on mobile phones, there are different kinds of user behavior
or test script to attack or ensure the stability of the system. So I
suggest we'd better keep every corner case safe. Would you please give
a comment on that? thanks
