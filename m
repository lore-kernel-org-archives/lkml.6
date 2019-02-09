Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B8DC169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB0D20821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHvdL2dY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBIAdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:33:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33688 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBIAdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:33:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so2300038pgu.0;
        Fri, 08 Feb 2019 16:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xSDiEUomFlKO81BcHg8wxzxKpBA9WTirXiTn2sWcb0g=;
        b=rHvdL2dYMBfO5I57l3R7mnQ8rEzrxc3ENpgi9e+2dRuOvfq0uTCdiozzg36O4gV71f
         6E6EZzVLx7im4Icn+p3RZFZABsEBm2prOAf/XbNcqKpbIJd1p04a90qsAnTSKseZXv/P
         +chU3hIelyMGQLraXJot2mN6OyWb9rYMKz6oxprr2W0TU7InlWFr04jp8SlYGak1MihO
         8qHQO0MipMmEA8nErV3V6fj8tfUzJhfw/xX1jBr4Kp8R3DUVzIaCAw+WmQ15o1AFf5Rk
         aYCOojiUNVsnb6bgSnpRuERZorLUaRKiwjuz4rGoNpXzdAXBvvrNZ2NuAy7fxNW/GYsV
         8vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xSDiEUomFlKO81BcHg8wxzxKpBA9WTirXiTn2sWcb0g=;
        b=ca01oG1HTd5b9sFlhiWdwAXj1bMRFU0T+jyWJ/M6xopE4qP5fkwQRZKexZPoa+j+Z1
         /ey8yCaXOiPtKOtYBJHMNB/01ptO1py0EnNQuMOJmKn9uAgm+EB8IaZgukWP8u8AYHbl
         VSkfXQfOw3//dRgqRFYH45iMrgFr104UNYu3ZyUA8y2NL1rTsE2POm2BJpSpqwUZ6KWs
         2iWVG6wTecG2r2L0kH8ZCL81w4pkolED3UOpkDkvusuJKZGQLr+pmGInxxSTbPSK0Mma
         CMqDp+oAVHam42asmgyazPiaO8qG5A0axIPtOnao3GXiugWUTf6bizu8kArbxsaLYZfC
         GjEA==
X-Gm-Message-State: AHQUAuaEpNxLQGpnsphdVT+soiQSiLsQ3Kpf/42mK4T945//WhHMZV4/
        vq2iI+CqaGBZHNrptED0PmK81HCM
X-Google-Smtp-Source: AHgI3IaPNWArHT7OstmG4D43bcqk7uC5UURIRyXgpM8MkNnIgr+z2Q7LqaJzmZEXnU/X32pM5On+rg==
X-Received: by 2002:a62:9fd9:: with SMTP id v86mr24964024pfk.191.1549672392171;
        Fri, 08 Feb 2019 16:33:12 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i71sm372491pfi.170.2019.02.08.16.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:33:11 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 01/16] Documentation: networking: switchdev: Update port parent ID section
Date:   Fri,  8 Feb 2019 16:32:33 -0800
Message-Id: <20190209003248.31088-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the section about switchdev drivers having to implement a
switchdev_port_attr_get() function to return
SWITCHDEV_ATTR_ID_PORT_PARENT_ID since that is no longer valid after
commit bccb30254a4a ("net: Get rid of
SWITCHDEV_ATTR_ID_PORT_PARENT_ID").

Fixes: bccb30254a4a ("net: Get rid of SWITCHDEV_ATTR_ID_PORT_PARENT_ID")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/networking/switchdev.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index f3244d87512a..2842f63ad47b 100644
--- a/Documentation/networking/switchdev.txt
+++ b/Documentation/networking/switchdev.txt
@@ -92,11 +92,11 @@ device.
 Switch ID
 ^^^^^^^^^
 
-The switchdev driver must implement the switchdev op switchdev_port_attr_get
-for SWITCHDEV_ATTR_ID_PORT_PARENT_ID for each port netdev, returning the same
-physical ID for each port of a switch.  The ID must be unique between switches
-on the same system.  The ID does not need to be unique between switches on
-different systems.
+The switchdev driver must implement the net_device operation
+ndo_get_port_parent_id for each port netdev,  returning the same physical ID
+for each port of a switch. The ID must be unique between switches on the same
+system. The ID does not need to be unique between switches on different
+systems.
 
 The switch ID is used to locate ports on a switch and to know if aggregated
 ports belong to the same switch.
-- 
2.17.1

