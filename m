Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeC0Bfz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 21:35:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55190 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbeC0Bfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 21:35:54 -0400
X-Google-Smtp-Source: AG47ELtZHWMUduofsTz0KhubQjcASnnFvCoCihUrnWLm6d7GPQ3kttgVI/nbmswoGxltqzdyPgWksnWETZ8UQFp38BM=
MIME-Version: 1.0
In-Reply-To: <20180326191031.14939-1-mathieu.desnoyers@efficios.com>
References: <20180326191031.14939-1-mathieu.desnoyers@efficios.com>
From: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Date: Mon, 26 Mar 2018 18:35:52 -0700
Message-ID: <CAEi0qN=zSWqH0U0pTg-c31vk+xXFbddzSniJG6sudjuaMk9kVQ@mail.gmail.com>
Subject: Re: [RFC PATCH] tracepoint: Provide tracepoint_kernel_find_by_name
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Mon, Mar 26, 2018 at 12:10 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> Provide an API allowing eBPF to lookup core kernel tracepoints by name.
>
> Given that a lookup by name explicitly requires tracepoint definitions
> to be unique for a given name (no duplicate keys), include a
> WARN_ON_ONCE() check that only a single match is encountered at runtime.
> This should always be the case, given that a DEFINE_TRACE emits a
> __tracepoint_##name symbol, which would cause a link-time error if more
> than one instance is found. Nevertheless, check this at runtime with
> WARN_ON_ONCE() to stay on the safe side.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Alexei Starovoitov <ast@kernel.org>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Ingo Molnar <mingo@kernel.org>
> ---
>  include/linux/tracepoint.h |  1 +
>  kernel/tracepoint.c        | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index c94f466d57ef..1b4ae64b7c6a 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -43,6 +43,7 @@ tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data);
>  extern void
>  for_each_kernel_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
>                 void *priv);
> +extern struct tracepoint *tracepoint_kernel_find_by_name(const char *name);
>
>  #ifdef CONFIG_MODULES
>  struct tp_module {
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 671b13457387..0a59f988055a 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -60,6 +60,11 @@ struct tp_probes {
>         struct tracepoint_func probes[0];
>  };
>
> +struct tp_find_args {
> +       const char *name;
> +       struct tracepoint *tp;
> +};
> +
>  static inline void *allocate_probes(int count)
>  {
>         struct tp_probes *p  = kmalloc(count * sizeof(struct tracepoint_func)
> @@ -528,6 +533,36 @@ void for_each_kernel_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
>  }
>  EXPORT_SYMBOL_GPL(for_each_kernel_tracepoint);
>
> +static void find_tp(struct tracepoint *tp, void *priv)
> +{
> +       struct tp_find_args *args = priv;
> +
> +       if (!strcmp(tp->name, args->name)) {
> +               WARN_ON_ONCE(args->tp);
> +               args->tp = tp;

I think this runtime check is not needed if it really can't happen
(linker verifies that already as you mentioned) although I'm not
opposed if you still want to keep it, because there's no way to break
out of the outer loop anyway so I guess your call.. I would just do:

if (args->tp)
    return;

if find_tp already found the tracepoint.

Tried to also create a duplicate tracepoint and I get:
  CC      init/version.o
  AR      init/built-in.o
  AR      built-in.o
  LD      vmlinux.o
block/blk-core.o:(__tracepoints+0x440): multiple definition of
`__tracepoint_sched_switch'
kernel/sched/core.o:(__tracepoints+0x440): first defined here
Makefile:1032: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

For this senseless diff:
 diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 81b43f5bdf23..2b855c05197d 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -49,6 +49,13 @@ DEFINE_EVENT(block_buffer, block_touch_buffer,
        TP_ARGS(bh)
 );

+DEFINE_EVENT(block_buffer, sched_switch,
+
+       TP_PROTO(struct buffer_head *bh),
+
+       TP_ARGS(bh)
+);
+
 /**
  * block_dirty_buffer - mark a buffer dirty
  * @bh: buffer_head being dirtied


thanks,

- Joel
