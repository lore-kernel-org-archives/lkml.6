Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D76C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FBB20861
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956014;
	bh=GgZqaEyCuV542eBwEosueQgsjawAIkawJIcpuQ5Sk00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1I/XLWDJoUjvhrnOzIHV8tfdq6vdfcOyGitSrRlUxqLNoNlxK843woRT1fISWpIoe
	 Qgtu1t2u6/RJr45W2WrOgWHIJtziQxTuAinDCWvKcxCuALmLh0Wl09JrRyzAbJPqCN
	 PqKUCxLGMjwV4tyEd3B6HW+XDPHcyJYmFqdSbBEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfBWVGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:06:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbfBWVGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:06:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98B322085A;
        Sat, 23 Feb 2019 21:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956004;
        bh=GgZqaEyCuV542eBwEosueQgsjawAIkawJIcpuQ5Sk00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=On2EevHS2KXMITYFq9Ld0uH7NWvSYMJ1Hiu8kzvbys/qjziGJ5XWtyFqUrOj4LQgB
         ueG2Q01TA7eFEfHfBcaEBw3axczV/wztvZOm6vUsgj1fPe5TnCUMclvvzYJ0VWm3La
         /fQ19nF25uKA+eIhKGGy0lIC/f1VtYD855QInWME=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Benedict Wong <benedictwong@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 03/65] xfrm: Make set-mark default behavior backward compatible
Date:   Sat, 23 Feb 2019 16:05:38 -0500
Message-Id: <20190223210640.200911-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
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

