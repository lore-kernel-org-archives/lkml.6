Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932198AbeBSWCV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 17:02:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932089AbeBSWCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 17:02:20 -0500
Date: Mon, 19 Feb 2018 16:02:19 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] x86/dumpstack: Improve opcodes dumping in the Code:
 section
Message-ID: <20180219220219.lrnt2y6pcb7qyx4q@treble>
References: <20180219202826.19797-1-bp@alien8.de>
 <20180219202826.19797-4-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180219202826.19797-4-bp@alien8.de>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 09:28:24PM +0100, Borislav Petkov wrote:
>  bool in_task_stack(unsigned long *stack, struct task_struct *task,
> @@ -358,8 +362,8 @@ void die(const char *str, struct pt_regs *regs, long err)
>  
>  static int __init code_bytes_setup(char *s)
>  {
> -	ssize_t ret;
>  	unsigned long val;
> +	ssize_t ret;
>  
>  	if (!s)
>  		return -EINVAL;
> @@ -372,35 +376,37 @@ static int __init code_bytes_setup(char *s)
>  	if (code_bytes > 8192)
>  		code_bytes = 8192;
>  
> +	if (code_bytes > OPCODE_BUFSIZE) {
> +		u8 *new_buf = kzalloc(code_bytes, GFP_KERNEL);
> +		if (!new_buf)
> +			return -EINVAL;

S/EINVAL/ENOMEM/ ?

Otherwise the code looks good to me, and I like the new feature.

-- 
Josh
