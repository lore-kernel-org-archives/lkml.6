Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FADC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D5721848
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691887;
	bh=Qy05m6YU7sijz9HqGN6a7TV+EUkf3eqhCrncOI/zwV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P9fOaigudr02xjsbDd0QVohV12vIKzPtC7uFcitxHp+e6Tv2IE9gjQSqKU/BN3E7s
	 4SD0ekttMYKsnkkazqUhFQYKPoPIG+AC08RpyNLwn6E3RHXpyu/1kMmFjW4D9zSDVq
	 3ZcjeG8O1DcemKlQSSZPl+tJZpF4W5dJ22g0Yb2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbfA1QL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:11:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732946AbfA1QLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:11:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E855E2177E;
        Mon, 28 Jan 2019 16:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691883;
        bh=Qy05m6YU7sijz9HqGN6a7TV+EUkf3eqhCrncOI/zwV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4Dna+OGZgCxeq1PQqr4dzFDvP1ydCjG+QQjDgetqA6kvu8zE3DiWisadq+FtVrxs
         ibLb7btfArphUomkgHomqvUIkdoM8aG0jEOTJic9qjdV8tthHbl72/RdYOUw1j3Jfo
         /Myye70x49gu9+YUETg/+wQzpsyBXF3AFTLWM1KM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 248/258] bpf: fix check_map_access smin_value test when pointer contains offset
Date:   Mon, 28 Jan 2019 10:59:14 -0500
Message-Id: <20190128155924.51521-248-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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
index 341806668f03..9997723038d3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1268,13 +1268,17 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
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

