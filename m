Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbeDKHsq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 03:48:46 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37915 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbeDKHsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 03:48:43 -0400
X-Google-Smtp-Source: AIpwx49vZAaklGcimota5uiBhnjQX2ITJPQ1DHeoTuymzSniEUUxpowfHE0tP8ygxOh8dAoMEkpK+EtxXzL/cAB4M6k=
MIME-Version: 1.0
In-Reply-To: <CAJWu+ooC4hCK31srhBFoAf=qwfFFOyTGsjRRJ9PdxaVsb6waQQ@mail.gmail.com>
References: <20180410061447.GQ21835@dhcp22.suse.cz> <CAGWkznGrugH0VqJyd5ZPiSBMOZ4SbbNpKiHVXM27Q-ep4SYb-Q@mail.gmail.com>
 <20180410074921.GU21835@dhcp22.suse.cz> <CAGWkznHQSZ5jPF2njOp0BritTmKiGOToq5bAz1bhzzmFi_01nA@mail.gmail.com>
 <20180410081231.GV21835@dhcp22.suse.cz> <CAGWkznEM=AX=3LWDmgyz4GRkWy81TNdFQQXZ7+W4=Ek4ZsnsJw@mail.gmail.com>
 <20180410090128.GY21835@dhcp22.suse.cz> <CAGWkznEf0siz1-RFSJwuKCjUtbKM=P1djo2Nc7sU1GS0AgWv2w@mail.gmail.com>
 <20180410104902.GC21835@dhcp22.suse.cz> <20180410082316.263d34ec@gandalf.local.home>
 <20180410122706.GH21835@dhcp22.suse.cz> <20180410083625.2c904ab2@gandalf.local.home>
 <20180410091311.20bd8ccc@gandalf.local.home> <CAJWu+oo5iUDjCnbhhJ7x2BGeuL6FDAVqFCa5tcTikVh5OtxfRA@mail.gmail.com>
 <20180410140036.650a8732@gandalf.local.home> <CAJWu+ooC4hCK31srhBFoAf=qwfFFOyTGsjRRJ9PdxaVsb6waQQ@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 11 Apr 2018 15:48:41 +0800
Message-ID: <CAGWkznF-sb4g2Sh66qj3Lc0pfPGFD975ZxOANPCtOtyxLHK8+Q@mail.gmail.com>
Subject: Re: [PATCH v1] ringbuffer: Don't choose the process with adj equal OOM_SCORE_ADJ_MIN
To: Joel Fernandes <joelaf@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 2:39 AM, Joel Fernandes <joelaf@google.com> wrote:
> Hi Steve,
>
> On Tue, Apr 10, 2018 at 11:00 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>> On Tue, 10 Apr 2018 09:45:54 -0700
>> Joel Fernandes <joelaf@google.com> wrote:
>>
>>> > diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
>>> > index a0233edc0718..807e2bcb21b3 100644
>>> > --- a/include/linux/ring_buffer.h
>>> > +++ b/include/linux/ring_buffer.h
>>> > @@ -106,7 +106,8 @@ __poll_t ring_buffer_poll_wait(struct ring_buffer *buffer, int cpu,
>>> >
>>> >  void ring_buffer_free(struct ring_buffer *buffer);
>>> >
>>> > -int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size, int cpu);
>>> > +int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
>>> > +                       int cpu, int rbflags);
>>> >
>>> >  void ring_buffer_change_overwrite(struct ring_buffer *buffer, int val);
>>> >
>>> > @@ -201,6 +202,7 @@ int ring_buffer_print_page_header(struct trace_seq *s);
>>> >
>>> >  enum ring_buffer_flags {
>>> >         RB_FL_OVERWRITE         = 1 << 0,
>>> > +       RB_FL_NO_RECLAIM        = 1 << 1,
>>>
>>> But the thing is, set_oom_origin doesn't seem to be doing the
>>> desirable thing every time anyway as per my tests last week [1] and
>>> the si_mem_available check alone seems to be working fine for me (and
>>> also Zhaoyang as he mentioned).
>>
>> But did you try it with just plain GFP_KERNEL, and not RETRY_MAYFAIL.
>
> Yes I tried it with just GFP_KERNEL as well. What I did based on your
> suggestion for testing the OOM hint is:
> 1. Comment the si_mem_available check
> 2. Do only GFP_KERNEL
>
> The system gets destabilized with this combination even with the OOM
> hint. These threads are here:
> https://lkml.org/lkml/2018/4/5/720
>
>> My tests would always trigger the allocating task without the
>> RETRY_MAYFAIL, but with RETRY_MAYFAIL it would sometimes take out other
>> tasks.
>>
>>>
>>> Since the problem Zhaoyang is now referring to is caused because of
>>> calling set_oom_origin in the first place, can we not just drop that
>>> patch and avoid adding more complexity?
>>
>> Actually, I'm thinking of dropping the MAYFAIL part. It really should
>> be the one targeted if you are extending the ring buffer.
>
> This then sounds like it should be fixed in -mm code? If we're giving
> the hint and its not getting killed there then that's an -mm issue.
>
>> I could add two loops. One that does NORETRY without the oom origin,
>> and if it succeeds, its fine. But if it requires reclaim, it will then
>> set oom_origin and go harder (where it should be the one targeted).
>>
>> But that may be pointless, because if NORETRY succeeds, there's not
>> really any likelihood of oom triggering in the first place.
>
> Yes.
>
>>
>>>
>>> IMHO I feel like for things like RB memory allocation, we shouldn't
>>> add a knob if we don't need to.
>>
>> It was just a suggestion.
>
> Cool, I understand.
>
>>>
>>> Also I think Zhaoyang is developing for Android too since he mentioned
>>> he ran CTS tests so we both have the same "usecase" but he can feel
>>> free to correct me if that's not the case ;)
>>
>> I think if you are really worried with the task being killed by oom,
>> then I agree with Michal and just fork a process to do the allocation
>> for you.
>
> Yes I agree. So lets just do that and no other patches additional
> patches are needed then. Let me know if there's anything else I
> missed?
>
> Also I got a bit confused, I reread all the threads. Zhaoyang's
> current issue is that the OOM hint *IS* working which is what
> triggered your patch to toggle the behavior through an option. Where
> was in this message we are discussing that the OOM hint doesn't always
> work which is not Zhaoyang's current issue. Let me know if I missed
> something? Sorry if I did.
>
> thanks,
>
> - Joel
Hi Joel, you are right. My issue is to make Steven's patch safer by
keeping -1000 process out of OOM. I think it is ok either we just have
si_mem_available or apply set/clear_current_oom_origin with absolving
-1000 process. The CTS case failed because the system_server was
killed as the innocent. If Steven think it is rared corner case, I am
ok with that.
