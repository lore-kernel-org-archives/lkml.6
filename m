Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965544AbeEIQjp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:39:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934647AbeEIQjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:39:44 -0400
Date: Wed, 9 May 2018 18:39:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH 2/2] uprobes: x86: Prohibit probing on MOV SS instruction
Message-ID: <20180509163939.GA26347@redhat.com>
References: <152587066475.17316.3035446966107675608.stgit@devbox>
 <152587072544.17316.5950935243917346341.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152587072544.17316.5950935243917346341.stgit@devbox>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09, Masami Hiramatsu wrote:
>
> Since MOV SS and POP SS instructions will delay the exceptions
> until the next instruction is executed, we should not do
> single-stepping on it by uprobes.
...
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -299,6 +299,10 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
>  	if (is_prefix_bad(insn))
>  		return -ENOTSUPP;
>  
> +	/* We should not singlestep on the exception masking instructions */
> +	if (insn_masking_exception(insn))
> +		return -ENOTSUPP;

Acked-by: Oleg Nesterov <oleg@redhat.com>
