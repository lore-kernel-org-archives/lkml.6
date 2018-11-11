Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840F5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4C220839
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C53u16zR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4C220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733032AbeKLJo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:44:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732717AbeKLISX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:23 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 897D221508;
        Sun, 11 Nov 2018 22:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975307;
        bh=gDAOY9NwoGUOskBvwDs4HdlbDz+vF+8/CjDkFmP8xq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C53u16zR+pqyg+RP/TlH/wH5tbvoT2vd/BZFKpk+37ge1vQuPuhufBSjMbR0TcCSy
         erhKN2/VG/veIOabb7iMXFq85l3Orws6XRN/VrQR4NO9gZ8woOc2XC/UQ1kSY5rCHY
         a/EPmaF9JKsPUFr6tkqeq14ahUvxigZyZbQ+7xEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 278/361] media: ov7670: make "xclk" clock optional
Date:   Sun, 11 Nov 2018 14:20:25 -0800
Message-Id: <20181111221655.586919466@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lubomir Rintel <lkundrak@v3.sk>

commit 786fa584eda86d6598db3b87c61dc81f68808d11 upstream.

When the "xclk" clock was added, it was made mandatory. This broke the
driver on an OLPC plaform which doesn't know such clock. Make it
optional.

Tested on a OLPC XO-1 laptop.

Fixes: 0a024d634cee ("[media] ov7670: get xclk")

Cc: stable@vger.kernel.org # 4.11+
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/ov7670.c |   27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

--- a/drivers/media/i2c/ov7670.c
+++ b/drivers/media/i2c/ov7670.c
@@ -1808,17 +1808,24 @@ static int ov7670_probe(struct i2c_clien
 			info->pclk_hb_disable = true;
 	}
 
-	info->clk = devm_clk_get(&client->dev, "xclk");
-	if (IS_ERR(info->clk))
-		return PTR_ERR(info->clk);
-	ret = clk_prepare_enable(info->clk);
-	if (ret)
-		return ret;
+	info->clk = devm_clk_get(&client->dev, "xclk"); /* optional */
+	if (IS_ERR(info->clk)) {
+		ret = PTR_ERR(info->clk);
+		if (ret == -ENOENT)
+			info->clk = NULL;
+		else
+			return ret;
+	}
+	if (info->clk) {
+		ret = clk_prepare_enable(info->clk);
+		if (ret)
+			return ret;
 
-	info->clock_speed = clk_get_rate(info->clk) / 1000000;
-	if (info->clock_speed < 10 || info->clock_speed > 48) {
-		ret = -EINVAL;
-		goto clk_disable;
+		info->clock_speed = clk_get_rate(info->clk) / 1000000;
+		if (info->clock_speed < 10 || info->clock_speed > 48) {
+			ret = -EINVAL;
+			goto clk_disable;
+		}
 	}
 
 	ret = ov7670_init_gpio(client, info);


