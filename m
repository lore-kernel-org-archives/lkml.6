Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6E2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B211214E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B211214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeLETk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:40:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:19844 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbeLETk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:40:57 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 11:40:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,319,1539673200"; 
   d="scan'208";a="98359884"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga006.jf.intel.com with SMTP; 05 Dec 2018 11:40:52 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 05 Dec 2018 21:40:51 +0200
Date:   Wed, 5 Dec 2018 21:40:51 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-bluetooth@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Kay Sievers <kay.sievers@vrfy.org>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 BlueZ] hid2hci: Fix udev rules for linux-4.14+
Message-ID: <20181205194051.GU9144@intel.com>
References: <20180620164240.6535-1-ville.syrjala@linux.intel.com>
 <20181204204117.14964-1-ville.syrjala@linux.intel.com>
 <20181205070621.GE16346@kroah.com>
 <20181205154032.GT9144@intel.com>
 <20181205192036.GB434@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181205192036.GB434@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 08:20:36PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Dec 05, 2018 at 05:40:32PM +0200, Ville Syrjälä wrote:
> > On Wed, Dec 05, 2018 at 08:06:21AM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Dec 04, 2018 at 10:41:17PM +0200, Ville Syrjala wrote:
> > > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > 
> > > > Since commit 1455cf8dbfd0 ("driver core: emit uevents when
> > > > device is bound to a driver") the kernel started emitting
> > > > "bind" and "unbind" uevents which confuse the hid2hci
> > > > udev rules.
> > > > 
> > > > The symptoms on an affected machine (Dell E5400 in my case)
> > > > include bluetooth devices not appearing and udev hogging
> > > > the cpu as it's busy processing a constant stream of these
> > > > "bind"+"unbind" uevents.
> > > 
> > > What is causing a "stream" of bind and unbind events?  This only happens
> > > when a device is attached to a driver or removed from a driver, which is
> > > caused by something else happening.
> > 
> > Not sure if it's just due to this thing causing devices to
> > appear/disappear during bind/unbind events or what.
> 
> Someone has to be telling the kernel to bind/unbind from a driver to
> a device, it doesn't do it on its own.  Look at your other rules/scripts
> for that.
> 
> Also note that the kernel has been doing this for over a year now (since
> 4.l4), what just happened in 4.19 to cause this to be an issue?

It became an issue for me after I got a machine that suffers from
this. The regression has been present ever since commit 1455cf8dbfd0
("driver core: emit uevents when device is bound to a driver").

You need a Dell E5400 or something similar to see it since those
have these magic bluetooth devices or whatever.

> 
> > > This should not be a normal
> > > occurance, unless something odd is happening to your hardware?
> > 
> > It's not specific to my hardware. Lot's of people are affected.
> > See eg. 
> > https://bugs.launchpad.net/ubuntu/+source/systemd/+bug/1759836
> > 
> > Acutally looking through that bug it seems someone else noticed
> > hid2hci failing lot in the logs. So maybe it's just that we already
> > switched the mode during "add", and then we try to redo the same
> > thing during "bind" which fails, and that then causes and unbind?
> 
> You have to manually unbind the device, the kernel does not do that.  So
> perhaps you have a broken udev rule somewhere else that would do
> something odd like unbind/bind?
> 
> I don't see this happening on my systems, but hey, I know better than to
> run Ubuntu :)

As do I. And you don't see it because you don't have the right
hardware.

-- 
Ville Syrjälä
Intel
