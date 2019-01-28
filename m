Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398DDC282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F365921741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694789;
	bh=Ob8R9n314Op+9+xV5KFjplqYppJIHvmu2KUeRYc8hu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=esOsiDW+kfMdzJ2a6XIUoWXnZ2CO1QzzJdyny11cphO+kpcMvwHP3SMwkkdhH2ioC
	 JHj88lizA+Vy5aHpmrzvNw8OeJcEMqGs2m3+QzVDdYEXF0fu3b0HLwVuW1W6v+DlWj
	 F6yjnQGviAg9NdNrKEQ0iHz7b7LDeSibqZUk5CQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388199AbfA1Q7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:59:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387892AbfA1QQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:16:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91CBE2148E;
        Mon, 28 Jan 2019 16:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692160;
        bh=Ob8R9n314Op+9+xV5KFjplqYppJIHvmu2KUeRYc8hu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8SQ6yqMts/ycFD/C3MzeuXejiPPD7h9HqYEx9W6VeiPfZlOmy/odsEdvuN0GOUrA
         JJXQNw9pLJjFvTtzmCwydhkplLPhEDcaxMv6kY6AzjfprwFyOOy0ypvsdNkGJ1w/5X
         vrrrDNKaALBMOYXi4+3n5Hc+NNmx5YZiugMbWNFM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 094/170] selftests/bpf: use __bpf_constant_htons in test_prog.c
Date:   Mon, 28 Jan 2019 11:10:44 -0500
Message-Id: <20190128161200.55107-94-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislav Fomichev <sdf@google.com>

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
index 11ee25cea227..1903fb4f45d8 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -43,10 +43,10 @@ static struct {
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
 
@@ -56,9 +56,9 @@ static struct {
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

