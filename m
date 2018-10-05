Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D09DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93BF21473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrjkKE4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93BF21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbeJEXOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729295AbeJEXOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24C12214D5;
        Fri,  5 Oct 2018 16:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756091;
        bh=kztMh+YzeLOZYKJl9m96rebpJrF/ID6OGHPPT0A7XyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrjkKE4maoLYWU3FJlt4MUxXHWP13u9bgvyFgcy9i5sd/3U8ymDvw454WdBoCmRGP
         aOo2dVxmwhvqv65/j41LTVrfa53PkxXx9S6CdxxSyPclJO3OEAiAdk+Ar3rmI5CKSz
         l+YfTbMFZh3e4Cg+ZfMxRbp+dxZSaU6Rg2ZKYH+0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 29/48] bpf: btf: Fix end boundary calculation for type section
Date:   Fri,  5 Oct 2018 12:14:05 -0400
Message-Id: <20181005161424.20521-29-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin KaFai Lau <kafai@fb.com>

[ Upstream commit 4b1c5d917d34f705096bb7dd8a2bd19b0881970e ]

The end boundary math for type section is incorrect in
btf_check_all_metas().  It just happens that hdr->type_off
is always 0 for now because there are only two sections
(type and string) and string section must be at the end (ensured
in btf_parse_str_sec).

However, type_off may not be 0 if a new section would be added later.
This patch fixes it.

Fixes: f80442a4cd18 ("bpf: btf: Change how section is supported in btf_header")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2590700237c1..138f0302692e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1844,7 +1844,7 @@ static int btf_check_all_metas(struct btf_verifier_env *env)
 
 	hdr = &btf->hdr;
 	cur = btf->nohdr_data + hdr->type_off;
-	end = btf->nohdr_data + hdr->type_len;
+	end = cur + hdr->type_len;
 
 	env->log_type_id = 1;
 	while (cur < end) {
-- 
2.17.1

