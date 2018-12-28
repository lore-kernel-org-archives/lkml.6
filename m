Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ABEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82D5205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbeL1Hzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 02:55:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729300AbeL1Hzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 02:55:45 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6687F7DD06;
        Fri, 28 Dec 2018 07:55:45 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-196.pek2.redhat.com [10.72.12.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C91C5D9C9;
        Fri, 28 Dec 2018 07:55:39 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V2 0/3] vhost: accelerate metadata access through vmap()
Date:   Fri, 28 Dec 2018 15:55:34 +0800
Message-Id: <20181228075537.21402-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 28 Dec 2018 07:55:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

This series tries to access virtqueue metadata through kernel virtual
address instead of copy_user() friends since they had too much
overheads like checks, spec barriers or even hardware feature
toggling.

Test shows about 24% improvement on TX PPS. It should benefit other
cases as well.

Changes from V1:
- instead of pinning pages, use MMU notifier to invalidate vmaps and
  remap duing metadata prefetch
- fix build warning on MIPS

Please review

Jason Wang (3):
  vhost: generalize adding used elem
  vhost: fine grain userspace memory accessors
  vhost: access vq metadata through kernel virtual address

 drivers/vhost/net.c   |   4 +-
 drivers/vhost/vhost.c | 362 ++++++++++++++++++++++++++++++++++++++----
 drivers/vhost/vhost.h |  15 +-
 3 files changed, 348 insertions(+), 33 deletions(-)

-- 
2.17.1

