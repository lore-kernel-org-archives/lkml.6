Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579FBC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC4B217C5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC4B217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbeHMQnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:43:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:60806 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728370AbeHMQnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:43:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DEA0FAE04;
        Mon, 13 Aug 2018 14:01:16 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
Cc:     konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk,
        boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 0/5] xen/blk: persistent grant rework
Date:   Mon, 13 Aug 2018 16:01:09 +0200
Message-Id: <20180813140114.20126-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Persistent grants are used in the Xen's blkfront/blkback drivers to
avoid mapping/unmapping of I/O buffers in the backend for each I/O.

While this speeds up processing quite a bit there are problems related
to persistent grants in some configurations: domains with multiple
block devices making use of persistent grants might suffer from a lack
of grants if each of the block devices experienced a high I/O load at
some time. This is due to the number of persistent grants per device
only to be limited by a rather high maximum value, but never being
released even in case of longer times without any I/O.

This series modifies xen-blkback to unmap any domU page mapped via a
persistent grant after a timeout (default: 60 seconds). The timeout
is set to its default value again when a persistent grant has been
used for an I/O.

xen-blkfront is modified to scan every 10 seconds for persistent grants
not in use by blkback any more and to remove such grants.

The last 3 patches are small cleanups of blkfront and blkback drivers.

V3:
- patch 1: make timeout parameter static

V2:
- patch 1: added new module parameter doc
- patch 1: removed PERSISTENT_GNT_WAS_ACTIVE flag
- patch 2: removed global worker active flag
- added new patch 4

Juergen Gross (5):
  xen/blkback: don't keep persistent grants too long
  xen/blkfront: cleanup stale persistent grants
  xen/blkfront: reorder tests in xlblk_init()
  xen/blkback: move persistent grants flags to bool
  xen/blkback: remove unused pers_gnts_lock from struct xen_blkif_ring

 Documentation/ABI/testing/sysfs-driver-xen-blkback |  10 ++
 drivers/block/xen-blkback/blkback.c                |  99 ++++++++++---------
 drivers/block/xen-blkback/common.h                 |  14 +--
 drivers/block/xen-blkfront.c                       | 110 ++++++++++++++++++---
 4 files changed, 163 insertions(+), 70 deletions(-)

-- 
2.13.7

