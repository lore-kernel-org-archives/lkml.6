Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F235C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 07:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FED2208A6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 07:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FED2208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeGHHbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 03:31:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:31812 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752807AbeGHHbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 03:31:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2018 00:31:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,324,1526367600"; 
   d="scan'208";a="54840710"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga007.jf.intel.com with SMTP; 08 Jul 2018 00:31:30 -0700
Received: by lahna (sSMTP sendmail emulation); Sun, 08 Jul 2018 10:31:30 +0300
Date:   Sun, 8 Jul 2018 10:31:30 +0300
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
Message-ID: <20180708073130.GR2534@lahna.fi.intel.com>
References: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
 <20180618110731.57427-6-mika.westerberg@linux.intel.com>
 <20180707211401.GA13111@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707211401.GA13111@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 11:14:01PM +0200, Lukas Wunner wrote:
> On Mon, Jun 18, 2018 at 02:07:31PM +0300, Mika Westerberg wrote:
> > Implement this using standard Linux runtime PM APIs so that when all the
> > children devices are runtime suspended, the Thunderbolt host controller
> > PCI device is runtime suspended as well. The ICM firmware then starts
> > powering down power domains towards RTD3 but it can prevent this if it
> > detects that there is an active Display Port stream (this is not visible
> > to the software, though).
> > 
> > The Thunderbolt host controller will be runtime resumed either when
> > there is a remote wake event (device is connected or disconnected), or
> > when there is access from userspace that requires hardware access.
> 
> IIUC, if there is no xdomain, after 15 s all switch devices as well as
> the domain device and the NHI will have runtime suspended.  The control
> channel is torn down as well, so you can no longer receive notifications
> over it.  Then how is wakeup of the NHI signalled on hotplug/unplug?
> Do you get a PME for the NHI device?

Yes, it sends PME.

> Because I'm fairly certain that
> I do not get a PME for the Light Ridge in my MacBook Pro, but I'll test
> this once more and modify negotiate_os_control() to grant PME control
> to the OS.

I think in case of Apple hardware, they handle the in some different
means than PME (possibly part of chipset driver or ACPI method/event).
