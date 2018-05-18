Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeERX6y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 19:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbeERX6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 19:58:51 -0400
Date: Sat, 19 May 2018 08:58:48 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+30d675e3ca03c1c351e7@syzkaller.appspotmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] uprobes/x86: remove the wrong WARN_ON() in
 uprobe_init_insn()
Message-Id: <20180519085848.e2b0be1ed752e3e35b7ba0ab@kernel.org>
In-Reply-To: <20180518162739.GA5559@redhat.com>
References: <000000000000b759cf056c2b3c12@google.com>
        <20180518162739.GA5559@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2018 18:27:39 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> insn_get_length() has the side-effect of processing the entire instruction
> but only if it was decoded successfully, otherwise insn_complete() can fail
> and in this case we need to just return an error without warning.
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> Reported-by: syzbot+30d675e3ca03c1c351e7@syzkaller.appspotmail.com
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  arch/x86/kernel/uprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 85c7ef2..efd7ee9 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -293,7 +293,7 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
>  	insn_init(insn, auprobe->insn, sizeof(auprobe->insn), x86_64);
>  	/* has the side-effect of processing the entire instruction */
>  	insn_get_length(insn);
> -	if (WARN_ON_ONCE(!insn_complete(insn)))
> +	if (!insn_complete(insn))
>  		return -ENOEXEC;
>  
>  	if (is_prefix_bad(insn))
> -- 
> 2.5.0
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
