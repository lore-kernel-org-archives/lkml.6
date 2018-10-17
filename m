Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFAAC5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E295214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E295214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeJQLIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:08:41 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:49082
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727097AbeJQLIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 07:08:40 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id CcHggcO9wwkZtCcHggMqfn; Tue, 16 Oct 2018 20:14:08 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gCcHg-0000DQ-LX; Tue, 16 Oct 2018 20:14:08 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Stable@vger.kernel.org
Subject: [PATCH 3/5] Drivers: hv: kvp: Fix the recent regression caused by incorrect clean-up
Date:   Wed, 17 Oct 2018 03:14:04 +0000
Message-Id: <20181017031406.773-3-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181017031406.773-1-kys@linuxonhyperv.com>
References: <20181017031241.669-1-kys@linuxonhyperv.com>
 <20181017031406.773-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfAS8Toz6INNrnzGBZ57JOy2NJGzd6LDzf6IjqJ0g4Msc+c4BB7luA+rpSKCu4xWZwWIzcejARJ34q44W97CAPUa7E2S7xFDJ50o0d/y8umpJ00Y8f4kH
 /9cx8//ik4ofD6qZ+EMAgkTkf01vKlwlMK4UFtJ68gALfTn0v5exIGIbNLXR5dMeflL6ECs/3Xg9tlRf77tP1UPRuecu/XzFUc7oVn3jMPPAV9w0nriivBxe
 s9ruaPGneBzgmIJuULeY9bvXoctsc3CCe15F56ZKu6OLkg6Fmr6EYyTtXmus/ECY5DrdxnLwt17SDVS4TOwtxTON14dyzYyey8d66SWgnpQ0CqI97Tos8nAG
 3iQGEVb6qRpF+yIZICN/MAowUqxvRgqSylKrGm9Or5m85MuFK7UHTWEFaSN4SBm99fVN7ghCSKaWNUifgqdkrgxhw4Qdc4QPIYg+hLByxNlyBXjYONzVu6n8
 IlIH/6ZBKBjtBDBNa16LqW5/xy1Ba7V9HDKWeMPryd03f3ex6KDRUNNdCNzPwDLT71lQP8W7hGkBvGarlQVp/cQysw7doONHDwBpQCzyjjXnAdGkDI7AuJbi
 lCnNWw/cxSvmhswFaFUU48JznEh2G6/VJQWWn+0q+RouSQ==
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
index a7513a8a8e37..9fbb15c62c6c 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -353,6 +353,9 @@ static void process_ib_ipinfo(void *in_msg, void *out_msg, int op)
 
 		out->body.kvp_ip_val.dhcp_enabled = in->kvp_ip_val.dhcp_enabled;
 
+		__attribute__ ((fallthrough));
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

