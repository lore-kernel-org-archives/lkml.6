Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4806EECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0005E20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rircDlgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0005E20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeINP1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:27:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54813 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbeINP1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:27:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id c14-v6so1371479wmb.4;
        Fri, 14 Sep 2018 03:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wQJV+ddJAv5kZKQDNvJ+wHS7DL8i4Je+cSh6xS7XWuM=;
        b=rircDlgBDrHWS6V0DOCcfoALp08ITkG3cQ57mUW7/dQW9MhPvpXC9MaJHZD4JFOI7h
         qKMb3jIRf04nxQSuFVj4cpLQJ78Cm+PNn648suHBIaqZP2UWd8b3tCgjEfSyPdSxIqjm
         A1loWb8zNhxtU80TYzg0Dj6lTTtHHGbgu0W1aky+Ukrdv8j2iaRljnVwl9IEiuy6noJr
         CoexKYHOav8Shb2F26s6rbnNSBjZfZAGDXBDZgdXJKLu22hORAr1+f0ozckapDmBpLJ3
         ihAzUGDDn550klDx8+4KhI+utfVHeFKEtUc2rRK7zlvyp7MjPxBZ7ptAeDwE2IsCg1Wn
         hRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wQJV+ddJAv5kZKQDNvJ+wHS7DL8i4Je+cSh6xS7XWuM=;
        b=BSVxvE0ZT1k3qKVir33BOVOt1yAlkSNvCNg0JzMZEaPO9dwITvYP2Ezjfi9SHUtofB
         6U8McC2vErFK7mtEsmNBX19rU1+eVhalXodfQk0qUunwYo1yalyOTldRuBFmDtQSRoV9
         ohu32uWPVQNNMYTLshpEPeuWZDSzSCbvfKN2jwnVGCEB63C95cPQFbRdP+YAThpc+wrh
         /Z/c4iA9ZPpEk61cMK58ZTXkDKUKm4GyzXwhKGk1X42Lrjc+c+8qbMfz26hBsWEMAWkZ
         TrFAzxpLOzqEHXwZ3xv1gu+k9fyFSCRIsA45H7GODig9jqQrhn8xL3DtVhQd6ZnmGkDS
         cseg==
X-Gm-Message-State: APzg51AMXA5gl41xfKVdsUqdGEFFspNCDYWHL6pPGeXq9pBx8b/Bn3mR
        vbLJz3aPp53AMVXPMWBNnEI=
X-Google-Smtp-Source: ANB0VdZY8rvGy+QS/OOWRyvjzzsgebRm2THF2oWSkUDULpGLrdu6XY0391j5GLt03LxcjIDA5ZGA7w==
X-Received: by 2002:a1c:ed4:: with SMTP id 203-v6mr1576847wmo.96.1536920037259;
        Fri, 14 Sep 2018 03:13:57 -0700 (PDT)
Received: from localhost.localdomain (static-css-cqn-143221.business.bouyguestelecom.com. [176.149.143.221])
        by smtp.gmail.com with ESMTPSA id x15-v6sm5618524wrt.53.2018.09.14.03.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 03:13:56 -0700 (PDT)
From:   Romain Izard <romain.izard.pro@gmail.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH 1/2] watchdog: sama5d4: fix timeout-sec usage
Date:   Fri, 14 Sep 2018 12:13:38 +0200
Message-Id: <20180914101339.7382-2-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180914101339.7382-1-romain.izard.pro@gmail.com>
References: <20180914101339.7382-1-romain.izard.pro@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using watchdog_init_timeout to update the default timeout value,
an error means that there is no "timeout-sec" in the relevant device
tree node.

This should not prevent binding of the driver to the device.

Fixes: 976932e40036 ("watchdog: sama5d4: make use of timeout-secs provided in devicetree")
Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/watchdog/sama5d4_wdt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index 255169916dbb..1e93c1b0e3cf 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -247,11 +247,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = watchdog_init_timeout(wdd, wdt_timeout, &pdev->dev);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to set timeout value\n");
-		return ret;
-	}
+	watchdog_init_timeout(wdd, wdt_timeout, &pdev->dev);
 
 	timeout = WDT_SEC2TICKS(wdd->timeout);
 
-- 
2.17.1

