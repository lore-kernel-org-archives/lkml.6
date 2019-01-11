Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDF1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4648A20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218653;
	bh=WP/zcWhpwRlhMNcjk0siQYAaUGun/LBd/uVcHXuOTXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Omv1b2g5ubyPGg73laUE0v/093nMUbxHDPTsA6zmJ0E+g5YCngwxRu02FGNVmi/qZ
	 oszOwtUlvTe+JJ38UsXwQ2m+f8VbOAU0zYMVOVMzETONW9CNJONt9P5aOkl0TT027w
	 LSwF8xnvdhfRjna2NRAR4/A0d9hGVlv3Yto84rdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391678AbfAKO5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390084AbfAKOfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:35:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B6FB204EC;
        Fri, 11 Jan 2019 14:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217311;
        bh=WP/zcWhpwRlhMNcjk0siQYAaUGun/LBd/uVcHXuOTXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vmsRvRYZG3aPgDgh7Lcijmk+DkIgr6fC+p2XM9hzeuH49UTdmgAGQht72LOxV6vaM
         tl43PXWXF41ebkxo7XZ/DU9yXr8+7+4cmJd+1u80bjs+m8F3hKQXKCr+x5AxlzJbFX
         v9vyoEZcurM7fNZUfdX8sPUYDCezDqvSy2z1UuZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 016/148] xfrm: Fix error return code in xfrm_output_one()
Date:   Fri, 11 Jan 2019 15:13:14 +0100
Message-Id: <20190111131114.977100189@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



