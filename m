Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE86C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAFF20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAFF20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeJ3BWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:22:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:39406 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727461AbeJ3BWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:22:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3EE9EB07E;
        Mon, 29 Oct 2018 16:33:34 +0000 (UTC)
Date:   Mon, 29 Oct 2018 17:33:31 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     mkubecek@suse.cz, David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        rweikusat@mobileactivedefense.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>,
        junchi.chen@intel.com, Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: RFC: changed error code when binding unix socket twice
Message-ID: <20181029163331.GA31059@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20170630073448.GA9546@unicorn.suse.cz>
 <20180831111436.GA23780@dell5510>
 <CAK8P3a2yfZKMtE16DNCjZBOQ1R5=uXD16k43eJ=najJBh7H85Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2yfZKMtE16DNCjZBOQ1R5=uXD16k43eJ=najJBh7H85Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> On Fri, Aug 31, 2018 at 1:17 PM Petr Vorel <pvorel@suse.cz> wrote:
> > > commit 0fb44559ffd6 ("af_unix: move unix_mknod() out of bindlock") moves
> > > the special file creation in unix_bind() before u->bindlock is taken in
> > > order to avoid an ABBA deadlock with do_splice(). As a side effect, it
> > > also moves the check for existence of the special file (which would
> > > result in -EADDRINUSE) before the check of u->addr (which would result
> > > in -EINVAL if socket is already bound). This means that the error
> > > returned for an attempt to bind a unix socket to the same path twice
> > > changed from -EINVAL to -EADDRINUSE with this commit.

> > > One way to restore the old error code is indicated below but before
> > > submitting it, I would like to ask if we need/want it.

> > > Pro:
> > >   - in general, we do not want to change return code for given testcase
> > >   - old error (-EINVAL) is consistent with AF_INET(6)
> > > Con:
> > >   - both POSIX and Linux man page only list error conditions without
> > >     stating which should take precedence if more of them apply so
> > >     neither of them seems wrong, strictly speaking

> > I'd be for restoring the original behavior (be conservative + looks like as not intended).

> > Any comment from netdev maintainers?

> Naresh noticed that LTP now has a version check to  detect linux-4.10+ and
> expect a different return code from previous versions, but the 0fb44559ffd6
> commit that changed the behavior got backported to stable linux-4.4 and 4.9,
> so now LTP complains about those:

> https://bugs.linaro.org/show_bug.cgi?id=4042
Thanks for report.

> I don't care much which error code gets returned here, but I think we
> should either handle this consistently in all kernel versions and check for
> the one that is deemed the correct one on all versions, or change LTP
> again to accept either return code.
Do you mean to apply this patch to 3.16.y? (The only still maintained LTS branch
which miss this fix). Although the patch don't apply and it's very old branch,
it'd be easy to adjust it and it looks to me deadlock can happen there as well.

I guess we need to adjust LTP test to accept either return code as EOL longterm
branches probably will not take this patch.

>         Arnd

Kind regards,
Petr

