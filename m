Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EEEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210E920700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I49YC+BL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfBVUdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:33:00 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40951 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfBVUc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:32:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id bj4so1586526plb.7;
        Fri, 22 Feb 2019 12:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GZkhi+mmpXnSn7pqionH/4UxhpUTb4ioOMnDR/vNPPs=;
        b=I49YC+BL27hrJ9lCeM19dga7HTRj1VONjkd3ZBolv3HwtqYUzYA7BwOva8IB0RYdvg
         xBFdt2wmwxGTsQ4qpiafa2WRLL0tb1IaDo5HVtxMtgORBA+YW9kMK+oyD8DrADVd290g
         P1s16xd0neXVI8Ps+FNI2Wur1PBl98f6ycbNUfw3m5+Xkrpl8LXISL907epXygyEB0Xz
         MbM/S+r451gnUYp/wTCigVBTZhS6yRjc5yaR7ZKHxDAEmcBVBf0FSHATbt5/Q3JWl9Dr
         AX+GudfiaPgPS0v6CVIrlo/3sb0+DdiivrZ3jSt9gJwLmFd5rYrzdiLxFaAXXzrGf2me
         1LKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GZkhi+mmpXnSn7pqionH/4UxhpUTb4ioOMnDR/vNPPs=;
        b=lJkuLggaTTE2vTVePNHMvpv+k8wHV1K8uqGoNCBsiLnoF8twlhMNQD9cyeITxtALVY
         0KZvzOgGeD9UnmVPQrkrR2zPCyAM7CvdWY3HMokuT6XaxjHV1b8ZVpQKK6Bdobyu5Vmf
         DpHerTZwWxh4ZxK0dAGNQZoQeV73eeYYuGsDzh3f5C2fSa5UGdpnQOkHn/U7XEyTas9p
         G2Z2o2OeuAkRBJu6mHHzOqfuT74iS8TB4uJfSWSSFs4BHAaGNbovMt1kT7mNumbQ7O8/
         OCUIoblPt2H9zuItYQ1MC3mKLjlvgUXkayVT/U3XcPPI8Xs30aRq2KSJEwt03bWC/Ypx
         mgRQ==
X-Gm-Message-State: AHQUAuZMmbp9FmO/G0mIblXJXqrWf1QLeSpdVdD21uJCxBAmw2iTTyVM
        iNAZRPPsfs8F9AotbikgzDfkARPW
X-Google-Smtp-Source: AHgI3IZ0+/DM1+5H1t9G68nuY1hM7HlKZaCuRItX3WXjWvjNhXqa/uGG5/urYXKTwanmT6+q1rhgHw==
X-Received: by 2002:a17:902:284b:: with SMTP id e69mr5839589plb.11.1550867578324;
        Fri, 22 Feb 2019 12:32:58 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q62sm4423860pfi.183.2019.02.22.12.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 12:32:57 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Jiri Pirko <jiri@mellanox.com>,
        oss-drivers@netronome.com (open list:NETRONOME ETHERNET DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/2] nfp: Remove switchdev.h inclusion
Date:   Fri, 22 Feb 2019 12:31:33 -0800
Message-Id: <20190222203134.19508-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222203134.19508-1-f.fainelli@gmail.com>
References: <20190222203134.19508-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is no longer necessary after a5084bb71fa4 ("nfp: Implement
ndo_get_port_parent_id()")

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_port.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_port.c b/drivers/net/ethernet/netronome/nfp/nfp_port.c
index 7e90880fa46b..93c5bfc0510b 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_port.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_port.c
@@ -3,7 +3,6 @@
 
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
-#include <net/switchdev.h>
 
 #include "nfpcore/nfp_cpp.h"
 #include "nfpcore/nfp_nsp.h"
-- 
2.17.1

