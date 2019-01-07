Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9C7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0462173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865973;
	bh=I/9la4pw/5hXe0UVi5IxVwC8ffFQvzJ1awZSAWrz63M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mDihw169wxhErzFPAuHAqY8gB63sLfxjjn0c7IVrq2ZNnWTOnN8hsUUK27mMpzbRo
	 bNRHIRZym35y9xQLodyvWMBGiUpYDWU+HcnV/7WK0s2HRbF12/ycKMUouc8VBY92Ls
	 pBnoId75FFu1H1ZxOczuBocC43BA5PAQpZ1Zyagc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfAGM7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:59:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:47058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730307AbfAGM72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:59:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2E7C206BB;
        Mon,  7 Jan 2019 12:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865968;
        bh=I/9la4pw/5hXe0UVi5IxVwC8ffFQvzJ1awZSAWrz63M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBNbC3nkKeqARzt12JOvhs6tnP5XHTlnyGp/jxc0njh7kbzKp3nYbOab0B/pZqqQl
         tMkATBK95dOtfJgqLen1YWFYTDfdU/yI8uRJX9KjLQd7Ng4fm5Y7j+4Rx0TSB6octk
         FPj6As9PbcfVMMikBMVt8FwYH2dEDpQRb9+SbFYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 145/170] media: imx274: fix stack corruption in imx274_read_reg
Date:   Mon,  7 Jan 2019 13:32:52 +0100
Message-Id: <20190107104510.046045933@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -636,16 +636,19 @@ static int imx274_write_table(struct sti
 
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
 


