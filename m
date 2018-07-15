Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EA1ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 11:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5FD208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 11:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5FD208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbeGOMFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 08:05:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:5744 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbeGOMFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 08:05:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2018 04:42:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,356,1526367600"; 
   d="scan'208";a="56666425"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.43])
  by orsmga007.jf.intel.com with ESMTP; 15 Jul 2018 04:42:49 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: bus: suppress sign-compare warnings
Date:   Sun, 15 Jul 2018 14:41:18 +0300
Message-Id: <20180715114118.7505-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comparison between signed and unsigned warnings
and associated type promotion may cause error
condition not be detected.
The type promotion issue in mei bus was addressed by two patches:
commit b40b3e9358fb ("mei: bus: type promotion bug in mei_nfc_if_version()")
commit cf1ed2c59b98 ("mei: bus: type promotion bug in mei_fwver()")
Now it is possible to suppress the warning, by adding proper
casting to move out of radar.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus-fixup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 2b8390447117..a6f41f96f2a1 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -181,7 +181,7 @@ static int mei_fwver(struct mei_cl_device *cldev)
 	ret = 0;
 	bytes_recv = __mei_cl_recv(cldev->cl, buf, sizeof(buf), 0,
 				   MKHI_RCV_TIMEOUT);
-	if (bytes_recv < 0 || bytes_recv < MKHI_FWVER_LEN(1)) {
+	if (bytes_recv < 0 || (size_t)bytes_recv < MKHI_FWVER_LEN(1)) {
 		/*
 		 * Should be at least one version block,
 		 * error out if nothing found
@@ -193,7 +193,7 @@ static int mei_fwver(struct mei_cl_device *cldev)
 	fwver = (struct mkhi_fw_ver *)req->data;
 	memset(cldev->bus->fw_ver, 0, sizeof(cldev->bus->fw_ver));
 	for (i = 0; i < MEI_MAX_FW_VER_BLOCKS; i++) {
-		if (bytes_recv < MKHI_FWVER_LEN(i + 1))
+		if ((size_t)bytes_recv < MKHI_FWVER_LEN(i + 1))
 			break;
 		dev_dbg(&cldev->dev, "FW version%d %d:%d.%d.%d.%d\n",
 			i, fwver->ver[i].platform,
@@ -341,7 +341,7 @@ static int mei_nfc_if_version(struct mei_cl *cl,
 
 	ret = 0;
 	bytes_recv = __mei_cl_recv(cl, (u8 *)reply, if_version_length, 0, 0);
-	if (bytes_recv < 0 || bytes_recv < if_version_length) {
+	if (bytes_recv < 0 || (size_t)bytes_recv < if_version_length) {
 		dev_err(bus->dev, "Could not read IF version\n");
 		ret = -EIO;
 		goto err;
-- 
2.14.4

