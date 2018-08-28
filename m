Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497E7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E2E2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E2E2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeH1ORY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:17:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35084 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbeH1ORX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:17:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C727D18A;
        Tue, 28 Aug 2018 03:26:25 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.emea.arm.com [10.4.13.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7DBE3F557;
        Tue, 28 Aug 2018 03:26:24 -0700 (PDT)
Date:   Tue, 28 Aug 2018 11:26:22 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2] kmemleak: Add option to print warnings to dmesg
Message-ID: <20180828102621.yawpcrkikhh4kagv@armageddon.cambridge.arm.com>
References: <20180827083821.7706-1-vincent.whitchurch@axis.com>
 <20180827151641.59bdca4e1ea2e532b10cd9fd@linux-foundation.org>
 <20180828101412.mb7t562roqbhsbjw@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828101412.mb7t562roqbhsbjw@axis.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 12:14:12PM +0200, Vincent Whitchurch wrote:
> On Mon, Aug 27, 2018 at 03:16:41PM -0700, Andrew Morton wrote:
> > On Mon, 27 Aug 2018 10:38:21 +0200 Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -593,6 +593,15 @@ config DEBUG_KMEMLEAK_DEFAULT_OFF
> > >  	  Say Y here to disable kmemleak by default. It can then be enabled
> > >  	  on the command line via kmemleak=on.
> > >  
> > > +config DEBUG_KMEMLEAK_WARN
> > > +	bool "Print kmemleak object warnings to log buffer"
> > > +	depends on DEBUG_KMEMLEAK
> > > +	help
> > > +	  Say Y here to make kmemleak print information about unreferenced
> > > +	  objects (including stacktraces) as warnings to the kernel log buffer.
> > > +	  Otherwise this information is only available by reading the kmemleak
> > > +	  debugfs file.
> > 
> > Why add the config option?  Why not simply make the change for all
> > configs?
> 
> No particular reason other than preserving the current behaviour for
> existing users.  I can remove the config option if Catalin is fine with
> it.

IIRC, in the early kmemleak days, people complained about it being to
noisy (the false positives rate was also much higher), so the default
behaviour was changed to monitor (almost) quietly with the details
available via debugfs. I'd like to keep this default behaviour but we
could have a "verbose" command via both debugfs and kernel parameter (as
we do with "off" and "on"). Would this work for you?

-- 
Catalin
