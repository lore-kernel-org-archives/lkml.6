Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F95ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C28205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C28205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeJRNJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:09:45 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:53398
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727477AbeJRNJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:09:44 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id D0Ywg3eJZ8NVfD0YwgV0SQ; Wed, 17 Oct 2018 22:09:34 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gD0Yw-0007HS-3i; Wed, 17 Oct 2018 22:09:34 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Stable@vger.kernel.org
Subject: [PATCH V2 3/5] Drivers: hv: kvp: Fix the recent regression caused by incorrect clean-up
Date:   Thu, 18 Oct 2018 05:09:30 +0000
Message-Id: <20181018050932.27932-3-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181018050932.27932-1-kys@linuxonhyperv.com>
References: <20181018050835.27828-1-kys@linuxonhyperv.com>
 <20181018050932.27932-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfBsrN4ux0LluePOYZFkM0APtb4tjOcEC9b2SwwsnVwY/h0UEY4m/MSwC6oijWZjG3ska7zq/6Fg+21fR2vXZ4cYF/ecgkrfO6fdZA5cadlq6Jz3oyyYk
 wKN6fjyF2VnD1A7+nGTTITaEBdGOhm2p0qcFEJ6Bn5n7d3RCx1ZCuyLRARk12JtE1qfFF70KpH6SHifqi3ftnDEdWcn8tmh0Yyitx38Xn6g6OAQ4QyUdNN5j
 XzIQMp/FHsZv05UdPPf693FIlws3tvot9yYHpHiVveQeJkLZMXZi/KHs62eoqnE7S7hyprljSgZxHKx1ChzyrRBemDclyszffCxj4rdZIqWfxx/4AdOL2bl0
 5Ma051gZEQ0EvI+J6TbFs9FeJGOV0GmBX3JOKKVjgpQ3jzlmpIeePmxV7zdXkBvKUAEzBHm3NkVgPfsj6zl7aEIFNiiuPuC7a4GtXTlc2LADuwveVE1ylaAA
 ia1BgUDrAdkkylL2Ah9GJ5ERPk7N4SH4HlFK0hauDbrIw+wdyLUbOuDAY4bBflcuzYHMo2yWvrhzP60ZLRLJ//PbGH0Mi1sPeHnQaslNMq7u1fdzSK3aHRV2
 nRfkWJHJFoWcgNNMG5QntYf3i+YfGeI5cY0MEcdAE47HQw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

In kvp_send_key(), we do need call process_ib_ipinfo() if
message->kvp_hdr.operation is KVP_OP_GET_IP_INFO, because it turns out
the userland hv_kvp_daemon needs the info of operation, adapter_id and
addr_family. With the incorrect fc62c3b1977d, the host can't get the
VM's IP via KVP.

And, fc62c3b1977d added a "break;", but actually forgot to initialize
the key_size/value in the case of KVP_OP_SET, so the default key_size of
0 is passed to the kvp daemon, and the pool files
/var/lib/hyperv/.kvp_pool_* can't be updated.

This patch effectively rolls back the previous fc62c3b1977d, and
correctly fixes the "this statement may fall through" warnings.

This patch is tested on WS 2012 R2 and 2016.

Fixes: fc62c3b1977d ("Drivers: hv: kvp: Fix two "this statement may fall through" warnings")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/hv_kvp.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index a7513a8a8e37..d6106e1a0d4a 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -353,6 +353,9 @@ static void process_ib_ipinfo(void *in_msg, void *out_msg, int op)
 
 		out->body.kvp_ip_val.dhcp_enabled = in->kvp_ip_val.dhcp_enabled;
 
+		/* fallthrough */
+
+	case KVP_OP_GET_IP_INFO:
 		utf16s_to_utf8s((wchar_t *)in->kvp_ip_val.adapter_id,
 				MAX_ADAPTER_ID_SIZE,
 				UTF16_LITTLE_ENDIAN,
@@ -405,7 +408,11 @@ kvp_send_key(struct work_struct *dummy)
 		process_ib_ipinfo(in_msg, message, KVP_OP_SET_IP_INFO);
 		break;
 	case KVP_OP_GET_IP_INFO:
-		/* We only need to pass on message->kvp_hdr.operation.  */
+		/*
+		 * We only need to pass on the info of operation, adapter_id
+		 * and addr_family to the userland kvp daemon.
+		 */
+		process_ib_ipinfo(in_msg, message, KVP_OP_GET_IP_INFO);
 		break;
 	case KVP_OP_SET:
 		switch (in_msg->body.kvp_set.data.value_type) {
@@ -446,9 +453,9 @@ kvp_send_key(struct work_struct *dummy)
 
 		}
 
-		break;
-
-	case KVP_OP_GET:
+		/*
+		 * The key is always a string - utf16 encoding.
+		 */
 		message->body.kvp_set.data.key_size =
 			utf16s_to_utf8s(
 			(wchar_t *)in_msg->body.kvp_set.data.key,
@@ -456,6 +463,17 @@ kvp_send_key(struct work_struct *dummy)
 			UTF16_LITTLE_ENDIAN,
 			message->body.kvp_set.data.key,
 			HV_KVP_EXCHANGE_MAX_KEY_SIZE - 1) + 1;
+
+		break;
+
+	case KVP_OP_GET:
+		message->body.kvp_get.data.key_size =
+			utf16s_to_utf8s(
+			(wchar_t *)in_msg->body.kvp_get.data.key,
+			in_msg->body.kvp_get.data.key_size,
+			UTF16_LITTLE_ENDIAN,
+			message->body.kvp_get.data.key,
+			HV_KVP_EXCHANGE_MAX_KEY_SIZE - 1) + 1;
 		break;
 
 	case KVP_OP_DELETE:
-- 
2.18.0

