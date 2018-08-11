Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C151CC46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DD122430
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DD122430
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeHKFS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 01:18:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60734 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbeHKFS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 01:18:29 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1foJub-0000QB-UZ; Sat, 11 Aug 2018 02:45:53 +0000
Date:   Sat, 11 Aug 2018 03:45:53 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Richard Henderson <rth@twiddle.net>
Cc:     Firoz Khan <firoz.khan@linaro.org>, linux-alpha@vger.kernel.org,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com
Subject: Re: [PATCH 3/6] alpha: Unify the not-implemented system call entry
 name
Message-ID: <20180811024553.GF6515@ZenIV.linux.org.uk>
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
 <1531736638-15294-4-git-send-email-firoz.khan@linaro.org>
 <20180811000455.GC6515@ZenIV.linux.org.uk>
 <98937991-cefa-b7f3-11c3-12727b3159b1@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98937991-cefa-b7f3-11c3-12727b3159b1@twiddle.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 07:31:55PM -0700, Richard Henderson wrote:

> > +++ b/arch/alpha/kernel/entry.S
> > @@ -473,7 +473,7 @@ entSys:
> >  	bne     $3, strace
> >  	beq	$4, 1f
> >  	ldq	$27, 0($5)
> > -1:	jsr	$26, ($27), alpha_ni_syscall
> > +1:	jsr	$26, ($27), sys_ni_syscall
> >  	ldgp	$gp, 0($26)
> >  	blt	$0, $syscall_error	/* the call failed */
> >  	stq	$0, 0($sp)
> 
> Once upon a time I had a patch to make the hint
> be sys_gettimeofday, as the most common syscall.
> Dunno what happened to that.

Might as well... ptraced case has it, non-ptraced doesn't.

BTW, seeing that it's your code - why was unop used in
alpha_ni_syscall?  I don't remember the rules re pipeline
stalls; is it that some earlier variants prefer unop to
nop in such places?  It's not that microoptimizing that
one makes any difference, but just out of curiosity -
would something like
	lda     $0, -ENOSYS
	stq     $sp, 0($sp)	/* sp != 0 */
	ret
do just as well there?
