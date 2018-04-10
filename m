Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbeDJQp5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:45:57 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:32774 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbeDJQp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 12:45:56 -0400
X-Google-Smtp-Source: AIpwx4+Fv0SogUjy9YYw2mHDIoaSIF7AC6hs0ZuJFg61GwzgQomC4F55JRvMSfc+4BSMV3K2WePHL2mo1pPFqD9Eg9c=
MIME-Version: 1.0
In-Reply-To: <20180410091311.20bd8ccc@gandalf.local.home>
References: <20180410061447.GQ21835@dhcp22.suse.cz> <CAGWkznGrugH0VqJyd5ZPiSBMOZ4SbbNpKiHVXM27Q-ep4SYb-Q@mail.gmail.com>
 <20180410074921.GU21835@dhcp22.suse.cz> <CAGWkznHQSZ5jPF2njOp0BritTmKiGOToq5bAz1bhzzmFi_01nA@mail.gmail.com>
 <20180410081231.GV21835@dhcp22.suse.cz> <CAGWkznEM=AX=3LWDmgyz4GRkWy81TNdFQQXZ7+W4=Ek4ZsnsJw@mail.gmail.com>
 <20180410090128.GY21835@dhcp22.suse.cz> <CAGWkznEf0siz1-RFSJwuKCjUtbKM=P1djo2Nc7sU1GS0AgWv2w@mail.gmail.com>
 <20180410104902.GC21835@dhcp22.suse.cz> <20180410082316.263d34ec@gandalf.local.home>
 <20180410122706.GH21835@dhcp22.suse.cz> <20180410083625.2c904ab2@gandalf.local.home>
 <20180410091311.20bd8ccc@gandalf.local.home>
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 10 Apr 2018 09:45:54 -0700
Message-ID: <CAJWu+oo5iUDjCnbhhJ7x2BGeuL6FDAVqFCa5tcTikVh5OtxfRA@mail.gmail.com>
Subject: Re: [PATCH v1] ringbuffer: Don't choose the process with adj equal OOM_SCORE_ADJ_MIN
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Michal Hocko <mhocko@kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Tue, Apr 10, 2018 at 6:13 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 10 Apr 2018 08:36:25 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> On Tue, 10 Apr 2018 14:27:06 +0200
>> Michal Hocko <mhocko@kernel.org> wrote:
>>
>> > I would rather that the code outside of MM not touch implementation
>> > details like OOM_SCORE_ADJ_MIN. It is really hard to get rid of abusers
>> > whenever you try to change something in MM then. Especially when the
>> > usecase is quite dubious.
>>
>> Fair enough. I was reluctant to use the OOM_SCORE_ADJ_MIN in this case.
>>
>> Perhaps I can create an option that lets users decide how they want to
>> allocate.
>>
>> For people like Joel, it will try hard (by default) and set oom_origin,
>> but the user could also set an option "no_mem_reclaim", where it will
>> not set oom_origin, but will also use NORETRY as well, where it wont
>> trigger OOM and will not be the designated victim of OOM. But it will
>> likely not allocate memory if the system is under heavy use. Then for
>> Zhaoyang's tests, all he has to do is to set that option (or clear it,
>> if the option is "mem_reclaim", which is what I'll probably call it).
>>
>
>
> Something like this:
>
> -- Steve
>
> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index a0233edc0718..807e2bcb21b3 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
> @@ -106,7 +106,8 @@ __poll_t ring_buffer_poll_wait(struct ring_buffer *buffer, int cpu,
>
>  void ring_buffer_free(struct ring_buffer *buffer);
>
> -int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size, int cpu);
> +int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
> +                       int cpu, int rbflags);
>
>  void ring_buffer_change_overwrite(struct ring_buffer *buffer, int val);
>
> @@ -201,6 +202,7 @@ int ring_buffer_print_page_header(struct trace_seq *s);
>
>  enum ring_buffer_flags {
>         RB_FL_OVERWRITE         = 1 << 0,
> +       RB_FL_NO_RECLAIM        = 1 << 1,

But the thing is, set_oom_origin doesn't seem to be doing the
desirable thing every time anyway as per my tests last week [1] and
the si_mem_available check alone seems to be working fine for me (and
also Zhaoyang as he mentioned).

Since the problem Zhaoyang is now referring to is caused because of
calling set_oom_origin in the first place, can we not just drop that
patch and avoid adding more complexity?

IMHO I feel like for things like RB memory allocation, we shouldn't
add a knob if we don't need to.

Also I think Zhaoyang is developing for Android too since he mentioned
he ran CTS tests so we both have the same "usecase" but he can feel
free to correct me if that's not the case ;)

thanks,

- Joel
[1] https://www.spinics.net/lists/linux-mm/msg149227.html
