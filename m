Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F8BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A5920881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763525;
	bh=d9lLxAj/270PRUcLOnjBj660nTPJLtOZC4X1CY3/Tl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f70QNWfwoVC/YRXGJnRfRE/5qYtGOEXLkoeDVRbrNl4zkSrmf+/u9Pa/SPiY2Hlia
	 8PTDMAs8Vy/BmGzbFfCqWN8pA5BLieg1KkOBxv7mah98yk7xzGdDkNp0p8ZYcUlKyl
	 q1QpW6v+fCIrI6rfFNA+2jvk2eX/OAeCcHyJ2g0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfA2LmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:42:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729942AbfA2LmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:42:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11F6E20857;
        Tue, 29 Jan 2019 11:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762122;
        bh=d9lLxAj/270PRUcLOnjBj660nTPJLtOZC4X1CY3/Tl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9Y/yVu8TOoTl3Lb67JC4JzMd11NOyS9eN5iU4+uuHNU6AAXxoDcZ8Ro4jDnjNnDN
         DtlC9MPcisJILvgXgMHZR6F8GiaDKNQ2zeuZPytmvK2co53O1gE//6BSG3Oj14t9TO
         +t5FJ/pqrm8U811ke4iB2MgzFIUlwm74QGN8R7p0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 099/117] bpf: restrict map value pointer arithmetic for unprivileged
Date:   Tue, 29 Jan 2019 12:35:50 +0100
Message-Id: <20190129113212.319591501@linuxfoundation.org>
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

[ commit 0d6303db7970e6f56ae700fa07e11eb510cda125 upstream ]

Restrict map value pointer arithmetic for unprivileged users in that
arithmetic itself must not go out of bounds as opposed to the actual
access later on. Therefore after each adjust_ptr_min_max_vals() with a
map value pointer as a destination it will simulate a check_map_access()
of 1 byte on the destination and once that fails the program is rejected
for unprivileged program loads. We use this later on for masking any
pointer arithmetic with the remainder of the map value space. The
likelihood of breaking any existing real-world unprivileged eBPF
program is very small for this corner case.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 05dcd313279c..7c97d7cf4113 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3165,6 +3165,17 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	__update_reg_bounds(dst_reg);
 	__reg_deduce_bounds(dst_reg);
 	__reg_bound_offset(dst_reg);
+
+	/* For unprivileged we require that resulting offset must be in bounds
+	 * in order to be able to sanitize access later on.
+	 */
+	if (!env->allow_ptr_leaks && dst_reg->type == PTR_TO_MAP_VALUE &&
+	    check_map_access(env, dst, dst_reg->off, 1, false)) {
+		verbose(env, "R%d pointer arithmetic of map value goes out of range, prohibited for !root\n",
+			dst);
+		return -EACCES;
+	}
+
 	return 0;
 }
 
-- 
2.19.1



