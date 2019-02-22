Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243D5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E420B20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdI0YT9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfBVUdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:33:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34775 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfBVUdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:33:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id i130so1637351pgd.1;
        Fri, 22 Feb 2019 12:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iVuz92haWaSeAowFA5brpV3ujx1hvhEPagb9ky5ze80=;
        b=kdI0YT9sOsvtz9+oSgG6Ehcd9nVauhp3/lPwfUJ6QiAsmyN0iEc1CTmGKmZaL6u0mD
         jwJRwN4hUzOfmdryXsMRqwSOqBPz1vUGFgIbzJ2EO5EFWnCcoOklrg4PQS2Ssh+j63x/
         OHTXeMKZhUMpjBqLQ8jVfcUtkSyIBq+oNMHzTtcRY2qvY6OyXxVTElaUvvU1nRN6SlOt
         8OwYrOKqL6s+e59oWxifV8DqCVvnI8+0TeA+6mZVn9OrWhe5hKg1eMOIz4a4M+TlmR2V
         BEgOTZLPxAwxdcsPwH/DZyPeptvhGJAsAMcxjmHdjRqiDkPeOPPkfNqVIpyVGtMNx7nR
         CoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iVuz92haWaSeAowFA5brpV3ujx1hvhEPagb9ky5ze80=;
        b=Nykc2Y0Xop8eoSwwolTmHN3WQBuaVWeGFmRJUjzj7NlIQ9NFUBy9v27+ZwTmkwQQbM
         o28Hk4mlVitWWgGwfxTHduHxS7qc964T+OqrcuxV+wkgmcGy70TBCg9Th4DoE65ehW0p
         kfAiNOq92v1HofzuOWNQs8pPsAy7/8Wg+S28UQog5CZttIXRDeQVX24m+8LXoM1+NoF/
         mlqUpcQOhkzpp94c3hTi8Jn/Enjtfk2tbSfOU/U6khl6bUvp3qLMsIFPpYH72OPwHXoe
         v+eBLZNWy3o50xJFyjwLFz2fmYbUROi4OZseIfypvpumViehysbB0LJf4v0uHeimBfWC
         6LWQ==
X-Gm-Message-State: AHQUAuYmPKHuC7qI5hS/k4ljuotjzGFxGjFwYMCEVMQoVIE3TDPMW1Bk
        4sNtM5GVQj5R61lyi/ozzx3cltgc
X-Google-Smtp-Source: AHgI3Iabm817ObSUiskNIWW7l9guZm8noRlxXFgCbmxefuEBuj5EOrpGZOiyQf9LWbmvtSfyStvyGA==
X-Received: by 2002:a63:4566:: with SMTP id u38mr5708915pgk.4.1550867585606;
        Fri, 22 Feb 2019 12:33:05 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q62sm4423860pfi.183.2019.02.22.12.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 12:33:04 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Debabrata Banerjee <dbanerje@akamai.com>,
        Sun Lianwen <sunlw.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/2] net: Remove switchdev.h inclusion from team/bond/vlan
Date:   Fri, 22 Feb 2019 12:31:34 -0800
Message-Id: <20190222203134.19508-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222203134.19508-1-f.fainelli@gmail.com>
References: <20190222203134.19508-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is no longer necessary after eca59f691566 ("net: Remove support for bridge bypass ndos from stacked devices")

Suggested-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/bonding/bond_main.c | 1 -
 drivers/net/team/team.c         | 1 -
 net/8021q/vlan_dev.c            | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 485462d3087f..a044a8032a0f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -77,7 +77,6 @@
 #include <net/pkt_sched.h>
 #include <linux/rculist.h>
 #include <net/flow_dissector.h>
-#include <net/switchdev.h>
 #include <net/bonding.h>
 #include <net/bond_3ad.h>
 #include <net/bond_alb.h>
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 958f1cf67282..3ff23a993668 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -28,7 +28,6 @@
 #include <net/genetlink.h>
 #include <net/netlink.h>
 #include <net/sch_generic.h>
-#include <net/switchdev.h>
 #include <generated/utsrelease.h>
 #include <linux/if_team.h>
 
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index b2d9c8f27cd7..15293c2a5dd8 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -31,7 +31,6 @@
 #include <linux/ethtool.h>
 #include <linux/phy.h>
 #include <net/arp.h>
-#include <net/switchdev.h>
 
 #include "vlan.h"
 #include "vlanproc.h"
-- 
2.17.1

