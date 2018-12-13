Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215E8C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB0020879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675605;
	bh=a92wHhcYRBcW7LlPfP0ImEYk6g0oHgxuYBumLWhQDdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lz4Q4JOfZVyPLkOoRkb6QlP7hVxM2Wld2LvH8FfgJG6HlqkMtCdvGHge8JfNevK1N
	 kbhysjZMqZHbFnI7XRxplaBy5lJvY2QgH4/vKez6guq+btCWZPwC52fDpZjhtOpomY
	 YxYlvWgrpctlD4BvDNdZVWc7cW4lWooIJ+uXVzVI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB0020879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbeLMEdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:33:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729323AbeLMEdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:33:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D56020873;
        Thu, 13 Dec 2018 04:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675600;
        bh=a92wHhcYRBcW7LlPfP0ImEYk6g0oHgxuYBumLWhQDdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=smFoEdYXpyHFD8OFZMW57rQjZydLU6WpuOuHx4KBKpBWtUOtI+s2MSVV3Ymd61owp
         dVj2KuMUWq0SamVnt5QikKIt6pgchpLlNtqsHfVylSNZdU3pidNq2tlU+EmJwWf6y8
         a4J43s0T9DBdslba9PMRjQMH85GjT+KBBsmtcETg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 11/23] drivers/sbus/char: add of_node_put()
Date:   Wed, 12 Dec 2018 23:32:47 -0500
Message-Id: <20181213043259.76643-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043259.76643-1-sashal@kernel.org>
References: <20181213043259.76643-1-sashal@kernel.org>
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
index 5609b602c54d..baa9b322520b 100644
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

