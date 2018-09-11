Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514AEC4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115F420865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115F420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeILEql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:46:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:5839 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbeILEqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:46:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 16:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="72208227"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.116.215])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2018 16:45:01 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
Subject: [PATCH 4/9] hid: intel-ish-hid: use helper function to access client buffer
Date:   Tue, 11 Sep 2018 16:44:16 -0700
Message-Id: <20180911234421.10691-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
References: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Even Xu <even.xu@intel.com>

ishtp bus driver exposed helper functions for client buffer accessing,
so change to use these functions in ishtp-hid-client driver to avoid
access client buffer directly.

Signed-off-by: Even Xu <even.xu@intel.com>
Reviewed-by: Andriy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 11ce54fcd098..bb8402f10831 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -323,20 +323,11 @@ static void ish_cl_event_cb(struct ishtp_cl_device *device)
 	struct ishtp_cl	*hid_ishtp_cl = ishtp_get_drvdata(device);
 	struct ishtp_cl_rb *rb_in_proc;
 	size_t r_length;
-	unsigned long flags;
 
 	if (!hid_ishtp_cl)
 		return;
 
-	spin_lock_irqsave(&hid_ishtp_cl->in_process_spinlock, flags);
-	while (!list_empty(&hid_ishtp_cl->in_process_list.list)) {
-		rb_in_proc = list_entry(
-			hid_ishtp_cl->in_process_list.list.next,
-			struct ishtp_cl_rb, list);
-		list_del_init(&rb_in_proc->list);
-		spin_unlock_irqrestore(&hid_ishtp_cl->in_process_spinlock,
-			flags);
-
+	while ((rb_in_proc = ishtp_cl_rx_get_rb(hid_ishtp_cl)) != NULL) {
 		if (!rb_in_proc->buffer.data)
 			return;
 
@@ -346,9 +337,7 @@ static void ish_cl_event_cb(struct ishtp_cl_device *device)
 		process_recv(hid_ishtp_cl, rb_in_proc->buffer.data, r_length);
 
 		ishtp_cl_io_rb_recycle(rb_in_proc);
-		spin_lock_irqsave(&hid_ishtp_cl->in_process_spinlock, flags);
 	}
-	spin_unlock_irqrestore(&hid_ishtp_cl->in_process_spinlock, flags);
 }
 
 /**
-- 
2.17.1

