Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeBICdl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 21:33:41 -0500
Received: from smtpbgjp3.qq.com ([54.92.39.34]:59410 "EHLO smtpbgjp3.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752218AbeBICdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 21:33:39 -0500
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: p/Y2uUKTrszhKlFXmhKlHQa2O1Lz9YhqBOpBLUmBPZDC+TvG9khrXkM7wUOfR
        zERDUd1rdlkcgA36WBsvk5CaXpK1kLYHl+eJSmMj5T19Eszg+yxNCeOXhKLgKdq90vvEaVY
        jtNPS39VBztoF/l4anDqVl73zA94tURmiyTg55zSVj+G3HdiV1K/u9m5T08TrNkBRzHOjbB
        ZwacuMN4usWrW9L+kxZjLICuleyAZrSuhwwyAyfDxBgpviowsTEj5YZT0QZCsW0L+Kn1OBK
        QWaZ/nIkiNH32iiHU5Maewvzc=
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 218.76.220.175
X-QQ-STYLE: 
X-QQ-mid: bizmailvip84t1518143611t84922
From: "=?utf-8?B?Wmhlbmd5dWFuIExpdQ==?=" <liuzhengyuan@kylinos.cn>
To: "=?utf-8?B?U3RldmVuIFJvc3RlZHQ=?=" <rostedt@goodmis.org>
Cc: "=?utf-8?B?bWluZ28=?=" <mingo@redhat.com>,
        "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?bGl1emhlbmd5dWFuZzUyMQ==?=" <liuzhengyuang521@gmail.com>,
        "=?utf-8?B?bGlueC56LmNoZW4=?=" <linx.z.chen@intel.com>
Subject: Re: [PATCH] ftrace: fix the file mode of graph tracer and stacktracer
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Date: Fri, 9 Feb 2018 10:33:31 +0800
X-Priority: 3
Message-ID: <tencent_34C119E628948BE127843C25@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <1518054113-28096-1-git-send-email-liuzhengyuan@kylinos.cn>
        <20180208102149.7e3bfe45@gandalf.local.home>
In-Reply-To: <20180208102149.7e3bfe45@gandalf.local.home>
X-QQ-ReplyHash: 3306839277
X-QQ-SENDSIZE: 520
Feedback-ID: bizmailvip:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w192Xiki010128

2018-02-08 23:21 GMT+08:00 Steven Rostedt <rostedt@goodmis.org>:
> On Thu,  8 Feb 2018 09:41:53 +0800
> Zhengyuan Liu <liuzhengyuan@kylinos.cn> wrote:
>
>> It's something looks weird that those files could be written by root
>> but shows with no write permission by ll command.
>> Chen LinX <linx.z.chen@intel.com> has sent a similar patch to fix
>> graph function file mode in 2000,  I didn't get the reason why that
>> patch wasn't applied so I resend it.
>>
>> Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
>> ---
>>  kernel/trace/ftrace.c      | 4 ++--
>>  kernel/trace/trace_stack.c | 2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index ccdf366..fe903dc8 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -5513,10 +5513,10 @@ static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
>>       ftrace_create_filter_files(&global_ops, d_tracer);
>>
>>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>> -     trace_create_file("set_graph_function", 0444, d_tracer,
>> +     trace_create_file("set_graph_function", 0644, d_tracer,
>
> Thanks for resending the patch.
>
> What's interesting is that this doesn't seem to affect whether or not
> root can write to the file. I wonder if that's a bug itself.
>
> -- Steve

Hi, Steve, Thanks for reply.

It doesn't affect root writing to those files as root is a super user and
can access to any write-only files.  I just want to make those writable
file to look consistent with others, seeing bellow:

-rw-r--r--  1 root root  set_event_pid
-rw-r--r--  1 root root  set_ftrace_filter
-rw-r--r--  1 root root  set_ftrace_notrace
-rw-r--r--  1 root root  set_ftrace_pid
-r--r--r--  1 root root   set_graph_function
-r--r--r--  1 root root  set_graph_notrace

If this patch makes no sense, just ignore it!

>>                                   NULL,
>>                                   &ftrace_graph_fops);
>> -     trace_create_file("set_graph_notrace", 0444, d_tracer,
>> +     trace_create_file("set_graph_notrace", 0644, d_tracer,
>>                                   NULL,
>>                                   &ftrace_graph_notrace_fops);
>>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
>> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
>> index 734accc..4356f14 100644
>> --- a/kernel/trace/trace_stack.c
>> +++ b/kernel/trace/trace_stack.c
>> @@ -468,7 +468,7 @@ static __init int stack_trace_init(void)
>>                       NULL, &stack_trace_fops);
>>
>>  #ifdef CONFIG_DYNAMIC_FTRACE
>> -     trace_create_file("stack_trace_filter", 0444, d_tracer,
>> +     trace_create_file("stack_trace_filter", 0644, d_tracer,
>>                         &trace_ops, &stack_trace_filter_fops);
>>  #endif
>>
>
