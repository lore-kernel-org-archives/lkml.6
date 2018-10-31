Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187BFECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D207D2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpUuLyjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D207D2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbeKAIYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:24:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729209AbeKAIKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:10:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB9A520870;
        Wed, 31 Oct 2018 23:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027435;
        bh=7rU3CT/K4Vz5EVwVCBxraRVK9bYBIoBpjI/z4XCXqQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qpUuLyjjg5ievuLKn+UW4Bwx40kdNrKlo/lYsakb7IAbeyOTTJ0NeNwl3YSY54R16
         PK8UMRfS/lqG5OHNhBBq/jye4avP1Sbt50ecMkZbHWV7+T5QbBrc7jgMo7tBzdEKql
         sabuekf0mAm3Xt4PBxR46krf6sGJ2xxTm8TcxBE4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 52/73] Drivers: hv: kvp: Fix two "this statement may fall through" warnings
Date:   Wed, 31 Oct 2018 19:09:27 -0400
Message-Id: <20181031230948.29203-52-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230948.29203-1-sashal@kernel.org>
References: <20181031230948.29203-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

[ Upstream commit fc62c3b1977d62e6374fd6e28d371bb42dfa5c9d ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/hv_kvp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 5eed1e7da15c..57715a0c8120 100644
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
2.17.1

