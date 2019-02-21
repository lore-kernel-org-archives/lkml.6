Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84620C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2B72148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfBUJym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:54:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:56030 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbfBUJym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:54:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 403E0AE9D;
        Thu, 21 Feb 2019 09:54:40 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 4A25DE00A5; Thu, 21 Feb 2019 10:54:39 +0100 (CET)
Date:   Thu, 21 Feb 2019 10:54:39 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 00/21] ethtool netlink interface, part 1
Message-ID: <20190221095439.GM23151@unicorn.suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
 <1cef1440-7345-a9a0-eab8-ab1c79c0d075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cef1440-7345-a9a0-eab8-ab1c79c0d075@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 07:21:18PM -0800, Florian Fainelli wrote:
> > Main changes between RFC v2 and RFC v3:
> > 
> > - do not allow building as a module (no netdev notifiers needed)
> 
> I would very much prefer that we could build this as a module. Some
> systems might be memory constrained or opt to disable ethtool entirely
> (security?). If this is not too much trouble, can we try to maintain that?

There were two reasons why I agreed so quickly to the suggestion to make
CONFIG_ETHTOOL a bool:

1. I didn't really think there would be anyone who would benefit from
having the interface as a loadable module and the only reason why I made
it possible originally was that it was easier to test changes that way.
That was rather poor reason for keeping it once submitted but if there
is an actual demand from real life users, it's something different.

2. Using of ethtool netdev notifiers for triggering netlink
notifications from other code (mostly ioctl interface) was rather
clumsy. However, it could be worked around using an RCU pointer and some
simple helpers (as discussed in the devlink thread) so this not not
a serious problem either.

> > - some features provided by ethtool would rather belong to devlink (and
> >   some are already superseded by devlink); however, only few drivers
> >   provide devlink interface at the moment and as recent discussion on
> >   flashing revealed, we cannot rely on devlink's presence
> 
> Should we just move everything under devlink given that ethtool over
> netlink or devlink are essentially manipulating the same (or close to)
> objects? It seems to me that at least now is the right time to make
> decisions about what should stay in ethtool and be offered via netlink,
> what should be migrated to something else (e.g.: Jiri mentioned
> rtnetlink), and what is a devlink candidate.
> 
> How do we proceed to easily triage which of these netlink facilities
> should things be routed to/from?

At the moment I would say the likely candidates for rtnetlink are
permanent hw address (ethtool -P), netdev features (-k / -K) and link
state (part of "ethtool <dev>"). (I'm not very happy about the prospect
of moving netdev features to rtnetlink but it seems hard to argue why
they shouldn't belong there.) As for devlink, I would see eeprom dump
(-e) and write (-E), register dump (-d), firmware dump (-w / -W) and
flash (-f), and module eeprom dump (-m) as candidates. Maybe also device
reset (--reset) (which was put into ethtool_ops, though, even if added
only recently).

There is also another question: at which level to do the split.

I would like to avoid doint it between user and ethtool utility, i.e.
dropping some functions from ethtool and pointing people to iproute2
tools (or even replacing ethtool with some new tool). There is the
"ifconfig memento": 20 years after it became obsolete, I still keep
hearing people say "I don't want to learn some new tool with unfamiliar
syntax". (Some of them learning to use ifconfig few years ago doesn't
really help. Neither them saying the same about ss which copied the most
of netstat's basic options.) I'm afraid the result would be exactly the
same with ethtool.

Then there is an option of providing the functions in ethtool but using
both ethtool netlink and devlink (and probably also rtnetlink) to talk
to kernel. This means a bit more complicated userspace code but nothing
serious. The bigger problem I see with this approach is that so far only
few NIC drivers have any devlink support. Unless we would want to add
ethtool_ops fallback for devlink, we would have to wait until the
relevant features are available via devlink in all in-tree NIC drivers
which provide them via ethtool_ops now.

Providing the features via ethtool netlink interface but having them
backed up by devlink would mean we would have two userspace interfaces
for the same (or almost the same) function. It's something I could live
with but I understand that not everyone would like this. The advantage
is that it would allow migrating the features from ethtool_ops to
devlink gradually.

> > - while the netlink interface allows easy future extensions, ethtool_ops
> >   interface does not; some settings could be implemented using tunables and
> >   accessed via relevant netlink messages (as well as tunables) from
> >   userspace but in the long term, something better will be needed
> 
> Right, so as a driver writer, one thing I kind of hate is having to fill
> a netlink skb myself because that's a lot of work, and it makes it
> fairly hard to do mass conversion of internal APIs due to the increased
> complexity in auditing what drivers do.

I would also prefer to avoid parsing and generating netlink messages in
drivers for regular operations.

Michal
