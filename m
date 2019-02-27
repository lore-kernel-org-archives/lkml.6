Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F74C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AD220842
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfB0Jhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:37:40 -0500
Received: from mga01.intel.com ([192.55.52.88]:43606 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbfB0Jhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:37:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 01:37:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,419,1544515200"; 
   d="scan'208";a="150387597"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 27 Feb 2019 01:37:37 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 27 Feb 2019 11:37:36 +0200
Date:   Wed, 27 Feb 2019 11:37:36 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] platform/x86: intel_cht_int33fe: Start using
 software nodes
Message-ID: <20190227093736.GC27730@kuha.fi.intel.com>
References: <20190219115959.55553-1-heikki.krogerus@linux.intel.com>
 <d0e10d6f-efb5-0139-d6c9-edb66c97c0b6@redhat.com>
 <20190225154823.GA2808@kuha.fi.intel.com>
 <be150dea-7c55-f0f4-501f-5818e0b3873c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be150dea-7c55-f0f4-501f-5818e0b3873c@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 08:14:55PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 25-02-19 16:48, Heikki Krogerus wrote:
> > On Fri, Feb 22, 2019 at 05:31:32PM +0100, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 2/19/19 12:59 PM, Heikki Krogerus wrote:
> > > > Hi guys,
> > > > 
> > > > The software nodes support node hierarchy. By using them with fusb302
> > > > we can add a separate fwnode also for the USB connector as a child of
> > > > fusb302. We can then use the "standard" USB connector device
> > > > properties with the connector node, and stop using the deprecated
> > > > fusb302 specific properties.
> > > > 
> > > > Since the goal is to ultimately move to the software node API from the
> > > > old device property API, converting also max17047 in this series.
> > > > 
> > > > If you test this now (before v5.1-rc1 is out), then the series depends
> > > > Greg's latest usb-next:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/log/?h=usb-next
> > > > 
> > > > and on a patch in Rafael's latest linux-next branch:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=344798206f171c5abea7ab1f9762fa526d7f539d
> > > 
> > > Interesting series, I like the direction this is heading in.
> > > 
> > > Question, I currently have this hack to test DP over Type-C on the
> > > GPD-pocket / GPD-win:
> > > 
> > > https://github.com/jwrdegoede/linux-sunxi/commit/f481b7032030dcdda1ccc39875eb59f996d3e775
> > > 
> > > Do this properly we need to add alt-modes support for usb-c-connector nodes to:
> > > Documentation/devicetree/bindings/connector/usb-connector.txt
> > 
> > Yes, this is a topic I wanted to talk about.
> > 
> > > Do you have any ideas for what the binding this should look like, we need to
> > > specify a svid, mode and vdo tripple in this case. Maybe use an u32 array
> > > with 3, 6, 9, ... entries depending on how much alt-modes the fwnode needs to
> > > specify ?
> > 
> > My idea was to use sub-nodes, i.e. every alt mode a connector supports
> > would need to have its own child node under the connector node. Those
> > sub-nodes could then have a device property "svid" and another device
> > property "vdo", etc.
> 
> Right, after sending this mail I realized myself that using child-nodes
> to group the svid and vdo together was the right answer. So we
> could add child-nodes with a binding like this:
> 
> Optionally an "usb-c-connector" can have child nodes, describing
> supported alt-modes.
> 
> Required properties for usb-c-connector altmode child-nodes:
> compatible:  "usb-type-c-altmode"
> svid:        integer, Standard or Vendor ID for the altmode (u16 stored in an u32) property and an u32
> vdo:         integer, Vendor Data Object, VDO describing the altmode capabilies, SVID specific
> 
> I'm not sure if we also need to specify the altmode index here, or
> we simple assign each alt-mode an index while enumerating?

I don't think we need the index. SVID and VDO are enough.

> > I think that approach would be OK in DT, and we can now support it also
> > with the software nodes, and even in ACPI there are now something
> > called "data nodes" which can be used for this purpose.
> 
> Ack.
> 
> > There are some questions though. That "USB connector" node description
> > relies on OF graph, so should we just extend those "endpoint" nodes
> > (which are sub-nodes), or should be still have dedicated sub-nodes for
> > the alt modes? I think we may need dedicated nodes for the alt modes
> > in any case if we choose to use this approach.
> 
> Right I'm thinking dedicated nodes for the alt modes.
> 
> I guess an alt-mode could have a port child-node to point to say the
> DisplayPort pins / mux connection ?  I'm not entirely sure how the graph
> stuff will work here, but I guess that from a DT pov it will be desirable
> to be able to describe where the datalines for the alt-mode come from,
> maybe in combination with what the "mux/select" value is for the mux ???

I don't know what is the correct approach here. In a way it would feel
logical to assign the mux connection to the alt mode child-node, but
on the other hand the alt mode child-nodes are not real "device nodes"
that represent some physical device like the connector node does. The
alt mode child-node is more like a representation of a device
function. It is unlikely that a connector has multiple muxes to deal
with even when it supports multiple alt modes.

I think if I had to vote on this, I would prefer to link the muxing
with the connector node, and not the alt mode child-node.


thanks,

-- 
heikki
