Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE65CECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52632146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52632146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbeIREl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:41:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50738 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbeIRElz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:41:55 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1A9EBC49;
        Mon, 17 Sep 2018 23:12:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Surabhi Vishnoi <svishnoi@codeaurora.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 105/158] ath10k: disable bundle mgmt tx completion event support
Date:   Tue, 18 Sep 2018 00:42:15 +0200
Message-Id: <20180917211716.142702786@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Surabhi Vishnoi <svishnoi@codeaurora.org>

[ Upstream commit 673bc519c55843c68c3aecff71a4101e79d28d2b ]

The tx completion of multiple mgmt frames can be bundled
in a single event and sent by the firmware to host, if this
capability is not disabled explicitly by the host. If the host
cannot handle the bundled mgmt tx completion, this capability
support needs to be disabled in the wmi init cmd, sent to the firmware.

Add the host capability indication flag in the wmi ready command,
to let firmware know the features supported by the host driver.
This field is ignored if it is not supported by firmware.

Set the host capability indication flag(i.e. host_capab) to zero,
for disabling the support of bundle mgmt tx completion. This will
indicate the firmware to send completion event for every mgmt tx
completion, instead of bundling them together and sending in a single
event.

Tested HW: WCN3990
Tested FW: WLAN.HL.2.0-01188-QCAHLSWMTPLZ-1

Signed-off-by: Surabhi Vishnoi <svishnoi@codeaurora.org>
Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c |    5 +++++
 drivers/net/wireless/ath/ath10k/wmi-tlv.h |    5 +++++
 2 files changed, 10 insertions(+)

--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -1584,6 +1584,11 @@ static struct sk_buff *ath10k_wmi_tlv_op
 	cfg->keep_alive_pattern_size = __cpu_to_le32(0);
 	cfg->max_tdls_concurrent_sleep_sta = __cpu_to_le32(1);
 	cfg->max_tdls_concurrent_buffer_sta = __cpu_to_le32(1);
+	cfg->wmi_send_separate = __cpu_to_le32(0);
+	cfg->num_ocb_vdevs = __cpu_to_le32(0);
+	cfg->num_ocb_channels = __cpu_to_le32(0);
+	cfg->num_ocb_schedules = __cpu_to_le32(0);
+	cfg->host_capab = __cpu_to_le32(0);
 
 	ath10k_wmi_put_host_mem_chunks(ar, chunks);
 
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.h
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
@@ -1670,6 +1670,11 @@ struct wmi_tlv_resource_config {
 	__le32 keep_alive_pattern_size;
 	__le32 max_tdls_concurrent_sleep_sta;
 	__le32 max_tdls_concurrent_buffer_sta;
+	__le32 wmi_send_separate;
+	__le32 num_ocb_vdevs;
+	__le32 num_ocb_channels;
+	__le32 num_ocb_schedules;
+	__le32 host_capab;
 } __packed;
 
 struct wmi_tlv_init_cmd {


