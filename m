Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACD5C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57ADF2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57ADF2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbeGZMBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:01:18 -0400
Received: from foss.arm.com ([217.140.101.70]:52276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbeGZMBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:01:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CB9180D;
        Thu, 26 Jul 2018 03:45:03 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6071A3F575;
        Thu, 26 Jul 2018 03:45:01 -0700 (PDT)
Date:   Thu, 26 Jul 2018 11:44:58 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, oleg@redhat.com,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        steve.mcintyre@arm.com, linux-arm-kernel@lists.infradead.org,
        ebiederm@xmission.com
Subject: Re: [PATCH 1/2] signal: Introduce COMPAT_SIGMINSTKSZ for use in
 compat_sys_sigaltstack
Message-ID: <20180726104456.GT4240@e103592.cambridge.arm.com>
References: <1532526312-26993-1-git-send-email-will.deacon@arm.com>
 <1532526312-26993-2-git-send-email-will.deacon@arm.com>
 <20180725155427.GR4240@e103592.cambridge.arm.com>
 <20180725163726.GE6866@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725163726.GE6866@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 05:37:26PM +0100, Will Deacon wrote:
> On Wed, Jul 25, 2018 at 04:54:27PM +0100, Dave Martin wrote:
> > On Wed, Jul 25, 2018 at 02:45:11PM +0100, Will Deacon wrote:
> > > @@ -3476,7 +3478,8 @@ int restore_altstack(const stack_t __user *uss)
> > >  	stack_t new;
> > >  	if (copy_from_user(&new, uss, sizeof(stack_t)))
> > >  		return -EFAULT;
> > > -	(void)do_sigaltstack(&new, NULL, current_user_stack_pointer());
> > > +	(void)do_sigaltstack(&new, NULL, current_user_stack_pointer(),
> > > +			     MINSIGSTKSZ);
> > 
> > Why can't this fail?
> > 
> > If this fails here we silently go wrong, but...
> > 
> > >  	/* squash all but EFAULT for now */
> > >  	return 0;
> > >  }
> > > @@ -3510,7 +3513,8 @@ static int do_compat_sigaltstack(const compat_stack_t __user *uss_ptr,
> > >  		uss.ss_size = uss32.ss_size;
> > >  	}
> > >  	ret = do_sigaltstack(uss_ptr ? &uss : NULL, &uoss,
> > > -			     compat_user_stack_pointer());
> > > +			     compat_user_stack_pointer(),
> > > +			     COMPAT_MINSIGSTKSZ);
> > 
> > If this fails on arm64, we seem to SEGV (see compat_sys_rt_sigreturn()).
> > 
> > This patch doesn't introduce this inconsistency, this might be a good
> > opportunity to clean it up.
> 
> I don't think there's an inconsistency here -- both restore_altstack and
> compat_restore_altstack suppress all non--EFAULT errors (remember that uoss
> is NULL in both cases, so the copy_from_user() immediately before the
> do_sigaltstack() call for the native path is all we care about). I think the
> behaviour is: on a sigreturn, if you set the altstack to be an unmapped
> address then you get a SEGV, otherwise if you make it invalid in some other
> way (e.g. too small) then it's ignored and the old altstack remains intact.

OK, I think I've satisfied myself that they do the same thing for now.

The code for the paths is a bit different, so it's not trivial to see
that they have the same effect...

Cheers
---Dave
