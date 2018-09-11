Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2475EC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3AD20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3AD20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeILEqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:46:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:5839 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725737AbeILEqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:46:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 16:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="72208220"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.116.215])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2018 16:45:01 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
Subject: [PATCH 2/9] hid: intel-ish-hid: use helper function for private driver data set/get
Date:   Tue, 11 Sep 2018 16:44:14 -0700
Message-Id: <20180911234421.10691-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
References: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Even Xu <even.xu@intel.com>

Use helper set/get function to set/get driver data in ishtp-hid-client
driver instead of directly accessing cl_device driver_data member.

Signed-off-by: Even Xu <even.xu@intel.com>
Reviewed-by: Andriy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 2d28cffc1404..11ce54fcd098 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -320,7 +320,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
  */
 static void ish_cl_event_cb(struct ishtp_cl_device *device)
 {
-	struct ishtp_cl	*hid_ishtp_cl = device->driver_data;
+	struct ishtp_cl	*hid_ishtp_cl = ishtp_get_drvdata(device);
 	struct ishtp_cl_rb *rb_in_proc;
 	size_t r_length;
 	unsigned long flags;
@@ -765,7 +765,7 @@ static void hid_ishtp_cl_reset_handler(struct work_struct *work)
 	if (!hid_ishtp_cl)
 		return;
 
-	cl_device->driver_data = hid_ishtp_cl;
+	ishtp_set_drvdata(cl_device, hid_ishtp_cl);
 	hid_ishtp_cl->client_data = client_data;
 	client_data->hid_ishtp_cl = hid_ishtp_cl;
 
@@ -814,7 +814,7 @@ static int hid_ishtp_cl_probe(struct ishtp_cl_device *cl_device)
 	if (!hid_ishtp_cl)
 		return -ENOMEM;
 
-	cl_device->driver_data = hid_ishtp_cl;
+	ishtp_set_drvdata(cl_device, hid_ishtp_cl);
 	hid_ishtp_cl->client_data = client_data;
 	client_data->hid_ishtp_cl = hid_ishtp_cl;
 	client_data->cl_device = cl_device;
@@ -844,7 +844,7 @@ static int hid_ishtp_cl_probe(struct ishtp_cl_device *cl_device)
  */
 static int hid_ishtp_cl_remove(struct ishtp_cl_device *cl_device)
 {
-	struct ishtp_cl *hid_ishtp_cl = cl_device->driver_data;
+	struct ishtp_cl *hid_ishtp_cl = ishtp_get_drvdata(cl_device);
 	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
 
 	hid_ishtp_trace(client_data, "%s hid_ishtp_cl %p\n", __func__,
@@ -874,7 +874,7 @@ static int hid_ishtp_cl_remove(struct ishtp_cl_device *cl_device)
  */
 static int hid_ishtp_cl_reset(struct ishtp_cl_device *cl_device)
 {
-	struct ishtp_cl *hid_ishtp_cl = cl_device->driver_data;
+	struct ishtp_cl *hid_ishtp_cl = ishtp_get_drvdata(cl_device);
 	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
 
 	hid_ishtp_trace(client_data, "%s hid_ishtp_cl %p\n", __func__,
@@ -898,7 +898,7 @@ static int hid_ishtp_cl_reset(struct ishtp_cl_device *cl_device)
 static int hid_ishtp_cl_suspend(struct device *device)
 {
 	struct ishtp_cl_device *cl_device = to_ishtp_cl_device(device);
-	struct ishtp_cl *hid_ishtp_cl = cl_device->driver_data;
+	struct ishtp_cl *hid_ishtp_cl = ishtp_get_drvdata(cl_device);
 	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
 
 	hid_ishtp_trace(client_data, "%s hid_ishtp_cl %p\n", __func__,
@@ -919,7 +919,7 @@ static int hid_ishtp_cl_suspend(struct device *device)
 static int hid_ishtp_cl_resume(struct device *device)
 {
 	struct ishtp_cl_device *cl_device = to_ishtp_cl_device(device);
-	struct ishtp_cl *hid_ishtp_cl = cl_device->driver_data;
+	struct ishtp_cl *hid_ishtp_cl = ishtp_get_drvdata(cl_device);
 	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
 
 	hid_ishtp_trace(client_data, "%s hid_ishtp_cl %p\n", __func__,
-- 
2.17.1

