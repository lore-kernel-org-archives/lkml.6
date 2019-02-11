Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18D4C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C96E21B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odBBgn09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387742AbfBKTKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:10:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34015 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732529AbfBKTKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:10:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so13486plz.1;
        Mon, 11 Feb 2019 11:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=whP2T31Mi9yk1nJwoFJ9GEi1TFBKA5bW2oJpYvjtFLM=;
        b=odBBgn09m3CSnwo8BpV1ZdwyoKxI6zXAcmYOB8E4WV7RseuMKFb18n+ySxPrTjrPJj
         jPp4ldQaw1Y+bwbAjjrlxfz0SZ/Gx/NB8Hbc63u7sbDu5eM8lRZ6cxtsD5tNpBp19Kcr
         t6lZv/miLHHY+V39TLgtGoX3ODSqvThlZKj4dT8d6QygKkHan9ASiGq+EZqXirWbVdOc
         JoiCDJnWPXW3TyBfzTGIYKoTMU742ZAr6K4X9iEacCF0B6pkKS3pCxvsv7P56TaUgNZM
         u9zzXJyoI3UOBSXBuM2uvAwIh0+WhE6+53TvC30R8DSN2cnj/O72hHsFO6dkZE3Xc4sH
         q60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=whP2T31Mi9yk1nJwoFJ9GEi1TFBKA5bW2oJpYvjtFLM=;
        b=E5mAma+kxBCQR+8Ehb0Vv+leHJtegi3ZJTeUmVTp9hKP5V6TZvs+d8crUeFixQ9BLL
         BUN/2ScrM0h1U8T03wUANkCZIHRAaaPobtc/D3ejG9AVutgHMdP04RtVj3Eja2wBqeN3
         GjNdwFiLxwr10hFitYebb3/5GA1rHxu0uFeq7J88H8wTI3lleprMjjS+mmrsb92YUTDQ
         dCZAwvlZiWQyUyvrhsGBT1pBWCN6VTc7a7iP5YSbiZotcihjlPe0S99cKewB9X0wTsc9
         IH5hALTB7Eh+2/18VTbRrzv8fH9T8/NSkn7HSp2nyfdk+tvCJl67l1T4+8tlL1VNHIiG
         A2/w==
X-Gm-Message-State: AHQUAubAACiAvrTIWzNuixoy359h1X/LETP9MtWErJQ7uH5j546SlUpN
        XJdDHxAlcEnxzfvH9oCBPrOPEMUk
X-Google-Smtp-Source: AHgI3IaVDXMVGBh5If1b9vC3yvgsG4rGOdR6dSN+b5jt4kyZqz6TzjbAEL3yzAUjsXclkGtTr6+UGw==
X-Received: by 2002:a17:902:27a8:: with SMTP id d37mr39370965plb.182.1549912228883;
        Mon, 11 Feb 2019 11:10:28 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i24sm2167206pgg.14.2019.02.11.11.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:10:28 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v4 1/9] Documentation: networking: switchdev: Update port parent ID section
Date:   Mon, 11 Feb 2019 11:09:53 -0800
Message-Id: <20190211191001.8623-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211191001.8623-1-f.fainelli@gmail.com>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
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
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/networking/switchdev.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index f3244d87512a..ea90243340a9 100644
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
+ndo_get_port_parent_id for each port netdev, returning the same physical ID for
+each port of a switch. The ID must be unique between switches on the same
+system. The ID does not need to be unique between switches on different
+systems.
 
 The switch ID is used to locate ports on a switch and to know if aggregated
 ports belong to the same switch.
-- 
2.17.1

