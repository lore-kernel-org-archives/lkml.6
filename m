Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFCAC6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4130320895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCfaKxp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4130320895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeJMJyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 05:54:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40324 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeJMJyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 05:54:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id d2-v6so15257600wro.7;
        Fri, 12 Oct 2018 19:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wq80mpIKQE7Vj8cI4ya9yy4keDn9JZEGeLzjYIbupik=;
        b=QCfaKxp+O4OWoMS7Qzqo07zyi9ylJ3KiqaBv9cJCLUypLzfihqo/XgUymrW1L2bVDs
         Hml09G28w1DnCO1WgY9WhC4Ss0RoxtO/coZ+AP97c57/EeySgJbmBWAcRJG2OUJUjOAb
         9D1DVSNsLD08HC9jEzp/cf6ipxmIyuyQkKlN/uMejKPN06L6+cWeli0dmtf9I6xuxh4B
         kGyGLeC57H1+QauDG4/WDL6AENaEx4sw/+q7gU3rKTZt5/jknLvT6LwCRTzjdovBf0fm
         AwBDq5UxUUJTMrBvWe4VoegoiTxaW+UH6ODIuyE1AtwWrwp96Levn0Q1IXbqdR2MUcfH
         BM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wq80mpIKQE7Vj8cI4ya9yy4keDn9JZEGeLzjYIbupik=;
        b=I76ll0V0rKJjGG3kn13yhwJm/qZ/T+I7SGpgIqC+SHx16DAe14eDJtxeoyPpAdyvWy
         iTXWwAmB0JP9XntdZFg7N09CYPRK+GSWtgbQ2MeGgyaQMe0y/zgTO+3JNVTyRXZIGOz9
         PpsolFCELOo3UUdacQ+5H/85MSz/KrOpZeRHWrm02DViE2oiZWwFFVWoIH7/98q3OMC8
         B2WcpSeiOErnjI634N/vWEgSR3vFXB/7BexRFgmtsLMPrO+n5DNlBcR3F4O9JI5v6Sg6
         c904v8pwh+GOpy2+3pu89pAvCwGh3Y3VEcKLT9hqMF3T2BqwMY5rJpxQpYli3zbWl3rp
         gREA==
X-Gm-Message-State: ABuFfojS7K/NrhMxNP5m6ezNM23vGrPdNmivGoIDVScmFUlbMlRX5xio
        a3VyrlfojqQ6uCY+MgO+jMo=
X-Google-Smtp-Source: ACcGV63Q3j570O+yizSh9X1yIKpsLP9zKmDBVtsfnU1qgHxZ2dqOrjZbaPv+WjRo5hA0FwDXAz3t/w==
X-Received: by 2002:a5d:6242:: with SMTP id m2-v6mr7140338wrv.162.1539397130716;
        Fri, 12 Oct 2018 19:18:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id s1-v6sm2681099wrw.35.2018.10.12.19.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 19:18:50 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dept-GELinuxNICDev@cavium.com,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org,
        Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>,
        Tomer Tayar <Tomer.Tayar@cavium.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] net: qla3xxx: Remove overflowing shift statement
Date:   Fri, 12 Oct 2018 19:14:58 -0700
Message-Id: <20181013021457.13608-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang currently warns:

drivers/net/ethernet/qlogic/qla3xxx.c:384:24: warning: signed shift
result (0xF00000000) requires 37 bits to represent, but 'int' only has
32 bits [-Wshift-overflow]
                    ((ISP_NVRAM_MASK << 16) | qdev->eeprom_cmd_data));
                      ~~~~~~~~~~~~~~ ^  ~~
1 warning generated.

The warning is certainly accurate since ISP_NVRAM_MASK is defined as
(0x000F << 16) which is then shifted by 16, resulting in 64424509440,
well above UINT_MAX.

Given that this is the only location in this driver where ISP_NVRAM_MASK
is shifted again, it seems likely that ISP_NVRAM_MASK was originally
defined without a shift and during the move of the shift to the
definition, this statement wasn't properly removed (since ISP_NVRAM_MASK
is used in the statenent right above this). Only the maintainers can
confirm this since this statment has been here since the driver was
first added to the kernel.

Link: https://github.com/ClangBuiltLinux/linux/issues/127
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

I sent this diff in a RFC email to the email in the MAINTAINERS file
with no response. Given that this driver has not received any actual
Cavium/QLogic treatment since at least the moving of this file in
commit aa43c2158d5a ("qlogic: Move the QLogic drivers") back in 2011,
I'd be curious to see who is actually using this driver but I'll leave
that for another time.

I've added a few of the active 'drivers/net/ethernet/qlogic' Cavium
developers (hope they don't mind) to see if this makes any sense since I
don't have the hardware to test and I know they're active.

 drivers/net/ethernet/qlogic/qla3xxx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index b48f76182049..10b075bc5959 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -380,8 +380,6 @@ static void fm93c56a_select(struct ql3_adapter *qdev)
 
 	qdev->eeprom_cmd_data = AUBURN_EEPROM_CS_1;
 	ql_write_nvram_reg(qdev, spir, ISP_NVRAM_MASK | qdev->eeprom_cmd_data);
-	ql_write_nvram_reg(qdev, spir,
-			   ((ISP_NVRAM_MASK << 16) | qdev->eeprom_cmd_data));
 }
 
 /*
-- 
2.19.1

