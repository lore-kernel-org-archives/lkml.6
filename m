Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156AEECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C010A21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0nJOx2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C010A21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388611AbeIUDMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:12:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35264 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeIUDMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:12:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id o18-v6so1034365wmc.0;
        Thu, 20 Sep 2018 14:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tVgVxlfs9vyZxkaXlAYhWNe23avDgzXcpA7xki/Hwcc=;
        b=u0nJOx2iFV2gqRt6aHZJPzxnX7QIMvoqL5+G+yD+lmVDpNGg0JAk3wOyNy01tTyVmM
         COcbO4OImsMnuA8B4rTfEwujF18IxpnTnGM3jAvMjANp/qbb9GiMe0o81dxd6L/HisbY
         txHk+sRAThu4VlJDWo/qZAHhjX23X7Wj36p0qZrn3SoXB5U5uHp2qpB4McHsla6hIZPC
         anVo4BKMf3JvoJ4+2KfpOBKx3H39MA1pzKQsPzpZ8D5lvljzFdckWeK619IUAKbtW+SD
         lgrf4qSXeM/31QZFXhkICZnsgRBYD61u45A/XDrTyLk8oXJ53e4ikSWw8gYlorvvigml
         4AmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tVgVxlfs9vyZxkaXlAYhWNe23avDgzXcpA7xki/Hwcc=;
        b=ZyUazKdcoPKHEEgQngNROxZk0sWzROKuzK44JlmHkPSmvh77SHyUAl+O8zv4hCBqUQ
         xshhocmd+BT+Dqf41RLJTx3HVgP7XZJm9feSN5MKYfaglg2PapubGIy+yFr7FEY1Y7EC
         ocqAPL6OAENTepszx3YCWHLd6tGG8l7PA5fQA4xuyKqZaClVhdGuQITWDKcv8O42BFOD
         P/FOm6EnqzY/T6M9k3uVm2j8K4j3if6aonAfn4TJDvHMJt3Et/IbvkdcLDhqbPdYskIo
         vTNy3bf40EmMrN47C4a1JsZw5bjIieRNsxifGto1IduQOp6dDy8qGQ62EJZxjHm0WFO+
         ef7Q==
X-Gm-Message-State: APzg51A3HwQ+GJhRcbEhAGgtNsT6R6gjxXcVlkXPil4FfokD3NBz5MGY
        BzqTUb49FzYCsr4t7MCXR/o=
X-Google-Smtp-Source: ACcGV61A82vlDNqkpaILXHB15MhgygtR53OPwyX8RnyRCgVfMNtNXPG/OXX29+NY1w0f1ZV+FsPBUA==
X-Received: by 2002:a1c:87ca:: with SMTP id j193-v6mr4674673wmd.76.1537478832059;
        Thu, 20 Sep 2018 14:27:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 198-v6sm4945313wmm.0.2018.09.20.14.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 14:27:11 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Aditya Shankar <aditya.shankar@microchip.com>,
        Ganesh Krishna <ganesh.krishna@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] staging: wilc1000: Remove unnecessary pointer check
Date:   Thu, 20 Sep 2018 14:26:49 -0700
Message-Id: <20180920212648.25181-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns that the address of a pointer will always evaluated as true
in a boolean context:

drivers/staging/wilc1000/linux_wlan.c:267:20: warning: address of
'vif->ndev->dev' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (!(&vif->ndev->dev))
            ~  ~~~~~~~~~~~^~~
1 warning generated.

Since this statement always evaluates to false due to the logical not,
remove it.

Link: https://github.com/ClangBuiltLinux/linux/issues/121
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/wilc1000/linux_wlan.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/wilc1000/linux_wlan.c b/drivers/staging/wilc1000/linux_wlan.c
index 49afda669393..323593440e40 100644
--- a/drivers/staging/wilc1000/linux_wlan.c
+++ b/drivers/staging/wilc1000/linux_wlan.c
@@ -264,9 +264,6 @@ static int wilc_wlan_get_firmware(struct net_device *dev)
 
 	netdev_info(dev, "loading firmware %s\n", firmware);
 
-	if (!(&vif->ndev->dev))
-		goto fail;
-
 	if (request_firmware(&wilc_firmware, firmware, wilc->dev) != 0) {
 		netdev_err(dev, "%s - firmware not available\n", firmware);
 		ret = -1;
-- 
2.19.0

