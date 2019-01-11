Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0047C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6687D20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="rqlrRaA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfAKC6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:58:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46750 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfAKC6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:58:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so6226577pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 18:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=VUEgoQGz4uKBYJBs5gDxOg7Z5yiw2mLaRJxRPbf+cPE=;
        b=rqlrRaA6TLlagMSVodwktaGfsG6NWqUG2llGg2QZq7Dpl4rGtTqwpmIGY1poRGMvxf
         7piCLXvMT+PdxNasTTn3vuysfd/2AErBH0dby8YjiCjScTzlTiILdpWLJPCs1SZHw05j
         EfT/QEnNOle/gI6wDc+0tisHCWbjS54qsCvKGMeFUafAzR6KDYSI2J61xyprznp8hNTr
         z4HFaan0kOnXAwNb6wGLiJ4/WTblIoHsCyKaFTnfX8aWMyu8HnX3C3xAmgrREW3a3yB1
         DTk1P1FXbX3iQnvEtsphxoF0OR/cKc08OL1h/6/unbnxCr56iWMFEyvehKZ3+ChjBFAe
         Wc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VUEgoQGz4uKBYJBs5gDxOg7Z5yiw2mLaRJxRPbf+cPE=;
        b=sU0ENYnsCyUZzyWPWAqyEfPvf0UWWxri5zoQBryasahT8upsdzWdByr4IySef/hI7r
         8LRJU06ZEILTWIyz8iOVi+t4Uw0lNqPTW7/H0mZGAHj6ubmxAUAOMmUd+WUAMqPYDd7b
         4SUqdY71RJldrEuw1HnTGN8l/9XSI087e+qWHqh/xaMErvbB//mBnyZOwgKYmwn9C/ZD
         /IWc23kPEDLI5YhVsQrB9dr1a2nPkOD5rRqOjgObX8vXqX8uysEQa5ya0/+uvzskSUcZ
         Krkxg3ztaKOCQSZJVwDKN6bGrgL7gbyN4/Grd0U80E5pAUm+4i115B76U+minDknYR4Y
         A60Q==
X-Gm-Message-State: AJcUukcEMVyRdzkdTjPBzZ+X6snwh3GQRklVhGJ5c0cm4ikGU1HftR1d
        KhKwi+PEMuPuEbWJC6eTHlbLCw==
X-Google-Smtp-Source: ALg8bN5q/lFx8s9ZZbe2EMgf8cmsUDZi6XFAwfAW9h611aZraZJ6oCpbWk86FujWiOP7eqkQ3OfrBQ==
X-Received: by 2002:a63:4342:: with SMTP id q63mr11752727pga.63.1547175532335;
        Thu, 10 Jan 2019 18:58:52 -0800 (PST)
Received: from localhost.localdomain (36-239-240-185.dynamic-ip.hinet.net. [36.239.240.185])
        by smtp.gmail.com with ESMTPSA id w3sm111295898pge.8.2019.01.10.18.58.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 18:58:51 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: max14577: Remove redundant MODULE_ALIAS
Date:   Fri, 11 Jan 2019 10:58:22 +0800
Message-Id: <20190111025822.17196-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The modalias is set by the MODULE_DEVICE_TABLE, thus remove redundant
MODULE_ALIAS.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/max14577-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/max14577-regulator.c b/drivers/regulator/max14577-regulator.c
index bc7f4751bf9c..85a88a9e4d42 100644
--- a/drivers/regulator/max14577-regulator.c
+++ b/drivers/regulator/max14577-regulator.c
@@ -324,4 +324,3 @@ module_exit(max14577_regulator_exit);
 MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
 MODULE_DESCRIPTION("Maxim 14577/77836 regulator driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:max14577-regulator");
-- 
2.17.1

