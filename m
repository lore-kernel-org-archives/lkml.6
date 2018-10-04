Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEC0C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435322084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="koIWB+/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435322084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbeJDWiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:38:07 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:36906 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeJDWiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:38:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 63CD81C4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Oct 2018 15:44:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IWJ-XL-8WpYv for <linux-kernel@vger.kernel.org>;
        Thu,  4 Oct 2018 10:44:16 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 396D1426
        for <linux-kernel@vger.kernel.org>; Thu,  4 Oct 2018 10:44:16 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id x5-v6so9206184ioa.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 08:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=C9FXET8nLUYT7EaXtCe+aZgjNqt94iaq704cE4c5DaY=;
        b=koIWB+/7PXG5fMOwFrE5jwXh8lO8++Vu3oHWGfvuaQZdnCb4+Cd8dYW5oUao1PkmBQ
         IJx8oWZHp0vRSf/eRZJq5Ezy1rMDi5qG99/iaMFGOV9/18esW/KctrT++jWAIH//0rVa
         +um6A5qT6lnYKzbq5ZnY7Ua0bHBZJHyh2zrSuHwD7M+1sfG+ztJb3+g843KNX4NZPy6F
         +0tTtBsvuV60QgCHGK2HNjkJPMP70bzCyNV6GM1i9F3ZzfQLPNERVMof1MonOtNZyP0f
         w4hXPj69+9/DxeNbgeL69BGK9/qcdLGEINR0Gnw2GRbiHFzzJxHSNN5TPZuzm3mQ7bPf
         U4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C9FXET8nLUYT7EaXtCe+aZgjNqt94iaq704cE4c5DaY=;
        b=jOQ1MJGvFth2ufX7vlq7w3sjD7zIGN5hKt09NgDbxapYGgPl6U6YgLxK7SHApM4yG3
         l84g+HM+z+d1LauF8h0nAP0Hd3zW9gY3n94HUzePCXmqXGYmSG9Y/vYimoLrkPE2S4PF
         PbxOo9ShbdzjQAVMKr0POxbQdkKZyKTVummG1Oh3ISM9bYYTjSsv21QIMr9Yif5X8Avk
         1/HgYsQbFpiha/cuCwfHyPIe/xKw3Jl85G7VNYXbAbqLUaCjVG4/zhduDxjPmZRY74xI
         7FYXM6vh6k51qoNoSeczbLlRfkKm+laccarmkSpfEbCN3D4du2QkxQif5RQxfgynyt/c
         nCzQ==
X-Gm-Message-State: ABuFfoiDT11urXR4jeajjRMqccQM4Io1WtRUs2/iTnp2sB3O8/MxMUKQ
        /7nNii7Kexpr5ZuEbn//XLkP35fIAaPcwz/t8Q/XV2drwwsXLzBRCXJlwq41JUC2B8+NntoaxIn
        fB+6eevUUo0S2I1DE/1suuSHde3qH
X-Received: by 2002:a24:7cc6:: with SMTP id a189-v6mr4955747itd.42.1538667855857;
        Thu, 04 Oct 2018 08:44:15 -0700 (PDT)
X-Google-Smtp-Source: ACcGV6139mxWTu6Cd7JeIiZzfcE6qrA5mkFrSqiynLLU2FgYelr8Ga4qly/ETt1TuCOcjqg2ZQgiNw==
X-Received: by 2002:a24:7cc6:: with SMTP id a189-v6mr4955733itd.42.1538667855664;
        Thu, 04 Oct 2018 08:44:15 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id r202-v6sm1569637iod.28.2018.10.04.08.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 08:44:14 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org (open list:TI DAVINCI SERIES MEDIA DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] media: isif: fix a NULL pointer dereference bug
Date:   Thu,  4 Oct 2018 10:44:02 -0500
Message-Id: <1538667843-18091-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In isif_probe(), there is a while loop to get the ISIF base address and
linearization table0 and table1 address. In the loop body, the function
platform_get_resource() is called to get the resource. If
platform_get_resource() returns NULL, the loop is terminated and the
execution goes to 'fail_nobase_res'. Suppose the loop is terminated at the
first iteration because platform_get_resource() returns NULL and the
execution goes to 'fail_nobase_res'. Given that there is another while loop
at 'fail_nobase_res' and i equals to 0, one iteration of the second while
loop will be executed. However, the second while loop does not check the
return value of platform_get_resource(). This can cause a NULL pointer
dereference bug if the return value is a NULL pointer.

This patch avoids the above issue by adding a check in the second while
loop after the call to platform_get_resource().

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/media/platform/davinci/isif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/davinci/isif.c b/drivers/media/platform/davinci/isif.c
index f924e76..340f821 100644
--- a/drivers/media/platform/davinci/isif.c
+++ b/drivers/media/platform/davinci/isif.c
@@ -1100,7 +1100,8 @@ static int isif_probe(struct platform_device *pdev)
 
 	while (i >= 0) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-		release_mem_region(res->start, resource_size(res));
+		if (res)
+			release_mem_region(res->start, resource_size(res));
 		i--;
 	}
 	vpfe_unregister_ccdc_device(&isif_hw_dev);
-- 
2.7.4

