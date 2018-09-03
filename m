Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981E5C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D96620843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D96620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeIDDIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 23:08:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:28872 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeIDDIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 23:08:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 15:45:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,326,1531810800"; 
   d="scan'208";a="67268788"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga007.fm.intel.com with ESMTP; 03 Sep 2018 15:45:49 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        stable@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc v4.4.y 2/2] mei: bus: type promotion bug in mei_nfc_if_version()
Date:   Tue,  4 Sep 2018 01:43:04 +0300
Message-Id: <20180903224304.15989-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180903224304.15989-1-tomas.winkler@intel.com>
References: <20180903224304.15989-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit b40b3e9358fbafff6a4ba0f4b9658f6617146f9c upstream

We accidentally removed the check for negative returns
without considering the issue of type promotion.
The "if_version_length" variable is type size_t so if __mei_cl_recv()
returns a negative then "bytes_recv" is type promoted
to a high positive value and treated as success.

Cc: <stable@vger.kernel.org> # 4.4
Fixes: 582ab27a063a ("mei: bus: fix received data size check in NFC fixup")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/bus-fixup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index bdc7fcd80eca..9dcdc6f41ceb 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -151,7 +151,7 @@ static int mei_nfc_if_version(struct mei_cl *cl,
 
 	ret = 0;
 	bytes_recv = __mei_cl_recv(cl, (u8 *)reply, if_version_length);
-	if (bytes_recv < if_version_length) {
+	if (bytes_recv < 0 || bytes_recv < if_version_length) {
 		dev_err(bus->dev, "Could not read IF version\n");
 		ret = -EIO;
 		goto err;
-- 
2.14.4

