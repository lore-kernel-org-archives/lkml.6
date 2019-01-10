Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4FEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23468214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X66BFFfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfAJH3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:29:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44613 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfAJH3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:29:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so10092961wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 23:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZtXwwgJ9jns1Sfy4Tyle1yTwi4X+cfbXqDXoJIa31BU=;
        b=X66BFFfwVK6hs8FEPRjQlqbXYcIZqcNUyMXN/AiT1VprSKpxjEtoQXKQ0FnX0D6Q9u
         W3wB8T1lSbYh877QKJAQSq6L06aByxN6VMX4cm+Zb92T90ndGCcitbsvU4UeXejCN/xp
         sWfnI1FolLL8YaH654IsqMXgPyB3eM77Aef8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZtXwwgJ9jns1Sfy4Tyle1yTwi4X+cfbXqDXoJIa31BU=;
        b=XknGK0KX+uTtVygKmDI7NK8bzlmF6ylbIC39L0/uHo0VXX3y35BVd2TKq8Px9BX2LV
         QKlYnusKK7hCz3fZsKSOhY15M/IBH7iMzw0na9F2X3DFpv0C3XEGjhOs8IzSGlQ91PXu
         vvsLHenj2mQXHVY/v7ATcg8iwAH3Fu3INUY3vF+TRU4U/Pd1WPU2gAei28bLCQi++afT
         JMZc8hA6IsOb5gqcWaM4sVPxNRjuWE5D2djtANcJRIuCrZC5KdYX/bvADOCegGKuqUQJ
         qA7DRZpceCJ0Wqj4WxTXmU+1DlCWPsJ5482Sg1wWReL7bP1sFXZDKj3pZ/ZG3ORdUiFF
         h8Qg==
X-Gm-Message-State: AJcUukdlDWstX6k3C3jrA4CIRWFWOAzGuh78Z4GTS3413yuaZWSf221L
        Ti5WxluTBFyG9TOmESUsnUWHO4HaLDqn1g==
X-Google-Smtp-Source: ALg8bN6JYAJnNmdLeU8FdAN1JA2feccocZGuVk0j2D+N2pAyBiausHSwhmeg0uynECoW3jINQHu/Cg==
X-Received: by 2002:adf:ae41:: with SMTP id u1mr7485670wrd.20.1547105341517;
        Wed, 09 Jan 2019 23:29:01 -0800 (PST)
Received: from dogfood.home ([2a01:cb1d:112:6f00:311a:55a6:a895:3ae2])
        by smtp.gmail.com with ESMTPSA id w12sm53846614wrr.23.2019.01.09.23.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 23:29:00 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, will.deacon@arm.com,
        Bernhard.Rosenkranzer@linaro.org, Carsten.Haitzler@arm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        David Airlie <airlied@linux.ie>
Subject: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
Date:   Thu, 10 Jan 2019 08:28:41 +0100
Message-Id: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM systems do not permit the use of anything other than cached
mappings for system memory, since that memory may be mapped in the
linear region as well, and the architecture does not permit aliases
with mismatched attributes.

So short-circuit the evaluation in ttm_io_prot() if the flags include
TTM_PL_SYSTEM when running on ARM or arm64, and just return cached
attributes immediately.

This fixes the radeon and amdgpu [TBC] drivers when running on arm64.
Without this change, amdgpu does not start at all, and radeon only
produces corrupt display output.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Junwei Zhang <Jerry.Zhang@amd.com>
Cc: David Airlie <airlied@linux.ie>
Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 046a6dda690a..0c1eef5f7ae3 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -530,6 +530,11 @@ pgprot_t ttm_io_prot(uint32_t caching_flags, pgprot_t tmp)
 	if (caching_flags & TTM_PL_FLAG_CACHED)
 		return tmp;
 
+#if defined(__arm__) || defined(__aarch64__)
+	/* ARM only permits cached mappings of system memory */
+	if (caching_flags & TTM_PL_SYSTEM)
+		return tmp;
+#endif
 #if defined(__i386__) || defined(__x86_64__)
 	if (caching_flags & TTM_PL_FLAG_WC)
 		tmp = pgprot_writecombine(tmp);
-- 
2.17.1

