Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF44CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CE12192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198521;
	bh=Pc2MhCz8X5hRrfdPLDpD1H6sISHv2F+Cdb+0qUwFsgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I2W8GV70gpIEGWrHKQ3sRm+LrzWSsoafX/yiIKZPY/TZr8kIluEjSLkQ6QVPaUCRr
	 r0pjBCn5zMJPioTrAY1gX4zr12uYZkO7r0hpGcSVr4uC1+sIqpvHmYvU26bqSn6oNO
	 S5IIcGbM9yU7siGutjyvfH53yK8YQHVHqKuNFGYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbfBOCl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:41:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731685AbfBOCJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:09:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3FE3222C9;
        Fri, 15 Feb 2019 02:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196569;
        bh=Pc2MhCz8X5hRrfdPLDpD1H6sISHv2F+Cdb+0qUwFsgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=18oTHget0bgLIJqwyDtyO83Mtvu4JNylcB8h3H5vPghZkHOVUlRubxrrpShbdphAQ
         aKBqflsOaeJXtDk9ogbL5JW4CfmejHMuZSYjn/3nZ8s7jtaevW4OKIhkKhxWj3+CcN
         JWWKpuNd0J/m9doMNx2uewEj5/qBI05KiLMX10SA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 17/77] ASoC: core: Make snd_soc_find_component() more robust
Date:   Thu, 14 Feb 2019 21:07:55 -0500
Message-Id: <20190215020855.176727-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 5a7b2aabc1aa0393f067d9325ada96fdf67f8cb7 ]

There are some use cases where you're checking for a lot of things on a
card and it makes sense that you might end up trying to call
snd_soc_find_component() without either a name or an of_node.  Currently
in that case we try to dereference the name and crash but it's more
useful to allow the caller to just treat that as a case where we don't
find anything, that error handling will already exist.

Inspired by a patch from Ajit Pandey fixing some callers.

Fixes: 8780cf1142a5 ("ASoC: soc-core: defer card probe until all component is added to list")
Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 17632da21ba7..e4da6656f65f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -742,7 +742,7 @@ static struct snd_soc_component *soc_find_component(
 		if (of_node) {
 			if (component->dev->of_node == of_node)
 				return component;
-		} else if (strcmp(component->name, name) == 0) {
+		} else if (name && strcmp(component->name, name) == 0) {
 			return component;
 		}
 	}
-- 
2.19.1

