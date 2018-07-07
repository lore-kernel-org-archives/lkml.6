Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750F4C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017D821798
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017D821798
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754060AbeGGOnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:43:51 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:39869 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753549AbeGGOnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:43:50 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 5566030000623;
        Sat,  7 Jul 2018 16:43:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1F21236A1E; Sat,  7 Jul 2018 16:43:48 +0200 (CEST)
Date:   Sat, 7 Jul 2018 16:43:48 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: [PATCH 5/5] thunderbolt: Add support for runtime PM
Message-ID: <20180707144348.GA28036@wunner.de>
References: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
 <20180618110731.57427-6-mika.westerberg@linux.intel.com>
 <20180707133815.GA6656@wunner.de>
 <20180707142553.GP2534@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707142553.GP2534@lahna.fi.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 05:25:53PM +0300, Mika Westerberg wrote:
> On Sat, Jul 07, 2018 at 03:38:15PM +0200, Lukas Wunner wrote:
> > You're setting pm_runtime_no_callbacks() on the domain.  A side effect of
> > setting this flag is that whenever the domain's device is runtime resumed,
> > it's parent (the NHI) is *not* runtime resumed, see this comment in
> > rpm_resume():
> > 
> > 	/*
> > 	 * See if we can skip waking up the parent.  This is safe only if
> > 	 * power.no_callbacks is set, because otherwise we don't know whether
> > 	 * the resume will actually succeed.
> > 	 */
> > 
> > Above, you're runtime resuming the domain in boot_acl_show().  So if the
> > NHI is runtime suspended while that sysfs attribute is accessed, it won't
> > be runtime resumed.  Is that actually what you want?
> 
> No, it should be runtime resumed when domain is. Looking at the code in
> question bit more deeper:
[snip]
> So skipping waking the parent can only happen if any of the following
> conditions are true:
> 
>   - Parent has runtime PM disabled
>   - Parent has ignore_children set
>   - Parent is already resumed
> 
> As far I can tell there can't be situation you describe that the parent would
> not be runtime resumed when the domain is.

Okay, missed that.

Then why aren't you using pm_runtime_no_callbacks() on switches as well?
Wouldn't that obviate the need to declare those empty runtime PM callbacks?


> > BTW, what's the purpose of nhi_enable_int_throttling()?
> 
> It changes how fast interrupts get delivered and when to start throttling.
> Mostly needed in P2P functionality (but should not do any harm for control
> channel traffic). See also 8c6bba10fb92 ("thunderbolt: Configure interrupt
> throttling for all interrupts").

Understood, thanks.

Lukas
