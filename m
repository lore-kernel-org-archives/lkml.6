Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD594C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E4E20661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957322;
	bh=eoyMvV5kbbb4SOv6DU2t6poAXyejX2umubXeeI7eKyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s2tL6lPR6DQUFr8ZpFrbOj0vc8s1M8tEIojWeI8VbG9Cr7FoQz22A6yQe7FmBA8UD
	 jDhu9bug7ff9MVcF7i4hOZszx6ME1rNiEPHGlEGxKE5uuoJjAwIRyWa25qY3PL/laV
	 1SsVdoRQ4+j3dzopbXkk3yZZvcKBgF0hTz1ahkMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfBWV2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:28:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbfBWVGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:06:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BAFC20855;
        Sat, 23 Feb 2019 21:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956003;
        bh=eoyMvV5kbbb4SOv6DU2t6poAXyejX2umubXeeI7eKyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1bKRzl9ldNUAMqday16yIv1qRh2QsXNXkFh0atxGSY6ye6OLx93QK5L6VF5scVgcB
         JbxJu0MMz5xi0RBtjEvwvF5aWfuOitj01AhMc9zeDTyIfv8MyE1d6CwVk3Mc6EELGy
         hgzU+UMy18xI5DpJMLhESZhCwU4qpsdiRW/KgRiI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 02/65] xfrm: refine validation of template and selector families
Date:   Sat, 23 Feb 2019 16:05:37 -0500
Message-Id: <20190223210640.200911-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 35e6103861a3a970de6c84688c6e7a1f65b164ca ]

The check assumes that in transport mode, the first templates family
must match the address family of the policy selector.

Syzkaller managed to build a template using MODE_ROUTEOPTIMIZATION,
with ipv4-in-ipv6 chain, leading to following splat:

BUG: KASAN: stack-out-of-bounds in xfrm_state_find+0x1db/0x1854
Read of size 4 at addr ffff888063e57aa0 by task a.out/2050
 xfrm_state_find+0x1db/0x1854
 xfrm_tmpl_resolve+0x100/0x1d0
 xfrm_resolve_and_create_bundle+0x108/0x1000 [..]

Problem is that addresses point into flowi4 struct, but xfrm_state_find
treats them as being ipv6 because it uses templ->encap_family is used
(AF_INET6 in case of reproducer) rather than family (AF_INET).

This patch inverts the logic: Enforce 'template family must match
selector' EXCEPT for tunnel and BEET mode.

In BEET and Tunnel mode, xfrm_tmpl_resolve_one will have remote/local
address pointers changed to point at the addresses found in the template,
rather than the flowi ones, so no oob read will occur.

Reported-by: 3ntr0py1337@gmail.com
Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_user.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 566919838d5e8..ab557827aac05 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1488,10 +1488,15 @@ static int validate_tmpl(int nr, struct xfrm_user_tmpl *ut, u16 family)
 		if (!ut[i].family)
 			ut[i].family = family;
 
-		if ((ut[i].mode == XFRM_MODE_TRANSPORT) &&
-		    (ut[i].family != prev_family))
-			return -EINVAL;
-
+		switch (ut[i].mode) {
+		case XFRM_MODE_TUNNEL:
+		case XFRM_MODE_BEET:
+			break;
+		default:
+			if (ut[i].family != prev_family)
+				return -EINVAL;
+			break;
+		}
 		if (ut[i].mode >= XFRM_MODE_MAX)
 			return -EINVAL;
 
-- 
2.19.1

