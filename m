Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99123C10F0B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEE020866
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550955874;
	bh=GgZqaEyCuV542eBwEosueQgsjawAIkawJIcpuQ5Sk00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dc5RKMIE3TWEoOipONdvitBSrie06eJZS2MyJw3fd7Ryg55T9KZfJv84s1mYO2HlZ
	 LxMzGzyZGZ5Mi7gHygj07PHc0IcAFpR3q7u8xDy9h9ccx9ny9eY87cmscYTrxbx/GQ
	 u3MwC/Z4flSwRfh39pB/B42PnAbFHCHrTdvxmxQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfBWVE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:04:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfBWVE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:04:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0849B20855;
        Sat, 23 Feb 2019 21:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955866;
        bh=GgZqaEyCuV542eBwEosueQgsjawAIkawJIcpuQ5Sk00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OEraJEw+v8dHRJNg9b6cb539kF/zd+hEtDfa3HG1nHAiGgoTK3MHn3mpstPfXmfzS
         PdIb/3na3w6R6fgrIN4noZSmJDDDOoVBV0v0GUx912Wf80M9+3mHZu2h2U3Q/ZnH9D
         6QVEpnCJj/ooO0XM1th9cydTjMmKugB12upLAXmw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Benedict Wong <benedictwong@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 03/72] xfrm: Make set-mark default behavior backward compatible
Date:   Sat, 23 Feb 2019 16:03:13 -0500
Message-Id: <20190223210422.199966-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benedict Wong <benedictwong@google.com>

[ Upstream commit e2612cd496e7b465711d219ea6118893d7253f52 ]

Fixes 9b42c1f179a6, which changed the default route lookup behavior for
tunnel mode SAs in the outbound direction to use the skb mark, whereas
previously mark=0 was used if the output mark was unspecified. In
mark-based routing schemes such as Android’s, this change in default
behavior causes routing loops or lookup failures.

This patch restores the default behavior of using a 0 mark while still
incorporating the skb mark if the SET_MARK (and SET_MARK_MASK) is
specified.

Tested with additions to Android's kernel unit test suite:
https://android-review.googlesource.com/c/kernel/tests/+/860150

Fixes: 9b42c1f179a6 ("xfrm: Extend the output_mark to support input direction and masking")
Signed-off-by: Benedict Wong <benedictwong@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_policy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 119a427d9b2b2..6ea8036fcdbeb 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1628,7 +1628,10 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 		dst_copy_metrics(dst1, dst);
 
 		if (xfrm[i]->props.mode != XFRM_MODE_TRANSPORT) {
-			__u32 mark = xfrm_smark_get(fl->flowi_mark, xfrm[i]);
+			__u32 mark = 0;
+
+			if (xfrm[i]->props.smark.v || xfrm[i]->props.smark.m)
+				mark = xfrm_smark_get(fl->flowi_mark, xfrm[i]);
 
 			family = xfrm[i]->props.family;
 			dst = xfrm_dst_lookup(xfrm[i], tos, fl->flowi_oif,
-- 
2.19.1

