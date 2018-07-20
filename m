Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4ABECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C1B20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C1B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbeGTBBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:01:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730288AbeGTBBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:01:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC388CE1EA;
        Fri, 20 Jul 2018 00:15:27 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 823DC2026D6B;
        Fri, 20 Jul 2018 00:15:24 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/9] TX used ring batched updating for vhost
Date:   Fri, 20 Jul 2018 08:15:12 +0800
Message-Id: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 20 Jul 2018 00:15:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 20 Jul 2018 00:15:27 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

This series implement batch updating of used ring for TX. This help to
reduce the cache contention on used ring. The idea is first split
datacopy path from zerocopy, and do only batching for datacopy. This
is because zercopy had already supported its own batching.

TX PPS was increased 25.8% and Netperf TCP does not show obvious
differences.

The split of datapath will also be helpful for future implementation
like in order completion.

Please review.

Thanks

Jason Wang (9):
  vhost_net: drop unnecessary parameter
  vhost_net: introduce helper to initialize tx iov iter
  vhost_net: introduce vhost_exceeds_weight()
  vhost_net: introduce get_tx_bufs()
  vhost_net: introduce tx_can_batch()
  vhost_net: split out datacopy logic
  vhost_net: rename vhost_rx_signal_used() to vhost_net_signal_used()
  vhost_net: rename VHOST_RX_BATCH to VHOST_NET_BATCH
  vhost_net: batch update used ring for datacopy TX

 drivers/vhost/net.c | 249 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 179 insertions(+), 70 deletions(-)

-- 
2.7.4

