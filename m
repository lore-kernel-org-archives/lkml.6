Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FE0C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13E821871
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762140;
	bh=2UXp2/mL2a1HEdBypwaQWnwxcNM+SP6JP1cS47rdILU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vHugvc6iieT0AKxCOYcvycUqzONndkeP7qRXhmB6/Hup6Hl6Z/PJNqRdHPw3NS5we
	 40LrHMYA0PygI3V9w5Ud+ZOT76Mt/YtZNUYAwgCASL4f7UIUatUrT/mB5TeaplbUk6
	 0aUJkhj1OeMmMQGYchjishAFaHhcCCm25z+sc2Vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbfA2LmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:42:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729253AbfA2LmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:42:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE87720882;
        Tue, 29 Jan 2019 11:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762134;
        bh=2UXp2/mL2a1HEdBypwaQWnwxcNM+SP6JP1cS47rdILU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I+uONgzAqshCX/vbfdFpsluBeIC2oxfGn51s6D+QKu4yin0z8fySW87v4Z68hNfVw
         yTU8zerAp5ecMoKW5KLzjnFH26yb6zYvqdfxLRiAv2AO4CRt7GBDh+1/2VyWYFyA65
         X6R24sw+vt1CmVrqkaYMQUM4w31qpWvnOh7BI6aM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 102/117] bpf: fix check_map_access smin_value test when pointer contains offset
Date:   Tue, 29 Jan 2019 12:35:53 +0100
Message-Id: <20190129113212.463652634@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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
index 8e90e795ca68..973ebab5b19d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1370,13 +1370,17 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
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



