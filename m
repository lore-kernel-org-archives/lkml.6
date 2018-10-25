Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58DFC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF3E20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOqYrDJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF3E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbeJYWuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbeJYWuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:11 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6DD420848;
        Thu, 25 Oct 2018 14:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477034;
        bh=wtWFfI9Czc9oOG5V1oTFkY47VKwFES/uPAH5WNHyP9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WOqYrDJB1F4Fqspk7zpuctC9hdpD1o0+dFo8Ni3xEc6tWkryB9NTrLuc5hVW/ffx6
         b7VN6zpj3RCSm93cZt9+XMbyklt6ifQu2hxW/BnZgMeFguSuEKJQGSVjpVLVZ5WrlG
         HSic8DGymcsKPlnC4fUL7WHoCwJxMcppweq80dlg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Herrmann <dh.herrmann@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 03/65] net: drop write-only stack variable
Date:   Thu, 25 Oct 2018 10:16:03 -0400
Message-Id: <20181025141705.213937-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Herrmann <dh.herrmann@gmail.com>

[ Upstream commit 3575dbf2cbbc8e598f17ec441aed526dbea0e1bd ]

Remove a write-only stack variable from unix_attach_fds(). This is a
left-over from the security fix in:

    commit 712f4aad406bb1ed67f3f98d04c044191f0ff593
    Author: willy tarreau <w@1wt.eu>
    Date:   Sun Jan 10 07:54:56 2016 +0100

        unix: properly account for FDs passed over unix sockets

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/af_unix.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e05ec54ac53f..c6b1eec94911 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1531,7 +1531,6 @@ static int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 {
 	int i;
 	unsigned char max_level = 0;
-	int unix_sock_count = 0;
 
 	if (too_many_unix_fds(current))
 		return -ETOOMANYREFS;
@@ -1539,11 +1538,9 @@ static int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 	for (i = scm->fp->count - 1; i >= 0; i--) {
 		struct sock *sk = unix_get_socket(scm->fp->fp[i]);
 
-		if (sk) {
-			unix_sock_count++;
+		if (sk)
 			max_level = max(max_level,
 					unix_sk(sk)->recursion_level);
-		}
 	}
 	if (unlikely(max_level > MAX_RECURSION_LEVEL))
 		return -ETOOMANYREFS;
-- 
2.17.1

