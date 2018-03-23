Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3955644-1521764237-2-271387599470766639
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521764237; b=YeiclnLF2KvhTcJ2/nptOiRS0zFM4BSLaACelu3Cpaj4f6C
    gz0KbrIy0T+0wYYB2g8trmBFudC/ZBsdzmhM3oXO0VPS8Q6R6nIxmcM61g7tYSCG
    7nhlP3Ik8n22HQw8RioCGgeVGgcPkLVcX68zqNnUbjvQEwCq0orKvp51ApV9JwPd
    6VyeSS/ju3VsOEOoHr04ApOtCShSWv19x+tBnMtE2BhbMiFOJN+ZL6GilBo4NmfR
    e0ujGPkA7KsCtUcbImMaZ8RB0DeeJrScrUOnG9nUR/7ILG54u5zaPELWxcoC6O3T
    Qp1iuIOrIX208p2lgH4JNij+WN27DgbmPshtV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521764237; bh=r
    o2TfgTed0N9H+wiiMZmW8s8lb0Sg/bBiItUPtNRp7k=; b=UQjhQRBg3O99VBhtg
    dh7YNlrC2z76/NIux+Ym2FE2XNs5xHfy1XWxfp3J/HMBN2rAtGAdSa0sc39oWhL6
    Y01Kqp1pXfbn2IMRAAGuFiPd79mLiaevoLhF7AKoHsyGnchGXRA3MK0GfDw4krxi
    +disPvwu8Nr7aX9yZmzBbJaFHWY4ldQYXs784UaUlQr+orfcCQEhobmbQZRY8n3O
    VgzSobbheqon0mQt9g6yOh0ncpvZZ+VBaaMKqmwY9VJY6EDDudGp/clI2/BLqU9S
    Zc733qaQX5OtuigmfxBJFKNZrdDMbRVSAeqQR+Dnb60ZpD3YtuagBJCfmGhH5lAg
    7BpTA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 devel@linuxdriverproject.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Storvsc: Select channel based on available percentage of
 ring buffer to write
Date: Thu, 22 Mar 2018 17:15:38 -0700
Message-Id: <20180323001538.31876-3-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180323001538.31876-1-longli@linuxonhyperv.com>
References: <20180323001538.31876-1-longli@linuxonhyperv.com>
X-CMAE-Envelope: MS4wfK2TU4yp36E4pYZ7M/4Oqo8uG325Xzjldud83uRZkqvkG7QN3u4cRDqMRd+JE+9uf0pEKIaiiD167g46TL9NggeZ0vaN35qeNhHjSJpzktqb+ZEjD4X4
 lDvquinfZSeBnfAz7ZYot4wQleorb00TnPbaSMTsgFd3Ic19BdNnZUl+mZj41334lrvupWKDeg7K8OjfZmSDJmZUu+QplMMpyX3G5Mdx98CPhLrJTp3fuduU
 N6JcRQlJKqkXsHvjwLFb+a+O19DiEuOk3RtMSS6PYsIc60cS8TdWcZD+DI7MeNywGKfi7t6mTsOUGk4URr4+UVxJFj63iBCF7YAz4MXFRSXxWonvp3Efp0sd
 7J6DjNfSQIbemy5EAKvZRAYbGPfwQjki6VwhSsF6JPP/D+v+uQ8v7hW+jlyVK9gmpN8+oLLjbhe+8X9wmoEDOO/2lCz4dQrBBwXYStopBVegAuacLlxod3/v
 rENGKPD5N78/YdChVYYFRqjVKLzsJdTJ3qlF5476oPvA1xrR3BVuTN++O8Y=
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Long Li <longli@microsoft.com>

This is a best effort for estimating on how busy the ring buffer is for
that channel, based on available buffer to write in percentage. It is still
possible that at the time of actual ring buffer write, the space may not be
available due to other processes may be writing at the time.

Selecting a channel based on how full it is can reduce the possibility that
a ring buffer write will fail, and avoid the situation a channel is over
busy.

Now it's possible that storvsc can use a smaller ring buffer size
(e.g. 40k bytes) to take advantage of cache locality.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 62 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index a2ec0bc9e9fa..96681c4f75cb 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -395,6 +395,12 @@ MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size (bytes)");
 
 module_param(storvsc_vcpus_per_sub_channel, int, S_IRUGO);
 MODULE_PARM_DESC(storvsc_vcpus_per_sub_channel, "Ratio of VCPUs to subchannels");
