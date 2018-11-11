Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F2AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C57F20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr7xsqDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C57F20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387980AbeKLITn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:41488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387951AbeKLITm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:42 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22E5A21780;
        Sun, 11 Nov 2018 22:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975386;
        bh=csHcl0dHRLUS3g0pyynFJVZ6EmvTMiMAYiauzQcuLYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rr7xsqDFdbXMxzCYzZZOvzyo43IiSGSBIYXoUVN+4FkbKyj2A27iueWevG2Fgl3Xm
         y5dByjZ9fCk2G7KnXhk7fPVStswj1SNZ0+cgmd2R6LeH3oAFH1Zl+dvjigyBi2yu6u
         b/L4JWHpMXKyYJdMtO+zDzi8AHPICXLjJQyV5tL0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 063/350] i2c: rcar: cleanup DMA for all kinds of failure
Date:   Sun, 11 Nov 2018 14:18:47 -0800
Message-Id: <20181111221709.785944548@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 31d86033a0749a0463ea654130b2de5c163154f1 ]

DMA needs to be cleaned up not only on timeout, but on all errors where
it has been setup before.

Fixes: 73e8b0528346 ("i2c: rcar: add DMA support")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-rcar.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -812,8 +812,12 @@ static int rcar_i2c_master_xfer(struct i
 
 	time_left = wait_event_timeout(priv->wait, priv->flags & ID_DONE,
 				     num * adap->timeout);
-	if (!time_left) {
+
+	/* cleanup DMA if it couldn't complete properly due to an error */
+	if (priv->dma_direction != DMA_NONE)
 		rcar_i2c_cleanup_dma(priv);
+
+	if (!time_left) {
 		rcar_i2c_init(priv);
 		ret = -ETIMEDOUT;
 	} else if (priv->flags & ID_NACK) {


