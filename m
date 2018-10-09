Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F041C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C86C214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="XiB/BPWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C86C214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeJJEtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:49:46 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:53192 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbeJJEtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:49:46 -0400
Received: from allenwind.lan (unknown [37.17.239.109])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 193E75C05B4;
        Tue,  9 Oct 2018 23:30:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1539120651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=kNsEN9fgj+eMmhsT1rMQuTSSjhJhBh8IFG0WTO8rLeY=;
        b=XiB/BPWshya9OO4RTLkDeqGQ8ESCH33BlwIm7GqLQqsO+Mm4pEbcbnuMcK3a1MSSCof908
        tSFToqq5LElgFT3/WKMk+/yoniQNcjwf2a6iL+m9DlxlhC+pSzoCmVoHSi0lBajroT071v
        NZw6Ms1aw0SK3Xn7A7rwzBiSP1RCuKI=
From:   Stefan Agner <stefan@agner.ch>
To:     p.zabel@pengutronix.de, airlied@linux.ie,
        gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, linux@armlinux.org.uk,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/2] component: add optional cleanup function
Date:   Tue,  9 Oct 2018 23:30:48 +0200
Message-Id: <83a28282a3f745a4cd4ca77d0593ad2e61359a5d.1539120077.git.stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional cleanup function on master level. This allows the
master to call framework level cleanup functions in case binding
of any component failed before the previously successfully bound
components get unbound.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Hi,

This is an attempt to fix the issue reported in:
"drm/imx: Crash in drm_mode_config_cleanup"

--
Stefan

 drivers/base/component.c  | 4 ++++
 include/linux/component.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 8946dfee4768..5350d931a663 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -535,6 +535,10 @@ int component_bind_all(struct device *master_dev, void *data)
 				break;
 		}
 
+	/* Allow the master to call framework cleanup functions */
+	if (master->ops->cleanup)
+		master->ops->cleanup(master->dev);
+
 	if (ret != 0) {
 		for (; i--; )
 			if (!master->match->compare[i].duplicate) {
diff --git a/include/linux/component.h b/include/linux/component.h
index e71fbbbc74e2..800534b52165 100644
--- a/include/linux/component.h
+++ b/include/linux/component.h
@@ -24,6 +24,7 @@ struct master;
 struct component_master_ops {
 	int (*bind)(struct device *master);
 	void (*unbind)(struct device *master);
+	void (*cleanup)(struct device *master);
 };
 
 void component_master_del(struct device *,
-- 
2.19.1

