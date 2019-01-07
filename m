Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356F0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0776720665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864999;
	bh=0AVrYq4m714zdNnekI7D7EgRIW/5jirYlSS5GfdJ6bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pona3obBcRJKvLwS/+WBW6m7mKNYK2REc9YILQGJ0n8uFHAaIDd/lw4ybx4R5gmk7
	 01odKgPTMwC5WyGd1YZQyEvmXIx/+6u5V3FamGzuwEmKFqr6SlgvUTa+LWo0OTVFLB
	 TwjGGoG054FJpFf+cHR/loa3h5saVvRy4ihgXzoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfAGMnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:43:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbfAGMnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:43:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 146F920449;
        Mon,  7 Jan 2019 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864994;
        bh=0AVrYq4m714zdNnekI7D7EgRIW/5jirYlSS5GfdJ6bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n7RgYDIXeT6ZmekjrPCMN7L9EwNp9CfTRgX6T9iHZ0cd7ffiuyBLw5BMJmpnHOEV7
         9CQI1rBsrxcnshAnsxNVX3RmJOzTaOG1ptTd5H14FQxvWA62C0pj6aJJJhr0+fh7hP
         Q2J9F8t4UCLm394ErBKZFypj3CeTwRzgsNw1KmvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.20 113/145] media: imx274: fix stack corruption in imx274_read_reg
Date:   Mon,  7 Jan 2019 13:32:30 +0100
Message-Id: <20190107104451.962712193@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Ceresoli <luca@lucaceresoli.net>

commit cea8c0077d6cf3a0cea2f18a8e914af78d46b2ff upstream.

imx274_read_reg() takes a u8 pointer ("reg") and casts it to pass it
to regmap_read(), which takes an unsigned int pointer. This results in
a corrupted stack and random crashes.

Fixes: 0985dd306f72 ("media: imx274: V4l2 driver for Sony imx274 CMOS sensor")

Cc: stable@vger.kernel.org # for 4.15 and up
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/imx274.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/media/i2c/imx274.c
+++ b/drivers/media/i2c/imx274.c
@@ -619,16 +619,19 @@ static int imx274_write_table(struct sti
 
 static inline int imx274_read_reg(struct stimx274 *priv, u16 addr, u8 *val)
 {
+	unsigned int uint_val;
 	int err;
 
-	err = regmap_read(priv->regmap, addr, (unsigned int *)val);
+	err = regmap_read(priv->regmap, addr, &uint_val);
 	if (err)
 		dev_err(&priv->client->dev,
 			"%s : i2c read failed, addr = %x\n", __func__, addr);
 	else
 		dev_dbg(&priv->client->dev,
 			"%s : addr 0x%x, val=0x%x\n", __func__,
-			addr, *val);
+			addr, uint_val);
+
+	*val = uint_val;
 	return err;
 }
 


