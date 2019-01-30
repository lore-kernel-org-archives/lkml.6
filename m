Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2DDC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2819D21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfA3NK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:10:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfA3NK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:10:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D464142BE4;
        Wed, 30 Jan 2019 13:10:57 +0000 (UTC)
Received: from treble (ovpn-120-91.rdu2.redhat.com [10.10.120.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C70B608C4;
        Wed, 30 Jan 2019 13:10:51 +0000 (UTC)
Date:   Wed, 30 Jan 2019 07:10:49 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Alice Ferrazzi <alicef@alicef.me>, jeyu@kernel.org,
        jikos@kernel.org, mbenes@suse.cz, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: Re: [PATCH] livepatch: core: Return ENOTSUPP instead of ENOSYS
Message-ID: <20190130131049.gnhge73xvh62p3gl@treble>
References: <20190126192630.6163-1-alicef@alicef.me>
 <20190128194943.GA18515@redhat.com>
 <20190129165054.vyi7n6in5v2omkpu@treble>
 <20190130124156.qjtbvrkjctu6wi62@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130124156.qjtbvrkjctu6wi62@pathway.suse.cz>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 30 Jan 2019 13:10:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 01:41:56PM +0100, Petr Mladek wrote:
> Hmm, the error code is passed to the syscall, for example:
> 
> + SYSCALL_DEFINE3(init_module
>   + load_module()
>     + do_init_module()
>       + do_one_initcall(mod->init);
> 
> I am not sure if we are allowed to return -ENOTSUPP (-524).
> It is defined in the internal include/linux/errno.h. There
> is the following commnent:
> 
> /*
>  * These should never be seen by user programs...
> 
> 
> 
> I tried to find a better alternative and found:
> 
> #define	EOPNOTSUPP	95	/* Operation not supported on transport endpoint */
> 
> 
> There is the following note in man errno:
> 
>        ENOTSUP         Operation not supported (POSIX.1)
> 
>        EOPNOTSUPP      Operation not supported on socket (POSIX.1)
> 		       (ENOTSUP and EOPNOTSUPP have the same value
> 		       on Linux, but according to POSIX.1 these error
> 		       values should be distinct.)
> 
> And it looks that -EOPNOTSUPP is used widely in many subsystes (not
> only network).

Yes, you are right.  It's confusing that ENOTSUPP and ENOTSUP are not
the same thing.  EOPNOTSUPP sounds good.

-- 
Josh
