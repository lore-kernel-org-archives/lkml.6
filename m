Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbeECQPm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:15:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751050AbeECQPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:15:41 -0400
Date: Thu, 3 May 2018 12:15:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Julia Cartwright <julia@ni.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] trace-cmd: add plugin for decoding
 syscalls/sys_enter_futex
Message-ID: <20180503121538.2a4485a8@gandalf.local.home>
In-Reply-To: <20171207025649.12160-1-julia@ni.com>
References: <20171207025649.12160-1-julia@ni.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2017 20:56:49 -0600
Julia Cartwright <julia@ni.com> wrote:

> The futex syscall is a complicated one.  It supports thirteen
> multiplexed operations, each with different semantics and encodings for
> the syscalls six arguments.
> 
> Manually decoding these arguments is tedious and error prone.
> 
> This plugin provides symbolic names for futex operations, futex flags,
> and tries to be intelligent about the intent of specific arguments (for
> example, waking operations use 'val' as an integer count, not just an
> arbitrary value).
> 
> It doesn't do a full decode of the FUTEX_WAKE_OP's 'val3' argument,
> however, this is a good starting point.
> 
> Signed-off-by: Julia Cartwright <julia@ni.com>

Hi Julia,

I missed this patch. I just applied it and will be pushing it out soon.

Thanks!

-- Steve

