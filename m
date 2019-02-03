Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BCCC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FE520815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfBCN7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:59:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53690 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728325AbfBCNt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:58 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9k-0003tp-JH; Sun, 03 Feb 2019 13:49:56 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9f-0007AI-Jp; Sun, 03 Feb 2019 14:49:51 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        "Dexuan Cui" <decui@microsoft.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.690990169@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 183/305] Drivers: hv: kvp: Fix the recent regression
 caused by incorrect clean-up
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

commit e670de54c813b5bc3672dd1c67871dc60e9206f4 upstream.

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
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hv/hv_kvp.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -326,6 +326,9 @@ static void process_ib_ipinfo(void *in_m
 
 		out->body.kvp_ip_val.dhcp_enabled = in->kvp_ip_val.dhcp_enabled;
 
+		/* fallthrough */
+
+	case KVP_OP_GET_IP_INFO:
 		utf16s_to_utf8s((wchar_t *)in->kvp_ip_val.adapter_id,
 				MAX_ADAPTER_ID_SIZE,
 				UTF16_LITTLE_ENDIAN,
@@ -378,7 +381,11 @@ kvp_send_key(struct work_struct *dummy)
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
@@ -419,9 +426,9 @@ kvp_send_key(struct work_struct *dummy)
 
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
@@ -429,6 +436,17 @@ kvp_send_key(struct work_struct *dummy)
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

