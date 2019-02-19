Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4998C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8BC2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfBSLgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:36:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:37634 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727777AbfBSLgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:36:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3ECD8AD8F;
        Tue, 19 Feb 2019 11:36:34 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 9A298E0122; Tue, 19 Feb 2019 12:36:32 +0100 (CET)
Date:   Tue, 19 Feb 2019 12:36:32 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 12/21] ethtool: provide permanent
 hardware address in GET_INFO request
Message-ID: <20190219113632.GD23151@unicorn.suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
 <4e5879e36289c526dc79db37e55e5fc7d89d15fe.1550513384.git.mkubecek@suse.cz>
 <20190219102400.GC3080@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219102400.GC3080@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 11:24:00AM +0100, Jiri Pirko wrote:
> Mon, Feb 18, 2019 at 07:22:24PM CET, mkubecek@suse.cz wrote:
> >Add information about permanent hadware address of a device (as provided by
> >ETHTOOL_GPERMADDR ioctl command) in GET_INFO reply if ETH_INFO_IM_PERMADDR
> >flag is set in the request.
> >
> >There is no separate attribute for hardware address length as nla_len gives
> >this information. The reply also provides address type (net_device::type).
> >
> >Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> >---
> > Documentation/networking/ethtool-netlink.txt |  9 ++++-
> > include/uapi/linux/ethtool_netlink.h         | 12 +++++-
> > net/ethtool/info.c                           | 39 ++++++++++++++++++++
> > 3 files changed, 58 insertions(+), 2 deletions(-)
> >
> >diff --git a/Documentation/networking/ethtool-netlink.txt b/Documentation/networking/ethtool-netlink.txt
> >index b6999a2167e8..1e615e111262 100644
> >--- a/Documentation/networking/ethtool-netlink.txt
> >+++ b/Documentation/networking/ethtool-netlink.txt
> >@@ -239,6 +239,9 @@ Kernel response contents:
> >         ETHA_DRVINFO_FWVERSION		(string)	firmware version
> >         ETHA_DRVINFO_BUSINFO		(string)	device bus address
> >         ETHA_DRVINFO_EROM_VER		(string)	expansion ROM version
> >+    ETHA_INFO_PERMADDR		(nested)
> >+        ETHA_PERMADDR_ADDRESS		(binary)	permanent HW address
> 
> I think this is a nice example of thing that should not be exposed with
> ethtool but rather via rtnetlink, alongside with the actual hw address.
> 
> [...]

I guess you are right. As we don't have to query the driver and just
read the information from struct net_device, rtnetlink does indeed seem
more appropriate.

Michal
