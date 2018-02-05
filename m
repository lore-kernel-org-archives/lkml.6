Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeBEIYj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 03:24:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751938AbeBEIYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 03:24:32 -0500
Date: Mon, 5 Feb 2018 09:24:23 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 01/18] tracing: Add function based events
Message-ID: <20180205082423.GB1253@krava>
References: <20180202230458.840252014@goodmis.org>
 <20180202231017.160509978@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202231017.160509978@goodmis.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 06:04:59PM -0500, Steven Rostedt wrote:

SNIP

> +static int create_function_event(int argc, char **argv)
> +{
> +	struct func_event *func_event, *fe;
> +	enum func_states state = FUNC_STATE_INIT;
> +	char *token;
> +	char *ptr;
> +	char last;
> +	int ret = -EINVAL;
> +	int i;
> +
> +	func_event = kzalloc(sizeof(*func_event), GFP_KERNEL);
> +	if (!func_event)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&func_event->files);
> +	func_event->ops.func = func_event_call;
> +	func_event->ops.flags = FTRACE_OPS_FL_SAVE_REGS;
> +
> +	for (i = 0; i < argc; i++) {
> +		ptr = argv[i];
> +		last = 0;
> +		for (token = next_token(&ptr, &last); token;
> +		     token = next_token(&ptr, &last)) {
> +			state = process_event(func_event, token, state);
> +			if (state == FUNC_STATE_ERROR)
> +				goto fail;
> +		}
> +	}
> +	if (state != FUNC_STATE_END)
> +		goto fail;
> +
> +	ret = -EALREADY;
> +	list_for_each_entry(fe, &func_events, list) {
> +		if (strcmp(fe->func, func_event->func) == 0)
> +			goto fail;
> +	}
> +
> +	ret = ftrace_set_filter(&func_event->ops, func_event->func,
> +				strlen(func_event->func), 0);
> +	if (ret < 0)
> +		goto fail;
> +
> +	ret = func_event_create(func_event);
> +	if (ret < 0)
> +		goto fail;
> +
> +	list_add_tail(&func_event->list, &func_events);
> +	return 0;

should this be done under 'func_event_mutex' ?

I tried and crashed the system by running 2 scripts with:

  echo 'ip_rcv(u64 skb, u64 dev)' > /sys/kernel/debug/tracing/function_events
  echo 'SyS_openat(int dfd, string buf, x32 flags, x32 mode)' >> /sys/kernel/debug/tracing/function_events
  echo 'SyS_open(x8[32] buf, x32 flags, x32 mode)' >> /sys/kernel/debug/tracing/function_events

jirka


[  376.727159] general protection fault: 0000 [#1] SMP PTI
[  376.732992] Modules linked in: intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul igb ghash_clmulni_intel intel_cstate ptp intel_uncore pps_core iTCO_wdt iTCO_vendor_support ipmi_ssif ipmi_si ipmi_devintf ipmi_msghandler shpchp ioatdma cdc_ether usbnet mii intel_rapl_perf i2c_i801 tpm_tis tpm_tis_core dca tpm lpc_ich wmi xfs libcrc32c mgag200 i2c_algo_bit drm_kms_helper ttm crc32c_intel drm megaraid_sas
[  376.779583] CPU: 9 PID: 1285 Comm: t.sh Not tainted 4.15.0-rc9idle+ #32
[  376.786956] Hardware name: IBM System x3650 M4 : -[7915E2G]-/00Y7683, BIOS -[VVE124AUS-1.30]- 11/21/2012
[  376.797545] RIP: 0010:__unregister_trace_event+0xe/0x70
[  376.803376] RSP: 0018:ffffa643043cbc50 EFLAGS: 00010286
[  376.809206] RAX: dead000000000100 RBX: ffff91b6340c2480 RCX: ffffffffbf2ebf50
[  376.817170] RDX: dead000000000200 RSI: ffffffffbf2ed540 RDI: ffff91b6340c2480
[  376.825135] RBP: ffff91b6340c2460 R08: 0000000000000001 R09: 0000000000000000
[  376.833099] R10: ffffa643043cbc78 R11: 0000000000000000 R12: ffff91b6340c2400
[  376.841062] R13: ffff91b6326f8600 R14: dead000000000200 R15: dead000000000100
[  376.849028] FS:  00007ff3644bcb40(0000) GS:ffff91b63fac0000(0000) knlGS:0000000000000000
[  376.858058] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  376.864469] CR2: 000055c83b531008 CR3: 00000004736d0003 CR4: 00000000000606e0
[  376.872433] Call Trace:
[  376.875168]  event_remove+0x72/0x120
[  376.879159]  trace_remove_event_call+0x79/0xd0
[  376.884117]  func_event_open+0xb1/0xd0
[  376.888302]  ? free_func_event+0x70/0x70
[  376.892673]  do_dentry_open+0x1b1/0x2d0
[  376.896954]  path_openat+0x602/0x14e0
[  376.901041]  do_filp_open+0x9b/0x110
[  376.905032]  ? __vfs_write+0x33/0x170
[  376.909119]  ? __check_object_size+0xaf/0x1b0
[  376.913981]  ? do_sys_open+0x1bd/0x250
[  376.918164]  do_sys_open+0x1bd/0x250
[  376.922156]  entry_SYSCALL_64_fastpath+0x20/0x83
[  376.927299] RIP: 0033:0x7ff363ba01c0
[  376.931287] RSP: 002b:00007ffdf21e4978 EFLAGS: 00000246
[  376.931290] Code: e0 d9 2e bf e9 94 aa 6e 00 0f 1f 40 00 48 c7 c7 e0 d9 2e bf e9 54 5c f7 ff 0f 1f 40 00 53 48 8b 07 48 89 fb 48 8b 57 08 48 85 c0 <48> 89 02 74 04 48 89 50 08 48 b8 00 01 00 00 00 00 ad de 48 8d 
[  376.958209] RIP: __unregister_trace_event+0xe/0x70 RSP: ffffa643043cbc50
[  376.965711] ---[ end trace b3dd6064ee6bc2f4 ]---
