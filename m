Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A62C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EE921841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130423;
	bh=vp5QKlUptwG3NKoBx3rjBv2AN8bsMVW7HajmeNLddq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UmGbsqODHHr1H5UZ45pctplcBSSw4tDrQzAb/XpX7gZOEZfjmf4CdUDEZ9UaT3/Uv
	 DFmAPQfcQPDZE+vJLVIIWjIHmhMraax2khkhDBni00+17PvIYRoL9NJKDsifa2AoZl
	 ovDzjn6hB1byL44k/+/kilLTOJ3EVrfI2/6BDOLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbfBYVdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:33:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732673AbfBYVda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:33:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DEB821848;
        Mon, 25 Feb 2019 21:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130409;
        bh=vp5QKlUptwG3NKoBx3rjBv2AN8bsMVW7HajmeNLddq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ohhO+z/twJx07KWUaUjVElwqzvBDbxtfSRwvcztEEQ/iAnxpN2bHDXCgK1tHedjtZ
         Pt/o+gCMPm/cAmwwx5n/GTTguDy4DNNtAJ0hf4HFNivfB5J+d0IvcNBqiKaThh5Q8x
         +CLwcv9b5xNkickSBJI4UVIqDsClgK8NiAYq9awY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 113/183] bpf: fix SO_MAX_PACING_RATE to support TCP internal pacing
Date:   Mon, 25 Feb 2019 22:11:26 +0100
Message-Id: <20190225195113.685488230@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index e176b335ddc09..16350f8c8815a 100644
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



