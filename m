Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26618ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BAB20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BAB20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbeGRJSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:18:00 -0400
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:43251 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbeGRJSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:18:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 6894218033786;
        Wed, 18 Jul 2018 08:41:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: soup81_271360bbf9a47
X-Filterd-Recvd-Size: 2194
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 18 Jul 2018 08:41:08 +0000 (UTC)
Message-ID: <93d979554b031755fafc03ded90560d3aaec40a3.camel@perches.com>
Subject: Re: [PATCH] x86: Avoid pr_cont() in show_opcodes()
From:   Joe Perches <joe@perches.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Wed, 18 Jul 2018 01:41:07 -0700
In-Reply-To: <8e7a3e658dbb928477639e0da67a5a204456b065.camel@perches.com>
References: <1530943625-3288-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
         <20180707111209.GA27768@gmail.com>
         <da14a295-3bff-f4bb-7c3e-f4126cda8d08@i-love.sakura.ne.jp>
         <12409dc4-c10a-d77a-f88d-165aa92b489e@rasmusvillemoes.dk>
         <f486debf-e824-0d0c-c0c9-cf1e278ee9eb@i-love.sakura.ne.jp>
         <218baff7-9473-ac1e-2449-13de98fa6dc9@rasmusvillemoes.dk>
         <2c8fe03e-36f5-5126-283c-cabc358a7d52@i-love.sakura.ne.jp>
         <8e7a3e658dbb928477639e0da67a5a204456b065.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 14:19 -0700, Joe Perches wrote:
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> []
> > @@ -93,26 +93,15 @@ static void printk_stack_address(unsigned long address, int reliable,
> >   */
> >  void show_opcodes(u8 *rip, const char *loglvl)
> >  {
> > -	unsigned int code_prologue = OPCODE_BUFSIZE * 2 / 3;
> > +	const unsigned int prologue = OPCODE_BUFSIZE * 2 / 3;
> 
> And this might be better as a #define to avoid
> a few more bytes of stack consumption.

Apologies for this silly suggestion.

automatics are not structs and gcc will eliminate
this declaration at all compiler optimization levels.
