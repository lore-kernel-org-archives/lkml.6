Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5370DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1687D214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864386;
	bh=umAxpgcPoUSVsPLOSIpQSPHiS+5AmGY3GuT+bjdNDFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SzYCmPIQrXbQYBgioFAjnUm5m33UZxXoahvqIj+BW8b1s1g+1Vzkk6SGINF5rP3b+
	 lvPNMk39Kr60cbjZnkPAVmORCvmvF3OH6D3+cA4lTB6RAH0JWYgk65dCnkTiEA/LQo
	 bzc5mKFjHPRtYYMrF2RXyVMU5UR5N9bjGdMQST/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbeLZWqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:46:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728975AbeLZWkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:40:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAEAA20651;
        Wed, 26 Dec 2018 22:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864009;
        bh=umAxpgcPoUSVsPLOSIpQSPHiS+5AmGY3GuT+bjdNDFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZY6k37CNEl8T5fVG0/DEEkSgukO0oEqKOqKOkfR4x6gIxmwNr/IZY4uZj7Fyey6I5
         JvEeyr5QzAKrxILkIjeJDio1P82JWYjwPiDvNQdr5PR9tvax0oExouprsyclBOvEy1
         N9lVGCdvFv6TnRQfNKrjdvcNsM0qkUjJMlFN4aOs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 09/59] xfrm: Fix error return code in xfrm_output_one()
Date:   Wed, 26 Dec 2018 17:37:49 -0500
Message-Id: <20181226223839.150262-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 533555e5cbb6aa2d77598917871ae5b579fe724b ]

xfrm_output_one() does not return a error code when there is
no dst_entry attached to the skb, it is still possible crash
with a NULL pointer dereference in xfrm_output_resume(). Fix
it by return error code -EHOSTUNREACH.

Fixes: 9e1437937807 ("xfrm: Fix NULL pointer dereference when skb_dst_force clears the dst_entry.")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_output.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index c47660fba498..b226b230e8bf 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -103,6 +103,7 @@ static int xfrm_output_one(struct sk_buff *skb, int err)
 		skb_dst_force(skb);
 		if (!skb_dst(skb)) {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+			err = -EHOSTUNREACH;
 			goto error_nolock;
 		}
 
-- 
2.19.1

