Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01F1C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605682190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026690;
	bh=AadVvcNT1FPVvpEsHbCvxm4fUOUZpfjlshHI48kjvLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GQo3PtUSNQQLJvb7wvfopGe4CkMOlZXy8c+tVCpVvc/SLhkLdFXwDEjEvOLTkZZKf
	 cE7rk3LICoHgDq7n7+VOCNT2ZRCsqAlx1NfOyr2pF+i0MkFRaP8Ci789GvXcoU73w+
	 1HgnqqhI/7HBHyqHtmX5I/LeJj9FIAnTfzXbuQOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbfBMCgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:36:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388114AbfBMCg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:36:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4C89222CE;
        Wed, 13 Feb 2019 02:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025386;
        bh=AadVvcNT1FPVvpEsHbCvxm4fUOUZpfjlshHI48kjvLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a30da+RQmEtJQUpcxrOuqQmGROlldrwXdJpDCw+8amzJlHwELRRAtg0YhKWUQ8WN3
         jNTj9WeHH4XfBczaOYGT+0m2a7gKn7u12AipGh6mH0QpcdZHo8E+ns0voezmhqNze4
         WVIdICG/xu0UXhju3jwBV458BWfbwPC09dXyRbnM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Oskolkov <posk@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 095/105] bpf: bpf_setsockopt: reset sock dst on SO_MARK changes
Date:   Tue, 12 Feb 2019 21:33:26 -0500
Message-Id: <20190213023336.19019-95-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oskolkov <posk@google.com>

[ Upstream commit f4924f24da8c7ef64195096817f3cde324091d97 ]

In sock_setsockopt() (net/core/sock.h), when SO_MARK option is used
to change sk_mark, sk_dst_reset(sk) is called. The same should be
done in bpf_setsockopt().

Fixes: 8c4b4c7e9ff0 ("bpf: Add setsockopt helper function to bpf")
Reported-by: Maciej Żenczykowski <maze@google.com>
Signed-off-by: Peter Oskolkov <posk@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Reviewed-by: Maciej Żenczykowski <maze@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index fa9452406f21..e176b335ddc0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3948,7 +3948,10 @@ BPF_CALL_5(bpf_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 			sk->sk_rcvlowat = val ? : 1;
 			break;
 		case SO_MARK:
-			sk->sk_mark = val;
+			if (sk->sk_mark != val) {
+				sk->sk_mark = val;
+				sk_dst_reset(sk);
+			}
 			break;
 		default:
 			ret = -EINVAL;
-- 
2.19.1

