Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D319EECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B8B20856
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B8B20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbeGPNOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:14:47 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63437 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbeGPNOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:14:47 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6GClQV0059301;
        Mon, 16 Jul 2018 21:47:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Mon, 16 Jul 2018 21:47:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6GClLQ6059216
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 16 Jul 2018 21:47:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] x86: Avoid pr_cont() in show_opcodes()
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1530943625-3288-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180707111209.GA27768@gmail.com>
 <da14a295-3bff-f4bb-7c3e-f4126cda8d08@i-love.sakura.ne.jp>
Message-ID: <77efbc52-60d0-c41b-640c-dfd0577192a2@i-love.sakura.ne.jp>
Date:   Mon, 16 Jul 2018 21:47:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <da14a295-3bff-f4bb-7c3e-f4126cda8d08@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, is this patch acceptable?

On 2018/07/07 22:54, Tetsuo Handa wrote:
>From 61752cef56fad2a910f6bfd277e1b9b028aeab43 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sat, 7 Jul 2018 22:45:30 +0900
> Subject: [PATCH v2] x86: Avoid pr_cont() in show_opcodes()
> 
> Since syzbot is confused by concurrent printk() messages [1], this patch
> changes show_opcodes() to use snprintf(). By this change, the Code: line
> will always be printed as one line even if multiple threads concurrently
> called printk().
> 
> To save on-stack footprint, this patch shares opcodes[] and buf[] because
> we sequentially reads from opcodes[] and sequentially writes to buf[].
> 
> When we start adding prefix to each line of printk() output,
> we will be able to handle concurrent printk() messages.
> 
> [1] https://syzkaller.appspot.com/text?tag=CrashReport&x=139d342c400000
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> ---
>  arch/x86/kernel/dumpstack.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index 666a284..6408123 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -94,25 +94,27 @@ static void printk_stack_address(unsigned long address, int reliable,
>  void show_opcodes(u8 *rip, const char *loglvl)
>  {
>  	unsigned int code_prologue = OPCODE_BUFSIZE * 2 / 3;
> -	u8 opcodes[OPCODE_BUFSIZE];
>  	u8 *ip;
>  	int i;
> -
> -	printk("%sCode: ", loglvl);
> +	int pos = 0;
> +	char buf[(3 * OPCODE_BUFSIZE + 2) + 1];
> +	u8 *opcodes = (u8 *) buf + sizeof(buf) - OPCODE_BUFSIZE;
>  
>  	ip = (u8 *)rip - code_prologue;
>  	if (probe_kernel_read(opcodes, ip, OPCODE_BUFSIZE)) {
> -		pr_cont("Bad RIP value.\n");
> +		printk("%sCode: Bad RIP value.\n", loglvl);
>  		return;
>  	}
>  
>  	for (i = 0; i < OPCODE_BUFSIZE; i++, ip++) {
>  		if (ip == rip)
> -			pr_cont("<%02x> ", opcodes[i]);
> +			pos += snprintf(buf + pos, sizeof(buf) - pos,
> +					"<%02x> ", opcodes[i]);
>  		else
> -			pr_cont("%02x ", opcodes[i]);
> +			pos += snprintf(buf + pos, sizeof(buf) - pos,
> +					"%02x ", opcodes[i]);
>  	}
> -	pr_cont("\n");
> +	printk("%sCode: %s\n", loglvl, buf);
>  }
>  
>  void show_ip(struct pt_regs *regs, const char *loglvl)
> 

