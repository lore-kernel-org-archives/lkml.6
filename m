Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD9DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE21C218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901090;
	bh=vOZblrMHiMPy/N2g4ULaI1y/2bqLsgO3ZEKp9zyj7Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ozY8ntR9qJj3QbIWwBwmsCYiTu6Gz+P1qd2gz9DoLJagHNOYN/tIuzG0naIFQPxc9
	 MI5ZARcZGWU6A1/vTU5EZkvVaN9kquYiQTHJ04BJEvXA5O/uSiUcZAzc3oYBfwa0bY
	 adp2TUXoXSPBMQFIqmbdoV88I85ZA6vOZsw8N38w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbfBKQEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:04:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728875AbfBKO2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:28:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E07520838;
        Mon, 11 Feb 2019 14:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895302;
        bh=vOZblrMHiMPy/N2g4ULaI1y/2bqLsgO3ZEKp9zyj7Vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yjPQwIxv5rNDOY/AODBVuzZqee2UYIUIXjwkmWWdollwcdUD6DE/BpBrOhBxbULpN
         r9oj0MAPQJU8cYEWqk+hGmE1BCpq2afKLvJp00ZfW7P3vf1GVeJcdBmQ2nvH/CZ7QV
         4YcDBfDjjZ/pPtazi7TmYdEfsJLVlt640t/TwfNA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 161/352] selftests/bpf: use __bpf_constant_htons in test_prog.c
Date:   Mon, 11 Feb 2019 15:16:28 +0100
Message-Id: <20190211141857.142945451@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

[ Upstream commit a0517a0f7ef23550b4484c37e2b9c2d32abebf64 ]

For some reason, my older GCC (< 4.8) isn't smart enough to optimize the
!__builtin_constant_p() branch in bpf_htons, I see:
  error: implicit declaration of function '__builtin_bswap16'

Let's use __bpf_constant_htons as suggested by Daniel Borkmann.

I tried to use simple htons, but it produces the following:
  test_progs.c:54:17: error: braced-group within expression allowed only
  inside a function
    .eth.h_proto = htons(ETH_P_IP),

Signed-off-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_progs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 2d3c04f45530..6ac7232b0fde 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -51,10 +51,10 @@ static struct {
 	struct iphdr iph;
 	struct tcphdr tcp;
 } __packed pkt_v4 = {
-	.eth.h_proto = bpf_htons(ETH_P_IP),
+	.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
 	.iph.ihl = 5,
 	.iph.protocol = 6,
-	.iph.tot_len = bpf_htons(MAGIC_BYTES),
+	.iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
 	.tcp.urg_ptr = 123,
 };
 
@@ -64,9 +64,9 @@ static struct {
 	struct ipv6hdr iph;
 	struct tcphdr tcp;
 } __packed pkt_v6 = {
-	.eth.h_proto = bpf_htons(ETH_P_IPV6),
+	.eth.h_proto = __bpf_constant_htons(ETH_P_IPV6),
 	.iph.nexthdr = 6,
-	.iph.payload_len = bpf_htons(MAGIC_BYTES),
+	.iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
 	.tcp.urg_ptr = 123,
 };
 
-- 
2.19.1



