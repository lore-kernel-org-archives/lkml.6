Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC99C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A02820880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763147;
	bh=MYnSJhu0MS3PUNqY26ljQKTg0ODdPGQQj7AfT6Srsx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BC+X3b9r8qXBgIKXHLFSXzZqtYjMPGZgOzKMsGgt7+gUxQVeU5RY73wPrqgb5vSMy
	 mNIqudOT8n87097SdcG6d+z0y51pewK5T9pjnKcycrYCLjbRX9LqT8C9F4PgRLlOMV
	 xjAhjK6u7aNqyHJkaQEwYOuCb+m6SHSCFTkHoS6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbfA2L7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:59:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbfA2Lr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:47:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F04E2083B;
        Tue, 29 Jan 2019 11:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762446;
        bh=MYnSJhu0MS3PUNqY26ljQKTg0ODdPGQQj7AfT6Srsx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeejoL+d0i13hzJBVWkOTJ8Gp0njIigxcbyZ+lW9HmoFg23RH9W9zirYeg4vrE3bT
         oMdMbAyMtRRgaaqDko/0vrJvB36fmjEIp31bzdtl4IvPF54zLYz4szRcHJVEw7cbr3
         QibVKtCufIhJ683fmh0ahliFWVm1AmzK48L4KntQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 094/103] bpf: fix check_map_access smin_value test when pointer contains offset
Date:   Tue, 29 Jan 2019 12:36:11 +0100
Message-Id: <20190129113207.164685192@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ commit b7137c4eab85c1cf3d46acdde90ce1163b28c873 upstream ]

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
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fbaa3b9e1d71..f9d5aea4891d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1294,13 +1294,17 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
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



