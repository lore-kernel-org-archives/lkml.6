Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeDIHHs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 03:07:48 -0400
Received: from mail2.tencent.com ([163.177.67.195]:52871 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeDIHHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 03:07:47 -0400
From: =?gb2312?B?aGFpYmluemhhbmco1cW6o7HzKQ==?= <haibinzhang@tencent.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?gb2312?B?bGlkb25nY2hlbiizwsGitqsp?= <lidongchen@tencent.com>,
        =?gb2312?B?eXVuZmFuZ3RhaSjMqNTLt70p?= <yunfangtai@tencent.com>
Subject: [PATCH v2] vhost-net: set packet weight of tx polling to 2 * vq size
Thread-Topic: [PATCH v2] vhost-net: set packet weight of tx polling to 2 *
 vq size
Thread-Index: AdPP0UNRr8qieZ2RQ2KxpowhrdkMAQ==
Date: Mon, 9 Apr 2018 07:07:42 +0000
Message-ID: <88D661ADF6AFBF42B2AB88D8E7682B0901FC4A15@EXMBX-SZMAIL011.tencent.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3977r4P010477

handle_tx will delay rx for tens or even hundreds of milliseconds when tx busy
polling udp packets with small length(e.g. 1byte udp payload), because setting
VHOST_NET_WEIGHT takes into account only sent-bytes but no single packet length.

Ping-Latencies shown below were tested between two Virtual Machines using
netperf (UDP_STREAM, len=1), and then another machine pinged the client:

vq size=256
Packet-Weight   Ping-Latencies(millisecond)
                   min      avg       max
Origin           3.319   18.489    57.303
64               1.643    2.021     2.552
128              1.825    2.600     3.224
256              1.997    2.710     4.295
512              1.860    3.171     4.631
1024             2.002    4.173     9.056
2048             2.257    5.650     9.688
4096             2.093    8.508    15.943

vq size=512
Packet-Weight   Ping-Latencies(millisecond)
                   min      avg       max
Origin           6.537   29.177    66.245
64               2.798    3.614     4.403
128              2.861    3.820     4.775
256              3.008    4.018     4.807
512              3.254    4.523     5.824
1024             3.079    5.335     7.747
2048             3.944    8.201    12.762
4096             4.158   11.057    19.985

Ring size is a hint from device about a burst size it can tolerate. Based on
benchmarks, set the weight to 2 * vq size.

To evaluate this change, another tests were done using netperf(RR, TX) between
two machines with Intel(R) Xeon(R) Gold 6133 CPU @ 2.50GHz, and vq size was
tweaked through qemu. Results shown below does not show obvious changes.

vq size=256 TCP_RR                vq size=512 TCP_RR
size/sessions/+thu%/+normalize%   size/sessions/+thu%/+normalize%
   1/       1/  -7%/        -2%      1/       1/   0%/        -2%
   1/       4/  +1%/         0%      1/       4/  +1%/         0%
   1/       8/  +1%/        -2%      1/       8/   0%/        +1%
  64/       1/  -6%/         0%     64/       1/  +7%/        +3%
  64/       4/   0%/        +2%     64/       4/  -1%/        +1%
  64/       8/   0%/         0%     64/       8/  -1%/        -2%
 256/       1/  -3%/        -4%    256/       1/  -4%/        -2%
 256/       4/  +3%/        +4%    256/       4/  +1%/        +2%
 256/       8/  +2%/         0%    256/       8/  +1%/        -1%

vq size=256 UDP_RR                vq size=512 UDP_RR
size/sessions/+thu%/+normalize%   size/sessions/+thu%/+normalize%
   1/       1/  -5%/        +1%      1/       1/  -3%/        -2%
   1/       4/  +4%/        +1%      1/       4/  -2%/        +2%
   1/       8/  -1%/        -1%      1/       8/  -1%/         0%
  64/       1/  -2%/        -3%     64/       1/  +1%/        +1%
  64/       4/  -5%/        -1%     64/       4/  +2%/         0%
  64/       8/   0%/        -1%     64/       8/  -2%/        +1%
 256/       1/  +7%/        +1%    256/       1/  -7%/         0%
 256/       4/  +1%/        +1%    256/       4/  -3%/        -4%
 256/       8/  +2%/        +2%    256/       8/  +1%/        +1%

vq size=256 TCP_STREAM            vq size=512 TCP_STREAM
size/sessions/+thu%/+normalize%   size/sessions/+thu%/+normalize%
  64/       1/   0%/        -3%     64/       1/   0%/         0%
  64/       4/  +3%/        -1%     64/       4/  -2%/        +4%
  64/       8/  +9%/        -4%     64/       8/  -1%/        +2%
 256/       1/  +1%/        -4%    256/       1/  +1%/        +1%
 256/       4/  -1%/        -1%    256/       4/  -3%/         0%
 256/       8/  +7%/        +5%    256/       8/  -3%/         0%
 512/       1/  +1%/         0%    512/       1/  -1%/        -1%
 512/       4/  +1%/        -1%    512/       4/   0%/         0%
 512/       8/  +7%/        -5%    512/       8/  +6%/        -1%
1024/       1/   0%/        -1%   1024/       1/   0%/        +1%
1024/       4/  +3%/         0%   1024/       4/  +1%/         0%
1024/       8/  +8%/        +5%   1024/       8/  -1%/         0%
2048/       1/  +2%/        +2%   2048/       1/  -1%/         0%
2048/       4/  +1%/         0%   2048/       4/   0%/        -1%
2048/       8/  -2%/         0%   2048/       8/   5%/        -1%
4096/       1/  -2%/         0%   4096/       1/  -2%/         0%
4096/       4/  +2%/         0%   4096/       4/   0%/         0%
4096/       8/  +9%/        -2%   4096/       8/  -5%/        -1%

Signed-off-by: Haibin Zhang <haibinzhang@tencent.com>
Signed-off-by: Yunfang Tai <yunfangtai@tencent.com>
Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 drivers/vhost/net.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 8139bc70ad7d..3563a305cc0a 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -44,6 +44,10 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
  * Using this limit prevents one virtqueue from starving others. */
 #define VHOST_NET_WEIGHT 0x80000
 
+/* Max number of packets transferred before requeueing the job.
+ * Using this limit prevents one virtqueue from starving rx. */
+#define VHOST_NET_PKT_WEIGHT(vq) ((vq)->num * 2)
+
 /* MAX number of TX used buffers for outstanding zerocopy */
 #define VHOST_MAX_PEND 128
 #define VHOST_GOODCOPY_LEN 256
@@ -473,6 +477,7 @@ static void handle_tx(struct vhost_net *net)
 	struct socket *sock;
 	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
 	bool zcopy, zcopy_used;
+	int sent_pkts = 0;
 
 	mutex_lock(&vq->mutex);
 	sock = vq->private_data;
@@ -580,7 +585,8 @@ static void handle_tx(struct vhost_net *net)
 		else
 			vhost_zerocopy_signal_used(net, vq);
 		vhost_net_tx_packet(net);
-		if (unlikely(total_len >= VHOST_NET_WEIGHT)) {
+		if (unlikely(total_len >= VHOST_NET_WEIGHT) ||
+		    unlikely(++sent_pkts >= VHOST_NET_PKT_WEIGHT(vq))) {
 			vhost_poll_queue(&vq->poll);
 			break;
 		}
-- 
2.12.3
