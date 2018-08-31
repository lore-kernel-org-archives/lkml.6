Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B28C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE912077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE912077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeHaTEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:04:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59944 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbeHaTEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:04:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DC6B7A9;
        Fri, 31 Aug 2018 07:56:17 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.emea.arm.com [10.4.13.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 722753F5BD;
        Fri, 31 Aug 2018 07:56:16 -0700 (PDT)
Date:   Fri, 31 Aug 2018 15:56:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2] kmemleak: Add option to print warnings to dmesg
Message-ID: <20180831145613.6cxtk3j5m4amxtoh@armageddon.cambridge.arm.com>
References: <20180827083821.7706-1-vincent.whitchurch@axis.com>
 <20180827151641.59bdca4e1ea2e532b10cd9fd@linux-foundation.org>
 <20180828101412.mb7t562roqbhsbjw@axis.com>
 <20180828102621.yawpcrkikhh4kagv@armageddon.cambridge.arm.com>
 <20180830074327.ivjq6g25lw7kpz2l@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830074327.ivjq6g25lw7kpz2l@axis.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:43:27AM +0200, Vincent Whitchurch wrote:
> On Tue, Aug 28, 2018 at 11:26:22AM +0100, Catalin Marinas wrote:
> > On Tue, Aug 28, 2018 at 12:14:12PM +0200, Vincent Whitchurch wrote:
> > > On Mon, Aug 27, 2018 at 03:16:41PM -0700, Andrew Morton wrote:
> > > > On Mon, 27 Aug 2018 10:38:21 +0200 Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> > > > > +config DEBUG_KMEMLEAK_WARN
> > > > > +	bool "Print kmemleak object warnings to log buffer"
> > > > > +	depends on DEBUG_KMEMLEAK
> > > > > +	help
> > > > > +	  Say Y here to make kmemleak print information about unreferenced
> > > > > +	  objects (including stacktraces) as warnings to the kernel log buffer.
> > > > > +	  Otherwise this information is only available by reading the kmemleak
> > > > > +	  debugfs file.
> > > > 
> > > > Why add the config option?  Why not simply make the change for all
> > > > configs?
> > > 
> > > No particular reason other than preserving the current behaviour for
> > > existing users.  I can remove the config option if Catalin is fine with
> > > it.
> > 
> > IIRC, in the early kmemleak days, people complained about it being to
> > noisy (the false positives rate was also much higher), so the default
> > behaviour was changed to monitor (almost) quietly with the details
> > available via debugfs. I'd like to keep this default behaviour but we
> > could have a "verbose" command via both debugfs and kernel parameter (as
> > we do with "off" and "on"). Would this work for you?
> 
> Either a config option or a parameter are usable for me.  How about
> something like this?  It can be enabled with kmemleak.verbose=1 or "echo
> 1 > /sys/module/kmemleak/parameters/verbose":

Works for me (slightly inconsistent with "echo ... >
/sys/kernel/debug/kmemleak" but a module_param seems to work better here
as it's a configuration rather than an action).

-- 
Catalin
