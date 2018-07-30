Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A20E13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B060420894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B060420894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbeG3O1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:27:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:48904 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729460AbeG3O1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:27:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C340AEEB;
        Mon, 30 Jul 2018 12:52:44 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 5B2A3A0BE8; Mon, 30 Jul 2018 14:52:42 +0200 (CEST)
Message-Id: <cover.1532953989.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH net-next v2 00/17] ethtool netlink interface (WiP)
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:52:42 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A netlink based interface for ethtool is a recurring discussion theme;
such discussion happens from time to time but never seems to reach any
clear conclusion except that netlink interface is desperately needed.
I'm sending this hoping that having a proposal (even if partial) on the
table could help move the discussion further.

The interface used for communication between ethtool and kernel is based on
ioctl() and suffers from many problems. The most pressing seems the be the
lack of extensibility. While some of the newer commands use structures
designed to allow future extensions (e.g. GFEATURES or TEST), most either
allow no extension at all (GPAUSEPARAM, GCOALESCE) or only limited set of
reserved fields (GDRVINFO, GEEE). Even most of those which support future
extensions limit the data types that can be used.

This series aims to provide an alternative interface based on netlink which
is what other network configuration utilities use. In particular, it uses
generic netlink (family "ethtool"). The goal is to provide an interface
which would be extensible, flexible and practical both for ethtool and for
other network configuration tools (e.g. wicked, systemd-networkd or
NetworkManager).

The interface is documented in Documentation/networking/ethtool-netlink.txt

A series for ethtool utility will follow shortly.

Basic concepts:

- the interface is based on generic netlink (family name "ethtool")

- the goal is to provide all features of ioctl interface but allow
  easier future extensions

- inextensibility of ioctl interface resulted in way too many commands,
  many of them obsoleted by newer ones; reduce the number by  ignoring the
  obsolete commands and grouping some together

- for "set" type commands, netlink allows providing only the attributes to
  be changed; therefore we don't need a get-modify-set cycle (which is
  inherently racy), userspace can simply say what it wants to change

- provide notifications to multicast group "monitor" like rtnetlink
  does, i.e. in the form of messages close to replies to "get" requests

- allow dump requests to get some information about all network defices
  providing it

- be less dependent on ethtool and kernel being in sync; allow e.g. saying
  "ethtool -s eth0 advertise foo off" without ethtool knowing what "foo"
  means; it's kernel's job to know what mode "xyz" is and if it exists
  and is supported

Main changes again RFC v1:

- support dumps for all "get" requests
- provide notifications for changes related to supported request types
- support getting string sets (both global and per device)
- support getting/setting device features
- get rid of family specific header, everything passed as attributes
- split netlink code into multiple files in net/ethtool/ directory

ToDo / open questions:

- as some comments in discussion on v1 pointed out, some features of
  ethtool would rather belong to devlink; phy_tunables and phy_stats
  seem to be candidates, maybe part of drvinfo; are there more?

- another question is where to do the split; should ethtool use devlink
  API for these or can we provide them in ethtool API as well but with
  devlink backend (for communication with NIC)

- currently, all communication with drivers via ethtool_ops is done
  under RTNL as this is what ioctl interface does and I suspect many
  ethtool_ops rely on that; can we do without RTNL?

- notifications are sent whenever a change is done via netlink API or
  ioctl API and for netdev features also whenever they are updated using
  netdev_change_features(); it would be desirable to notify also about
  link state and negotiation result (speed/duplex and partner link
  modes) but it would be more tricky

- find reasonable format for data transfers (e.g. eeprom dump or flash);
  I don't have clear idea how big these can get and if 64 KB limit on
  attribute size (including nested ones) is a problem; if so, dumps can
  be an answer for dumps, some kind of multi-message requests would be
  needed for flashes

- while the netlink interface allows easy future extensions, ethtool_ops
  interface does not; some settings could be implemented using tunables and
  accessed via relevant netlink messages (as well as tunables) from
  userspace but in the long term, something better will be needed

- it would be nice if driver could provide useful error/warning messages to
  be passed to userspace via extended ACK; example: while testing, I found
  a driver which only allows values 0, 1, 3 and 10000 for certain parameter
  but the only way poor user can find out is either by trying all values or
  by checking driver source

- some of the functions for GET_SETTINGS and GET_PARAMS are quite
  similar (e.g. ethtool_get_*); it might be beneficial to introduce some
  "ops", leave only "parse", "prepare", "size" and "fill" handlers and
  make the rest generic (like ethnl_dumpit()).

- the counts and sizes in GET_DRVINFO reply seem to be a relic of the
  past and if userspace needs them, there are (or will be) other ways to
  get them; they should most likely go


Michal Kubecek (17):
  netlink: introduce nla_put_bitfield32()
  ethtool: move to its own directory
  ethtool: introduce ethtool netlink interface
  ethtool: helper functions for netlink interface
  ethtool: netlink bitset handling
  ethtool: support for netlink notifications
  ethtool: implement EVENT notifications
  ethtool: implement GET_STRSET message
  ethtool: implement GET_DRVINFO message
  ethtool: implement GET_SETTINGS message
  ethtool: implement GET_SETTINGS request for features
  ethtool: implement SET_SETTINGS notification
  ethtool: implement SET_SETTINGS message
  ethtool: implement SET_SETTINGS request for features
  ethtool: implement GET_PARAMS message
  ethtool: implement SET_PARAMS notification
  ethtool: implement SET_PARAMS message

 Documentation/networking/ethtool-netlink.txt |  558 ++++++++
 include/linux/ethtool_netlink.h              |   17 +
 include/linux/netdevice.h                    |   25 +
 include/net/netlink.h                        |   15 +
 include/uapi/linux/ethtool.h                 |    7 +
 include/uapi/linux/ethtool_netlink.h         |  325 +++++
 net/Kconfig                                  |    7 +
 net/Makefile                                 |    2 +-
 net/core/Makefile                            |    2 +-
 net/core/dev.c                               |   27 +-
 net/ethtool/Makefile                         |    7 +
 net/ethtool/common.c                         |  242 ++++
 net/ethtool/common.h                         |   26 +
 net/ethtool/drvinfo.c                        |  131 ++
 net/{core/ethtool.c => ethtool/ioctl.c}      |  310 ++---
 net/ethtool/netlink.c                        |  840 ++++++++++++
 net/ethtool/netlink.h                        |  169 +++
 net/ethtool/params.c                         | 1008 ++++++++++++++
 net/ethtool/settings.c                       | 1230 ++++++++++++++++++
 net/ethtool/strset.c                         |  552 ++++++++
 20 files changed, 5269 insertions(+), 231 deletions(-)
 create mode 100644 Documentation/networking/ethtool-netlink.txt
 create mode 100644 include/linux/ethtool_netlink.h
 create mode 100644 include/uapi/linux/ethtool_netlink.h
 create mode 100644 net/ethtool/Makefile
 create mode 100644 net/ethtool/common.c
 create mode 100644 net/ethtool/common.h
 create mode 100644 net/ethtool/drvinfo.c
 rename net/{core/ethtool.c => ethtool/ioctl.c} (88%)
 create mode 100644 net/ethtool/netlink.c
 create mode 100644 net/ethtool/netlink.h
 create mode 100644 net/ethtool/params.c
 create mode 100644 net/ethtool/settings.c
 create mode 100644 net/ethtool/strset.c

-- 
2.18.0

