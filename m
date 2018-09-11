Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21FFC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20D22087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20D22087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeILEqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:46:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:5845 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbeILEqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:46:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 16:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="72208234"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.116.215])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2018 16:45:01 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
Subject: [PATCH 6/9] hid: intel-ish-hid: use helper function to search client id
Date:   Tue, 11 Sep 2018 16:44:18 -0700
Message-Id: <20180911234421.10691-7-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
References: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Even Xu <even.xu@intel.com>

ishtp exposed helper ishtp_fw_cl_get_client() function for client
information searching, so switch to use it.

Signed-off-by: Even Xu <even.xu@intel.com>
Reviewed-by: Andriy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index bb8402f10831..e64243bc9c96 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -626,8 +626,8 @@ static int ishtp_get_report_descriptor(struct ishtp_cl *hid_ishtp_cl,
 static int hid_ishtp_cl_init(struct ishtp_cl *hid_ishtp_cl, int reset)
 {
 	struct ishtp_device *dev;
-	unsigned long flags;
 	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
+	struct ishtp_fw_client *fw_client;
 	int i;
 	int rv;
 
@@ -649,16 +649,14 @@ static int hid_ishtp_cl_init(struct ishtp_cl *hid_ishtp_cl, int reset)
 	hid_ishtp_cl->rx_ring_size = HID_CL_RX_RING_SIZE;
 	hid_ishtp_cl->tx_ring_size = HID_CL_TX_RING_SIZE;
 
-	spin_lock_irqsave(&dev->fw_clients_lock, flags);
-	i = ishtp_fw_cl_by_uuid(dev, &hid_ishtp_guid);
-	if (i < 0) {
-		spin_unlock_irqrestore(&dev->fw_clients_lock, flags);
+	fw_client = ishtp_fw_cl_get_client(dev, &hid_ishtp_guid);
+	if (!fw_client) {
 		dev_err(&client_data->cl_device->dev,
 			"ish client uuid not found\n");
-		return i;
+		return -ENOENT;
 	}
-	hid_ishtp_cl->fw_client_id = dev->fw_clients[i].client_id;
-	spin_unlock_irqrestore(&dev->fw_clients_lock, flags);
+
+	hid_ishtp_cl->fw_client_id = fw_client->client_id;
 	hid_ishtp_cl->state = ISHTP_CL_CONNECTING;
 
 	rv = ishtp_cl_connect(hid_ishtp_cl);
-- 
2.17.1

