Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874A6C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB7420878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0FdNFA1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB7420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeJHWhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeJHWhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:37:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6602220878;
        Mon,  8 Oct 2018 15:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012331;
        bh=09O93cjrg/pcC3dl8LtUgQGenyotl9ppGe3FmWlD6gA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0FdNFA1JZ1JZEyHpiYQsUN43ZHwOFEmYR0LlST0e0CR3sIf3qjxLygtvjCjyhl1cW
         xnB/btDSN2Kr/nJus7oNmMEDxM4sxsD9m0JTD4DbAAI+1crrq3L8fmCpU2uhAgl9Mv
         z/pt/QXj1S5JEsuAWCfU3WXA5pvzqbagNbInJrQI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sanyog Kale <sanyog.r.kale@intel.com>,
        Shreyas NC <shreyas.nc@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 03/58] soundwire: Fix acquiring bus lock twice during master release
Date:   Mon,  8 Oct 2018 11:24:28 -0400
Message-Id: <20181008152523.70705-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanyog Kale <sanyog.r.kale@intel.com>

[ Upstream commit 8d6ccf5cebbc7ed1dee9986e36853a78dfb64084 ]

As part of sdw_stream_remove_master(), sdw_stream_remove_slave() is called
which results in bus lock being acquired twice.

So, fix it by performing specific Slave remove operations in
sdw_release_master_stream() instead of calling sdw_stream_remove_slave().

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/soundwire/stream.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index b2682272503e..e5c7e1ef6318 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -899,9 +899,10 @@ static void sdw_release_master_stream(struct sdw_stream_runtime *stream)
 	struct sdw_master_runtime *m_rt = stream->m_rt;
 	struct sdw_slave_runtime *s_rt, *_s_rt;
 
-	list_for_each_entry_safe(s_rt, _s_rt,
-			&m_rt->slave_rt_list, m_rt_node)
-		sdw_stream_remove_slave(s_rt->slave, stream);
+	list_for_each_entry_safe(s_rt, _s_rt, &m_rt->slave_rt_list, m_rt_node) {
+		sdw_slave_port_release(s_rt->slave->bus, s_rt->slave, stream);
+		sdw_release_slave_stream(s_rt->slave, stream);
+	}
 
 	list_del(&m_rt->bus_node);
 }
-- 
2.17.1

