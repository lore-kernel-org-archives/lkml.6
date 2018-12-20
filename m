Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0342C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC84B21773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297711;
	bh=VPIAIZPxeuBTglRUff7joPOR78yiPZRYUuI54eBcKts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yJHlYGLwxegDWV1mGuthSjsUjpm5xenFXaBAzV62VfjCjYTCB4lq8S0B/7S2GhSAo
	 Dmog27G0n/GrwUs2HvSKCgsN7bI/0QvZNtw/J5WCpl3V96KtCySZmwNp+NClO7qJGA
	 9LSq4LmaoLvyaWa/j0FlzKnm/14AmN45ELc+E5VU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbeLTJVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:21:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731186AbeLTJVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:21:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A366021720;
        Thu, 20 Dec 2018 09:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297707;
        bh=VPIAIZPxeuBTglRUff7joPOR78yiPZRYUuI54eBcKts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZIF7Kh7WPItzDvYAWcmZtWpS4pjJ72zkfKRavvcLpPwBgPxOA0n/Sw+iQA9NHe9mP
         c/dFhHT4Yqf5XanSfiOGdf7AfFDq1vDMVEfCrmYB4Jm2Ez009CTfSkWnS8b6SFFcpy
         Zdk5X4ZAwvPn2F0RLBZ8OpyQoCBWpV3W57N8SPbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 27/40] drivers/sbus/char: add of_node_put()
Date:   Thu, 20 Dec 2018 10:18:39 +0100
Message-Id: <20181220085827.552837807@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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



