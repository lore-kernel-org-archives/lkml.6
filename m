Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF72EECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977C120989
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977C120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeIXDKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 23:10:42 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:39552
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727139AbeIXDKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 23:10:41 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id 4BeQgoiWisezk4BeQgk9gW; Sun, 23 Sep 2018 14:10:46 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1g4BeP-0007HH-S6; Sun, 23 Sep 2018 14:10:45 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Stable@vger.kernel.org
Subject: [PATCH 3/4] Drivers: hv: kvp: Fix two "this statement may fall through" warnings
Date:   Sun, 23 Sep 2018 21:10:43 +0000
Message-Id: <20180923211044.27922-3-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180923211044.27922-1-kys@linuxonhyperv.com>
References: <20180923210938.27859-1-kys@linuxonhyperv.com>
 <20180923211044.27922-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfGL/VmB8lC2Co1lkZ52Slf/WMpK9yEDR9q5mMwmY8KxKmXJo8VyPcEelL+795/DEKSeFXUMAaNAD09LBKAQSNBaB4qI/p6A3ZFhBGVDFTfbYS5LqB/Xc
 y0Z1uAyS7dpGYI7eg32pO6a3t5D+puaEOMIUklureZqseZ+Q/KCUjOzawwnZ08yp0aQUindeVlNoiG1whlDIQheCLM0KXZwSsDct3+6sjytG0YhDbfN5MJcO
 VKfgi/4r0jsJ6KMO4SKPDLqyfYdl0PD4slUCI9EvMxLAyiWUhElfr1YT2xTEzwAlMzAHnNzGFT/sYQiHzcXLL5BRc0iMAHl1LVoPXu7OqWRAHeCWJieJAYgY
 Jfl4rWa/d3uZEeX+EWMve3kGE2cAxYiKfyIFSmlaIoTkQ1A5CcYoDTc+qyu6msfJBiEYxDWhvvLHb6oFrnl/FK+Gh8b7Qa6UDnvDuofdbJJk7bpeMx9MeWOZ
 acb7EcfonFapqGzcDvmjpvXQOPU6xvJ3TsvdNBmQ05mTEUueLU0jwe0uY2WaCSzVAKwnswb/qB6pm3wM9s3U9YbRMjoeo0XnKNGk/HXOVngDar7U69FUj1Um
 Isi9WXXv76Jz6CUXBGVshMnkYQ5aM5airPBcma47e6CCIQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

We don't need to call process_ib_ipinfo() if message->kvp_hdr.operation is
KVP_OP_GET_IP_INFO in kvp_send_key(), because here we just need to pass on
the op code from the host to the userspace; when the userspace returns
the info requested by the host, we pass the info on to the host in
kvp_respond_to_host() -> process_ob_ipinfo(). BTW, the current buggy code
actually doesn't cause any harm, because only message->kvp_hdr.operation
is used by the userspace, in the case of KVP_OP_GET_IP_INFO.

The patch also adds a missing "break;" in kvp_send_key(). BTW, the current
buggy code actually doesn't cause any harm, because in the case of
KVP_OP_SET, the unexpected fall-through corrupts
message->body.kvp_set.data.key_size, but that is not really used: see
the definition of struct hv_kvp_exchg_msg_value.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/hv_kvp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 023bd185d21a..a7513a8a8e37 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -353,7 +353,6 @@ static void process_ib_ipinfo(void *in_msg, void *out_msg, int op)
 
 		out->body.kvp_ip_val.dhcp_enabled = in->kvp_ip_val.dhcp_enabled;
 
-	default:
 		utf16s_to_utf8s((wchar_t *)in->kvp_ip_val.adapter_id,
 				MAX_ADAPTER_ID_SIZE,
 				UTF16_LITTLE_ENDIAN,
@@ -406,7 +405,7 @@ kvp_send_key(struct work_struct *dummy)
 		process_ib_ipinfo(in_msg, message, KVP_OP_SET_IP_INFO);
 		break;
 	case KVP_OP_GET_IP_INFO:
-		process_ib_ipinfo(in_msg, message, KVP_OP_GET_IP_INFO);
+		/* We only need to pass on message->kvp_hdr.operation.  */
 		break;
 	case KVP_OP_SET:
 		switch (in_msg->body.kvp_set.data.value_type) {
@@ -446,6 +445,9 @@ kvp_send_key(struct work_struct *dummy)
 			break;
 
 		}
+
+		break;
+
 	case KVP_OP_GET:
 		message->body.kvp_set.data.key_size =
 			utf16s_to_utf8s(
-- 
2.18.0

