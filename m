Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8FCC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD8120857
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeL2MrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 07:47:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbeL2MrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 07:47:08 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4991088306;
        Sat, 29 Dec 2018 12:47:08 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-130.pek2.redhat.com [10.72.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 884041001F5E;
        Sat, 29 Dec 2018 12:47:00 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net
Subject: [RFC PATCH V3 0/5] Hi:
Date:   Sat, 29 Dec 2018 20:46:51 +0800
Message-Id: <20181229124656.3900-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 29 Dec 2018 12:47:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tries to access virtqueue metadata through kernel virtual
address instead of copy_user() friends since they had too much
overheads like checks, spec barriers or even hardware feature
toggling.

Test shows about 24% improvement on TX PPS. It should benefit other
cases as well.

Changes from V2:
- fix buggy range overlapping check
- tear down MMU notifier during vhost ioctl to make sure invalidation
  request can read metadata userspace address and vq size without
  holding vq mutex.
Changes from V1:
- instead of pinning pages, use MMU notifier to invalidate vmaps and
  remap duing metadata prefetch
- fix build warning on MIPS

Jason Wang (5):
  vhost: generalize adding used elem
  vhost: fine grain userspace memory accessors
  vhost: rename vq_iotlb_prefetch() to vq_meta_prefetch()
  vhost: introduce helpers to get the size of metadata area
  vhost: access vq metadata through kernel virtual address

 drivers/vhost/net.c   |   4 +-
 drivers/vhost/vhost.c | 416 +++++++++++++++++++++++++++++++++++++-----
 drivers/vhost/vhost.h |  15 +-
 3 files changed, 384 insertions(+), 51 deletions(-)

-- 
2.17.1

