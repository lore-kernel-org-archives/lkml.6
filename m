Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA680C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BCA20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvswTSg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BCA20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeJPMCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727449AbeJPMC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3728E2145D;
        Tue, 16 Oct 2018 04:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663246;
        bh=hMFtkzAhQrrhJVdOlbsa5sIsVrw/sVgNzcSP7+RY2Vg=;
        h=From:To:Cc:Subject:Date:From;
        b=TvswTSg7/tZMyTvPh7GSVE4nNMbNkhD2ZxRg/KaG/mAZP657GNNCxHzW5VXp2A85b
         /NAjjyNKWCLnCc6HBNrBWFWC5INGpPyiFeVv7YPz8YrhFQG5caHALU5EqtV73HjrfV
         y+E/+6vlupsuMlr4CnlP0VBFsaYaSkCUL+JXfAX8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 01/61] xfrm: Validate address prefix lengths in the xfrm selector.
Date:   Tue, 16 Oct 2018 00:13:03 -0400
Message-Id: <20181016041403.135678-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steffen Klassert <steffen.klassert@secunet.com>

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
index 5554d28a32eb..4292347bf45e 100644
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
@@ -1353,10 +1359,16 @@ static int verify_newpolicy_info(struct xfrm_userpolicy_info *p)
 
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

