Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D76C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4452084A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="mf4k6NBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfA3NEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:04:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36848 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfA3NEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:04:42 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so11029740plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=imdjjwGI+C/Ysj1zZBsNPuPs051hwglpOibknRAu9ts=;
        b=mf4k6NBSglHDn0985IcJAxUfNrG9AKh2vttYBcg4aGtOLibf6ZtPnpLQTUDg7Apk4Q
         yv55dsrZkKxG1NW14C9NwPsh7qjeV4ao/PtsArlmXW2pQFmayVEjIHGgDKBUURR38vYD
         It1D0BLyU5WYUoc3U70wqn4UjsCjrIMyDvjKYiL9CcDXdnEEq+loqbJUcuWhE3uZeaZF
         VvknLBf1T/Xco3Frg0wO8fZPJlObJUuK6ZSlQZEmnHCdcB8Lb15z+oXCiSJuKyssGccb
         UZfvoy5OdZmGlQUzTtcXzVSniEkqKcxk2Xl28RanZbQBhB/To9+hxBfFQh91mGcJ44i3
         kE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=imdjjwGI+C/Ysj1zZBsNPuPs051hwglpOibknRAu9ts=;
        b=WEAsjg/JgdmptSoAclo+hW82JYiU8To8/S04/aaChp6tjXBwMSVz8wRRtcmUtgaKZW
         0SiKrP7E8w2nZIA++554ElEwxPMkcNKlkh0j2rUIj8ngEBNXSV2OnG/BhYQzUY9fC54e
         wVW1Vk9+LraJB7X3YrHW8Ekxwda96/Mb3gvebYi1Aj75XjndEZTYBIVcOYz/y50H1Sc0
         uEIa+uEfCvys7pytlH6DZYZJqS+GaYbtOiwIgzMzX2taF3otrTFqxaKXFVjqp/12QcDs
         14kDUnulqRFccUe2/HBKhTirjiD2X5xTN1ys9mt/UtIjJ/gvw6qU7Fc3krrJW182VJ3l
         k1Tw==
X-Gm-Message-State: AHQUAuYVGAngQjfQJRwl6uY4ryKaWlwEOTeHsLMBmqOUD9Njr41NVF+l
        Q35UAHEyEqMX364ABWNO+lmrQA==
X-Google-Smtp-Source: AHgI3IYjj7ucOmaUVMLu7OCWMX7HL/bsvhHEKTunKm+74HP4E7e9sJ5LPHE8nCJre83Lsu0qL3xiiw==
X-Received: by 2002:a17:902:b03:: with SMTP id 3mr472671plq.91.1548853481693;
        Wed, 30 Jan 2019 05:04:41 -0800 (PST)
Received: from localhost.localdomain (36-239-242-165.dynamic-ip.hinet.net. [36.239.242.165])
        by smtp.gmail.com with ESMTPSA id m3sm5128033pff.173.2019.01.30.05.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 05:04:40 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Milo Kim <milo.kim@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: lp8788-buck: Remove *regulator from struct lp8788_buck
Date:   Wed, 30 Jan 2019 21:04:19 +0800
Message-Id: <20190130130419.23548-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130130419.23548-1-axel.lin@ingics.com>
References: <20190130130419.23548-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not used at all, remove it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lp8788-buck.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/lp8788-buck.c b/drivers/regulator/lp8788-buck.c
index 30de784d8e30..f84167688e5e 100644
--- a/drivers/regulator/lp8788-buck.c
+++ b/drivers/regulator/lp8788-buck.c
@@ -91,7 +91,6 @@ enum lp8788_buck_id {
 
 struct lp8788_buck {
 	struct lp8788 *lp;
-	struct regulator_dev *regulator;
 	void *dvs;
 };
 
@@ -523,7 +522,6 @@ static int lp8788_buck_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	buck->regulator = rdev;
 	platform_set_drvdata(pdev, buck);
 
 	return 0;
-- 
2.17.1

