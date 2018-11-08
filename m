Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F70C0044B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B623820857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQPuuYAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B623820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbeKIIPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:15:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbeKIHgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:00 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB393208E3;
        Thu,  8 Nov 2018 21:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714312;
        bh=CTjzpNoaAcAh6TIP9PAZfnk78D3MogcxhtG0WISzelU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hQPuuYAtR014gf9aws+sn1Nm15PhDKvR1Wfzg1TVybBM4Tgw1Q/rBdZ3QbidsW8G/
         FVCt8NrV6IBoxnYUZZfAdj30r70rNUHuYLTy7P3A7bfKaqy6NkI5H5ONLZtIcftU5l
         nK0qbMXhU/LOZiM+RxRx4UEeZS8d75oqI1P6Nvqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Air Icy <icytxw@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 001/114] xfrm: Validate address prefix lengths in the xfrm selector.
Date:   Thu,  8 Nov 2018 13:50:16 -0800
Message-Id: <20181108215059.146651302@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 07bf7908950a8b14e81aa1807e3c667eab39287a ]

We don't validate the address prefix lengths in the xfrm
selector we got from userspace. This can lead to undefined
behaviour in the address matching functions if the prefix
is too big for the given address family. Fix this by checking
the prefixes and refuse SA/policy insertation when a prefix
is invalid.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Air Icy <icytxw@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_user.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index a9b4491a3cc4..c2e98dcba9fe 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -151,10 +151,16 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 	err = -EINVAL;
 	switch (p->family) {
 	case AF_INET:
+		if (p->sel.prefixlen_d > 32 || p->sel.prefixlen_s > 32)
+			goto out;
+
 		break;
 
 	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
+		if (p->sel.prefixlen_d > 128 || p->sel.prefixlen_s > 128)
+			goto out;
+
 		break;
 #else
 		err = -EAFNOSUPPORT;
@@ -1312,10 +1318,16 @@ static int verify_newpolicy_info(struct xfrm_userpolicy_info *p)
 
 	switch (p->sel.family) {
 	case AF_INET:
+		if (p->sel.prefixlen_d > 32 || p->sel.prefixlen_s > 32)
+			return -EINVAL;
+
 		break;
 
 	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
+		if (p->sel.prefixlen_d > 128 || p->sel.prefixlen_s > 128)
+			return -EINVAL;
+
 		break;
 #else
 		return  -EAFNOSUPPORT;
-- 
2.17.1