> ---
>  Makefile       |   1 +
>  plugin_futex.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 136 insertions(+)
>  create mode 100644 plugin_futex.c
> 
> diff --git a/Makefile b/Makefile
> index 5c35143c8867..58b957d9a578 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -365,6 +365,7 @@ PLUGIN_OBJS += plugin_kvm.o
>  PLUGIN_OBJS += plugin_mac80211.o
>  PLUGIN_OBJS += plugin_sched_switch.o
>  PLUGIN_OBJS += plugin_function.o
> +PLUGIN_OBJS += plugin_futex.o
>  PLUGIN_OBJS += plugin_xen.o
>  PLUGIN_OBJS += plugin_scsi.o
>  PLUGIN_OBJS += plugin_cfg80211.o
> diff --git a/plugin_futex.c b/plugin_futex.c
> new file mode 100644
> index 000000000000..b12c92d91a86
> --- /dev/null
> +++ b/plugin_futex.c
> @@ -0,0 +1,135 @@
> +/*
> + * Copyright (C) 2017 National Instruments Corp.
> + *
> + * Author: Julia Cartwright <julia@ni.com>
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation;
> + * version 2.1 of the License (not later!)
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this program; if not,  see <http://www.gnu.org/licenses>
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <linux/futex.h>
> +
> +#include "trace-cmd.h"
> +
> +struct futex_args {
> +	unsigned long long	uaddr;
> +	unsigned long long	op;
> +	unsigned long long	val;
> +	unsigned long long	utime; /* or val2 */
> +	unsigned long long	uaddr2;
> +	unsigned long long	val3;
> +};
> +
> +struct futex_op {
> +	const char	*name;
> +	const char	*fmt_val;
> +	const char	*fmt_utime;
> +	const char	*fmt_uaddr2;
> +	const char	*fmt_val3;
> +};
> +
> +static const struct futex_op futex_op_tbl[] = {
> +	{            "FUTEX_WAIT", " val=0x%08llx", " utime=0x%08llx",               NULL,             NULL },
> +	{            "FUTEX_WAKE",     " val=%llu",              NULL,               NULL,             NULL },
> +	{              "FUTEX_FD",     " val=%llu",              NULL,               NULL,             NULL },
> +	{         "FUTEX_REQUEUE",     " val=%llu",      " val2=%llu", " uaddr2=0x%08llx",             NULL },
> +	{     "FUTEX_CMP_REQUEUE",     " val=%llu",      " val2=%llu", " uaddr2=0x%08llx", " val3=0x%08llx" },
> +	{         "FUTEX_WAKE_OP",     " val=%llu",      " val2=%llu", " uaddr2=0x%08llx", " val3=0x%08llx" },
> +	{         "FUTEX_LOCK_PI",            NULL, " utime=0x%08llx",               NULL,             NULL },
> +	{       "FUTEX_UNLOCK_PI",            NULL,              NULL,               NULL,             NULL },
> +	{      "FUTEX_TRYLOCK_PI",            NULL,              NULL,               NULL,             NULL },
> +	{     "FUTEX_WAIT_BITSET", " val=0x%08llx", " utime=0x%08llx",               NULL, " val3=0x%08llx" },
> +	{     "FUTEX_WAKE_BITSET",     " val=%llu",              NULL,               NULL, " val3=0x%08llx" },
> +	{ "FUTEX_WAIT_REQUEUE_PI", " val=0x%08llx", " utime=0x%08llx", " uaddr2=0x%08llx", " val3=0x%08llx" },
> +	{  "FUTEX_CMP_REQUEUE_PI",     " val=%llu",      " val2=%llu", " uaddr2=0x%08llx", " val3=0x%08llx" },
> +};
> +
> +
> +static void futex_print(struct trace_seq *s, const struct futex_args *args,
> +			const struct futex_op *fop)
> +{
> +	trace_seq_printf(s, " uaddr=0x%08llx", args->uaddr);
> +
> +	if (fop->fmt_val)
> +		trace_seq_printf(s, fop->fmt_val, args->val);
> +
> +	if (fop->fmt_utime)
> +		trace_seq_printf(s,fop->fmt_utime, args->utime);
> +
> +	if (fop->fmt_uaddr2)
> +		trace_seq_printf(s, fop->fmt_uaddr2, args->uaddr2);
> +
> +	if (fop->fmt_val3)
> +		trace_seq_printf(s, fop->fmt_val3, args->val3);
> +}
> +
> +static int futex_handler(struct trace_seq *s, struct pevent_record *record,
> +			 struct event_format *event, void *context)
> +{
> +	const struct futex_op *fop;
> +	struct futex_args args;
> +	unsigned long long cmd;
> +
> +	if (pevent_get_field_val(s, event, "uaddr", record, &args.uaddr, 1))
> +		return 1;
> +
> +	if (pevent_get_field_val(s, event, "op", record, &args.op, 1))
> +		return 1;
> +
> +	if (pevent_get_field_val(s, event, "val", record, &args.val, 1))
> +		return 1;
> +
> +	if (pevent_get_field_val(s, event, "utime", record, &args.utime, 1))
> +		return 1;
> +
> +	if (pevent_get_field_val(s, event, "uaddr2", record, &args.uaddr2, 1))
> +		return 1;
> +
> +	if (pevent_get_field_val(s, event, "val3", record, &args.val3, 1))
> +		return 1;
> +
> +	cmd = args.op & FUTEX_CMD_MASK;
> +	if (cmd >= ARRAY_SIZE(futex_op_tbl))
> +		return 1;
> +
> +	fop = &futex_op_tbl[cmd];
> +
> +	trace_seq_printf(s, "op=%s", fop->name);
> +
> +	if (args.op & FUTEX_PRIVATE_FLAG)
> +		trace_seq_puts(s, "|FUTEX_PRIVATE_FLAG");
> +
> +	if (args.op & FUTEX_CLOCK_REALTIME)
> +		trace_seq_puts(s, "|FUTEX_CLOCK_REALTIME");
> +
> +	futex_print(s, &args, fop);
> +	return 0;
> +}
> +
> +int PEVENT_PLUGIN_LOADER(struct pevent *pevent)
> +{
> +	pevent_register_event_handler(pevent, -1, "syscalls", "sys_enter_futex",
> +				      futex_handler, NULL);
> +	return 0;
> +}
> +
> +void PEVENT_PLUGIN_UNLOADER(struct pevent *pevent)
> +{
> +	pevent_unregister_event_handler(pevent, -1, "syscalls", "sys_enter_futex",
> +					futex_handler, NULL);
> +}
