Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEB3C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D1F23F16
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D1F23F16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933290AbeGFM7I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:59:08 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55877 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932569AbeGFM7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:59:07 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MUyT2-1fcRTs1QwG-00YCVW; Fri, 06 Jul 2018 14:59:00 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Arkadi Sharshevsky <arkadis@mellanox.com>,
        Moshe Shemesh <moshe@mellanox.com>,
        David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [net-next] devlink: fix incorrect return statement
Date:   Fri,  6 Jul 2018 14:58:51 +0200
Message-Id: <20180706125858.3602497-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:DEUtdz05Vw6g4RvEt4zvf7+0YQ/0XtY/XkUbIVTuA5tDXvgHwo7
 o0qZWCQWP3aHFGM/K86Dje9GCm6k3FXEPY8ZrmSwvraHclWsgUSh4YcFH0QaFgVrcXPFg42
 fFyaoE2KOXnlYLaFrgtzS0Awz4nv8j8PT72RD2GRQyT2hM/YpESo1HDFAQfTorRBHU/do8D
 53GO1TVvB/xAS/qK2c23Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+zV9HUG1cRU=:xgnZBL+9PNBft8oDf5UyMg
 nXqfr85wIRRbLVUDpDjrl8U4zOvZ3HRV+/f8aKqivaiW3SOfFPA6CsF/WIpYmFDygWn8gI7fU
 LJZYrTzkAwoCN0QaX4bXiaJAMtRtTAGrccbEuXr97HmflQMqAWUlxrepcWA7j+2vfPP1uJRU7
 W3WHQ0EY1COX0hMDW8gE1tsjqzfe5rK/c7FAZzi0phNA8Zj4vgzEOynypAvqaNz+Ms22NaSGo
 cjkZElUQb0xv2UbEBezZolC9XKUEDBFVwwzMFPbkyU5F+jq0/BYM4gkXdn9P2QE9P1Cckp4vi
 /bCYs7OZL9krBmrLDayl+/mCqlfXWfXtjWaI7ZkVgdX1/6qW+ZzkJh68oQlaN88xPzP03ldKZ
 MrtafkACqTQZRi1ZKHuw1vl+vj8bmJHQXwRflchnP/XYRNGeNNbvQuTWhzYhAOGXCNKaSYv9z
 bhlilqtB+DzW0FSyJ94SGJuGbQ8Y4HsCp/8dOfDF4fg8mfaL8JU9cKOQUjJZK8NOhsFnIfWWG
 arRSUfo3LtkUQIEL4Tw8SbuBHL6HzsVAYEXaMr8GMgOx/zEMHUtUkN0rVG8fqe5wYGU2Gc4mN
 Oalu0x/aqKKQFxhWNDGKVMsHZEp5rfo+RWVYYRQ5vRcsLgsPsGucfjHWN8fzvB+81teBqxsLg
 K7w1pCAVtvn+iAktB+3MEYjL+N0PghZGiJkakS+LpHb+FXnNE7dzybO5lcz0WKOAWsUc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A newly added dummy helper function tries to return a failure from a "void"
function:

In file included from include/net/dsa.h:24,
                 from arch/arm/plat-orion/common.c:21:
include/net/devlink.h: In function 'devlink_param_value_changed':
include/net/devlink.h:771:9: error: 'return' with a value, in function returning void [-Werror]
  return -EOPNOTSUPP;

This fixes it by removing the bogus statement.

Fixes: ea601e170988 ("devlink: Add devlink notifications support for params")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/net/devlink.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 8ed571385626..f67c29cede15 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -768,7 +768,6 @@ devlink_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
 static inline void
 devlink_param_value_changed(struct devlink *devlink, u32 param_id)
 {
-	return -EOPNOTSUPP;
 }
 
 #endif
-- 
2.9.0

