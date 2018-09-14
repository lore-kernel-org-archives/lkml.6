Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6281FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE9320671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE9320671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeINUZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:25:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35264 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbeINUZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:25:12 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0pjX-00088I-Dx; Fri, 14 Sep 2018 15:10:11 +0000
Date:   Fri, 14 Sep 2018 16:10:11 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHES] tty ioctls cleanups, compat and not only
Message-ID: <20180914151011.GZ19965@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <CAK8P3a2LpC6sw5KQ_6kcXKNfgUXkjsxbFkD30kdMgQjurGgy9Q@mail.gmail.com>
 <20180913203145.GU19965@ZenIV.linux.org.uk>
 <CAK8P3a3LD58jnwP38OpnEWHMzAAfrqtfjHamWVU5PwaKoWyKjg@mail.gmail.com>
 <20180914022737.GX19965@ZenIV.linux.org.uk>
 <CAK8P3a0wN0uMZdj-mxXwbN9AnZjHzMU6_b01H5y+Vpdt+UoeAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0wN0uMZdj-mxXwbN9AnZjHzMU6_b01H5y+Vpdt+UoeAw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 10:21:53AM +0200, Arnd Bergmann wrote:

> This does sound very appealing, but there is a small downside:
> The difference between ".compat_ioctl = NULL" and
> ".compat_ioctl=native_ioctl" is now very subtle, and I wouldn't
> necessarily expect casual readers to understand that.

???

One is "all non-generics take pointers to wordsize-neutral objects",
another "all non-generics take integers".

That solution certainly needs to be documented more than just in commit
message, though; IMO the method descriptions next to declaration are the
best place for that.  Will update...

> If we go with my file_operations patch for generic_compat_ioctl_ptrarg
> and add generic_compat_ioctl_intarg, we can do the same thing here
> with ldisc_compat_ioctl_ptrarg/ldisc_compat_ioctl_intarg to make it
> a little more consistent with fops and self-documenting.

No, we can't - ldisc ->ioctl() (or ->compat_ioctl()) doesn't get ldisc
in arguments.  Besides, indirect calls are costly these days...

> +        if (retval == -ENOIOCTLCMD && _IOC_TYPE(cmd) == 'T') {
> +                 retval = tty_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
> +                 WARN_ON_ONCE(retval != -ENOIOCTLCMD && retval != -ENOTTY);
> +        }
> 
> Seeing that you list every single 'T' command in tty_compat_ioctl()
> that we handle in the native case, that WARN_ON_ONCE should not
> trigger for any input, but it would catch (and warn about) any of those
> that might get added in the future to the native code path without the
> compat entry.

Anything adding new ioctls needs careful review anyway.  And blind bets upon
that stuff taking compat pointer are, AFAICS, completely unfounded.
