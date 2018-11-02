Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A893C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4862081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+BFjBom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4862081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeKCDp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbeKCDp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:45:56 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BB992082D;
        Fri,  2 Nov 2018 18:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183865;
        bh=JjvdSpUIAiCbUnUD2iTDHQ8F7XTEp4qEeUlgHIt1dGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+BFjBomlqsg2zbROvmBgqGKIcLKw+MXcAGzMMF1SqX5eyn0onr7WiiXuEMXXhHmY
         FdFZkbXoMm/bVwjZmTkagqzHQOOjiEjf3MNC7+EuWmqWHuVvE14vn0t5s4qJQXh90e
         HXXmhwJgIKxAD4AYC/bnmWV4kt3ozWq5kcLE3/9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+5da0d0a72a9e7d791748@syzkaller.appspotmail.com,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 20/24] sctp: check policy more carefully when getting pr status
Date:   Fri,  2 Nov 2018 19:34:53 +0100
Message-Id: <20181102182842.839118398@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182839.725385066@linuxfoundation.org>
References: <20181102182839.725385066@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 713358369382cebf92f6e98ce2005f94e7344931 ]

When getting pr_assocstatus and pr_streamstatus by sctp_getsockopt,
it doesn't correctly process the case when policy is set with
SCTP_PR_SCTP_ALL | SCTP_PR_SCTP_MASK. It even causes a
slab-out-of-bounds in sctp_getsockopt_pr_streamstatus().

This patch fixes it by return -EINVAL for this case.

Fixes: 0ac1077e3a54 ("sctp: get pr_assoc and pr_stream all status with SCTP_PR_SCTP_ALL")
Reported-by: syzbot+5da0d0a72a9e7d791748@syzkaller.appspotmail.com
Suggested-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/socket.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -7101,14 +7101,15 @@ static int sctp_getsockopt_pr_assocstatu
 	}
 
 	policy = params.sprstat_policy;
-	if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)))
+	if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)) ||
+	    ((policy & SCTP_PR_SCTP_ALL) && (policy & SCTP_PR_SCTP_MASK)))
 		goto out;
 
 	asoc = sctp_id2assoc(sk, params.sprstat_assoc_id);
 	if (!asoc)
 		goto out;
 
-	if (policy & SCTP_PR_SCTP_ALL) {
+	if (policy == SCTP_PR_SCTP_ALL) {
 		params.sprstat_abandoned_unsent = 0;
 		params.sprstat_abandoned_sent = 0;
 		for (policy = 0; policy <= SCTP_PR_INDEX(MAX); policy++) {
@@ -7160,7 +7161,8 @@ static int sctp_getsockopt_pr_streamstat
 	}
 
 	policy = params.sprstat_policy;
-	if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)))
+	if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)) ||
+	    ((policy & SCTP_PR_SCTP_ALL) && (policy & SCTP_PR_SCTP_MASK)))
 		goto out;
 
 	asoc = sctp_id2assoc(sk, params.sprstat_assoc_id);


