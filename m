Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3652FC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA7820835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026732;
	bh=AOblHNB1I4m5T4xHNu/ReneSaRK7xRaUSgz5L7AoJbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WDXCNZcBqB9H4ze4Q2+KNy8aZJhBuJsuJCQoVODWXOK8/MrD+F3u35sgU6Nj2Y+1c
	 KnWd7T3g8G1lVINdlDiG4iwEt9jQatp30tQIjD3Lgje1C9sbfvHyn9J3JLCQZhtm0c
	 lMj3zyr4I9TZxlraPgnJL4N3DBYKcOJryS8Jt+VI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390204AbfBMC6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:58:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732102AbfBMCg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:36:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3518222CC;
        Wed, 13 Feb 2019 02:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025387;
        bh=AOblHNB1I4m5T4xHNu/ReneSaRK7xRaUSgz5L7AoJbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0sxQ81Hn51U5aNlbHiHRwueH2dsoO4W//7MkHJqZCVb9ipldW+145UUfrwQ08fCt0
         Ux7EH1lQRktSj92/xUTJUV3cdhEOgGWKjW+sM3Kvuy/uRFYIz/iG3jG2YRED03VYti
         6D8ldlTMvFZ08uOa23LWhg8i0ZhZIuOiqzuQJEi4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 096/105] bpf: fix SO_MAX_PACING_RATE to support TCP internal pacing
Date:   Tue, 12 Feb 2019 21:33:27 -0500
Message-Id: <20190213023336.19019-96-sashal@kernel.org>
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

[ Upstream commit e224c390a6259c529f7b2a6bd215a087b3344f5c ]

If sch_fq packet scheduler is not used, TCP can fallback to
internal pacing, but this requires sk_pacing_status to
be properly set.

Fixes: 8c4b4c7e9ff0 ("bpf: Add setsockopt helper function to bpf")
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Lawrence Brakmo <brakmo@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index e176b335ddc0..16350f8c8815 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3935,6 +3935,10 @@ BPF_CALL_5(bpf_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 			sk->sk_sndbuf = max_t(int, val * 2, SOCK_MIN_SNDBUF);
 			break;
 		case SO_MAX_PACING_RATE: /* 32bit version */
+			if (val != ~0U)
+				cmpxchg(&sk->sk_pacing_status,
+					SK_PACING_NONE,
+					SK_PACING_NEEDED);
 			sk->sk_max_pacing_rate = (val == ~0U) ? ~0UL : val;
 			sk->sk_pacing_rate = min(sk->sk_pacing_rate,
 						 sk->sk_max_pacing_rate);
-- 
2.19.1

