Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713FAECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288982146F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Cwu2ChZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288982146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbeGQJcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:32:53 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37962 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbeGQJcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:32:53 -0400
Received: by mail-lf0-f67.google.com with SMTP id a4-v6so280610lff.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KFYtXehKt13DaWoTpc0385WJRkOF+xkM4v6NIlC+MLE=;
        b=Cwu2ChZyIY+hsMI5jBGlSxwxfD9bEA0DY/TTCrS0paHPJ9RsSvPkXM3jnZLL0C6zVi
         vsrXDReh4R6ycpjVYndvYq2oHIVEoEuAMCK6Wtli1IsQTww1wBnOg0OkUQ2E9yzoT/4g
         vty2hOAbnRqtN6D2vProw3SVbz8JeDLTuEHdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KFYtXehKt13DaWoTpc0385WJRkOF+xkM4v6NIlC+MLE=;
        b=oBbxRQPMMiaodKNkYwduuBcZ0qmwJrdze7McSsQrFr61PJZilJnpSuXwb+7DUZBoAx
         E524c9DxdbCEdLXxfckDGkMBUXWsqRoJsDS/jcx2dqkZJZmliddbhYIbTUabU2t4jqrw
         pEzz8VpggcVcPQ3R2NwA6BMvGaAOr/KgYg+eRF3Q1Lc0Hy3YWhIe2oV4ih1YbEKq342w
         kXpP1sPLPJ8BhPrgOtNNSATh+9ED4RVxVcgpJSmFcDNWNhx+d4KKy1z2DEotP7lxj4Hh
         DWYTzH9vST2YXdZtNNUz2EdXfqAKQtbZ85QqfZ4AuCM/ktc+Jd9keTL/IVzp+nVXV/5S
         F8Dw==
X-Gm-Message-State: AOUpUlHqjZe4hTw79O3DhH4Qxx43cEtcasKeOPW83l49SyyxyabYJS3Q
        kKntwqoBO2jYgbAFd6uQG2pQmA==
X-Google-Smtp-Source: AAOMgpdEz6RKmcp09w1/7HBmC92j3aBnUhYlBNz1bLbpxYjAMjCgQzLClfRkAAfalAe6bYxr3om6jA==
X-Received: by 2002:a19:73c9:: with SMTP id h70-v6mr668911lfk.61.1531818076543;
        Tue, 17 Jul 2018 02:01:16 -0700 (PDT)
Received: from [172.16.11.32] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z7-v6sm72509lfg.89.2018.07.17.02.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 02:01:16 -0700 (PDT)
Subject: Re: [PATCH] x86: Avoid pr_cont() in show_opcodes()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ingo Molnar <mingo@kernel.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1530943625-3288-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180707111209.GA27768@gmail.com>
 <da14a295-3bff-f4bb-7c3e-f4126cda8d08@i-love.sakura.ne.jp>
From:   Rasmus Villemoes <mail@rasmusvillemoes.dk>
Message-ID: <12409dc4-c10a-d77a-f88d-165aa92b489e@rasmusvillemoes.dk>
Date:   Tue, 17 Jul 2018 11:01:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <da14a295-3bff-f4bb-7c3e-f4126cda8d08@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-07 15:54, Tetsuo Handa wrote:
> On 2018/07/07 20:12, Ingo Molnar wrote:
>>
>> * Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>>
>>> From: Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>
>>>
>>> Since syzbot is confused by concurrent printk() messages [1],
>>> this patch changes show_opcodes() to use snprintf().
>>>
>>> When we start adding prefix to each line of printk() output,
>>> we will be able to handle concurrent printk() messages.
>>>
>>> [1] https://syzkaller.appspot.com/text?tag=CrashReport&x=139d342c400000
>>
>> Does this change the output?
>>
>> - If yes, could you show the before/after output in the changelog,
>>
>> - If not (i.e. if only the number of printk calls is changed, the output is the 
>>   same), could you say so in the changelog?
> 
> This patch will not change the output unless multiple threads concurrently
> call printk(). The purpose of this patch is to help parsing kernel messages
> when multiple threads are concurrently calling printk() for multiple times
> (e.g. backtrace) by reducing pr_cont()/KERN_CONT usage.
> 
>>
>> Also, 3*OPCODE_BUFSIZE+2+1 is 195 bytes - isn't that a bit too much on-stack 
>> footprint?
> 
> Then, we can reduce it by OPCODE_BUFSIZE bytes by unionizing opcodes[] and buf[].

Why not this instead? Less stack use, less code, no intermediary
snprintfs, no pr_cont...

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 666a284116ac..c881e8a757d9 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -93,26 +93,16 @@ static void printk_stack_address(unsigned long
address, int reliable,
  */
 void show_opcodes(u8 *rip, const char *loglvl)
 {
-       unsigned int code_prologue = OPCODE_BUFSIZE * 2 / 3;
+       unsigned int prologue = OPCODE_BUFSIZE * 2 / 3;
        u8 opcodes[OPCODE_BUFSIZE];
-       u8 *ip;
-       int i;

-       printk("%sCode: ", loglvl);
-
-       ip = (u8 *)rip - code_prologue;
-       if (probe_kernel_read(opcodes, ip, OPCODE_BUFSIZE)) {
-               pr_cont("Bad RIP value.\n");
+       if (probe_kernel_read(opcodes, rip - prologue, OPCODE_BUFSIZE)) {
+               printk("%sCode: Bad RIP value.\n", loglvl);
                return;
        }
-
-       for (i = 0; i < OPCODE_BUFSIZE; i++, ip++) {
-               if (ip == rip)
-                       pr_cont("<%02x> ", opcodes[i]);
-               else
-                       pr_cont("%02x ", opcodes[i]);
-       }
-       pr_cont("\n");
+       printk("%sCode: %*ph <%02x> %*ph\n", loglvl,
+              prologue, &opcodes[0], opcodes[prologue],
+              OPCODE_BUFSIZE - prologue - 1, &opcodes[prologue + 1]);
 }

 void show_ip(struct pt_regs *regs, const char *loglvl)

Not compile-tested, probably whitespace-damaged, but you get the idea.

Rasmus
