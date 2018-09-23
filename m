Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452E2C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 05:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35F8214C2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 05:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35F8214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbeIWLNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 07:13:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:48278 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeIWLNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 07:13:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Sep 2018 22:17:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,291,1534834800"; 
   d="scan'208";a="82581577"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Sep 2018 22:13:16 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc v4.9.y] mei: bus: type promotion bug in mei_nfc_if_version()
Date:   Sun, 23 Sep 2018 08:09:51 +0300
Message-Id: <20180923050951.29018-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
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

Cc: <stable@vger.kernel.org> # 4.9
Fixes: 582ab27a063a ("mei: bus: fix received data size check in NFC fixup")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/bus-fixup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 75b9d4ac8b1e..371f5f66a9d6 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -178,7 +178,7 @@ static int mei_nfc_if_version(struct mei_cl *cl,
 
 	ret = 0;
 	bytes_recv = __mei_cl_recv(cl, (u8 *)reply, if_version_length);
-	if (bytes_recv < if_version_length) {
+	if (bytes_recv < 0 || bytes_recv < if_version_length) {
 		dev_err(bus->dev, "Could not read IF version\n");
 		ret = -EIO;
 		goto err;
-- 
2.14.4

