Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADE1C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B92020663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548067427;
	bh=jvzmMg9bLvi8nLvB4BlOLaUIKlbOlS9FjeNjM+o0MEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pmKQryqp5c5+M4RfTJMeT8mU+5c86c+wfITqudj83bX5Cd4IfWOBfaC+/qOk0GNJE
	 2JcJ6729Ikc6oQtTW3EQ0Cagp2jvlNZh5/rwylJ20lvTJqgv9IYMDoR8mlUptCygh/
	 caZMaSza2pIklh+FqQ5uSEbbJ3TBMhYCRJ4uq5rM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfAUKnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:43:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbfAUKno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:43:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ADED20663;
        Mon, 21 Jan 2019 10:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548067423;
        bh=jvzmMg9bLvi8nLvB4BlOLaUIKlbOlS9FjeNjM+o0MEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dPRLtPT4vcRFnJ5f8wFJJcZQJRBdI26bDNhFpBxcHqMW+zmdfIc7Nfx1AKEPGTf0U
         Bc7a9QqRtJMdDlwT18F7eiHUb+deFom1ioJbWP8olkuqyCwfxriUFxLSi/gS8BDBc/
         oqkssdSiq4eMpWT5ZF8KBLUOIe4YTBLFf6qOup4E=
Date:   Mon, 21 Jan 2019 11:43:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Xiaozhou Liu <lxz1983@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Compiler Attributes: move kernel-only attributes into
 __KERNEL__
Message-ID: <20190121104341.GB16002@kroah.com>
References: <20181128140852.178260-1-liuxiaozhou@bytedance.com>
 <CANiq72kzHqQ-M2Gyrf7iy1BQMabM6txChYwa8hrDkMmc3w8ORw@mail.gmail.com>
 <20181129021635.rzmehzzfgt2jvpgi@bytedancedeMacBook-Air.local>
 <CANiq72=uwbHqPB_1b7q+dD7FaqZ+HOmOvXMPX3d=z7-xqzwFzQ@mail.gmail.com>
 <20181206123926.q5gd5u62vg2u7s5w@bytedancedeMacBook-Air.local>
 <20181206124957.GA22907@kroah.com>
 <CANiq72kg+LvComNFkdXVjfE+ZQQt2bqABVH8Q_fSRzXMDJ7Nzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kg+LvComNFkdXVjfE+ZQQt2bqABVH8Q_fSRzXMDJ7Nzw@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 07:22:50PM +0100, Miguel Ojeda wrote:
> Hi Greg, Nick, Xiaozhou,
> 
> On Thu, Dec 6, 2018 at 1:50 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > If something is fixed in Linus's tree for this, I want to take it into
> > the 4.19-stable tree as well.
> 
> This ended up in Linus' tree before the holidays, i.e. 4.20 has it,
> see commit 71391bdd2e9a ("include/linux/compiler_types.h: don't
> pollute userspace with macro definitions").
> 
> In case you want to still backport this to 4.19: you can't cherry-pick
> it without conflicts because some stuff was moved around due to the
> Compiler Attributes patch series (which also went in with 4.20 too),
> but you can move the macros like this commit does. There are 2
> conflicts:
> 
>   * The big block of macros for attributes:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/include/linux/compiler_types.h?h=v4.19.16#n189
>   * The __always_inline macro:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/include/linux/compiler_types.h?h=v4.19.16#n275
> 
> All those are nowadays inside __KERNEL__ && !__ASSEMBLY__, so it
> should be fine to move those too along the rest that this patch moves.

I have no idea why I would want to backport this, sorry :(

If this resolves a problem, great, but someone has to do the backport
for me to be able to take it.

thanks,

greg k-h

> 
> Cheers,
> Miguel
