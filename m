Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EACC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F45021476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfho1S7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F45021476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbeJSB7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:59:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbeJSB7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:59:39 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A958A2145D;
        Thu, 18 Oct 2018 17:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885454;
        bh=z5/xUBjfPcMgm82m6/1eg5IAvV/JEXlEfXg+5m1nsIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pfho1S7q7t6BOGib3rM8QWQUPTyrZaMeeW4+Ae/agk+kCrUFRqr9/YsCyF1/8s3je
         OI1qa6ygbl+9+KhCEQSL315oPDIKCfQ9agDcwEFg6ZER2xaRtSLrsRVcSQF0xsktx+
         0e/RMmqQoz2qyDDz0imnx/UgB19HxvScjQZdDUO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>,
        Shreyas NC <shreyas.nc@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 03/53] soundwire: Fix acquiring bus lock twice during master release
Date:   Thu, 18 Oct 2018 19:53:56 +0200
Message-Id: <20181018175417.133789410@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soundwire/stream.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -899,9 +899,10 @@ static void sdw_release_master_stream(st
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


