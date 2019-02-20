Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0FAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1F72086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QF5YQi+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfBTVfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:35:09 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:42569 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfBTVfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:35:08 -0500
Received: by mail-it1-f201.google.com with SMTP id j127so11085437itj.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 13:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OXyCSDz8Enqud3cO2LvvNEFBuYyIKW4lu57aGkX8Qks=;
        b=QF5YQi+lyz3S2F3WmepcCstzOtCUTMjYABX7XE4bks4wO0ofNXKzivLQU1ti4cqwYq
         YgETxQRrHqwjW4njIZOiam6be6cGXMfO9F+CilH51RE19xErGzE+AkigBRvJKLennQCw
         kk/lrOVIVNQjx84Cr5zy3KPGrnvL2dzBBVps4w232e9I63vFjX946L3yxjLoWyohvccp
         vRQe9STD7F8vlxrbuH61743VOMcwqHyBl2LXpcHUXEDSIRjakY8jnM56iWXP7HA40+Sp
         lEN24NWo9rM3goqqSWooU+VSqo0NZZMYGlLZ77m7kJ1wiRUYibTOqOFMeW+muw0pTQrU
         UNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OXyCSDz8Enqud3cO2LvvNEFBuYyIKW4lu57aGkX8Qks=;
        b=rlXXkahm9pPzeZ/Bpd8GKvlNWQJqZ3H29Haznmkid5xFavx/WD1apMl/zYIaD3GClm
         4CL5yfzonXQpoiJa01QecZQxSqTYW6/8WlqhuOHzlchln33XPPBSgCF/nFliXHUlrjTy
         znKL344ZvJWNr73jXaaf9glWlD5SQqmOR1eyHH32o/QtDs/EzKRWhziQN5A4Rsj7JTH2
         97LFYzM8q/SaZ0TNz8t8UUk63JW0yapjiIaN2ox863+SMB6u4QRkwWIjJ3rgn7upmSsn
         l+8GYPJfpdElSDqWQXc0nIlWIlZ9QUlEl2yeVT9/JgCCb2TewI7svwV4JKOaV4vpW5tP
         on3A==
X-Gm-Message-State: AHQUAuaaKqez+N/oRBL7zhxc63RUBfXMGqPvGOHu9OS0NJVvHKdazszf
        t2Y6dvVgf4lAy/APn+C0HQscPpW1fg==
X-Google-Smtp-Source: AHgI3IYRU+i08VyArFmdRrCtGKs7syI/9DTrKV8QxT8jV7m7thX0zFntp9gJ/KSp+kGiex8W2keey7P74A==
X-Received: by 2002:a24:1303:: with SMTP id 3mr1534061itz.40.1550698507926;
 Wed, 20 Feb 2019 13:35:07 -0800 (PST)
Date:   Wed, 20 Feb 2019 22:34:54 +0100
Message-Id: <20190220213454.244600-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH net] net: socket: add check for negative optlen in compat setsockopt
From:   Jann Horn <jannh@google.com>
To:     "David S. Miller" <davem@davemloft.net>, jannh@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__sys_setsockopt() already checks for `optlen < 0`. Add an equivalent check
to the compat path for robustness. This has to be `> INT_MAX` instead of
`< 0` because the signedness of `optlen` is different here.

Signed-off-by: Jann Horn <jannh@google.com>
---
 net/compat.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/compat.c b/net/compat.c
index 959d1c51826d..3d348198004f 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -388,8 +388,12 @@ static int __compat_sys_setsockopt(int fd, int level, int optname,
 				   char __user *optval, unsigned int optlen)
 {
 	int err;
-	struct socket *sock = sockfd_lookup(fd, &err);
+	struct socket *sock;
+
+	if (optlen > INT_MAX)
+		return -EINVAL;
 
+	sock = sockfd_lookup(fd, &err);
 	if (sock) {
 		err = security_socket_setsockopt(sock, level, optname);
 		if (err) {
-- 
2.21.0.rc0.258.g878e2cd30e-goog

