Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C59BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74F620645
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkRO0bRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74F620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeHUTdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:33:05 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42582 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbeHUTdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:33:04 -0400
Received: by mail-lf1-f65.google.com with SMTP id z11-v6so11686712lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 09:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ejxToLkjmh4kxvoC43HtWFI56ySraISwQDXewSpr1jY=;
        b=IkRO0bRqI11r3WwMD2Dq6envhpiJjG0qn00AOppQqjZahStkl3B5nEeFgYkDr+MV4F
         7RLYTc5a+GD9n0IQleYFMXeIoVM6soYNbIKMEyhrKf/dVBRzr4cynX7qw9dnjeBAoRVW
         VQiZEzUGXPUpgqRSJ9Bl+6ChKDXt1gV+A9vH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ejxToLkjmh4kxvoC43HtWFI56ySraISwQDXewSpr1jY=;
        b=tMT/Y0olntDvCRESlirK4dbi7+LkP0E92iFtRtUcU+5hxG2tWOYk5oBP6EMy69gLdv
         WblbE1p+xKqrk+R5+LDlyEKHdquPNxgYWVIg8zl+UF0tvr3muO7I3Dl6KHsSSoZcfNZw
         PS51L2YFZfBCOwJtzlS6L0RmBU2Qz7+oTAiCRBq21Lngu2jzZyEkzxdIDrYB2+dXkmfV
         5XeHG6u+/ho7EnQlU46Wja/k4GtTgGdXJE36cnNIQOwsiTtRwwSf8zWCHWNY/7BWj02V
         3oN7rD452GVnpFOuf7yMQt9Q1PnrQ/W0XfXzNkZGwVX40iZYG1ndczjKK3WoLWlicMzj
         EOIw==
X-Gm-Message-State: AOUpUlG0P69VxIWEnnvapXJL6YIuaRFeWwxmDPgqeLYhtKEB2wERP5Rs
        a+f6sOqeMRTwX+HM47Z7Wokp5B9lc5rVUw==
X-Google-Smtp-Source: AA+uWPyo7BWMsFjyjgFt/6KoQ6faWpcHfu8kG1imh6R/rfcAfcIbJ3nGK10rL02SntTYhAYzJiaoFQ==
X-Received: by 2002:a19:9710:: with SMTP id z16-v6mr34562447lfd.17.1534867937292;
        Tue, 21 Aug 2018 09:12:17 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id g16-v6sm860667lfb.5.2018.08.21.09.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 09:12:16 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     davem@davemloft.net, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: net: move fragment forwarding/config up a level
Date:   Tue, 21 Aug 2018 18:12:12 +0200
Message-Id: <20180821161212.5750-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make kselftest-merge' assumes that the config files for the tests are
located under the 'main' tet dir, like tools/testing/selftests/net/ and
not in a subdir to net.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/net/config            | 13 +++++++++----
 tools/testing/selftests/net/forwarding/config | 12 ------------
 2 files changed, 9 insertions(+), 16 deletions(-)
 delete mode 100644 tools/testing/selftests/net/forwarding/config

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index cd3a2f1545b5..b344619b34f2 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -2,15 +2,20 @@ CONFIG_USER_NS=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_TEST_BPF=m
 CONFIG_NUMA=y
-CONFIG_NET_VRF=y
+CONFIG_NET_VRF=m
 CONFIG_NET_L3_MASTER_DEV=y
 CONFIG_IPV6=y
 CONFIG_IPV6_MULTIPLE_TABLES=y
-CONFIG_VETH=y
+CONFIG_VETH=m
 CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_NET_IPVTI=y
 CONFIG_INET6_XFRM_MODE_TUNNEL=y
 CONFIG_IPV6_VTI=y
 CONFIG_DUMMY=y
-CONFIG_BRIDGE=y
-CONFIG_VLAN_8021Q=y
+CONFIG_BRIDGE=m
+CONFIG_VLAN_8021Q=m
+CONFIG_CGROUP_BPF=y
+CONFIG_NET_CLS_FLOWER=m
+CONFIG_NET_SCH_INGRESS=m
+CONFIG_NET_ACT_GACT=m
+CONFIG_BRIDGE_VLAN_FILTERING=y
diff --git a/tools/testing/selftests/net/forwarding/config b/tools/testing/selftests/net/forwarding/config
deleted file mode 100644
index 5cd2aed97958..000000000000
--- a/tools/testing/selftests/net/forwarding/config
+++ /dev/null
@@ -1,12 +0,0 @@
-CONFIG_BRIDGE=m
-CONFIG_VLAN_8021Q=m
-CONFIG_BRIDGE_VLAN_FILTERING=y
-CONFIG_NET_L3_MASTER_DEV=y
-CONFIG_IPV6_MULTIPLE_TABLES=y
-CONFIG_NET_VRF=m
-CONFIG_BPF_SYSCALL=y
-CONFIG_CGROUP_BPF=y
-CONFIG_NET_CLS_FLOWER=m
-CONFIG_NET_SCH_INGRESS=m
-CONFIG_NET_ACT_GACT=m
-CONFIG_VETH=m
-- 
2.18.0

