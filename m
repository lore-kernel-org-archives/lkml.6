Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E22C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC912070B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865309;
	bh=xEPPcGyXYi+XdMfYyNIssjsFMKQvo60l134+7kkM1YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vMJNbU1De0r4VuG3O9mKONHHJ9C/pT+tgo6mFQiwAS/4QtpiOxFS92tu+1bZFCfWs
	 ESsY++lbBaKZyKOFJZaC1gYR+jl+RQP1V726MPRfPvzo5wfA2vLgWorjrQowDOaDnZ
	 6xMvvdEJxYF+CSsoJk8FVyt3BJPDq3Bh+MtKk4ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbeLZXBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:01:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbeLZWgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 888A5218EA;
        Wed, 26 Dec 2018 22:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863785;
        bh=xEPPcGyXYi+XdMfYyNIssjsFMKQvo60l134+7kkM1YQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fIB9M2B/9ZJMZ4ucBASWItoUGRgnDTbZ3owwZWdhNaeHN3n8wdiI6s7smO7Om8FL9
         51tunsC8c2+q/qjTdByiIUEdYIqQod8y3PJ3Si1zSO2qtokPSR5rn2/RXjt9nK/YiE
         bPwm+nFjoz6JAjDz4US1bwlKoKTZwBI1i3sciiv0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 16/97] xfrm: Fix error return code in xfrm_output_one()
Date:   Wed, 26 Dec 2018 17:34:36 -0500
Message-Id: <20181226223557.149329-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
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
index 261995d37ced..6d20fbcde000 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -102,6 +102,7 @@ static int xfrm_output_one(struct sk_buff *skb, int err)
 		skb_dst_force(skb);
 		if (!skb_dst(skb)) {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+			err = -EHOSTUNREACH;
 			goto error_nolock;
 		}
 
-- 
2.19.1

