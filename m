Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E651C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25D32146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547214365;
	bh=oUhFWK+NKg04N6oO0fb5nzrty6X/Uo8qNEYG3ZLOZh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jSIF4Zfq7kFvUuwJxdEQ//q43FLZ2yATb40Kf30KToWtPTFRoY5RZtJR0s1BepJxl
	 Zx6l8hZLY4YoOIRlfm1ShtOrNZ9sv30xNSSpiKq2KQeY/4FAxgXIJ+WitUplllvdBd
	 dWQ2CLPltyrBQzepYd9/DmYQ/A2L8QPEJjcCNTuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732816AbfAKNqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:46:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728591AbfAKNqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:46:03 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 751122084C;
        Fri, 11 Jan 2019 13:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547214362;
        bh=oUhFWK+NKg04N6oO0fb5nzrty6X/Uo8qNEYG3ZLOZh8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sSFEcsVGEfEM8mqRkYEdkDHeeZwam9vxIPazDgsx2HN0VqZtQ/gZ/l3MCNpcYKL3C
         B6LgHHC9VVVA4KLQY+uwYuWDL5ElwDYmZF0lEfhpqZyYlLfhpZwNYRigM+TSq9CHne
         U3g/5jNn9OxrOXKTz4Bp2tPbJz7YAxC3Aqyc12Dg=
Date:   Fri, 11 Jan 2019 22:45:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] tracing/kprobes: fix NULL pointer dereference in
 trace_kprobe_create()
Message-Id: <20190111224559.4d55dafa75a20e3f2e55ab7b@kernel.org>
In-Reply-To: <20190111060113.GA22841@xps-13>
References: <20190111060113.GA22841@xps-13>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 07:01:13 +0100
Andrea Righi <righi.andrea@gmail.com> wrote:

> It is possible to trigger a NULL pointer dereference by writing an
> incorrectly formatted string to krpobe_events (trying to create a
> kretprobe omitting the symbol).
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
> Fix by doing the proper argument checks in trace_kprobe_create().

Thank you Andrea!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> 
> Link: https://lore.kernel.org/lkml/20190111095108.b79a2ee026185cbd62365977@kernel.org
> Fixes: 6212dd29683e ("tracing/kprobes: Use dyn_event framework for kprobe events")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  v2: argument check refactoring
> 
>  kernel/trace/trace_kprobe.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 5c19b8c41c7e..d5fb09ebba8b 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -607,11 +607,17 @@ static int trace_kprobe_create(int argc, const char *argv[])
>  	char buf[MAX_EVENT_NAME_LEN];
>  	unsigned int flags = TPARG_FL_KERNEL;
>  
> -	/* argc must be >= 1 */
> -	if (argv[0][0] == 'r') {
> +	switch (argv[0][0]) {
> +	case 'r':
>  		is_return = true;
>  		flags |= TPARG_FL_RETURN;
> -	} else if (argv[0][0] != 'p' || argc < 2)
> +		break;
> +	case 'p':
> +		break;
> +	default:
> +		return -ECANCELED;
> +	}
> +	if (argc < 2)
>  		return -ECANCELED;
>  
>  	event = strchr(&argv[0][1], ':');
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
