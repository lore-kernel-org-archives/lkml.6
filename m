Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17214ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC61208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTzeyS9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC61208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732901AbeKIHrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:47:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732891AbeKIHrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:47:36 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94F6020989;
        Thu,  8 Nov 2018 22:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541715004;
        bh=ucPQLHOVfjFyOyslsopkQGcsYbqDZ/Q6BrOVd1UVFH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PTzeyS9TK0AjZ707iDE5V/6mb5Cr84C47bORjjL1aAcT32hrHIdak8y9Bv3Awrse7
         cFo32rHvZjcKIVahzbnwgez86ylKkM4263jjmmpc9V0Fsn8LoEkx1VeI5m2qvVFY05
         z17r9STg5lYFxS8PZOhFJsCBSHXOa+noSwt1wmwI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Edward Cree <ecree@solarflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 03/34] bpf: fix partial copy of map_ptr when dst is scalar
Date:   Thu,  8 Nov 2018 13:52:32 -0800
Message-Id: <20181108215139.111281294@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 0962590e553331db2cc0aef2dc35c57f6300dbbe upstream.

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
Acked-by: Edward Cree <ecree@solarflare.com>
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
index 82e8edef6ea0..b000686fa1a1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2731,7 +2731,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			dst_reg->umax_value = umax_ptr;
 			dst_reg->var_off = ptr_reg->var_off;
 			dst_reg->off = ptr_reg->off + smin_val;
-			dst_reg->range = ptr_reg->range;
+			dst_reg->raw = ptr_reg->raw;
 			break;
 		}
 		/* A new variable offset is created.  Note that off_reg->off
@@ -2761,10 +2761,11 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
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
@@ -2793,7 +2794,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			dst_reg->var_off = ptr_reg->var_off;
 			dst_reg->id = ptr_reg->id;
 			dst_reg->off = ptr_reg->off - smin_val;
-			dst_reg->range = ptr_reg->range;
+			dst_reg->raw = ptr_reg->raw;
 			break;
 		}
 		/* A new variable offset is created.  If the subtrahend is known
@@ -2819,11 +2820,12 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
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



