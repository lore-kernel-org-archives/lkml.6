Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09275C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5F3217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392063AbfBRSV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:21:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:45906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389263AbfBRSV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:21:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C885AEA9;
        Mon, 18 Feb 2019 18:21:26 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 833C5E0122; Mon, 18 Feb 2019 19:21:24 +0100 (CET)
Message-Id: <cover.1550513384.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH net-next v3 00/21] ethtool netlink interface, part 1
To:     netdev@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Date:   Mon, 18 Feb 2019 19:21:24 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: this is marked as RFC because it's rather late in the cycle; the plan
is to make a regular submission (with changes based on review) once
net-next reopens after the 5.1 merge window. The full (work in progress)
series, together with the (userspace) ethtool counterpart can be found at
https://github.com/mkubecek/ethnl

This is first part of alternative userspace interface for ethtool. The aim
is to address some long known issues with the ioctl interface, mainly lack
of extensibility, raciness, limited error reporting and absence of
notifications.

The interface uses generic netlink family "ethtool"; it provides multicast
group "monitor" which is used for notifications. Documentation for the
interface is in Documentation/networking/ethtool-netlink.txt

Basic concepts:

- the goal is to provide all features of ioctl interface but allow
  easier future extensions; at some point, it should be possible to have
  full ethtool functionality without using the ioctl interface
- inextensibility of ioctl interface resulted in way too many commands,
  many of them obsoleted by newer ones; reduce the number by  ignoring the
  obsolete commands and grouping some together
- for "set" type commands, allows passing only the attributes to be
  changed; therefore we don't need a get-modify-set cycle (which is
  inherently racy), userspace can simply say what it wants to change
- provide notifications to multicast group "monitor" like rtnetlink does,
  i.e. in the form of messages close to replies to "get" requests
- allow dump requests to get some information about all network devices
  providing it
- be less dependent on ethtool and kernel being in sync; allow e.g. saying
  "ethtool -s eth0 advertise foo off" without ethtool knowing what "foo"
  means; it's kernel's job to know what mode "xyz" is and if it exists and
  is supported

Main changes between RFC v2 and RFC v3:

- do not allow building as a module (no netdev notifiers needed)
- drop some obsolete fields
- add permanent hw address, timestamping and private flags support
- rework bitset handling to get rid of variable length arrays
- notify monitor on device renames
- restructure GET_SETTINGS/SET_SETTINGS messages
- split too long patches and submit only first part of the series

Main changes between RFC v1 and RFC v2:

- support dumps for all "get" requests
- provide notifications for changes related to supported request types
- support getting string sets (both global and per device)
- support getting/setting device features
- get rid of family specific header, everything passed as attributes
- split netlink code into multiple files in net/ethtool/ directory

ToDo / open questions:

- some features provided by ethtool would rather belong to devlink (and
  some are already superseded by devlink); however, only few drivers
  provide devlink interface at the moment and as recent discussion on
  flashing revealed, we cannot rely on devlink's presence

- while the netlink interface allows easy future extensions, ethtool_ops
  interface does not; some settings could be implemented using tunables and
  accessed via relevant netlink messages (as well as tunables) from
  userspace but in the long term, something better will be needed

- currently, all communication with drivers via ethtool_ops is done
  under RTNL as this is what ioctl interface does and likely many
  ethtool_ops handlers rely on that; if we are going to rework ethtool_ops
  in the future ("phase two"), it would be nice to get rid of it

- ethtool_ops should pass extack pointer to allow drivers more meaningful
  error reporting; it's not clear, however, how to pass information about
  offending attribute

- notifications are sent whenever a change is done via netlink API or
  ioctl API and for netdev features also whenever they are updated using
  netdev_change_features(); it would be desirable to notify also about
  link state and negotiation result (speed/duplex and partner link
  modes) but it would be more tricky

Michal Kubecek (21):
  netlink: introduce nla_put_bitfield32()
  ethtool: move to its own directory
  ethtool: introduce ethtool netlink interface
  ethtool: helper functions for netlink interface
  ethtool: netlink bitset handling
  ethtool: support for netlink notifications
  ethtool: implement EVENT notifications
  ethtool: generic handlers for GET requests
  ethtool: move string arrays into common file
  ethtool: provide string sets with GET_STRSET request
  ethtool: provide driver/device information in GET_INFO request
  ethtool: provide permanent hardware address in GET_INFO request
  ethtool: provide timestamping information in GET_INFO request
  ethtool: provide link mode names as a string set
  ethtool: provide link settings and link modes in GET_SETTINGS request
  ethtool: provide WoL information in GET_SETTINGS request
  ethtool: provide message level in GET_SETTINGS request
  ethtool: provide link state in GET_SETTINGS request
  ethtool: provide device features in GET_SETTINGS request
  ethtool: provide private flags in GET_SETTINGS request
  ethtool: send netlink notifications about setting changes

 Documentation/networking/ethtool-netlink.txt | 441 +++++++++++++
 include/linux/ethtool_netlink.h              |  17 +
 include/linux/netdevice.h                    |  14 +
 include/net/netlink.h                        |  15 +
 include/uapi/linux/ethtool.h                 |  10 +
 include/uapi/linux/ethtool_netlink.h         | 265 ++++++++
 include/uapi/linux/net_tstamp.h              |  13 +
 net/Kconfig                                  |   8 +
 net/Makefile                                 |   2 +-
 net/core/Makefile                            |   2 +-
 net/ethtool/Makefile                         |   7 +
 net/ethtool/bitset.c                         | 572 +++++++++++++++++
 net/ethtool/bitset.h                         |  40 ++
 net/ethtool/common.c                         | 227 +++++++
 net/ethtool/common.h                         |  29 +
 net/ethtool/info.c                           | 332 ++++++++++
 net/{core/ethtool.c => ethtool/ioctl.c}      | 244 ++-----
 net/ethtool/netlink.c                        | 634 +++++++++++++++++++
 net/ethtool/netlink.h                        | 252 ++++++++
 net/ethtool/settings.c                       | 559 ++++++++++++++++
 net/ethtool/strset.c                         | 461 ++++++++++++++
 21 files changed, 3937 insertions(+), 207 deletions(-)
 create mode 100644 Documentation/networking/ethtool-netlink.txt
 create mode 100644 include/linux/ethtool_netlink.h
 create mode 100644 include/uapi/linux/ethtool_netlink.h
 create mode 100644 net/ethtool/Makefile
 create mode 100644 net/ethtool/bitset.c
 create mode 100644 net/ethtool/bitset.h
 create mode 100644 net/ethtool/common.c
 create mode 100644 net/ethtool/common.h
 create mode 100644 net/ethtool/info.c
 rename net/{core/ethtool.c => ethtool/ioctl.c} (91%)
 create mode 100644 net/ethtool/netlink.c
 create mode 100644 net/ethtool/netlink.h
 create mode 100644 net/ethtool/settings.c
 create mode 100644 net/ethtool/strset.c

-- 
2.20.1

