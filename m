Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD98C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B68222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7c9E5oA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389028AbfBOSQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:16:15 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39915 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfBOSQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:16:13 -0500
Received: by mail-yb1-f195.google.com with SMTP id s5so4142271ybp.6;
        Fri, 15 Feb 2019 10:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0go488RgnPPm/Ui9LmmLamxGGya9yogRZa7CFwmPBRE=;
        b=V7c9E5oAW/5y5FQVr/IlpNLlofjCAHumLqR2BEbQMmScM8zefkNzLts0LVeLcCztdG
         OpR+HpJDr+ztsgnUNWH3OFjysM5VKhZaQwg9nnSCx7kcfPA8ydOcmW2P0eFTqAd6T6rA
         aYxgx4E2Fp9nZxVzSLnm/Bp5iZQfIDulD4QxG1G041GWTJOvHr6gecBUTTP5aTNdYJpT
         5slGX/BUppXZEfrvEsXdnQfEzIbFjrL8GleEwAAp9L//4Ky7UCRDZeOoVXM0pRioUq6e
         4+cjoyZifR0rWRakA3bk8DQyReUd58opQU0Cwn+I/tIYU7B8u0sEWXvUCCy4+viFvoPC
         ga3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0go488RgnPPm/Ui9LmmLamxGGya9yogRZa7CFwmPBRE=;
        b=R/CFOmUusgZiykDcZrw74NgQtiMJdcTtcNBKXUoVQhD5qPXlcdJwMo682oSDWHG9Do
         B/twrfbdiD1vkNPWBJNBLVaNFSDzuTM+YT3qbFB1stcKT+bk7EHJjsxa6P8VNL3Xsn8s
         nezPvnEaP6iWNw5DGGLOpz9V+O+5YecNSxK2+oXN2zejFweLco1zVc01J70WQXYTqjEO
         01bLZGgRyx9UuLjKUDpMCkJNWL+hkqprAJlxU6Z5ltZQnglXzkiFm4ybvS8luDVvBp65
         HerPce5K7hsyrbgOC+ZuZ41rTzVmlvA/rpqVxpNABLsT77uMrHTkJbzYgMdKrXC9vWaR
         bjCw==
X-Gm-Message-State: AHQUAuZzuMnw1EClgGNJrFZig8oTmO/VfyY2dYxXbKdyoiQP+ZF+uEOf
        vp7oDXFA/Wuy9akyWMzEpTtx3Lkz
X-Google-Smtp-Source: AHgI3IY8w3MFt81bV769wY8MjptLMOkfhVlLedT7f9ZMD5883bT5lpHswCFcOaWAKaRhViUwOKT2og==
X-Received: by 2002:a25:1c1:: with SMTP id 184mr9358640ybb.188.1550254572354;
        Fri, 15 Feb 2019 10:16:12 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z139sm2355075ywa.36.2019.02.15.10.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 10:16:10 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] selftests: forwarding: Add some missing configuration symbols
Date:   Fri, 15 Feb 2019 10:14:52 -0800
Message-Id: <20190215181457.21101-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the forwarding selftests to work, we need network namespaces when
using veth/vrf otherwise ping/ping6 commands like these:

ip vrf exec vveth0 /bin/ping 192.0.2.2 -c 10 -i 0.1 -w 5

will fail because network namespaces may not be enabled.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 tools/testing/selftests/net/forwarding/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/config b/tools/testing/selftests/net/forwarding/config
index 5cd2aed97958..da96eff72a8e 100644
--- a/tools/testing/selftests/net/forwarding/config
+++ b/tools/testing/selftests/net/forwarding/config
@@ -10,3 +10,5 @@ CONFIG_NET_CLS_FLOWER=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_ACT_GACT=m
 CONFIG_VETH=m
+CONFIG_NAMESPACES=y
+CONFIG_NET_NS=y
-- 
2.17.1

