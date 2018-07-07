Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F77C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BBD2174C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BBD2174C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932681AbeGGPyT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 11:54:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:22224 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932352AbeGGPyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 11:54:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jul 2018 08:54:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,320,1526367600"; 
   d="scan'208";a="65143950"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga003.jf.intel.com with SMTP; 07 Jul 2018 08:54:14 -0700
Received: by lahna (sSMTP sendmail emulation); Sat, 07 Jul 2018 18:54:14 +0300
Date:   Sat, 7 Jul 2018 18:54:14 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: [PATCH 5/5] thunderbolt: Add support for runtime PM
Message-ID: <20180707155414.GQ2534@lahna.fi.intel.com>
References: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
 <20180618110731.57427-6-mika.westerberg@linux.intel.com>
 <20180707133815.GA6656@wunner.de>
 <20180707142553.GP2534@lahna.fi.intel.com>
 <20180707144348.GA28036@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707144348.GA28036@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 04:43:48PM +0200, Lukas Wunner wrote:
> On Sat, Jul 07, 2018 at 05:25:53PM +0300, Mika Westerberg wrote:
> > On Sat, Jul 07, 2018 at 03:38:15PM +0200, Lukas Wunner wrote:
> > > You're setting pm_runtime_no_callbacks() on the domain.  A side effect of
> > > setting this flag is that whenever the domain's device is runtime resumed,
> > > it's parent (the NHI) is *not* runtime resumed, see this comment in
> > > rpm_resume():
> > > 
> > > 	/*
> > > 	 * See if we can skip waking up the parent.  This is safe only if
> > > 	 * power.no_callbacks is set, because otherwise we don't know whether
> > > 	 * the resume will actually succeed.
> > > 	 */
> > > 
> > > Above, you're runtime resuming the domain in boot_acl_show().  So if the
> > > NHI is runtime suspended while that sysfs attribute is accessed, it won't
> > > be runtime resumed.  Is that actually what you want?
> > 
> > No, it should be runtime resumed when domain is. Looking at the code in
> > question bit more deeper:
> [snip]
> > So skipping waking the parent can only happen if any of the following
> > conditions are true:
> > 
> >   - Parent has runtime PM disabled
> >   - Parent has ignore_children set
> >   - Parent is already resumed
> > 
> > As far I can tell there can't be situation you describe that the parent would
> > not be runtime resumed when the domain is.
> 
> Okay, missed that.
> 
> Then why aren't you using pm_runtime_no_callbacks() on switches as well?
> Wouldn't that obviate the need to declare those empty runtime PM callbacks?

Domain is a kind of object that does not have a real physical device. It
is just an abstraction of a Thunderbolt domain formed by the host
controller (NHI) and the connection manager.  Therefore we power manage
it with the parent device (NHI). This is pretty much the purpose of
pm_runtime_no_callbacks().

However, switches do have a real physical device that can be power
managed. Furthermore we may need to add switch specific power management
logic at some point.
