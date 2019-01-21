Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E5CC37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD64620684
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6EPkfUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfAUXxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:53:06 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38353 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfAUXxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:53:06 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so17884979ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 15:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NB3Pnr4FGtpd9UY969+LPhME7MeKZH6Kn3tsP1O25mw=;
        b=Q6EPkfUV2cIZJMbxZs4Tv/3BxNqiHwiv2jr0/DVBVz4fPpy82MyVLk+3R++o1YEo2m
         sgs6V1T0rBoPlgvV6PlOOHMOsUfIyEbpnsANb/qDC67N9w6lhDGzNDQK7wFPWLHD226i
         Ix5eaADKHVBZA2zkgYttCLjTdTTDz8W7z0Pi57LVUagJlGsVtn1fg4hlDiddi9OyyvZD
         5brYXcj5r8JLClQVm1PlicshEbOEQ3gJv8fHOf1MYpsqaDaIzCxR2L3o7A/QPlgu3aP2
         I/QQW4xZhCLYlwE49mNxAvKxJwFU9i6ABq7E8LpvdVe40K5YkX1aOj+EvwtdsPrOWB73
         AoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NB3Pnr4FGtpd9UY969+LPhME7MeKZH6Kn3tsP1O25mw=;
        b=qI8P2x13aBgaVgNSVDMMVmkuAOoiNi9xuIT84pyWclaoXMD58elh/ihz8/+Ep6QM4z
         aFSlcrDYuLfIOS7rvL9epSWIajQgkCXBC2wg+CKwA5zC/mBJP6YPIIYuS4ee+fTch7Tu
         i/UX3fFCVFEShQlZ0zSYnvzIw0V0s/DG4T7zr/QK1AYDB+OEgJcxeHg3BT8cqQsC5esz
         MHb8aZB6LgnihAYJ+GN7Q0D/pIzYmTdqsASCq011AlXE7mFDtxpvsNppgHlNb+PLOxV/
         ZU8K7hEIbuD2QBhmGH9q9t90LMYBnBAzy8wJvtIBk/+LDVtP3qNL7JvS9TqXO2Lge+B/
         8VNA==
X-Gm-Message-State: AJcUukdORKV9OwyL/EqgSW2y76zjALTiz+0WP/u0PDmQ1htipN8Zhjq9
        jB+ItJe7iXTEWfx1015iMzI=
X-Google-Smtp-Source: ALg8bN6vXAGhxCRrpM1J45xfnfXXXqk+ly6s799uIcE9+ZDtv89sC4GarED32CCeWci4nEUTdM5Xpg==
X-Received: by 2002:a50:a974:: with SMTP id m49mr29353186edc.220.1548114784490;
        Mon, 21 Jan 2019 15:53:04 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id g5-v6sm5018346ejm.15.2019.01.21.15.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 15:53:03 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Mark Nutter <Mark.Nutter@arm.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amdkfd: Fix if preprocessor statement above kfd_fill_iolink_info_for_cpu
Date:   Mon, 21 Jan 2019 16:52:15 -0700
Message-Id: <20190121235214.28455-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121223516.24340-1-natechancellor@gmail.com>
References: <20190121223516.24340-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:866:5: warning:
'CONFIG_X86_64' is not defined, evaluates to 0 [-Wundef]
#if CONFIG_X86_64
    ^
1 warning generated.

Fixes: d1c234e2cd10 ("drm/amdkfd: Allow building KFD on ARM64 (v2)")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Resending as I forgot to add the lists...

 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 5d85ff341385..2e7c44955f43 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -863,7 +863,7 @@ static int kfd_fill_mem_info_for_cpu(int numa_node_id, int *avail_size,
 	return 0;
 }
 
-#if CONFIG_X86_64
+#ifdef CONFIG_X86_64
 static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_size,
 				uint32_t *num_entries,
 				struct crat_subtype_iolink *sub_type_hdr)
-- 
2.20.1

