Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965690AbeCADTQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 22:19:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965589AbeCADTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 22:19:15 -0500
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: brouer@redhat.com, john.fastabend@gmail.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 0/2] virtio-net: re enable XDP_REDIRECT for mergeable buffer
Date: Thu,  1 Mar 2018 11:19:03 +0800
Message-Id: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

This series tries to re-enable XDP_REDIRECT for mergeable buffer which
was removed since commit 7324f5399b06 ("virtio_net: disable
XDP_REDIRECT in receive_mergeable() case"). Main concerns are:

- not enough tailroom was reserved which breaks cpumap
- complex logic like EWMA and linearizing during XDP processing

Fix those by:

- reserve enough tailroom during refill
- disable EWMA and use fixed size of rx buffer
- drop linearizing logic and offload it to generic XDP routine, this
  could happen only when the buffer were refilled before XDP set, so
  we could simply ignore the negative performance impact.

Please review.

Thanks

Jason Wang (2):
  virtio-net: re enable XDP_REDIRECT for mergeable buffer
  virtio-net: simplify XDP handling in small buffer

 drivers/net/virtio_net.c | 186 ++++++++++++++++++-----------------------------
 1 file changed, 70 insertions(+), 116 deletions(-)

-- 
2.7.4
