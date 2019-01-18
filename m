Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F58C5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA3D20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JPMweWD5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bWmLcNJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfARSiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:38:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36258 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbfARSiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:38:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 127F76095F; Fri, 18 Jan 2019 18:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547836684;
        bh=wraxb8tqxboMY5dWAZ4NH9qu+s9ojH3IOewaLdOWADc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JPMweWD5FWYiplTL90Qedt8tVZj+Mkfv2T5gSWftDxP5GqJBpN6/JHsrcVeHpCyVt
         zErXghLZcvNLCbz8WM88yjJQa0npqISb1huRtng9x9nq9aL+itALuUrb5eEO5tqDbk
         JIbhL6H2zRwPVKzfymbTWjQAT5BbE4Xb+D5Lvyy8=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 699C3608FF;
        Fri, 18 Jan 2019 18:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547836683;
        bh=wraxb8tqxboMY5dWAZ4NH9qu+s9ojH3IOewaLdOWADc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bWmLcNJI5dNDlYzuIGRxPHibM47e1IaIvOxyYTdcXMJJzaa8yNS8t6hNjtysEyJHe
         bqWoJY98HTufwdr7H2xBvz3khJQYJrb8LcIg1CUp2Kix2ip1fh3oFeHRQxQLG4Qe0C
         k8FwSfQZnrR9TzMyO3PNJ7b7qnA2kr9mpKuciReU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 699C3608FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
From:   Liam Mark <lmark@codeaurora.org>
To:     labbott@redhat.com, sumit.semwal@linaro.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        afd@ti.com, john.stultz@linaro.org,
        Liam Mark <lmark@codeaurora.org>
Subject: [PATCH 3/4] dma-buf: add support for mapping with dma mapping attributes
Date:   Fri, 18 Jan 2019 10:37:46 -0800
Message-Id: <1547836667-13695-4-git-send-email-lmark@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for configuring dma mapping attributes when mapping
and unmapping memory through dma_buf_map_attachment and
dma_buf_unmap_attachment.

Signed-off-by: Liam Mark <lmark@codeaurora.org>
---
 include/linux/dma-buf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 58725f890b5b..59bf33e09e2d 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -308,6 +308,8 @@ struct dma_buf {
  * @dev: device attached to the buffer.
  * @node: list of dma_buf_attachment.
  * @priv: exporter specific attachment data.
+ * @dma_map_attrs: DMA mapping attributes to be used in
+ *		   dma_buf_map_attachment() and dma_buf_unmap_attachment().
  *
  * This structure holds the attachment information between the dma_buf buffer
  * and its user device(s). The list contains one attachment struct per device
@@ -323,6 +325,7 @@ struct dma_buf_attachment {
 	struct device *dev;
 	struct list_head node;
 	void *priv;
+	unsigned long dma_map_attrs;
 };
 
 /**
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project

