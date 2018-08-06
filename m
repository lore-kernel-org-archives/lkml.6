Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BCBC46473
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85A121A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85A121A04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbeHFNnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:43:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:33720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728417AbeHFNnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:43:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8009AE83;
        Mon,  6 Aug 2018 11:34:18 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
Cc:     konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk,
        boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH 0/4] xen/blk: persistent grant rework
Date:   Mon,  6 Aug 2018 13:33:58 +0200
Message-Id: <20180806113403.24728-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
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

The last 2 patches are small cleanups of blkfront and blkback drivers.

Juergen Gross (4):
  xen/blkback: don't keep persistent grants too long
  xen/blkfront: cleanup stale persistent grants
  xen/blkfront: reorder tests in xlblk_init()
  xen/blkback: remove unused pers_gnts_lock from struct xen_blkif_ring

 drivers/block/xen-blkback/blkback.c |  77 +++++++++++++++---------
 drivers/block/xen-blkback/common.h  |   2 +-
 drivers/block/xen-blkfront.c        | 115 ++++++++++++++++++++++++++++++++----
 3 files changed, 153 insertions(+), 41 deletions(-)

-- 
2.13.7

