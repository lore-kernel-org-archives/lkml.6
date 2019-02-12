Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8D3C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1508A217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbfBLQug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:50:36 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3189 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731264AbfBLQuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:50:32 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B9FF6C2F53D8B5932EBF;
        Wed, 13 Feb 2019 00:50:26 +0800 (CST)
Received: from j00421895-HPW10.huawei.com (10.202.226.61) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Wed, 13 Feb 2019 00:50:16 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <jonathan.cameron@huawei.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Michal Hocko <mhocko@kernel.org>, <jcm@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 0/3] ACPI: Support generic initiator proximity domains
Date:   Tue, 12 Feb 2019 16:49:23 +0000
Message-ID: <20190212164926.202-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI 6.3 introduced a new entity that can be part of a NUMA proximity domain.
It may share such a domain with the existing options (memory, cpu etc) but it
may also exist on it's own.

The intent is to allow the description of the NUMA properties (particulary
via HMAT) of accelerators and other initiators of memory activity that are not
the host processor running the operating system.

To illustrate one use case for this feature.

A multiqueue high performance ethernet adaptor is connected to a pair
of SoCs via an appropriate interconnect. The system memory is attached to
the two SoCs. The ethernet adaptor driver wants to load balance the location
of it's memory buffers between the two different SoCs to avoid saturating
the interconnect.  Under current models the ethernet adaptor must be assigned
to an existing NUMA domain (via _PXM).  None of these are able to indicate
that the ethernet adaptor is equidistant from two separate memory / processor
nodes. By assigning it to a node with none of the traditional elements, we can
represent this and the driver is able to load balance between the nodes
improving performance.   We have hardware where 5-10% performance
improvement may be easily achieved using this approach.  As CCIX and similar
interconnects become common, this situation will occur more often.

This patch set introduces 'just enough' to make them work for arm64.
It should be trivial to support other architectures, I just don't suitable
NUMA systems readily available to test.

There are a few quirks that need to be considered.

1. Fall back nodes
******************

As pre ACPI 6.3 supporting operating systems do not have Generic Initiator
Proximity Domains it is possible to specify, via _PXM in DSDT that another
device is part of such a GI only node.  This currently blows up spectacularly
in Linux.

Whilst we can obviously 'now' protect against such a situation (see the related
thread on PCI _PXM support and the  threadripper board identified there as
also falling into the  problem of using non existent nodes
https://patchwork.kernel.org/patch/10723311/ ), there is no way to  be sure
we will never have legacy OSes that are not protected  against this.  It would
also be 'non ideal' to fallback to  a default node as there may be a better
(non GI) node to pick  if GI nodes aren't available.

The work around is that we also have a new system wide OSC bit that allows
an operating system to 'annouce' that it supports Generic Initiators.  This
allows, the firmware to us DSDT magic to 'move' devices between the nodes
dependent on whether our new nodes are there or not.

2. New ways of assigning a proximity domain for devices
*******************************************************

Until now, the only way firmware could indicate that a particular device
(outside the 'special' set of cpus etc) was to be found in a particular
Proximity Domain by the use of _PXM in DSDT.

That is equally valid with GI domains, but we have new options. The SRAT
affinity structure includes a handle (ACPI or PCI) to identify devices
with the system and specify their proximity domain that way.  If both _PXM
and this are provided, they should give the same answer.

For now this patch set completely ignores that feature as we don't need
it to start the discussion.  It will form a follow up set at some point
(if no one else fancies doing it).

acpica-tools patches will go via the normal route to there.

Bits of the headers are here in order to have this stand on it's own.

Jonathan Cameron (3):
  ACPI: Support Generic Initator only domains
  arm64: Support Generic Initiator only domains
  ACPI: Let ACPI know we support Generic Initiator Affinity Structures

 arch/arm64/kernel/smp.c        |  8 +++++
 drivers/acpi/bus.c             |  1 +
 drivers/acpi/numa.c            | 62 +++++++++++++++++++++++++++++++++-
 drivers/base/node.c            |  3 ++
 include/acpi/actbl3.h          | 37 +++++++++++++++++++-
 include/asm-generic/topology.h |  3 ++
 include/linux/acpi.h           |  1 +
 include/linux/nodemask.h       |  1 +
 include/linux/topology.h       |  7 ++++
 9 files changed, 121 insertions(+), 2 deletions(-)

-- 
2.18.0


