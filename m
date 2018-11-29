Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B78C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE922145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vu/ZHuBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE922145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389233AbeK3BhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:37:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729111AbeK3BhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:37:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BF08213A2;
        Thu, 29 Nov 2018 14:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501903;
        bh=6wHH2/a2a2FaIeypfMGmOB1VZGMqlSk9QU4s6nicg1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vu/ZHuBv5GaS8JQPpnwzPZXHOQkFUIObWXeNhGwT0bKWX13W/dErq4I01Wl6MjZ/m
         rI9ViEV1CFiYl/ZS9aIuUwzzhXKtvmfAjGX6Bu131Q5Xap+7CopLJiF5XSavssrkXA
         OYyHwPzzZr0bPkI2ipOowgLHLcIAUBaIkvRny0TI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 087/110] SUNRPC: Fix a bogus get/put in generic_key_to_expire()
Date:   Thu, 29 Nov 2018 15:12:58 +0100
Message-Id: <20181129135924.771277151@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e3d5e573a54dabdc0f9f3cb039d799323372b251 ]

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/auth_generic.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/sunrpc/auth_generic.c b/net/sunrpc/auth_generic.c
index f1df9837f1ac..1ac08dcbf85d 100644
--- a/net/sunrpc/auth_generic.c
+++ b/net/sunrpc/auth_generic.c
@@ -281,13 +281,7 @@ static bool generic_key_to_expire(struct rpc_cred *cred)
 {
 	struct auth_cred *acred = &container_of(cred, struct generic_cred,
 						gc_base)->acred;
-	bool ret;
-
-	get_rpccred(cred);
-	ret = test_bit(RPC_CRED_KEY_EXPIRE_SOON, &acred->ac_flags);
-	put_rpccred(cred);
-
-	return ret;
+	return test_bit(RPC_CRED_KEY_EXPIRE_SOON, &acred->ac_flags);
 }
 
 static const struct rpc_credops generic_credops = {
-- 
2.17.1



