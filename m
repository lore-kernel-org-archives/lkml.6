Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084F3C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DE321476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uS0rgKpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DE321476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeJSB5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbeJSB5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:57:47 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 660BF204FD;
        Thu, 18 Oct 2018 17:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885343;
        bh=rLFHc0IzZwsxaPeCqbs0uB/D1U9M/2obvFCtSpm43CM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uS0rgKpWn+NHvPTiF/gU8lmpOw6l46SSalvXqmo/tBzsV5QHlE1ke1V3SsN9FBahl
         UgdBvRPDAN5Gd5Q4ghAnUcEFG7yCoYD6lrSna+zwkse8MCbPnF+v1vhl63ozam36dO
         NXzGfDKQO4vPZKb7ZnD+wBYaYUpwifeU3JGaNbdo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shreyas NC <shreyas.nc@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 01/53] soundwire: Fix duplicate stream state assignment
Date:   Thu, 18 Oct 2018 19:53:54 +0200
Message-Id: <20181018175416.791968288@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soundwire/stream.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1123,8 +1123,6 @@ int sdw_stream_add_master(struct sdw_bus
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
@@ -1186,6 +1188,12 @@ int sdw_stream_add_slave(struct sdw_slav
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
 


