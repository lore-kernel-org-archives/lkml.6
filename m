Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EAFC46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD3E20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD3E20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbeKFShA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:37:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:26399 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729160AbeKFShA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:37:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 01:12:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,471,1534834800"; 
   d="scan'208";a="83674063"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga007.fm.intel.com with ESMTP; 06 Nov 2018 01:12:43 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 3/3] mei: expedite ioctl return on the notify set operation error
Date:   Tue,  6 Nov 2018 12:04:40 +0200
Message-Id: <20181106100440.2140-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181106100440.2140-1-tomas.winkler@intel.com>
References: <20181106100440.2140-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

The notify set operation ioctl will wait till timeout is expired
even in case when the FW returned an error.
Check the status field of the client object in wait_event_timeout()
to determine if the caller can return earlier.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/client.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index ee58561ceb08..1fe9426ce48b 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1357,7 +1357,9 @@ int mei_cl_notify_request(struct mei_cl *cl,
 
 	mutex_unlock(&dev->device_lock);
 	wait_event_timeout(cl->wait,
-			   cl->notify_en == request || !mei_cl_is_connected(cl),
+			   cl->notify_en == request ||
+			   cl->status ||
+			   !mei_cl_is_connected(cl),
 			   mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
 	mutex_lock(&dev->device_lock);
 
-- 
2.14.5

