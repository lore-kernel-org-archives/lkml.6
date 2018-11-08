Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0A3C0044B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733F220844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAd1CUKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733F220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbeKIIOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:14:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:53792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbeKIHgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:23 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E20F20818;
        Thu,  8 Nov 2018 21:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714335;
        bh=sAmQb4Hjf7tVzNcLxj5TkzxW72LiGbhxx5odDLUXbp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QAd1CUKEYy4VPrLYrFF0QAuz4h3sfFS4EKFC6Ydo0tOdUZMgUpf8zp7Akqx9+GSLl
         NoKt4KIsifCpjz1asCC9dTx9NG9A2zluUrt6Q2LV5qTTp7OTAJrr6uS7g7tHGeTa5l
         iUZ7HF7tb30N4wCoMz60Na/9djXNRtKFSGWaXgAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 021/114] net: drop write-only stack variable
Date:   Thu,  8 Nov 2018 13:50:36 -0800
Message-Id: <20181108215101.046481417@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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



