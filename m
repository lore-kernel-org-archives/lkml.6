Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C71CECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D842120831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D842120831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeJYKvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 06:51:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37700 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeJYKvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 06:51:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFVG7-0000YM-VH; Thu, 25 Oct 2018 02:20:28 +0000
Date:   Thu, 25 Oct 2018 03:20:27 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Joe Perches <joe@perches.com>
Cc:     Fengguang Wu <fengguang.wu@intel.com>, Willy Tarreau <w@1wt.eu>,
        David Miller <davem@davemloft.net>, wanghaifine@gmail.com,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        LKP <lkp@intel.com>, Philip Li <philip.li@intel.com>
Subject: Re: [PATCH] Change judgment len position
Message-ID: <20181025022027.GG32577@ZenIV.linux.org.uk>
References: <20181024154729.5312-1-wanghaifine@gmail.com>
 <20181024.101028.1211941922121897721.davem@davemloft.net>
 <61d94f2a5563db4d6580c8385c3b93c8eeb3669a.camel@perches.com>
 <20181024204852.GA25509@1wt.eu>
 <49ec92564284b5beb0a151bce1d537b51340d0a8.camel@perches.com>
 <20181025011111.bhbstq5wtrwk26b5@wfg-t540p.sh.intel.com>
 <dda151c160e42aeb07d158d9c7cd4c1a3341ab5f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda151c160e42aeb07d158d9c7cd4c1a3341ab5f.camel@perches.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 06:16:31PM -0700, Joe Perches wrote:
> On Thu, 2018-10-25 at 09:11 +0800, Fengguang Wu wrote:
> > CC Philip and LKP team.
> > > 	Please try to make your first patch in drivers/staging
> > > 	to get familiar with submitting patches to the kernel.
> > > 	https://kernelnewbies.org/FirstKernelPatch
> > > 
> > > Maybe there's utility in creating a filtering and auto-reply
> > > tool for first time patch submitters for all the vger mailing
> > > lists using some combination of previously known submitters
> > > and the 0-day robot to point those first time submitters of
> > > defective patches to kernelnewbies and staging.
> > 
> > Yeah good idea. That feature can be broken into 2 parts:
> > 
> > - an email script, which could be added to Linux scripts/ dir 
> > - maintain records for telling whether someone is first-time patch submitters
> 
> Maybe run checkpatch on those first-time submitter patches too.

OK, now I'm certain that you are trolling...

Joe, what really pisses me off is that it's actually at the expense of original
poster (who had nothing to do with the CoCup) *and* an invitation for a certain
variety of kooks.  In probably vain hope of heading that off, here's the
summary of what happened _before_ Joe started to stir the shit:

	* code in question is, indeed, (slightly) bogus in mainline.
It reads as "reject negative values for length, truncate positive ones to 4",
but in reality it's "treat everything outside of 0..4 as 4".  It's not broken
per se, but it's certainly misleading.
	* one possible fix would be to drop the "reject negative values"
completely, another - to move checking for negatives before the truncation.
Patch tried to do the latter.
	* the author of the patch has moved the check *too* early -
before the value being tested is even obtained.	It's obviously wrong - kernel
newbie or not.
	* I sincerely doubt that it was an attempt to introduce a backdoor,
albeit one would've been created if that patch went in as-is.  Genuine braino
is much more likely, and we'd all done such.
	* such brainos can be surprisingly hard to spot in one's code.
It's too obviously wrong, in a sense - you know what you've meant to write
and you keep seeing that instead of what you've actually written.  If you
are really unlucky, that might end up with a few days worth of debugging,
with eventual embarrassed "how the fuck have I managed not to notice that
previous twenty times I went over this function today?"  Been there,
done that, and so has everyone who'd actually written anything (other
than the worthless screeds, that is).
	* one thing the author of that patch could be blamed for (and most
of us have fucked up that way at one point or another) is not testing the
effect of the damn thing.  Modification is local, the change of behaviour -
simple and triggering that code is also trivial.  Checking that the patch
has done what you expect it to do would be simple and would've caught the
problem.
`
	Code of Conduct is garbage, but neither Dave nor the author
of this patch had anything to do with that mess.  If you want to make a point,
do so without shit splatter hitting innocent bystanders - people tend to
get very annoyed by that kind of thing, and with a damn good reason.
Sheesh...
