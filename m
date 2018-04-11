Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752966AbeDKOvZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:51:25 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:38505 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbeDKOvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:51:24 -0400
X-Google-Smtp-Source: AIpwx4/4bqO8tCEPGQ09BM545ILUpCLOGowy9iscxmFyeG2+k5mHSw0tZD1IKsZTMg62dEIm9XJ3R1UXGDG52hYoDOg=
MIME-Version: 1.0
In-Reply-To: <20180411104702.7f24401f@gandalf.local.home>
References: <00000000000032a0c30569916870@google.com> <20180411104702.7f24401f@gandalf.local.home>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 11 Apr 2018 16:51:02 +0200
Message-ID: <CACT4Y+Yi8DLRHo6CbQk71i8oLzoqYvFprJUsEc3LE32jNnOhVw@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in __free_filter
To: Steven Rostedt <rostedt@goodmis.org>
Cc: syzbot <syzbot+dadcc936587643d7f568@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 4:47 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Apr 2018 05:02:02 -0700
> syzbot <syzbot+dadcc936587643d7f568@syzkaller.appspotmail.com> wrote:
>
>> Hello,
>>
>> syzbot hit the following crash on upstream commit
>> b284d4d5a6785f8cd07eda2646a95782373cd01e (Tue Apr 10 19:25:30 2018 +0000)
>> Merge tag 'ceph-for-4.17-rc1' of git://github.com/ceph/ceph-client
>> syzbot dashboard link:
>> https://syzkaller.appspot.com/bug?extid=dadcc936587643d7f568
>>
>> So far this crash happened 6 times on upstream.
>> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6547381214511104
>> syzkaller reproducer:
>> https://syzkaller.appspot.com/x/repro.syz?id=5485642750361600
>> Raw console output:
>> https://syzkaller.appspot.com/x/log.txt?id=5352489637380096
>> Kernel config:
>> https://syzkaller.appspot.com/x/.config?id=-1223000601505858474
>> compiler: gcc (GCC) 8.0.1 20180301 (experimental)
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+dadcc936587643d7f568@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for
>> details.
>> If you forward the report, please keep this part and the footer.
>>
>
> Can you try this patch?

Hi Steve,

Instructions for asking syzbot to test a patch are here:

https://github.com/google/syzkaller/blob/master/docs/syzbot.md#communication-with-syzbot

> -- Steve
>
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 33b7720e2aa1..5c07ae2ac5d7 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1705,18 +1705,16 @@ static int create_filter(struct trace_event_call *call,
>                          struct event_filter **filterp)
>  {
>         struct filter_parse_error *pe = NULL;
> -       struct event_filter *filter = NULL;
>         int err;
>
> -       err = create_filter_start(filter_string, set_str, &pe, &filter);
> +       err = create_filter_start(filter_string, set_str, &pe, filterp);
>         if (err)
>                 return err;
>
> -       err = process_preds(call, filter_string, filter, pe);
> +       err = process_preds(call, filter_string, *filterp, pe);
>         if (err && set_str)
> -               append_filter_err(pe, filter);
> +               append_filter_err(pe, *filterp);
>
> -       *filterp = filter;
>         return err;
>  }
>
> @@ -1740,24 +1738,22 @@ static int create_system_filter(struct trace_subsystem_dir *dir,
>                                 struct trace_array *tr,
>                                 char *filter_str, struct event_filter **filterp)
>  {
> -       struct event_filter *filter = NULL;
>         struct filter_parse_error *pe = NULL;
>         int err;
>
> -       err = create_filter_start(filter_str, true, &pe, &filter);
> +       err = create_filter_start(filter_str, true, &pe, filterp);
>         if (!err) {
>                 err = process_system_preds(dir, tr, pe, filter_str);
>                 if (!err) {
>                         /* System filters just show a default message */
> -                       kfree(filter->filter_string);
> -                       filter->filter_string = NULL;
> +                       kfree((*filterp)->filter_string);
> +                       (*filterp)->filter_string = NULL;
>                 } else {
> -                       append_filter_err(pe, filter);
> +                       append_filter_err(pe, *filterp);
>                 }
>         }
>         create_filter_finish(pe);
>
> -       *filterp = filter;
>         return err;
>  }
>
> @@ -1765,7 +1761,7 @@ static int create_system_filter(struct trace_subsystem_dir *dir,
>  int apply_event_filter(struct trace_event_file *file, char *filter_string)
>  {
>         struct trace_event_call *call = file->event_call;
> -       struct event_filter *filter;
> +       struct event_filter *filter = NULL;
>         int err;
>
>         if (!strcmp(strstrip(filter_string), "0")) {
> @@ -1818,7 +1814,7 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
>  {
>         struct event_subsystem *system = dir->subsystem;
>         struct trace_array *tr = dir->tr;
> -       struct event_filter *filter;
> +       struct event_filter *filter = NULL;
>         int err = 0;
>
>         mutex_lock(&event_mutex);
> @@ -2025,7 +2021,7 @@ int ftrace_profile_set_filter(struct perf_event *event, int event_id,
>                               char *filter_str)
>  {
>         int err;
> -       struct event_filter *filter;
> +       struct event_filter *filter = NULL;
>         struct trace_event_call *call;
>
>         mutex_lock(&event_mutex);
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20180411104702.7f24401f%40gandalf.local.home.
> For more options, visit https://groups.google.com/d/optout.
