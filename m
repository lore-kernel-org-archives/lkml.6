Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362C6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0990A21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391928AbeLUU6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:58:37 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:36147 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390266AbeLUU6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:58:37 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43M1F64Y1Hz1qtG8;
        Fri, 21 Dec 2018 21:58:34 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43M1F61F6pz1qsJj;
        Fri, 21 Dec 2018 21:58:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ISVDhN9rwaSS; Fri, 21 Dec 2018 21:58:33 +0100 (CET)
X-Auth-Info: x0K/q70BaPsUJ9pjJPT7z2D6e+2O9auz10V58Cibf3gOEF9Bs/RcXdzkc2De367U
Received: from igel.home (ppp-188-174-150-84.dynamic.mnet-online.de [188.174.150.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 21 Dec 2018 21:58:33 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 4BBAD2C25D9; Fri, 21 Dec 2018 21:58:32 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [for-next][PATCH 23/24] string.h: Add strncmp_prefix() helper macro
References: <20181221175618.968519903@goodmis.org>
        <20181221175659.208858193@goodmis.org>
        <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
        <20181221144054.20bdeb33@gandalf.local.home>
        <CAHk-=wgSvRhj6KNRdn9gbK9RJVAswdtKSNjAxdf9O9vn04T5XQ@mail.gmail.com>
        <20181221153526.5e6055ca@gandalf.local.home>
        <077eeb8b09baebe78822819b5f15d671b738a2b2.camel@perches.com>
        <20181221155435.38a9a221@gandalf.local.home>
X-Yow:  My CODE of ETHICS is vacationing at famed SCHROON LAKE
 in upstate New York!!
Date:   Fri, 21 Dec 2018 21:58:32 +0100
In-Reply-To: <20181221155435.38a9a221@gandalf.local.home> (Steven Rostedt's
        message of "Fri, 21 Dec 2018 15:54:35 -0500")
Message-ID: <871s6ad2br.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dez 21 2018, Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 21 Dec 2018 12:46:47 -0800
> Joe Perches <joe@perches.com> wrote:
>
>> > + * @str: The string to test
>> > + * @prefix: The string to see if @str starts with
>> > + *
>> > + * A common way to test a prefix of a string is to do:
>> > + *  strncmp(str, prefix, sizeof(prefix) - 1)
>> > + *
>> > + * But this can lead to bugs due to typos, or if prefix is a pointer
>> > + * and not a constant. Instead use has_prefix().
>> > + *
>> > + * Returns: 0 if @str does not start with @prefix
>> > +         strlen(@prefix) if @str does start with @prefix
>> > + */
>> > +#define has_prefix(str, prefix)						\
>> > +	({								\
>> > +		const char *____prefix____ = (const char *)(prefix);	\
>> > +		int ____len____ = strlen(____prefix____);		\
>> > +		strncmp(str, ____prefix____, ____len____) == 0 ?	\
>> > +			____len____ : 0;				\
>> > +	})   
>> 
>> I think all the underscores are unnecessary and confusing.
>> 
>
> Well, perhaps I can just remove the ending ones. I get paranoid with
> macro variables, and tend to over do it so that there's no question.

Why not make it an inline function?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
