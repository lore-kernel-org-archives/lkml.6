Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5536C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FD020827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJtOtHnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FD020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeKGPyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 10:54:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37562 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeKGPyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 10:54:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so14518947wmc.2;
        Tue, 06 Nov 2018 22:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aR49N8yjTibP5fGwJiI0weDQN1eLl7ZUPmm8Gnaamls=;
        b=UJtOtHnU3j/wWHB8hT2V0JrU9Y6A161as69O0J0PdpesufJq+pIkZT31ae666lAF8z
         1Ayk4yEs85cAEfs7qunshh50vMI2PgqIpBhj6wckKu1I3TwxOTFZrwUrnEWazSGSFe7+
         FDDHEzBuexaJQh3uc1IroOfL/eKJHhicSuemgSrSIR7T4L1ACYwOwE+r5UnBSpNFWlGP
         eKg5E9lJfeXQjbBo5LbfHv4fyBWe0PcgaNc+GhrnCHB5MA4SjNn0MSQSady+XyZJbzGg
         oZKL0BzThCJ72pmbA/6UfjXSlLPS5yNRu1fHye9Bca4Ib1cVRAMXABPZMhYgeJrkQfz5
         jhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aR49N8yjTibP5fGwJiI0weDQN1eLl7ZUPmm8Gnaamls=;
        b=ZQ8/7AFQoACeKfDaF0CrHbUk/OH6PoHQroemhM/4X+geUj3UmMk1yZVAlICj+IGyM1
         ctr6lK9dW2DPmpYE9QNgEIcaabkTVRag38L3PMyLPCCd4wGf1+FB7TYGfhLYuaZ+vlav
         svNxmyYXI7KjMsfFm/SVV2ew5J24FyN0heq355vr3NPLo/rN6H9wqdb8t+jM/RhIX5ys
         rUuRPzW2XwufX05IKekByav8ZV78xpVIlkBpN5t9fdiXVatnWeNlnKhd7GBiuojqURDR
         vEzd3Q3HWWzaqLQb6YKas1eWtKiVnwyM1w249UkBKden5SnxWPTrD604MrciCv5SWADe
         4/pg==
X-Gm-Message-State: AGRZ1gLxfNITh7vfRY25lrkJ4+VhceR4VPlV2+pA904gK+HaA80Dg+zl
        5c8vAbCSbvvuCA3qAhIHPfY=
X-Google-Smtp-Source: AJdET5d1xR15tmyY+MQ5TCTAuJvAKVXWIyZF2mVqR2UObGa8gkHSox7LV+IedJgLZox69yFraTrYvA==
X-Received: by 2002:a1c:39c1:: with SMTP id g184-v6mr712244wma.93.1541571938242;
        Tue, 06 Nov 2018 22:25:38 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id y2-v6sm21657752wrh.53.2018.11.06.22.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 22:25:37 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] media: imx214: Remove unnecessary self assignment in for loop
Date:   Tue,  6 Nov 2018 23:24:50 -0700
Message-Id: <20181107062450.5511-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when a variable is assigned to itself:

drivers/media/i2c/imx214.c:695:13: error: explicitly assigning value of
variable of type 'const struct reg_8 *' to itself
[-Werror,-Wself-assign]
        for (table = table; table->addr != IMX214_TABLE_END ; table++) {
             ~~~~~ ^ ~~~~~
1 error generated.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/media/i2c/imx214.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 284b9b49ebde..ec3d1b855f62 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -692,7 +692,7 @@ static int imx214_write_table(struct imx214 *imx214,
 	int i;
 	int ret;
 
-	for (table = table; table->addr != IMX214_TABLE_END ; table++) {
+	for (; table->addr != IMX214_TABLE_END ; table++) {
 		if (table->addr == IMX214_TABLE_WAIT_MS) {
 			usleep_range(table->val * 1000,
 				     table->val * 1000 + 500);
-- 
2.19.1