+
+static int ring_avail_percent_lowater = 10;
+module_param(ring_avail_percent_lowater, int, S_IRUGO);
+MODULE_PARM_DESC(ring_avail_percent_lowater,
+		"Select a channel if available ring size > this in percent");
+
 /*
  * Timeout in seconds for all devices managed by this driver.
  */
@@ -1285,9 +1291,9 @@ static int storvsc_do_io(struct hv_device *device,
 {
 	struct storvsc_device *stor_device;
 	struct vstor_packet *vstor_packet;
-	struct vmbus_channel *outgoing_channel;
+	struct vmbus_channel *outgoing_channel, *channel;
 	int ret = 0;
-	struct cpumask alloced_mask;
+	struct cpumask alloced_mask, other_numa_mask;
 	int tgt_cpu;
 
 	vstor_packet = &request->vstor_packet;
@@ -1301,22 +1307,53 @@ static int storvsc_do_io(struct hv_device *device,
 	/*
 	 * Select an an appropriate channel to send the request out.
 	 */
-
 	if (stor_device->stor_chns[q_num] != NULL) {
 		outgoing_channel = stor_device->stor_chns[q_num];
-		if (outgoing_channel->target_cpu == smp_processor_id()) {
+		if (outgoing_channel->target_cpu == q_num) {
 			/*
 			 * Ideally, we want to pick a different channel if
 			 * available on the same NUMA node.
 			 */
 			cpumask_and(&alloced_mask, &stor_device->alloced_cpus,
 				    cpumask_of_node(cpu_to_node(q_num)));
-			for_each_cpu_wrap(tgt_cpu, &alloced_mask,
-					outgoing_channel->target_cpu + 1) {
-				if (tgt_cpu != outgoing_channel->target_cpu) {
-					outgoing_channel =
-					stor_device->stor_chns[tgt_cpu];
-					break;
+
+			for_each_cpu_wrap(tgt_cpu, &alloced_mask, q_num + 1) {
+				if (tgt_cpu == q_num)
+					continue;
+				channel = stor_device->stor_chns[tgt_cpu];
+				if (hv_get_avail_to_write_percent(
+							&channel->outbound)
+						> ring_avail_percent_lowater) {
+					outgoing_channel = channel;
+					goto found_channel;
+				}
+			}
+
+			/*
+			 * All the othe channels on the same NUMA node are
+			 * busy. Try to use the channel with the current CPU
+			 */
+			if (hv_get_avail_to_write_percent(
+						&outgoing_channel->outbound)
+					> ring_avail_percent_lowater)
+				goto found_channel;
+
+			/*
+			 * If we reach here, all the channels on the current
+			 * NUMA node are busy. Try to find a channel in
+			 * other NUMA nodes
+			 */
+			cpumask_andnot(&other_numa_mask,
+					&stor_device->alloced_cpus,
+					cpumask_of_node(cpu_to_node(q_num)));
+
+			for_each_cpu(tgt_cpu, &other_numa_mask) {
+				channel = stor_device->stor_chns[tgt_cpu];
+				if (hv_get_avail_to_write_percent(
+							&channel->outbound)
+						> ring_avail_percent_lowater) {
+					outgoing_channel = channel;
+					goto found_channel;
 				}
 			}
 		}
@@ -1324,7 +1361,7 @@ static int storvsc_do_io(struct hv_device *device,
 		outgoing_channel = get_og_chn(stor_device, q_num);
 	}
 
-
+found_channel:
 	vstor_packet->flags |= REQUEST_COMPLETION_FLAG;
 
 	vstor_packet->vm_srb.length = (sizeof(struct vmscsi_request) -
@@ -1733,7 +1770,8 @@ static int storvsc_probe(struct hv_device *device,
 	}
 
 	scsi_driver.can_queue = (max_outstanding_req_per_channel *
-				 (max_sub_channels + 1));
+				 (max_sub_channels + 1)) *
+				 (100 - ring_avail_percent_lowater) / 100;
 
 	host = scsi_host_alloc(&scsi_driver,
 			       sizeof(struct hv_host_device));
-- 
2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
