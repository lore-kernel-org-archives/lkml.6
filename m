Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50219C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE4E2190C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539800;
	bh=pli8xqi8WxPzyN44reqhImyq0BVWPTs3m2FlJ7htzyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n27oHrzLoxhxrH18r3clhKvd9ka1+hydTq1+S7tICLWmFcdBKaWInl6gEAs7efyc2
	 IgWZmZc0u7c8zNE5RnfF6KwVKltlBkGbdZBXvNnPL0JXoQbE6strtzwNKZEBRyiwFx
	 Ie52XcQTwhv3IfT/Rx25O1jdLCQM2Q2XhIUchjHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfBGLnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:43:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbfBGLnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:43:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA5EA21907;
        Thu,  7 Feb 2019 11:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539796;
        bh=pli8xqi8WxPzyN44reqhImyq0BVWPTs3m2FlJ7htzyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lDvC0xkuSa5U3yn11+UR/g5R+nGABu7Os1id7jBNGvGDIsPe+rvk+gVoN3Ads8Sqf
         tfmo4two2fCd9+K1CUXVJJ21TvbUbjpqjnQXs+OU+vhwoJHJgqn/zg0bWlO3AE7sSq
         hBq7XZwFzKZntfVdGVhOq/VsAmAbUDuxdbLIIzwY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 11/34] ipfrag: really prevent allocation on netns exit
Date:   Thu,  7 Feb 2019 12:41:53 +0100
Message-Id: <20190207113026.021768200@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
References: <20190207113025.552605181@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit f6f2a4a2eb92bc73671204198bb2f8ab53ff59fb upstream.

Setting the low threshold to 0 has no effect on frags allocation,
we need to clear high_thresh instead.

The code was pre-existent to commit 648700f76b03 ("inet: frags:
use rhashtables for reassembly units"), but before the above,
such assignment had a different role: prevent concurrent eviction
from the worker and the netns cleanup helper.

Fixes: 648700f76b03 ("inet: frags: use rhashtables for reassembly units")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/inet_fragment.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -90,7 +90,7 @@ static void inet_frags_free_cb(void *ptr
 
 void inet_frags_exit_net(struct netns_frags *nf)
 {
-	nf->low_thresh = 0; /* prevent creation of new frags */
+	nf->high_thresh = 0; /* prevent creation of new frags */
 
 	rhashtable_free_and_destroy(&nf->rhashtable, inet_frags_free_cb, NULL);
 }


