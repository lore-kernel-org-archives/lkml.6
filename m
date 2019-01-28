Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E21C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D842147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696650;
	bh=nCzpa6x/3V5yNVYO64VEm/QkGy4lEbeozjf7RD9N4O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wo3U0oWN7rfZoxdX6+sIsVWNnseFpdHLzP5fpKeYoptghHPacMyK04uOwiq51cxaq
	 ZxsmG36wFfCrOXTJhF5Hp/rO09GappfCL5sJubU15HH3qe8Jmrb8lwXUdfhbCg5uih
	 NassSt7lrroqpZB/yA+/ta9JnFRjZtt4PauA2Brs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfA1Ras (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:30:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728755AbfA1P6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:58:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8AE321841;
        Mon, 28 Jan 2019 15:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691114;
        bh=nCzpa6x/3V5yNVYO64VEm/QkGy4lEbeozjf7RD9N4O4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZPop7A97YWcRnEVe+9E101tReNdpnf3yrK2SOp4yk54YAUt29b46cwzsJR/oh+Fjs
         tTJif2QIu3Nd1ZFaYoVEOlsQH2yEFRdjvi4UYpETNlQl0LMYqNAXrTOTG/FlqgzxBW
         1joNNS2r3Lro8rSpFlrCHacPp3nCGvW1E2o5tKdA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 293/304] bpf: fix check_map_access smin_value test when pointer contains offset
Date:   Mon, 28 Jan 2019 10:43:30 -0500
Message-Id: <20190128154341.47195-293-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit b7137c4eab85c1cf3d46acdde90ce1163b28c873 ]

In check_map_access() we probe actual bounds through __check_map_access()
with offset of reg->smin_value + off for lower bound and offset of
reg->umax_value + off for the upper bound. However, even though the
reg->smin_value could have a negative value, the final result of the
sum with off could be positive when pointer arithmetic with known and
unknown scalars is combined. In this case we reject the program with
an error such as "R<x> min value is negative, either use unsigned index
or do a if (index >=0) check." even though the access itself would be
fine. Therefore extend the check to probe whether the actual resulting
reg->smin_value + off is less than zero.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eedc7bd4185d..8ae4c7f8eaf6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1345,13 +1345,17 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 	 */
 	if (env->log.level)
 		print_verifier_state(env, state);
+
 	/* The minimum value is only important with signed
 	 * comparisons where we can't assume the floor of a
 	 * value is 0.  If we are using signed variables for our
 	 * index'es we need to make sure that whatever we use
 	 * will have a set floor within our range.
 	 */
-	if (reg->smin_value < 0) {
+	if (reg->smin_value < 0 &&
+	    (reg->smin_value == S64_MIN ||
+	     (off + reg->smin_value != (s64)(s32)(off + reg->smin_value)) ||
+	      reg->smin_value + off < 0)) {
 		verbose(env, "R%d min value is negative, either use unsigned index or do a if (index >=0) check.\n",
 			regno);
 		return -EACCES;
-- 
2.19.1

