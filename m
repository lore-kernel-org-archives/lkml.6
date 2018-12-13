Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D130BC6786C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DECC20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DECC20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbeLMCxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:53:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeLMCxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:53:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1996437EEF;
        Thu, 13 Dec 2018 02:53:46 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-167.pek2.redhat.com [10.72.12.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3DB45D70A;
        Thu, 13 Dec 2018 02:53:41 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net V3 0/3] Fix various issue of vhost
Date:   Thu, 13 Dec 2018 10:53:36 +0800
Message-Id: <20181213025339.14023-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 13 Dec 2018 02:53:46 +0000 (UTC)
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

Please consider them for -stable.

Thanks

Changes from V2:
- drop dirty page fix and make it for net-next
Changes from V1:
- silent compiler warning for 32bit.
- use mutex_trylock() on slowpath instead of mutex_lock() even on fast
  path.

Jason Wang (3):
  vhost: make sure used idx is seen before log in vhost_add_used_n()
  vhost_net: switch to use mutex_trylock() in vhost_net_busy_poll()
  Revert "net: vhost: lock the vqs one by one"

 drivers/vhost/net.c   |  8 +++++++-
 drivers/vhost/vhost.c | 23 +++++++++++++++++++----
 2 files changed, 26 insertions(+), 5 deletions(-)

-- 
2.17.1

