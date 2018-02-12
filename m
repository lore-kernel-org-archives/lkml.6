Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbeBLRE5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:04:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751063AbeBLRE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:04:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4236921104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 12 Feb 2018 12:04:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Du, Changbin" <changbin.du@intel.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/power: Don't share template for cpu_idle and
 cpu_frequency
Message-ID: <20180212120452.50abd9bf@gandalf.local.home>
In-Reply-To: <20180211105004.p55ajlt5kw36qwxi@intel.com>
References: <1518226624-8931-1-git-send-email-changbin.du@intel.com>
        <20180209214458.1ed36c3c@vmware.local.home>
        <20180211105004.p55ajlt5kw36qwxi@intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Feb 2018 18:50:04 +0800
"Du, Changbin" <changbin.du@intel.com> wrote:

> Steve, How abount DEFINE_EVENT_PRINT as below?

Yes, DEFINE_EVENT_PRINT is better.

> 
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index 908977d..e71ce98 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -14,12 +14,12 @@
> 
>  DECLARE_EVENT_CLASS(cpu,
> 
> -       TP_PROTO(unsigned int state, unsigned int cpu_id),
> +       TP_PROTO(int state, unsigned int cpu_id),
> 
>         TP_ARGS(state, cpu_id),
> 
>         TP_STRUCT__entry(
> -               __field(        u32,            state           )
> +               __field(        s32,            state           )
>                 __field(        u32,            cpu_id          )
>         ),
> 
> @@ -28,13 +28,12 @@ DECLARE_EVENT_CLASS(cpu,
>                 __entry->cpu_id = cpu_id;
>         ),
> 
> -       TP_printk("state=%lu cpu_id=%lu", (unsigned long)__entry->state,
> -                 (unsigned long)__entry->cpu_id)

Yous still need the type casting, because s32/u32 on 32 bit machines
can be defined as "long".

-- Steve

> +       TP_printk("state=%d cpu_id=%u", __entry->state, __entry->cpu_id)
>  );
> 
>  DEFINE_EVENT(cpu, cpu_idle,
> 
> -       TP_PROTO(unsigned int state, unsigned int cpu_id),
> +       TP_PROTO(int state, unsigned int cpu_id),
> 
>         TP_ARGS(state, cpu_id)
>  );
> @@ -141,11 +140,13 @@ TRACE_EVENT(pstate_sample,
>                 { PM_EVENT_RESTORE, "restore" }, \
>                 { PM_EVENT_RECOVER, "recover" })
> 
> -DEFINE_EVENT(cpu, cpu_frequency,
> +DEFINE_EVENT_PRINT(cpu, cpu_frequency,
> 
> -       TP_PROTO(unsigned int frequency, unsigned int cpu_id),
> +       TP_PROTO(int state, unsigned int cpu_id),
> 
> -       TP_ARGS(frequency, cpu_id)
> +       TP_ARGS(state, cpu_id),
> +
> +       TP_printk("frequency=%u cpu_id=%lu", __entry->state, __entry->cpu_id)
>  );
