Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5969C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F002183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216335;
	bh=53bRl8hHLEkh/vACmcI2wYjcHN4+n5WWW5JXrXn1tT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GDA4tk86RuDiq3PsPAqGMtKaSFfQR4qGpy0jw9xhPPMy9qdJjEWgLM277vGH/6+jb
	 X8w57Zc5Pk369vialds1X7JIpx8OJFPRYrGbPYPFI+19vgimaIR/fdI/kkOS6eyCof
	 MbCFcIT+Y3VcvQIAxoOXI8jx5nQKZCODXYY2Yl8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfAKOSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:18:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731550AbfAKOSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:18:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D7A82183F;
        Fri, 11 Jan 2019 14:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216327;
        bh=53bRl8hHLEkh/vACmcI2wYjcHN4+n5WWW5JXrXn1tT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WCJUM3sGFSgIzdS0yYjeXcqDuDD0qME6Maykjbm6OeCJKEMXyyqmqxRZFGjO2cMP+
         eown+casOEi9PA4k5hSix5/RN2zGL8MLblb/iCzwW2HnqEkw1n/AlljLneVBCFb03t
         q600rPBLLYCA0IK0/e1BsP5Q1Y6CmaVjcpIsNbGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Poirier <bpoirier@suse.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 60/88] xfrm: Fix bucket count reported to userspace
Date:   Fri, 11 Jan 2019 15:08:29 +0100
Message-Id: <20190111131055.604887549@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

[ Upstream commit ca92e173ab34a4f7fc4128bd372bd96f1af6f507 ]

sadhcnt is reported by `ip -s xfrm state count` as "buckets count", not the
hash mask.

Fixes: 28d8909bc790 ("[XFRM]: Export SAD info.")
Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 9b6e51450fc5..13f261feb75c 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -623,7 +623,7 @@ void xfrm_sad_getinfo(struct net *net, struct xfrmk_sadinfo *si)
 {
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
 	si->sadcnt = net->xfrm.state_num;
-	si->sadhcnt = net->xfrm.state_hmask;
+	si->sadhcnt = net->xfrm.state_hmask + 1;
 	si->sadhmcnt = xfrm_state_hashmax;
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 }
-- 
2.19.1



