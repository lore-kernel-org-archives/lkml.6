Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeC0JSM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:18:12 -0400
Received: from mail2.tencent.com ([163.177.67.195]:40551 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbeC0JSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:18:10 -0400
From: =?gb2312?B?aGFpYmluemhhbmco1cW6o7HzKQ==?= <haibinzhang@tencent.com>
To: "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] vhost-net: add time limitation for tx polling
Thread-Topic: [PATCH] vhost-net: add time limitation for tx polling
Thread-Index: AdPFq4I5xcTKhETOTeyd0/a3ZzrdNA==
Date: Tue, 27 Mar 2018 09:12:27 +0000
Message-ID: <88D661ADF6AFBF42B2AB88D8E7682B0901FC4059@EXMBX-SZMAIL011.tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.90.75]
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2R9IN29027615

handle_tx() will delay rx for a long time when busy tx polling udp packets
with short length(ie: 1byte udp payload), because setting VHOST_NET_WEIGHT
takes into account only sent-bytes but no time. It's not fair for handle_rx(),
so needs to limit max time of tx polling.

Signed-off-by: Haibin Zhang <haibinzhang@tencent.com>
---
 drivers/vhost/net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 8139bc70ad7d..dc9218a3a75b 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -473,6 +473,7 @@ static void handle_tx(struct vhost_net *net)
 	struct socket *sock;
 	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
 	bool zcopy, zcopy_used;
+	unsigned long start = jiffies;
 
 	mutex_lock(&vq->mutex);
 	sock = vq->private_data;
@@ -580,7 +581,7 @@ static void handle_tx(struct vhost_net *net)
 		else
 			vhost_zerocopy_signal_used(net, vq);
 		vhost_net_tx_packet(net);
-		if (unlikely(total_len >= VHOST_NET_WEIGHT)) {
+		if (unlikely(total_len >= VHOST_NET_WEIGHT) || unlikely(jiffies - start >= 1)) {
 			vhost_poll_queue(&vq->poll);
 			break;
 		}
-- 
2.12.3
