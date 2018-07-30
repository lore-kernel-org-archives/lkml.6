Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7674C13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6B920892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6B920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbeG3Oaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:30:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:50016 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729407AbeG3Oai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:30:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3403AD6A;
        Mon, 30 Jul 2018 12:55:44 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 43437A0BE8; Mon, 30 Jul 2018 14:55:44 +0200 (CEST)
Message-Id: <cover.1532954671.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH ethtool v2 00/23] ethtool netlink interface (userspace side) (WiP)
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:55:44 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(The series is based on v4.17)

This patch series is and ethtool counterpart to kernel series "ethtool
netlink interface (WiP)"; it's marked as "v2" to match kernel series
version even if I never really sent "v1" to the list. It's only an RFC
as the netlink API it implements is still only a proposal.

The series modifies ethtool to use the netlink based kernel API when
available. If not, it falls back to the ioctl API. The aim is to
preserve command line syntax (with few extensions) and preserve the
output as much as possible.

This brings a natural question: why? It would be certainly tempting to
start with a new tool without the limitations of the old command line
syntax and without having to immitatte strange artefacts of the past.
It may still come to that but experience with iproute2 shows even if you
provide a new tool with cleaner syntax, more features and better
organized output, 19 years later you may still meet (a lot of) people
still using the old tool and claiming they are not going to learn some
new tools with "strange syntax and incomprehensible output" (the sadest
part being that many of them haven't learn using ifconfig before it had
been already obsolete for ten years). That's why I tried to give this
approach at least a try.

As both parser and dump functions in current ethtool code are closely
tied to data structures used by ioctl API, only very little of existing
code could be reused. The parts used also by netlink code were moved to
common.h and common.c. New netlink related code resides in netlink/
subdirectory. Copies of kernel uapi headers were moved to uapi/
directory to make their status more apparent. Netlink code uses libmnl
for message composition and parsing.

Currently reimplemented functions are

  -i / --driver
  (no option)
  -s
  -k / --show-features / --show-offload
  -K / --features / --offload
  -c / --show-coalesce
  -C / --coalesce
  -g / --show-ring
  -G / --set-ring
  -a / --show-pause
  -A / --pause
  -l / --show-channels
  -L / --set-channels
  --show-eee
  --set-eee
  --show-fec
  --set-fec

For all "get" type options, "*" can be used as device name to request
information about all interfaces supporting that request type.

The most interesting new feature is notification monitoring. When
started as

  ethtool --monitor --all

ethtool will listen to netlink notifications and display information
about changes. Replacing "--all" with one of the options above will show
only notifications about changes related to that option. A device name
can be also used to display only notifications related to that device.

ToDo / open questions:

- the most important question still is if we want to reimplement ethtool
  or come with a completely new utility instead

- if we go on with teaching ethtool netlink, another interesting
  question is how closely we need to stick to current output and its
  formatting; even if people are told not to, there are certainly tons
  of scripts parsing ethtool output which may break on any change

- an example of this are legacy "flags" for netdev features; we will
  have to make sure "ethtool -K dev tso off" will do what users expect
  it to but can we get rid of them at least in "ethtool -k" output?

- having to say "--monitor -all" for monitoring all events while just
  "--monitor" only watches for sset ("-s") type changes is probably
  counterintuitive; would it be better to make "--all" default and leave
  only "--monitor -s" for watching only "sset" events

Michal Kubecek (23):
  move UAPI header copies to a separate directory
  update UAPI header copies
  netlink: add netlink interface
  netlink: add support for string sets
  netlink: add notification monitor
  netlink: add netlink handler for gdrv (-i)
  netlink: add netlink handler for gset (no option)
  netlink: add helpers for command line parsing
  netlink: add netlink handler for sset (-s)
  netlink: add netlink handler for gfeatures (-k)
  netlink: add netlink handler for sfeatures (-K)
  netlink: add netlink handler for gcoalesce (-c)
  netlink: add netlink handler for gring (-g)
  netlink: add netlink handler for gpause (-a)
  netlink: add netlink handler for gchannels (-l)
  netlink: add netlink handler for geee (--show-eee)
  netlink: add netlink handler for gfec (--show-fec)
  netlink: add netlink handler for scoalesce (-C)
  netlink: add netlink handler for sring (-G)
  netlink: add netlink handler for spause (-A)
  netlink: add netlink handler for schannels (-L)
  netlink: add netlink handler for seee (--set-eee)
  netlink: add netlink handler for sfec (--set-fec)

 Makefile.am                                  |   20 +-
 common.c                                     |  325 ++++++
 common.h                                     |   83 ++
 configure.ac                                 |   14 +-
 ethtool.c                                    |  437 +++-----
 internal.h                                   |   12 +-
 netlink/drvinfo.c                            |   43 +
 netlink/extapi.h                             |   37 +
 netlink/monitor.c                            |  283 +++++
 netlink/netlink.c                            |  681 ++++++++++++
 netlink/netlink.h                            |  189 ++++
 netlink/params.c                             |  659 +++++++++++
 netlink/parser.c                             |  559 ++++++++++
 netlink/parser.h                             |   49 +
 netlink/settings.c                           | 1035 ++++++++++++++++++
 netlink/strset.c                             |  265 +++++
 netlink/strset.h                             |   16 +
 ethtool-copy.h => uapi/linux/ethtool.h       |   13 +-
 uapi/linux/ethtool_netlink.h                 |  325 ++++++
 uapi/linux/genetlink.h                       |   89 ++
 net_tstamp-copy.h => uapi/linux/net_tstamp.h |   19 +
 uapi/linux/netlink.h                         |  247 +++++
 22 files changed, 5134 insertions(+), 266 deletions(-)
 create mode 100644 common.c
 create mode 100644 common.h
 create mode 100644 netlink/drvinfo.c
 create mode 100644 netlink/extapi.h
 create mode 100644 netlink/monitor.c
 create mode 100644 netlink/netlink.c
 create mode 100644 netlink/netlink.h
 create mode 100644 netlink/params.c
 create mode 100644 netlink/parser.c
 create mode 100644 netlink/parser.h
 create mode 100644 netlink/settings.c
 create mode 100644 netlink/strset.c
 create mode 100644 netlink/strset.h
 rename ethtool-copy.h => uapi/linux/ethtool.h (99%)
 create mode 100644 uapi/linux/ethtool_netlink.h
 create mode 100644 uapi/linux/genetlink.h
 rename net_tstamp-copy.h => uapi/linux/net_tstamp.h (89%)
 create mode 100644 uapi/linux/netlink.h

-- 
2.18.0

