Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4344C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7480E2063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976786;
	bh=hzPUi3gLZq7HQA/O4v4QNBgF5Jex93qpxWLU00yqgb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jJM/dZIS/fealv/L6ZamTMnEWGBjcjfEqJ4FF41wrExhQu1FNkhTa+Gl4Y14Hveic
	 5vQgIEDfyYCpzD1xBYFmSI6eK7kEe/4efR2fldAJmBxJAHytlDRIjoqAGRvyZ1nIT3
	 fMYoUscJx5FWC2tyyv+97C/KnVPIKDnL2CemkOSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbfAHTqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:46:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731547AbfAHTdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:33:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34CF1205C9;
        Tue,  8 Jan 2019 19:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975983;
        bh=hzPUi3gLZq7HQA/O4v4QNBgF5Jex93qpxWLU00yqgb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M5Nixxma9CixgF4H381J3uj1QSzFC9CwJCybGVXkHmcSP3ITUgj/XlrjbfUOhjFIo
         vukmQXhh3wJiz/qy+vBdhSOxjOGE3shEEO3uaKWcWSEWVz8lGGzd2ym98ZsVzm+7IC
         3dkuLySfVmk1FbGCPSup7kDLoCcDw1MKxxuybqzY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     yupeng <yupeng0921@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 24/53] net: call sk_dst_reset when set SO_DONTROUTE
Date:   Tue,  8 Jan 2019 14:31:52 -0500
Message-Id: <20190108193222.123316-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193222.123316-1-sashal@kernel.org>
References: <20190108193222.123316-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yupeng <yupeng0921@gmail.com>

[ Upstream commit 0fbe82e628c817e292ff588cd5847fc935e025f2 ]

after set SO_DONTROUTE to 1, the IP layer should not route packets if
the dest IP address is not in link scope. But if the socket has cached
the dst_entry, such packets would be routed until the sk_dst_cache
expires. So we should clean the sk_dst_cache when a user set
SO_DONTROUTE option. Below are server/client python scripts which
could reprodue this issue:

server side code:

==========================================================================
import socket
import struct
import time

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(('0.0.0.0', 9000))
s.listen(1)
sock, addr = s.accept()
sock.setsockopt(socket.SOL_SOCKET, socket.SO_DONTROUTE, struct.pack('i', 1))
while True:
    sock.send(b'foo')
    time.sleep(1)
==========================================================================

client side code:
==========================================================================
import socket
import time

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(('server_address', 9000))
while True:
    data = s.recv(1024)
    print(data)
==========================================================================

Signed-off-by: yupeng <yupeng0921@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 36f19458e2fe..33584eb7f0cf 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -735,6 +735,7 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 	case SO_DONTROUTE:
 		sock_valbool_flag(sk, SOCK_LOCALROUTE, valbool);
+		sk_dst_reset(sk);
 		break;
 	case SO_BROADCAST:
 		sock_valbool_flag(sk, SOCK_BROADCAST, valbool);
-- 
2.19.1

