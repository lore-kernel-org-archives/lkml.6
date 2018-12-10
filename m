Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF36C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE722082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE722082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeLJJpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:45:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbeLJJpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:45:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4FEB36883;
        Mon, 10 Dec 2018 09:45:01 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-196.pek2.redhat.com [10.72.12.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E03C760C45;
        Mon, 10 Dec 2018 09:44:56 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 0/4] Fix various issue of vhost
Date:   Mon, 10 Dec 2018 17:44:50 +0800
Message-Id: <20181210094454.21144-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 10 Dec 2018 09:45:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

This series tries to fix various issues of vhost:

- Patch 1 adds a missing write barrier between used idx updating and
  logging.
- Patch 2-3 brings back the protection of device IOTLB through vq
  mutex, this fixes possible use after free in device IOTLB entries.
- Patch 4 fixes the diry page logging when device IOTLB is
  enabled. We should done through GPA instead of GIOVA, this was done
  through logging through iovec and traversing GPA->HPA list for the
  GPA.

Please consider them for -stable.

Thanks

Jason Wang (4):
  vhost: make sure used idx is seen before log in vhost_add_used_n()
  vhost_net: rework on the lock ordering for busy polling
  Revert "net: vhost: lock the vqs one by one"
  vhost: log dirty page correctly

 drivers/vhost/net.c   |  21 +++++++--
 drivers/vhost/vhost.c | 101 ++++++++++++++++++++++++++++++++++--------
 drivers/vhost/vhost.h |   3 +-
 3 files changed, 102 insertions(+), 23 deletions(-)

-- 
2.17.1

