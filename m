Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF07C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3FD21773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547125897;
	bh=GbOeBpWB+htKNiWD2D794EUDwYV5XMDYhjd9tXtw68g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JqqY8K+s5vgK+gPzZAp4wwZErb4C6dDfNUsDKkQhZQvl0tTLjOrS1P3X03vwg6Mwn
	 wcRsrAw9QH/7NLW2YVHTjEVHW6aWVAn/LvjH37q7fAidZJ6YE4RiVmkdDKlMnWa1+1
	 3jwsW+pH6UT/HJNO1mjKgCxjqg/JwundKU0qm9Cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfAJNLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:11:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728131AbfAJNLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:11:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7206220879;
        Thu, 10 Jan 2019 13:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547125894;
        bh=GbOeBpWB+htKNiWD2D794EUDwYV5XMDYhjd9tXtw68g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jR7PCt7aElDElU64b30zNhbWaMB1N1mK3hpXBre6cpdiJ9ZXpYZ5lUjgj7dwmv/4L
         hTBf1ivsxZUrf198k3yk7JaD53XMScMjJWIjyuJu9xsi52Qn93j+/m7b8figfDldM9
         y2bsWIBrj93FK47owfkN4sdOUPrwqBU3geOciryc=
Date:   Thu, 10 Jan 2019 14:11:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Marc Dionne <marc.c.dionne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
Message-ID: <20190110131132.GC20217@kroah.com>
References: <git-mailbomb-linux-master-12209993e98c5fa1855c467f22a24e3d5b8be205@kernel.org>
 <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
 <20190109111951.5zvnj7ls6jv56p2u@linutronix.de>
 <20190109165235.GA8151@kroah.com>
 <20190109170935.e6b6rwzpk6dlruu4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109170935.e6b6rwzpk6dlruu4@linutronix.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 06:09:35PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-01-09 17:52:35 [+0100], Greg Kroah-Hartman wrote:
> > If there are no in-kernel users, the symbols should not be exported
> > anymore.  That's nothing new, we have always done this.
> 
> The thing is that we had
>   EXPORT_SYMBOL(__kernel_fpu_begin)
>   EXPORT_SYMBOL_GPL(kernel_fpu_begin)
> 
> and now __kernel_fpu_begin() is no longer exported and static only.

Ok, that is fine.

> All in kernel user (including the kvm module) use kernel_fpu_begin()
> which is not available to proprietary modules. Hence Marc's mail.

But since when did out-of-tree modules use __kernel_fpu_begin?  It's an
x86-only thing, and shouldn't really be used by anyone, right?

> > > On the other hand could we just drop EXPORT_SYMBOL_GPL? I doubt this
> > > helps in any way yet please correct me if I am wrong. 
> > 
> > Yes, it helps, please leave it as-is.
> 
> As you say. I only notice that certain things used to work and then no
> longer do because due to $rework it somehow become EXPORT_SYMBOL_GPL
> only and people complain and we tend to switch the export back to
> EXPORT_SYMBOL.

That is a different topic than the whole _GPL symbol export at all.
Please don't conflate the two.

> I'm not aware of a case where it actually helped in anyway.

The use of the _GPL symbol exports has helped in numerous places over
the years.  I'd be glad to discuss details over a beverage sometime :)

thanks,

greg k-h
