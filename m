Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF26CC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938EB2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938EB2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeGYJyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:54:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:42949 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728357AbeGYJyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:54:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 01:43:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,400,1526367600"; 
   d="scan'208";a="74331041"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga004.fm.intel.com with SMTP; 25 Jul 2018 01:43:09 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 25 Jul 2018 11:43:10 +0300
Date:   Wed, 25 Jul 2018 11:43:09 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] thunderbolt: Add support for runtime PM
Message-ID: <20180725084309.GF2534@lahna.fi.intel.com>
References: <20180725080321.35746-1-mika.westerberg@linux.intel.com>
 <20180725080321.35746-7-mika.westerberg@linux.intel.com>
 <20180725081701.GA16930@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725081701.GA16930@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 10:17:01AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 25, 2018 at 11:03:20AM +0300, Mika Westerberg wrote:
> > When Thunderbolt host controller is set to RTD3 mode (Runtime D3) it is
> > present all the time. Because of this it is important to runtime suspend
> > the controller whenever possible. In case of ICM we have following rules
> > which all needs to be true before the host controller can be put to D3:
> > 
> >   - The controller firmware reports to support RTD3
> >   - All the connected devices announce support for RTD3
> >   - There is no active XDomain connection
> > 
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
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/thunderbolt/domain.c  |  42 +++++++++++-
> >  drivers/thunderbolt/icm.c     | 119 ++++++++++++++++++++++++++++++----
> >  drivers/thunderbolt/nhi.c     |  38 ++++++++++-
> >  drivers/thunderbolt/switch.c  |  65 +++++++++++++++++--
> >  drivers/thunderbolt/tb.h      |  10 +++
> >  drivers/thunderbolt/tb_msgs.h |   4 ++
> >  drivers/thunderbolt/xdomain.c |  18 +++++
> >  7 files changed, 276 insertions(+), 20 deletions(-)
> 
> 
> This patch did not apply to my tree at all, what branch did you make it
> against?

It is based on v4.18-rc2 but I missed the fact that 007a74907dee
("thunderbolt: Notify userspace when boot_acl is changed") touches
domain.c as well. I've just rebased this patch on top of your current
char-misc-testing and will be sending it to your direction in a moment.
Sorry about that.

> I've applied the others here, thanks.

Thanks!
