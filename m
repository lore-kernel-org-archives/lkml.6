Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3E4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18D4208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="kE+IJkk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18D4208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeH0XSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:18:44 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:57658 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeH0XSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:18:44 -0400
Received: from trochilidae.lan (unknown [IPv6:2a02:169:34d6::189])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 6F8ED5C1EBA;
        Mon, 27 Aug 2018 21:30:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1535398245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=OBhaFGOqZBODV5kV0skLvsD9hNTXWPKX9VQE2Q6xlgY=;
        b=kE+IJkk4lAETsXgc4Yj03qz1xs3PdaJEeIqtquUWg9o5Brefxm64c6hf7BcNN9mNvFQwei
        m0bCa3RIIwomGlF9HI3xMIUmrZRucs71wgAOe+JsjznP8CVJQAo3IlsL9xWQmgl5uZptn6
        OEQUNBAfHTZYwVpuDw6NTea3MBsSF2Q=
From:   Stefan Agner <stefan@agner.ch>
To:     daniel@iogearbox.net
Cc:     kafai@fb.com, ast@kernel.org, mka@chromium.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] bpf: fix build error with clang
Date:   Mon, 27 Aug 2018 21:30:42 +0200
Message-Id: <20180827193042.3573-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the newly introduced BPF_PROG_TYPE_SK_REUSEPORT leads to
a compile time error when building with clang:
net/core/filter.o: In function `sk_reuseport_convert_ctx_access':
  ../net/core/filter.c:7284: undefined reference to `__compiletime_assert_7284'

It seems that clang has issues resolving hweight_long at compile
time. Since SK_FL_PROTO_MASK is a constant, we can use the interface
for known constant arguments which works fine with clang.

Fixes: 2dbb9b9e6df6 ("bpf: Introduce BPF_PROG_TYPE_SK_REUSEPORT")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index c25eb36f1320..7a2430945c71 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7281,7 +7281,7 @@ static u32 sk_reuseport_convert_ctx_access(enum bpf_access_type type,
 		break;
 
 	case offsetof(struct sk_reuseport_md, ip_protocol):
-		BUILD_BUG_ON(hweight_long(SK_FL_PROTO_MASK) != BITS_PER_BYTE);
+		BUILD_BUG_ON(HWEIGHT32(SK_FL_PROTO_MASK) != BITS_PER_BYTE);
 		SK_REUSEPORT_LOAD_SK_FIELD_SIZE_OFF(__sk_flags_offset,
 						    BPF_W, 0);
 		*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, SK_FL_PROTO_MASK);
-- 
2.18.0

