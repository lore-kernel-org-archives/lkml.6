Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19251C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D056421848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217069;
	bh=TY9iOQATkS/j/pAzBwCyMdLI+lAj/kgC4P/X6Hb4nE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jcyzym7lvBiu9Ur1gYWkvOhGZqh+w0gFM/+JWmhsu72z4yBU0rWVbrM031QiFjic+
	 22KRjB4zBN7ao6i5W7/jER/0b10MEW/UfIIdKGj9WcP0h/SJWpixed2lRoRdRyLTLp
	 kyPzwYUIQiJJBcSy+K/lTAJqb/R7Yp3xoD/sqjVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389112AbfAKObI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:31:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389080AbfAKObE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:31:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4E422063F;
        Fri, 11 Jan 2019 14:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217064;
        bh=TY9iOQATkS/j/pAzBwCyMdLI+lAj/kgC4P/X6Hb4nE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Ex5nijvZRaluIKjIhF+P2UTMBtXGmw+T0ygW9+t6XG11TQXNr9v1Us2ZQq3XcPcK
         a1P6wYU3ryo1CmzDfOkmtMTVlnuGbvNwJmuy5dggg1RBlI7IGM7Oh7evgqKKooTXW7
         NJxXOJHDgdF0L01XDOCR7IXxLJL26gU4nNqF/+fY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 009/105] xfrm: Fix error return code in xfrm_output_one()
Date:   Fri, 11 Jan 2019 15:13:40 +0100
Message-Id: <20190111131103.862936964@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



