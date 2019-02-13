Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CAEC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14DE2190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026998;
	bh=nLkXeyfQYeRx00mE1S2/JY+5KDkFRXPz1wJv6XGeYpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A2N0eSfVkA3zs9b9GgbeLJtKHOuWAEAVebnNN9yCBNOHa9k6Eg9bQjKa3iVVY6qUR
	 PA3YtEJiBGWRt2cSBiZRBDuKxHzs1ft8ios1Mc8DXf93KlyJOg9kIASmLzLDdNPHcy
	 onJePZ+RqhYHSwjjVO4qvVqwoAEeYTdCHftBguFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390398AbfBMDDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:03:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387801AbfBMCep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:34:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E7B2206B6;
        Wed, 13 Feb 2019 02:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025284;
        bh=nLkXeyfQYeRx00mE1S2/JY+5KDkFRXPz1wJv6XGeYpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vXdujmSoD0qU6PBqeE+L/KRfLQQgr6o+3134uODqgJpBgLa5C9VzWoImIDjZfrVy8
         NWSz4vZ0Y9YJwE7sZj6wOmmSEwR5pBP4Z7KdsMgni2e9NZ1jKy8bX2XCVli3qPlcmq
         hECFcyswvUGgccRLKXdI9bbVd0gzDLMy3/DM4gtc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yuchung Cheng <ycheng@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 044/105] bpf: correctly set initial window on active Fast Open sender
Date:   Tue, 12 Feb 2019 21:32:35 -0500
Message-Id: <20190213023336.19019-44-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuchung Cheng <ycheng@google.com>

[ Upstream commit 31aa6503a15ba00182ea6dbbf51afb63bf9e851d ]

The existing BPF TCP initial congestion window (TCP_BPF_IW) does not
to work on (active) Fast Open sender. This is because it changes the
(initial) window only if data_segs_out is zero -- but data_segs_out
is also incremented on SYN-data.  This patch fixes the issue by
proerly accounting for SYN-data additionally.

Fixes: fc7478103c84 ("bpf: Adds support for setting initial cwnd")
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Lawrence Brakmo <brakmo@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index eb0007f30142..fa9452406f21 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4019,7 +4019,7 @@ BPF_CALL_5(bpf_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 			/* Only some options are supported */
 			switch (optname) {
 			case TCP_BPF_IW:
-				if (val <= 0 || tp->data_segs_out > 0)
+				if (val <= 0 || tp->data_segs_out > tp->syn_data)
 					ret = -EINVAL;
 				else
 					tp->snd_cwnd = val;
-- 
2.19.1

