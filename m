Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162500AbeE1Ki1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162467AbeE1KiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:38:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Ben Hutchings <ben@decadent.org.uk>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 269/329] virtio-net: Fix operstate for virtio when no VIRTIO_NET_F_STATUS
Date: Mon, 28 May 2018 12:03:18 +0200
Message-Id: <20180528100304.319552368@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jay Vosburgh <jay.vosburgh@canonical.com>

[ Upstream commit bda7fab54828bbef2164bb23c0f6b1a7d05cc718 ]

The operstate update logic will leave an interface in the
default UNKNOWN operstate if the interface carrier state never changes
from the default carrier up state set at creation.  This includes the
case of an explicit call to netif_carrier_on, as the carrier on to on
transition has no effect on operstate.

	This affects virtio-net for the case that the virtio peer does
not support VIRTIO_NET_F_STATUS (the feature that provides carrier state
updates).  Without this feature, the virtio specification states that
"the link should be assumed active," so, logically, the operstate should
be UP instead of UNKNOWN.  This has impact on user space applications
that use the operstate to make availability decisions for the interface.

	Resolve this by changing the virtio probe logic slightly to call
netif_carrier_off for both the "with" and "without" VIRTIO_NET_F_STATUS
cases, and then the existing call to netif_carrier_on for the "without"
case will cause an operstate transition.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1949,8 +1949,8 @@ static int virtnet_probe(struct virtio_d
 
 	/* Assume link up if device can't report link status,
 	   otherwise get link status from config. */
+	netif_carrier_off(dev);
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
-		netif_carrier_off(dev);
 		schedule_work(&vi->config_work);
 	} else {
 		vi->status = VIRTIO_NET_S_LINK_UP;
