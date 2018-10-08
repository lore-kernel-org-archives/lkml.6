Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A7CC677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717B120890
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/LOcZJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717B120890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbeJHWho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:37:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbeJHWho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:37:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABDA220644;
        Mon,  8 Oct 2018 15:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012329;
        bh=nxDOOtF14Qw3It1GHli3S3pMmZ8ey/IS560+P8KM/SE=;
        h=From:To:Cc:Subject:Date:From;
        b=e/LOcZJ0VGn/co8hGdkJhUVwWhCSVXcqLMFut0KdfzYVPSQfZj02OMsDCsYnxgPFH
         FSrZfFbSRMX2X/1IW4epgLce1oWpvzkZ5uizEPs5LvdZP45FdJwtCHnx1lQDPdEnkc
         I8pYZYyt3Ne2Aj7FrnU92Xw2xWlYisojTVa6b+Tc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shreyas NC <shreyas.nc@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 01/58] soundwire: Fix duplicate stream state assignment
Date:   Mon,  8 Oct 2018 11:24:26 -0400
Message-Id: <20181008152523.70705-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreyas NC <shreyas.nc@intel.com>

[ Upstream commit 0aebe40bae6cf5652fdc3d05ecee15fbf5748194 ]

For a SoundWire stream it is expected that a Slave is added to the
stream before Master is added.

So, move the stream state to CONFIGURED after the first Slave is
added and remove the stream state assignment for Master add.
Along with these changes, add additional comments to explain the same.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/soundwire/stream.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 4b5e250e8615..7ba6d4d8cd03 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1123,8 +1123,6 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 	if (ret)
 		goto stream_error;
 
-	stream->state = SDW_STREAM_CONFIGURED;
-
 stream_error:
 	sdw_release_master_stream(stream);
 error:
@@ -1141,6 +1139,10 @@ EXPORT_SYMBOL(sdw_stream_add_master);
  * @stream: SoundWire stream
  * @port_config: Port configuration for audio stream
  * @num_ports: Number of ports
+ *
+ * It is expected that Slave is added before adding Master
+ * to the Stream.
+ *
  */
 int sdw_stream_add_slave(struct sdw_slave *slave,
 		struct sdw_stream_config *stream_config,
@@ -1186,6 +1188,12 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	if (ret)
 		goto stream_error;
 
+	/*
+	 * Change stream state to CONFIGURED on first Slave add.
+	 * Bus is not aware of number of Slave(s) in a stream at this
+	 * point so cannot depend on all Slave(s) to be added in order to
+	 * change stream state to CONFIGURED.
+	 */
 	stream->state = SDW_STREAM_CONFIGURED;
 	goto error;
 
-- 
2.17.1

