Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeCLPKY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:10:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751943AbeCLPKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:10:21 -0400
Date: Mon, 12 Mar 2018 16:10:17 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 3/3] tracing: Rewrite filter logic to be simpler and
 faster
Message-ID: <20180312151017.GE23111@krava>
References: <20180310023442.791997138@goodmis.org>
 <20180310023907.798690563@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310023907.798690563@goodmis.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 09:34:45PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Al Viro reviewed the filter logic of ftrace trace events and found it to be
> very troubling. It creates a binary tree based on the logic operators and
> walks it during tracing. He sent myself and Tom Zanussi a long explanation
> (and formal proof) of how to do the string parsing better and end up with a
> program array that can be simply iterated to come up with the correct
> results.
> 
> I took his ideas and his pseudo code and rewrote the filter logic based on
> them. In doing so, I was able to remove a lot of code, and have a much more
> condensed filter logic in the process. I wrote a very long comment
> describing the methadology that Al proposed in my own words. For more info
> on how this works, read the comment above predicate_parse().
> 
> Suggested-by: Al Viro <viro@ZenIV.linux.org.uk>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

got it crashed when clearing the filter via 'echo > filter'

jirka


---
ibm-x3650m4-01 login: [  803.551062] BUG: unable to handle kernel paging request at ffff972acc154c34
[  803.558846] IP: process_preds+0x5e9/0x680
[  803.563318] PGD 251bbf067 P4D 251bbf067 PUD 0 
[  803.568280] Oops: 0000 [#1] SMP PTI
[  803.572172] Modules linked in: intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm igb irqbypass crct10dif_pclmul ptp crc32_pclmul ipmi_ssmi_msghandler intel_rapl_perf wmi i2c_i801 mii lpc_ich xfs libcrc32c mgag200 i2c_algo_bit drm_kms_helper ttm crc32c_intel drm megaraid_sas
[  803.618767] CPU: 13 PID: 1297 Comm: bash Not tainted 4.16.0-rc4+ #96
[  803.625857] Hardware name: IBM System x3650 M4 : -[7915E2G]-/00Y7683, BIOS -[VVE124AUS-1.30]- 11/21/2012
[  803.636441] RIP: 0010:process_preds+0x5e9/0x680
[  803.641496] RSP: 0018:ffffa8aac2b9fd30 EFLAGS: 00010286
[  803.647327] RAX: ffff972375def4e0 RBX: ffff972575b84e08 RCX: 00000000fffffffe
[  803.655289] RDX: ffff972acc154c30 RSI: ffff972375def500 RDI: 0000000000023ee0
[  803.663251] RBP: ffff972575b84198 R08: ffff972377be3ee0 R09: ffff972575b84210
[  803.671213] R10: 0000000000000000 R11: 0000000040000000 R12: ffff972575b84ff0
[  803.679176] R13: 0000000000000001 R14: 00000000fffffff4 R15: ffff972575b84ff0
[  803.687139] FS:  00007f216a513700(0000) GS:ffff972377bc0000(0000) knlGS:0000000000000000
[  803.696169] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  803.702581] CR2: ffff972acc154c34 CR3: 0000000274478001 CR4: 00000000000606e0
[  803.710544] Call Trace:
[  803.713278]  create_filter+0x80/0xc0
[  803.717268]  apply_event_filter+0xb8/0x120
[  803.721837]  event_filter_write+0x5d/0xb0
[  803.726312]  __vfs_write+0x33/0x170
[  803.730207]  ? __inode_security_revalidate+0x4a/0x70
[  803.735740]  ? selinux_file_permission+0xce/0x120
[  803.740989]  ? _cond_resched+0x16/0x40
[  803.745173]  vfs_write+0xb0/0x190
[  803.748870]  SyS_write+0x52/0xc0
[  803.752473]  do_syscall_64+0x6e/0x180
[  803.756560]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[  803.762196] RIP: 0033:0x7f2169c00b50
[  803.766182] RSP: 002b:00007ffc35e05db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  803.774630] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f2169c00b50
[  803.782592] RDX: 0000000000000001 RSI: 0000560031449e00 RDI: 0000000000000001
[  803.790555] RBP: 0000560031449e00 R08: 00007f2169ecb740 R09: 00007f216a513700
[  803.798517] R10: 0000560031453a00 R11: 0000000000000246 R12: 0000000000000001
[  803.806479] R13: 0000000000000001 R14: 00007f2169eca5e0 R15: 00007f2169ec63c0
[  803.814443] Code: 02 00 00 00 00 44 89 10 c7 40 04 00 00 00 00 83 e9 01 83 f9 ff 74 22 48 63 c1 48 c1 e0 04 48 01 f0 48 63 10 48 c1 e2 04 48 01 f2 <8b> 5a 04 39 58 04
[  803.835544] RIP: process_preds+0x5e9/0x680 RSP: ffffa8aac2b9fd30
[  803.842247] CR2: ffff972acc154c34
[  803.845945] ---[ end trace 81df1915c389f53d ]---
