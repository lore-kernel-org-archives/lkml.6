Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C2DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F022077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F022077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeIERys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:54:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:63490 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbeIERyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:54:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 06:24:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,333,1531810800"; 
   d="scan'208";a="87402771"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 05 Sep 2018 06:24:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 05 Sep 2018 16:24:29 +0300
Date:   Wed, 5 Sep 2018 16:24:29 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     whitequark <whitequark@whitequark.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: USB type-C altmode support for UCSI
Message-ID: <20180905132429.GB25121@kuha.fi.intel.com>
References: <1e8398f2c1790890f40b69f12e2934e3@whitequark.org>
 <20180903140623.GD15112@kuha.fi.intel.com>
 <28522bb57c5d8f49416b9174b19b1625@whitequark.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28522bb57c5d8f49416b9174b19b1625@whitequark.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Mika, Mario, LKML

On Mon, Sep 03, 2018 at 02:17:46PM +0000, whitequark wrote:
> After looking through LKML, I've seen that people refer to you when
> discussing issues with USB-C device compatibility. Do you think you
> could help me with an Apple Thunderbolt 2 to 3 adapter? I've spent
> quite a while studying USB-C, reverse engineering platform and
> adapter firmware and so on, and I'm quite stumped.
> 
> I have a Dell XPS13 laptop. UCSI advertises port altmodes
> 8087:00000001, ff01:00001c46, 413c:00000001, in that order.
> When I plug in the adapter, UCSI advertises partner altmode
> 8087:00000001. A billboard class device enumerates. Nothing else
> happens; the Thunderbolt NHI device doesn't appear, and if I force
> it to appear via the WMI hook, there are no Thunderbolt events,
> and the only device on the Thunderbolt bus is the root switch.

Can you tell which XPS 13 model you have (9360 or 9370 or ...)?

> I made an USB PD sniffer. Here's the exchange that happens
> when I plug the adapter in (GOOD CRC and initial PDO stuff omitted):
> 
> -> REQ Disc Ident SVID:0xff00
> <- ACK Disc Ident SVID:0xff00 VDO:0x6c0005ac VDO:0x00000000 VDO:0x16570348
> VDO:1000000a
> -> REQ Disc SVID SVID:0xff00
> <- ACK Disc SVID SVID:0xff00 VDO:0x808705ac VDO:0x00000000
> -> REQ Disc Mode SVID:0x8087
> <- ACK Disc Mode SVID:0x8087 VDO:0x00010001
> 
> Nothing happens after that.
> 
> I'm a bit puzzled as to why the ACK Disc Mode has a VDO 0x00010001
> and not 0x00000001 as UCSI reports, which is also what I would expect
> from a Thunderbolt device. Am I misunderstanding something in the spec?

I don't have access to the Thunderbolt alt mode spec unfortunately, so
I can't really say what the VDO should be, but I do know that that is
what UCSI reports on all platforms. The VDO value is always 1 on the
first port, and 2 on the second.

> This laptop doesn't support SET_NEW_CAM command so I can't do anything
> laptop-side. I can probably modify adapter firmware if I know what to
> change, but I'm not sure why this doesn't work in the first place.

I don't really see any problems with USB Type-C here. The PD
controller seems to take the steps that it should take when a device
is plugged to the connector: It checks the identity, SVIDs and their
modes, etc. I don't know based on that sniffer output has the
Thunderbolt alternate mode been entered or not, but I would imagine
the PD controller does not try to enter any modes unless the
Thunderbolt controller explicitly tells it to do so.

So I think the problem is with Thunderbolt in this case. Mika is the
man to talk about Thundebolt.

> (There's also an UCSI bug where no notifications appear when connecting
> a device, only when disconnecting and only once, but it can be worked
> around by reloading the module, so it isn't critical. Not sure what's up
> with that either.)

This is indeed a separate issue, and you are the second person that
reports it. Either the (EC) firmware on those laptops is not
generating the connection event as is should for some reason, or the
EC driver in Linux kernel fails to deliver the event to the UCSI
driver. I don't have XPS 13 that I could use to reproduce the issue
unfortunately.

Mario! Can you help with this?


Thanks,

-- 
heikki
