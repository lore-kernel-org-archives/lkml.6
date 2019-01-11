Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A165C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031752133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547167874;
	bh=Lvca0j7SQ8acgEjqgQpHsC1KXYC4RVNaaIuBFKjpcKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JftawxGkoep9LGMEKRPhIU1oX9lo2jx95L+wy4wD6raMTGzuqAL7Do9FfWS23E0Na
	 sJ8mdiL8zvbNGxpn5Inqzg8St2NwBIQUnrc78nv5WlPTyyCG0qx8/m0DO49DSVGInZ
	 ZDYm9HDAgmqYnTIl4H/iYdJxmy7Q27Fa0A4V3xwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfAKAvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:51:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfAKAvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:51:12 -0500
Received: from devnote (unknown [180.0.253.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17DD20879;
        Fri, 11 Jan 2019 00:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547167871;
        bh=Lvca0j7SQ8acgEjqgQpHsC1KXYC4RVNaaIuBFKjpcKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PE8WTNUIaD0KrN/YxlDh1v2YqX+6Heshp4C4bXjzhfa3/yrQW3QFetH2BG2QXuBNX
         tNfuHwjsV92azWYRByt8Vd0UIBnsL+y5Ux/lV/vzQIHFtFADf1Y7CoMRQVmXm91w79
         9JIIe7KCWeUJysreIQPfornNYplQXAxDd++6MF7c=
Date:   Fri, 11 Jan 2019 09:51:08 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/kprobes: fix NULL pointer dereference in
 trace_kprobe_create()
Message-Id: <20190111095108.b79a2ee026185cbd62365977@kernel.org>
In-Reply-To: <20190110173947.GA19243@xps-13>
References: <20190110173947.GA19243@xps-13>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Thu, 10 Jan 2019 18:39:47 +0100
Andrea Righi <righi.andrea@gmail.com> wrote:

> It is possible to trigger a NULL pointer dereference by writing an
> incorrectly formatted string to krpobe_events (omitting the symbol).
> 
> Example:
> 
>  echo "r:event_1 " >> /sys/kernel/debug/tracing/kprobe_events
> 
> That triggers this:
> 
>  BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
>  #PF error: [normal kernel read fault]
>  PGD 0 P4D 0
>  Oops: 0000 [#1] SMP PTI
>  CPU: 6 PID: 1757 Comm: bash Not tainted 5.0.0-rc1+ #125
>  Hardware name: Dell Inc. XPS 13 9370/0F6P3V, BIOS 1.5.1 08/09/2018
>  RIP: 0010:kstrtoull+0x2/0x20
>  Code: 28 00 00 00 75 17 48 83 c4 18 5b 41 5c 5d c3 b8 ea ff ff ff eb e1 b8 de ff ff ff eb da e8 d6 36 bb ff 66 0f 1f 44 00 00 31 c0 <80> 3f 2b 55 48 89 e5 0f 94 c0 48 01 c7 e8 5c ff ff ff 5d c3 66 2e
>  RSP: 0018:ffffb5d482e57cb8 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff82b12720
>  RDX: ffffb5d482e57cf8 RSI: 0000000000000000 RDI: 0000000000000000
>  RBP: ffffb5d482e57d70 R08: ffffa0c05e5a7080 R09: ffffa0c05e003980
>  R10: 0000000000000000 R11: 0000000040000000 R12: ffffa0c04fe87b08
>  R13: 0000000000000001 R14: 000000000000000b R15: ffffa0c058d749e1
>  FS:  00007f137c7f7740(0000) GS:ffffa0c05e580000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 0000000497d46004 CR4: 00000000003606e0
>  Call Trace:
>   ? trace_kprobe_create+0xb6/0x840
>   ? _cond_resched+0x19/0x40
>   ? _cond_resched+0x19/0x40
>   ? __kmalloc+0x62/0x210
>   ? argv_split+0x8f/0x140
>   ? trace_kprobe_create+0x840/0x840
>   ? trace_kprobe_create+0x840/0x840
>   create_or_delete_trace_kprobe+0x11/0x30
>   trace_run_command+0x50/0x90
>   trace_parse_run_command+0xc1/0x160
>   probes_write+0x10/0x20
>   __vfs_write+0x3a/0x1b0
>   ? apparmor_file_permission+0x1a/0x20
>   ? security_file_permission+0x31/0xf0
>   ? _cond_resched+0x19/0x40
>   vfs_write+0xb1/0x1a0
>   ksys_write+0x55/0xc0
>   __x64_sys_write+0x1a/0x20
>   do_syscall_64+0x5a/0x120
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Fix by doing the proper argument check when a NULL symbol is passed in
> trace_kprobe_create().
> 

Oops! It is my fault on commit 6212dd29683e ("tracing/kprobes: Use dyn_event
framework for kprobe events")

Previously, we have following check, but it is removed 

-       if (argc < 2) {
-               pr_info("Probe point is not specified.\n");
-               return -EINVAL;
-       }

and check it only for kprobe event but not kretprobe event.

        /* argc must be >= 1 */
        if (argv[0][0] == 'r') {
                is_return = true;
                flags |= TPARG_FL_RETURN;
        } else if (argv[0][0] != 'p' || argc < 2)
                return -ECANCELED;

I would like to recover above if block instead of adding new check.

Could you do it with Fixed: and Cc: stable@vger.kernel.org tags?

Thank you,

> Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
> ---
>  kernel/trace/trace_kprobe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 5c19b8c41c7e..76410ceeff50 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -644,6 +644,8 @@ static int trace_kprobe_create(int argc, const char *argv[])
>  
>  	/* try to parse an address. if that fails, try to read the
>  	 * input as a symbol. */
> +	if (!argv[1])
> +		return -EINVAL;
>  	if (kstrtoul(argv[1], 0, (unsigned long *)&addr)) {
>  		/* Check whether uprobe event specified */
>  		if (strchr(argv[1], '/') && strchr(argv[1], ':'))
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
