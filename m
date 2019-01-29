Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D25C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D97F21873
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762153;
	bh=+Ll0/BqSsmbXS/IUUuMgqLwO9yNVFO16O/9CU2HGhLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P5Ng4LUHzIdmXMNlSOPSM+FnepI719j95wVA/5y8kkFzbEkj7b+LOYFQe0OuCwvTs
	 P3yBKZFuwkiFNtbyzoMsEe7rEqLVmFxwhj/3KwljG7bnFhbJx3PFaDhtXt+Ea26rHM
	 JZxlp+0N1Kdzb1V3Or0aNMRIvJthPKPqsSrO6Xns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbfA2Lmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:42:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730040AbfA2LmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:42:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F62821871;
        Tue, 29 Jan 2019 11:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762143;
        bh=+Ll0/BqSsmbXS/IUUuMgqLwO9yNVFO16O/9CU2HGhLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WaX9YBrYgWrdHEtPOCFEHF7VeZNx1lmYB6y+kkfZQEg6qwBCP6tmd759bBLNIw/Bv
         kVMzrUkdBU8TwrWMskCfMau3CE4PiXVU4reU141KSziAkCdhNVG8A1cI7TaPjEp+Dk
         2YSpTejR6pQ0v9i+fQ9lhkx1poKbjlENpsLcO6mc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 105/117] bpf: fix inner map masking to prevent oob under speculation
Date:   Tue, 29 Jan 2019 12:35:56 +0100
Message-Id: <20190129113212.609944461@linuxfoundation.org>
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

[ commit 9d5564ddcf2a0f5ba3fa1c3a1f8a1b59ad309553 upstream ]

During review I noticed that inner meta map setup for map in
map is buggy in that it does not propagate all needed data
from the reference map which the verifier is later accessing.

In particular one such case is index masking to prevent out of
bounds access under speculative execution due to missing the
map's unpriv_array/index_mask field propagation. Fix this such
that the verifier is generating the correct code for inlined
lookups in case of unpriviledged use.

Before patch (test_verifier's 'map in map access' dump):

  # bpftool prog dump xla id 3
     0: (62) *(u32 *)(r10 -4) = 0
     1: (bf) r2 = r10
     2: (07) r2 += -4
     3: (18) r1 = map[id:4]
     5: (07) r1 += 272                |
     6: (61) r0 = *(u32 *)(r2 +0)     |
     7: (35) if r0 >= 0x1 goto pc+6   | Inlined map in map lookup
     8: (54) (u32) r0 &= (u32) 0      | with index masking for
     9: (67) r0 <<= 3                 | map->unpriv_array.
    10: (0f) r0 += r1                 |
    11: (79) r0 = *(u64 *)(r0 +0)     |
    12: (15) if r0 == 0x0 goto pc+1   |
    13: (05) goto pc+1                |
    14: (b7) r0 = 0                   |
    15: (15) if r0 == 0x0 goto pc+11
    16: (62) *(u32 *)(r10 -4) = 0
    17: (bf) r2 = r10
    18: (07) r2 += -4
    19: (bf) r1 = r0
    20: (07) r1 += 272                |
    21: (61) r0 = *(u32 *)(r2 +0)     | Index masking missing (!)
    22: (35) if r0 >= 0x1 goto pc+3   | for inner map despite
    23: (67) r0 <<= 3                 | map->unpriv_array set.
    24: (0f) r0 += r1                 |
    25: (05) goto pc+1                |
    26: (b7) r0 = 0                   |
    27: (b7) r0 = 0
    28: (95) exit

After patch:

  # bpftool prog dump xla id 1
     0: (62) *(u32 *)(r10 -4) = 0
     1: (bf) r2 = r10
     2: (07) r2 += -4
     3: (18) r1 = map[id:2]
     5: (07) r1 += 272                |
     6: (61) r0 = *(u32 *)(r2 +0)     |
     7: (35) if r0 >= 0x1 goto pc+6   | Same inlined map in map lookup
     8: (54) (u32) r0 &= (u32) 0      | with index masking due to
     9: (67) r0 <<= 3                 | map->unpriv_array.
    10: (0f) r0 += r1                 |
    11: (79) r0 = *(u64 *)(r0 +0)     |
    12: (15) if r0 == 0x0 goto pc+1   |
    13: (05) goto pc+1                |
    14: (b7) r0 = 0                   |
    15: (15) if r0 == 0x0 goto pc+12
    16: (62) *(u32 *)(r10 -4) = 0
    17: (bf) r2 = r10
    18: (07) r2 += -4
    19: (bf) r1 = r0
    20: (07) r1 += 272                |
    21: (61) r0 = *(u32 *)(r2 +0)     |
    22: (35) if r0 >= 0x1 goto pc+4   | Now fixed inlined inner map
    23: (54) (u32) r0 &= (u32) 0      | lookup with proper index masking
    24: (67) r0 <<= 3                 | for map->unpriv_array.
    25: (0f) r0 += r1                 |
    26: (05) goto pc+1                |
    27: (b7) r0 = 0                   |
    28: (b7) r0 = 0
    29: (95) exit

Fixes: b2157399cc98 ("bpf: prevent out-of-bounds speculation")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/map_in_map.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 99d243e1ad6e..52378d3e34b3 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -12,6 +12,7 @@
 struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 {
 	struct bpf_map *inner_map, *inner_map_meta;
+	u32 inner_map_meta_size;
 	struct fd f;
 
 	f = fdget(inner_map_ufd);
@@ -36,7 +37,12 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		return ERR_PTR(-EINVAL);
 	}
 
-	inner_map_meta = kzalloc(sizeof(*inner_map_meta), GFP_USER);
+	inner_map_meta_size = sizeof(*inner_map_meta);
+	/* In some cases verifier needs to access beyond just base map. */
+	if (inner_map->ops == &array_map_ops)
+		inner_map_meta_size = sizeof(struct bpf_array);
+
+	inner_map_meta = kzalloc(inner_map_meta_size, GFP_USER);
 	if (!inner_map_meta) {
 		fdput(f);
 		return ERR_PTR(-ENOMEM);
@@ -46,9 +52,16 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	inner_map_meta->key_size = inner_map->key_size;
 	inner_map_meta->value_size = inner_map->value_size;
 	inner_map_meta->map_flags = inner_map->map_flags;
-	inner_map_meta->ops = inner_map->ops;
 	inner_map_meta->max_entries = inner_map->max_entries;
 
+	/* Misc members not needed in bpf_map_meta_equal() check. */
+	inner_map_meta->ops = inner_map->ops;
+	if (inner_map->ops == &array_map_ops) {
+		inner_map_meta->unpriv_array = inner_map->unpriv_array;
+		container_of(inner_map_meta, struct bpf_array, map)->index_mask =
+		     container_of(inner_map, struct bpf_array, map)->index_mask;
+	}
+
 	fdput(f);
 	return inner_map_meta;
 }
-- 
2.19.1



