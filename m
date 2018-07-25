Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E9BC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD635205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD635205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeGYRtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:49:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41946 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728633AbeGYRtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:49:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDD6080D;
        Wed, 25 Jul 2018 09:37:26 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BEBBA3F575;
        Wed, 25 Jul 2018 09:37:26 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id BBF9A1AE1110; Wed, 25 Jul 2018 17:37:26 +0100 (BST)
Date:   Wed, 25 Jul 2018 17:37:26 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, oleg@redhat.com,
        linux@dominikbrodowski.net, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, steve.mcintyre@arm.com,
        linux-arm-kernel@lists.infradead.org, ebiederm@xmission.com
Subject: Re: [PATCH 1/2] signal: Introduce COMPAT_SIGMINSTKSZ for use in
 compat_sys_sigaltstack
Message-ID: <20180725163726.GE6866@arm.com>
References: <1532526312-26993-1-git-send-email-will.deacon@arm.com>
 <1532526312-26993-2-git-send-email-will.deacon@arm.com>
 <20180725155427.GR4240@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725155427.GR4240@e103592.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 04:54:27PM +0100, Dave Martin wrote:
> On Wed, Jul 25, 2018 at 02:45:11PM +0100, Will Deacon wrote:
> > @@ -3476,7 +3478,8 @@ int restore_altstack(const stack_t __user *uss)
> >  	stack_t new;
> >  	if (copy_from_user(&new, uss, sizeof(stack_t)))
> >  		return -EFAULT;
> > -	(void)do_sigaltstack(&new, NULL, current_user_stack_pointer());
> > +	(void)do_sigaltstack(&new, NULL, current_user_stack_pointer(),
> > +			     MINSIGSTKSZ);
> 
> Why can't this fail?
> 
> If this fails here we silently go wrong, but...
> 
> >  	/* squash all but EFAULT for now */
> >  	return 0;
> >  }
> > @@ -3510,7 +3513,8 @@ static int do_compat_sigaltstack(const compat_stack_t __user *uss_ptr,
> >  		uss.ss_size = uss32.ss_size;
> >  	}
> >  	ret = do_sigaltstack(uss_ptr ? &uss : NULL, &uoss,
> > -			     compat_user_stack_pointer());
> > +			     compat_user_stack_pointer(),
> > +			     COMPAT_MINSIGSTKSZ);
> 
> If this fails on arm64, we seem to SEGV (see compat_sys_rt_sigreturn()).
> 
> This patch doesn't introduce this inconsistency, this might be a good
> opportunity to clean it up.

I don't think there's an inconsistency here -- both restore_altstack and
compat_restore_altstack suppress all non--EFAULT errors (remember that uoss
is NULL in both cases, so the copy_from_user() immediately before the
do_sigaltstack() call for the native path is all we care about). I think the
behaviour is: on a sigreturn, if you set the altstack to be an unmapped
address then you get a SEGV, otherwise if you make it invalid in some other
way (e.g. too small) then it's ignored and the old altstack remains intact.

Will
