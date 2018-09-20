Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C400BECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6DD2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6DD2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbeITXSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:18:02 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:19626 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732601AbeITXQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:16:23 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 20 Sep 2018 10:31:20 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id C45B440691;
        Thu, 20 Sep 2018 10:31:47 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        Nadav Amit <namit@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, <linux-mm@kvack.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 00/20] vmw_balloon: compaction, shrinker, 64-bit, etc.
Date:   Thu, 20 Sep 2018 10:30:06 -0700
Message-ID: <20180920173026.141333-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set adds the following enhancements to the VMware balloon
driver:

1. Balloon compaction support.
2. Report the number of inflated/deflated ballooned pages through vmstat.
3. Memory shrinker to avoid balloon over-inflation (and OOM).
4. Support VMs with memory limit that is greater than 16TB.
5. Faster and more aggressive inflation.

To support compaction we wish to use the existing infrastructure.
However, we need to make slight adaptions for it. We add a new list
interface to balloon-compaction, which is more generic and efficient,
since it does not require as many IRQ save/restore operations. We leave
the old interface that is used by the virtio balloon.

Big parts of this patch-set are cleanup and documentation. Patches 1-13
simplify the balloon code, document its behavior and allow the balloon
code to run concurrently. The support for concurrency is required for
compaction and the shrinker interface.

For documentation we use the kernel-doc format. We are aware that the
balloon interface is not public, but following the kernel-doc format may
be useful one day.

v1->v2:	* Fix build error when THP is off (kbuild)
	* Fix build error on i386 (kbuild)

Cc: Xavier Deguillard <xdeguillard@vmware.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: linux-mm@kvack.org
Cc: virtualization@lists.linux-foundation.org

Nadav Amit (19):
  vmw_balloon: handle commands in a single function.
  vmw_balloon: unify commands tracing and stats
  vmw_balloon: merge send_lock and send_unlock path
  vmw_balloon: simplifying batch access
  vmw_balloon: remove sleeping allocations
  vmw_balloon: change batch/single lock abstractions
  vmw_balloon: treat all refused pages equally
  vmw_balloon: rename VMW_BALLOON_2M_SHIFT to VMW_BALLOON_2M_ORDER
  vmw_balloon: refactor change size from vmballoon_work
  vmw_balloon: simplify vmballoon_send_get_target()
  vmw_balloon: stats rework
  vmw_balloon: rework the inflate and deflate loops
  vmw_balloon: general style cleanup
  vmw_balloon: add reset stat
  mm/balloon_compaction: suppress allocation warnings
  mm/balloon_compaction: list interfaces
  vmw_balloon: compaction support
  vmw_balloon: memory shrinker
  vmw_balloon: split refused pages

Xavier Deguillard (1):
  vmw_balloon: support 64-bit memory limit

 drivers/misc/Kconfig               |    1 +
 drivers/misc/vmw_balloon.c         | 2196 +++++++++++++++++++---------
 include/linux/balloon_compaction.h |    4 +
 include/uapi/linux/magic.h         |    1 +
 mm/balloon_compaction.c            |  142 +-
 5 files changed, 1577 insertions(+), 767 deletions(-)

-- 
2.17.1

