Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1148C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8051213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2yjhGPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8051213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeJCWjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:39:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37427 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCWjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:39:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so6687174wrr.4;
        Wed, 03 Oct 2018 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TOcpJN9kECAmgkneeSAmIQnuqUIwWghnwFlQS7iLnWI=;
        b=u2yjhGPMFCTQx3523ofS4FT+gkM+XefAWJlvpvhofD0ciTDa/k2s0wE4ikWzUjVVtv
         9bnVam7vhjJEjUMO80fSCvJcBGR8QDUwavj7SSzdJzNSE6VOkuFD4rn3p4Qq/dGE2RYA
         plK2NWHt7T0zXsPD7vwibIUYKI27OE//smcCyHCoehVLmixfjBFr1gR2SEYD/moom0oj
         jHfxM7NqD0LrJZbWUr/ipyw5pywOeBxzINhchFNLSUz0SI8/jdbw7b4FDD2AvgBrmf8w
         pnWxpkYDpWrjmqjOdrJYeWi7Frm6UvDjWvmgPLpWZy/HelFzDQU/PIDvcwJ4YWAdKVfv
         uJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TOcpJN9kECAmgkneeSAmIQnuqUIwWghnwFlQS7iLnWI=;
        b=Fe7T2ha/xTkjRCq0XnHyMrev4bTHvyCMh4ZUV/CbrNfwu6Ce1Kek3vkaKpr+Wt167w
         pKSEhVKIAfgVlU5+t/Ss64r16f8+JiIip01N/okF8Qdvz6Ve9dtveoiHwmMa8ifjPeqa
         TCYXYFXl8eX7RAL0S5ptqHlWklGdxGiU7TIb2FWZ0cLE+r7o3zqn1WYCsM51b3FnDAOB
         tNlj70t2w46MGmcvy8L7SN6Ohiq/SOotW4sUx1tWVKZxG8LwCTkWwE+eUbaObL3iWqRK
         WD7fCuLFaF/c3co9QvLSsgNAoX5VMFzqW+2QCb2JvdgVf0zqoBWVvcum9pe3axXukKJa
         Fvsw==
X-Gm-Message-State: ABuFfohj7R8b3v00DqUY6rNXRKpHtHvhEzu6KL0/abzGuX0xCFniulFF
        zOlJQLNgMqO/pkikwJnrpXstC0hd
X-Google-Smtp-Source: ACcGV63qO1lbsp6rtj21iVc4uY2Y+irGyB+yMoe6SM1VC0Wqq9GSloLSt03kAcTcljb4jEUMxEMwlg==
X-Received: by 2002:adf:e512:: with SMTP id j18-v6mr1723483wrm.111.1538581847804;
        Wed, 03 Oct 2018 08:50:47 -0700 (PDT)
Received: from pc-ceresoli.dev.aim (45.11.168.109.cust.ip.kpnqwest.it. [109.168.11.45])
        by smtp.gmail.com with ESMTPSA id h18-v6sm1707614wrb.82.2018.10.03.08.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 08:50:46 -0700 (PDT)
From:   Luca Ceresoli <lucaceresoli77@gmail.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Peter Rosin <peda@axentia.se>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH v2 1/3] i2c: mux: pca954x: simplify code to reach the adapter
Date:   Wed,  3 Oct 2018 17:50:22 +0200
Message-Id: <20181003155024.16024-1-lucaceresoli77@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca@lucaceresoli.net>

struct i2c_client has a direct pointer to the adapter, no need to dig
it out of the struct device tree.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 24bd9275fde5..bfabf985e830 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -347,7 +347,7 @@ static void pca954x_cleanup(struct i2c_mux_core *muxc)
 static int pca954x_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adap = client->adapter;
 	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct device *dev = &client->dev;
 	struct device_node *np = dev->of_node;
-- 
2.17.1

