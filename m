Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F07CC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE8420672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675484;
	bh=+trt5WXd89UdDfXyN9azN1n2wCcO3940CTZhoBUIQA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZyT+PWqr5qZug8MZXw8fR5vHRWZf0rnyTWsd87BdkDgNHJ41qX83yEClLwQVAz0Xl
	 2ZZicelharAT2kktEDT4eKGGk+wenzHmCAcI7AfwA7ozft+9Mvm91fD1/EC+FyWhn4
	 7/d/ESqenRN5FI/pJjXS5wLHOoDjQWyKW+06ijjA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE8420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeLMEbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:31:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728694AbeLMEbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:31:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7725820873;
        Thu, 13 Dec 2018 04:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675477;
        bh=+trt5WXd89UdDfXyN9azN1n2wCcO3940CTZhoBUIQA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jimFCjiWLqAtVx8GmNshN9btrfMYlyd5+A6KcqQ/e3fccYjJxDbxmT9gMyZPjRyYE
         qvftHO2qU09Wgp7rs5hPRlvqZwFQM0bohr6S6GFBHBg8kyUrhozVpbPG4BiFLfZ/jH
         anYFf45mmHKQ7rLiHXCo04gn8RrL8W5W9WcAtD90=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 14/41] drivers/sbus/char: add of_node_put()
Date:   Wed, 12 Dec 2018 23:30:27 -0500
Message-Id: <20181213043054.75891-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043054.75891-1-sashal@kernel.org>
References: <20181213043054.75891-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit 6bd520ab7cf69486ea81fd3cdfd2d5a390ad1100 ]

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/sbus/char/envctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index 56e962a01493..b8481927bfe4 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -910,8 +910,10 @@ static void envctrl_init_i2c_child(struct device_node *dp,
 			for (len = 0; len < PCF8584_MAX_CHANNELS; ++len) {
 				pchild->mon_type[len] = ENVCTRL_NOMON;
 			}
+			of_node_put(root_node);
 			return;
 		}
+		of_node_put(root_node);
 	}
 
 	/* Get the monitor channels. */
-- 
2.19.1

