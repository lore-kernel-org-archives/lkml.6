Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13085C46460
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB56021785
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB56021785
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeHMF5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 01:57:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbeHMF5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 01:57:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0083E401B3A9;
        Mon, 13 Aug 2018 03:17:36 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-183.pek2.redhat.com [10.72.12.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E77552156712;
        Mon, 13 Aug 2018 03:17:32 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, jbrouer@redhat.com,
        mst@redhat.com, Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH net-next V2 0/6] XDP rx handler
Date:   Mon, 13 Aug 2018 11:17:24 +0800
Message-Id: <1534130250-5302-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 13 Aug 2018 03:17:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 13 Aug 2018 03:17:36 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

This series tries to implement XDP support for rx hanlder. This would
be useful for doing native XDP on stacked device like macvlan, bridge
or even bond.

The idea is simple, let stacked device register a XDP rx handler. And
when driver return XDP_PASS, it will call a new helper xdp_do_pass()
which will try to pass XDP buff to XDP rx handler directly. XDP rx
handler may then decide how to proceed, it could consume the buff, ask
driver to drop the packet or ask the driver to fallback to normal skb
path.

A sample XDP rx handler was implemented for macvlan. And virtio-net
(mergeable buffer case) was converted to call xdp_do_pass() as an
example. For ease comparision, generic XDP support for rx handler was
also implemented.

Compared to skb mode XDP on macvlan, native XDP on macvlan (XDP_DROP)
shows about 83% improvement.

Please review.

Thanks

Jason Wang (6):
  net: core: factor out generic XDP check and process routine
  net: core: generic XDP support for stacked device
  net: core: introduce XDP rx handler
  macvlan: count the number of vlan in source mode
  macvlan: basic XDP support
  virtio-net: support XDP rx handler

 drivers/net/macvlan.c      | 189 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/net/virtio_net.c   |  11 +++
 include/linux/filter.h     |   1 +
 include/linux/if_macvlan.h |   1 +
 include/linux/netdevice.h  |  12 +++
 net/core/dev.c             |  69 +++++++++++++----
 net/core/filter.c          |  28 +++++++
 7 files changed, 293 insertions(+), 18 deletions(-)

-- 
2.7.4

