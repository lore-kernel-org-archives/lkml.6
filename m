Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8CBC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605FE208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605FE208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbeGKMeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:34:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:36427 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387414AbeGKMeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:34:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 05:30:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,338,1526367600"; 
   d="scan'208";a="55702693"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.43])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2018 05:30:40 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [char-misc-next 2/2] mei: bus: type promotion bug in mei_fwver()
Date:   Wed, 11 Jul 2018 15:29:32 +0300
Message-Id: <20180711122932.28197-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180711122932.28197-1-tomas.winkler@intel.com>
References: <20180711122932.28197-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if __mei_cl_recv() returns a negative then "bytes_recv"
type is promoted to a high positive value in comparison with
size_t evaluated by MKHI_FWVER_LEN(1). It results in error condition
not to be detected.

Cc: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 9078ad92ef86 ("mei: expose fw version to sysfs")
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus-fixup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 65e28be3c8cc..4c232f0eae90 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -181,7 +181,7 @@ static int mei_fwver(struct mei_cl_device *cldev)
 	ret = 0;
 	bytes_recv = __mei_cl_recv(cldev->cl, buf, sizeof(buf), 0,
 				   MKHI_RCV_TIMEOUT);
-	if (bytes_recv < MKHI_FWVER_LEN(1)) {
+	if (bytes_recv < 0 || bytes_recv < MKHI_FWVER_LEN(1)) {
 		/*
 		 * Should be at least one version block,
 		 * error out if nothing found
-- 
2.14.4

