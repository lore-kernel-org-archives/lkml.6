Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8B5C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5923C20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKdO/WXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5923C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbeJPMQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729008AbeJPMCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A051D21476;
        Tue, 16 Oct 2018 04:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663249;
        bh=8yPPFUOqOyQ6bICZtR5jCv2qrNf9Omp/+FnS4SMZ7eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VKdO/WXiFewq52WZck61y4mecuWBoFW26926rn6TGOgR6VewyIwcK88wOwwFIPN2w
         OpMG+hJ4dzHbLe+JgMbWxaqFWFek15cYyy2bT8jcGpV0R6S2FBxEzX22VHvlATnatG
         NYW//74CnuDzvhoIg7B3IMULziRwDMNSLwuj84h0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 04/61] xfrm: reset crypto_done when iterating over multiple input xfrms
Date:   Tue, 16 Oct 2018 00:13:06 -0400
Message-Id: <20181016041403.135678-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>

[ Upstream commit 782710e333a526780d65918d669cb96646983ba2 ]

We only support one offloaded xfrm (we do not have devices that
can handle more than one offload), so reset crypto_done in
xfrm_input() when iterating over multiple transforms in xfrm_input,
so that we can invoke the appropriate x->type->input for the
non-offloaded transforms

Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 9f492dc417d5..8e75319dd9c0 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -453,6 +453,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINHDRERROR);
 			goto drop;
 		}
+		crypto_done = false;
 	} while (!err);
 
 	err = xfrm_rcv_cb(skb, family, x->type->proto, 0);
-- 
2.17.1

