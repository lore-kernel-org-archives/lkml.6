Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8492DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A3F20841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNlvPPy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A3F20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeJHWhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:37:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeJHWho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:37:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EBD420841;
        Mon,  8 Oct 2018 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012330;
        bh=/C+EsTsB5X9UpQixRXfq6994Rp99OwL0GHAco9gjFTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kNlvPPy8tVwXuFErlNjfblJ5WbZH/+3Dx7a7yKdE/EmFoZPm+jLJBzxEiC8le4TLt
         tQL36NmAHMZGWzMIM6MzMeDik10JyNy+EAyXAlHx3RUBgr7pFnkcHzthC3avPDnQ6H
         7UIqAZniJqQGtF0z1yLjbQYDOBey3++E6JgX6TH0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shreyas NC <shreyas.nc@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 02/58] soundwire: Fix incorrect exit after configuring stream
Date:   Mon,  8 Oct 2018 11:24:27 -0400
Message-Id: <20181008152523.70705-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreyas NC <shreyas.nc@intel.com>

[ Upstream commit 3fef1a2259c556cce34df2791688cb3001f81c92 ]

In sdw_stream_add_master() after the Master ports are configured,
the stream is released incorrectly.

So, fix it by avoiding stream release after configuring the Master
for the stream.
While at it, rename the label appropriately.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/soundwire/stream.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 7ba6d4d8cd03..b2682272503e 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1112,7 +1112,7 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 				"Master runtime config failed for stream:%s",
 				stream->name);
 		ret = -ENOMEM;
-		goto error;
+		goto unlock;
 	}
 
 	ret = sdw_config_stream(bus->dev, stream, stream_config, false);
@@ -1123,9 +1123,11 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 	if (ret)
 		goto stream_error;
 
+	goto unlock;
+
 stream_error:
 	sdw_release_master_stream(stream);
-error:
+unlock:
 	mutex_unlock(&bus->bus_lock);
 	return ret;
 }
-- 
2.17.1

