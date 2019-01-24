Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC36EC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65D5218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358904;
	bh=UbHkM3zbuLTmAKwwBB6LesUmuz8uJoFxuXPgCmP1Mqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SrB7PSyn5xQtAiTpjZmzZx5U9c0Jq/B9GTEH/bVLlOTXW67sJde3P9ntE2ucZHdB9
	 Du1QDtFefpiC+tWp0jzhGGlj+mX8KX23TDuATnruMNyO/uSxnBY0V+ssthInSodZsx
	 YvMQvhGzQEbJxSXHIdsFeOztsBcupypdGpVU/BX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387638AbfAXTlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:41:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732837AbfAXTlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:41:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8FAA20663;
        Thu, 24 Jan 2019 19:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358899;
        bh=UbHkM3zbuLTmAKwwBB6LesUmuz8uJoFxuXPgCmP1Mqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCNnmWXrNFhWc5bH+xlOVO0RoaRoc3QNlZI2THV2otCWTWnHnN6PZe9y5AeZUR1rs
         jFWGChF7mT4B9X2Ja721JSmEAbwKxnKOUhmXYCPYIAnqct5v3Ebamy3f4054eUoLzz
         sTgbekAaU1b5GDDrMXWVFoDCrOczo1ydfpcvsB6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yupeng <yupeng0921@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 064/127] net: call sk_dst_reset when set SO_DONTROUTE
Date:   Thu, 24 Jan 2019 20:20:10 +0100
Message-Id: <20190124190214.875680498@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 98659fb6e9fb..530583ae92bf 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -698,6 +698,7 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 	case SO_DONTROUTE:
 		sock_valbool_flag(sk, SOCK_LOCALROUTE, valbool);
+		sk_dst_reset(sk);
 		break;
 	case SO_BROADCAST:
 		sock_valbool_flag(sk, SOCK_BROADCAST, valbool);
-- 
2.19.1



