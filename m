Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C3AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B275B21773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897191;
	bh=V5F8ieFbdH9YxOR5YZO2EISp4eaDMAb7lIQ0MexPzsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JbBrBd1lr1U6eK3zvr8cDPO75jAr4PEe+t/o6t8vbpM6icQZWVTCWCHZcENmmZHzC
	 pu4jjLxPU2ptUMojs9Ee73FJLyKEnKfVmLXaP1Mj8hMZzS6AgRS1b9YfOopNvpMsdI
	 5pzdBByi25Nqsv2RQCOht0f1aoc3iCZUrmCx8iG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389880AbfBKO7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:59:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbfBKO7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:59:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADEAB222A4;
        Mon, 11 Feb 2019 14:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897187;
        bh=V5F8ieFbdH9YxOR5YZO2EISp4eaDMAb7lIQ0MexPzsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y2rxCMecxS7tZolsbqFl+3IORXhYT2ROq/JyjgvXaXG1FZHniJbJZ51sH5S2kEZcQ
         qtz4Naxv1JVxdSD65R0Ce2C+1VcAHK9x5jE269DqW/QyLfgI7dvk2/i7I4BgLw+xax
         O/YCPrmGBJ2wcdNc/QgiAWJRIt/cODlqc26+obqY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 090/205] selftests/bpf: use __bpf_constant_htons in test_prog.c
Date:   Mon, 11 Feb 2019 15:18:08 +0100
Message-Id: <20190211141834.542968866@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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



