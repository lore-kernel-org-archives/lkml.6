Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C648C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03202213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzlLr2L0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03202213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeIMIOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 04:14:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36006 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeIMIOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 04:14:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so1984700pfo.3;
        Wed, 12 Sep 2018 20:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YQ5exA3UDgqtg3kFvjbqHCjK5UqOrYOG45Iw4jIRy8U=;
        b=lzlLr2L0jja7WSAFcE4TP212fMrFewIqtAiR5IR2eQzGATj8z+t0/Vni4gLgm/cfRs
         raf8YerJsEYOxsibB4mVWIH/xAKudIU4ZOvHxcb3LCuzPA2mkXLUmqcGL823ihpW+9y0
         i5ldmqobsTuqnft7vvb8kq50E3r744YN9xN3xMlu5EFjHMz8L1/UoGcB0rwsmLJE3TNz
         xVWdqbeqwqBE567u5VKR2HM8k7LYax3SArfutoCNzs3HCizJvlT6wrQTMnyEM04Fo5lH
         awMwp1/OugOAIkuwwKC1/KGBcY4g9xSy6hatLe1SyxDGGQgq3NbDhj1oTq3h/wfza6Hy
         zzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YQ5exA3UDgqtg3kFvjbqHCjK5UqOrYOG45Iw4jIRy8U=;
        b=SPY2RJ5eQ2JhXscOJvxCHNKZ5vZk7WuCEmfo7Qu2x3IGjOW07S+neeiTZowRdQGm0E
         odI3/04xfNFTi5RY1Krt00CaV4ZLP4HiBJGusx1iYWgVQcWrOoeoxw1NKGRigHmvSvh1
         7LxRP5BeORBG6t2w3yjZYlY60NhgdzeuoeIoPvY6ssyKv1rLbRsh53GZNibKWUJdLz79
         u67dpE6LwY1dCJwLCk/t5LKwhlFhvU8udh+JG1c5izjUR1/TkVcXUiomddhCXl1NOJzz
         xrbU72NoQ2Cx3FYORaLCnSMnC9XuNJCiULqtFC97oa3Iwmpjwo7oJhH1B4l8RO1ETGT4
         rPzg==
X-Gm-Message-State: APzg51CxoMFnnkQ1zGsCcopyCzL4BozlvwCi8Gc5zgaPU9goNcYuW/Xa
        p+u66Y0PwuqOjeQRbZb9HBY=
X-Google-Smtp-Source: ANB0VdYZYLOsc4W5XVzoDK/9d8OcXPdIYnq4WubychtjSXiQcWICFH9H0HR39HnN42CMvrATWxf1gQ==
X-Received: by 2002:a63:b258:: with SMTP id t24-v6mr5166013pgo.317.1536808035407;
        Wed, 12 Sep 2018 20:07:15 -0700 (PDT)
Received: from josh-ThinkPad-T460s (cpe-75-80-215-168.hawaii.res.rr.com. [75.80.215.168])
        by smtp.gmail.com with ESMTPSA id b203-v6sm3841027pfb.174.2018.09.12.20.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 20:07:14 -0700 (PDT)
From:   Josh Abraham <j.abraham1776@gmail.com>
X-Google-Original-From: Josh Abraham <sinisterpatrician@gmail.com>
Date:   Wed, 12 Sep 2018 17:07:11 -1000
To:     vinholikatti@gmail.com
Cc:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, j.abraham1776@gmail.com
Subject: [PATCH] scsi: ufs: use PTR_ERR_OR_ZERO in ufs_hisi_get_resource()
Message-ID: <20180913030711.GA12975@josh-ThinkPad-T460s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PTR_ERR_OR_ZERO instead of IF_ERR() return PTR_ERR().

Signed-off-by: Joshua Abraham <j.abraham1776@gmail.com>
---
 drivers/scsi/ufs/ufs-hisi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
index 46df707e6f2c..e79499469cb3 100644
--- a/drivers/scsi/ufs/ufs-hisi.c
+++ b/drivers/scsi/ufs/ufs-hisi.c
@@ -505,10 +505,8 @@ static int ufs_hisi_get_resource(struct ufs_hisi_host *host)
 	/* get resource of ufs sys ctrl */
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	host->ufs_sys_ctrl = devm_ioremap_resource(dev, mem_res);
-	if (IS_ERR(host->ufs_sys_ctrl))
-		return PTR_ERR(host->ufs_sys_ctrl);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(host->ufs_sys_ctrl);
 }
 
 static void ufs_hisi_set_pm_lvl(struct ufs_hba *hba)
-- 
2.17.1

