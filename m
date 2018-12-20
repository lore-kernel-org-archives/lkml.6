Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B40C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207A120811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545299208;
	bh=FYPnA0AlGszBA6GRLh8AZQn0sPNb4eDnmaKPre4KBoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=st8690BqLOhTj/JssQyHlvo3TX95wFDW8McbjKwWoyr6FW+YpBj1Ih1gP8OuKtVI4
	 CACsvR5QMCTqa6yrP6r3mdkOf5DopEhohR3HLQZg6vcda83xj+ZH55Vv1AqpTQ5F/H
	 ZzVWxPyK4ePv9E2L3SFW6lXo3qGtZBJjTdykyxfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbeLTJqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:46:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730417AbeLTJTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:19:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFC5F21773;
        Thu, 20 Dec 2018 09:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297593;
        bh=FYPnA0AlGszBA6GRLh8AZQn0sPNb4eDnmaKPre4KBoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jO86n361CR6ggaewEEuPJ/wZCEvv/7mKsRpSuXvnSjJmuoG9IebbgEx0vhT8AOi0q
         BQ7SLVkegDBDn3C9zrUo51iQ9uNu8PVDcpeV+SuiNxUQExT7UvfpOm1PiJSrhWB2Uh
         4hTamqtuRsyPcb+9oGw5gk50vOFk4Gt0HYQvnGzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 18/31] drivers/sbus/char: add of_node_put()
Date:   Thu, 20 Dec 2018 10:18:30 +0100
Message-Id: <20181220085743.322674350@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085742.601260254@linuxfoundation.org>
References: <20181220085742.601260254@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6bd520ab7cf69486ea81fd3cdfd2d5a390ad1100 ]

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/sbus/char/envctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index af15a2fdab5e..3d36fa025a5a 100644
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



