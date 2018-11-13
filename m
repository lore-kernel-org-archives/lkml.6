Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BE5C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D25A22513
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoUTYRVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D25A22513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbeKMPqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:46:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730813AbeKMPqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:46:21 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14D9022510;
        Tue, 13 Nov 2018 05:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088194;
        bh=YVEvl6hki7F34vqK7BWBKlzJlSaO7EmXHzKS/ds807U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JoUTYRVE9piG5sKM6gnA93zzQB8AQtPFmUPf5mBpAlX0VPQ7QgmSchTpMU2JlWRYq
         he+UcSwkWTJ16AkmioFa4scId4SrFvFBziHd3ZC8Dk0JPLEC4rxPkULxQDb0RZYwX9
         enPz6zRr5sYVH05IjQnRcdiEZqS7+s7fIRrs0DuE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Edward Cree <ecree@solarflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 07/44] bpf: fix partial copy of map_ptr when dst is scalar
Date:   Tue, 13 Nov 2018 00:49:13 -0500
Message-Id: <20181113054950.77898-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113054950.77898-1-sashal@kernel.org>
References: <20181113054950.77898-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 0962590e553331db2cc0aef2dc35c57f6300dbbe ]

ALU operations on pointers such as scalar_reg += map_value_ptr are
handled in adjust_ptr_min_max_vals(). Problem is however that map_ptr
and range in the register state share a union, so transferring state
through dst_reg->range = ptr_reg->range is just buggy as any new
map_ptr in the dst_reg is then truncated (or null) for subsequent
checks. Fix this by adding a raw member and use it for copying state
over to dst_reg.

Fixes: f1174f77b50c ("bpf/verifier: rework value tracking")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Edward Cree <ecree@solarflare.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf_verifier.h |  3 +++
 kernel/bpf/verifier.c        | 10 ++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 38b04f559ad3..1fd6fa822d2c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -50,6 +50,9 @@ struct bpf_reg_state {
 		 *   PTR_TO_MAP_VALUE_OR_NULL
 		 */
 		struct bpf_map *map_ptr;
+
+		/* Max size from any of the above. */
+		unsigned long raw;
 	};
 	/* Fixed part of pointer offset, pointer types only */
 	s32 off;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 465952a8e465..b046564cc18d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2762,7 +2762,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			dst_reg->umax_value = umax_ptr;
 			dst_reg->var_off = ptr_reg->var_off;
 			dst_reg->off = ptr_reg->off + smin_val;
-			dst_reg->range = ptr_reg->range;
+			dst_reg->raw = ptr_reg->raw;
 			break;
 		}
 		/* A new variable offset is created.  Note that off_reg->off
@@ -2792,10 +2792,11 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		}
 		dst_reg->var_off = tnum_add(ptr_reg->var_off, off_reg->var_off);
 		dst_reg->off = ptr_reg->off;
+		dst_reg->raw = ptr_reg->raw;
 		if (reg_is_pkt_pointer(ptr_reg)) {
 			dst_reg->id = ++env->id_gen;
 			/* something was added to pkt_ptr, set range to zero */
-			dst_reg->range = 0;
+			dst_reg->raw = 0;
 		}
 		break;
 	case BPF_SUB:
@@ -2824,7 +2825,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			dst_reg->var_off = ptr_reg->var_off;
 			dst_reg->id = ptr_reg->id;
 			dst_reg->off = ptr_reg->off - smin_val;
-			dst_reg->range = ptr_reg->range;
+			dst_reg->raw = ptr_reg->raw;
 			break;
 		}
 		/* A new variable offset is created.  If the subtrahend is known
@@ -2850,11 +2851,12 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		}
 		dst_reg->var_off = tnum_sub(ptr_reg->var_off, off_reg->var_off);
 		dst_reg->off = ptr_reg->off;
+		dst_reg->raw = ptr_reg->raw;
 		if (reg_is_pkt_pointer(ptr_reg)) {
 			dst_reg->id = ++env->id_gen;
 			/* something was added to pkt_ptr, set range to zero */
 			if (smin_val < 0)
-				dst_reg->range = 0;
+				dst_reg->raw = 0;
 		}
 		break;
 	case BPF_AND:
-- 
2.17.1

