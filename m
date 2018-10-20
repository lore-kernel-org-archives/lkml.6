Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D5CC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 20:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3311216C4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 20:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="oiE0idkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3311216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeJUFJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 01:09:49 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:45666 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJUFJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 01:09:49 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 5EF3195E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 20:58:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aIdMwZRR16CW for <linux-kernel@vger.kernel.org>;
        Sat, 20 Oct 2018 15:58:04 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 364E395D
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 15:58:04 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id l21-v6so20247668ioc.21
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xQ+GmITu1UBL82c2OOxEU+5GVCJZBz0JV2g6rO5syUA=;
        b=oiE0idkrrH0BXuKiZmb+YqGCFvkz2wiHpgZZ3nRA4kOBt01DNULhTYmMuAVbUbJwQB
         wyWW3IipLINQrvx9PuH9a9uFc+8m2JDN7pAblKU3/ARXHUVHsnCAcbRTDkJeahR9fxbn
         FSmo1ngnGwoEy7iETgDOfxvmCHYnlyD1Yzbs9AP5Ozji2LwFb05aUzl1cB8DWGQMMCkY
         8Ic6wRx3QrlFjzanktChsTJAnqz5oMl9XulYYg94lNf4IeXIq7dtt4lrMcRY4ZJkTLxg
         5Jty3EAM0OoIeFcfvhbrVtoOatqbLawECLel+dKRMQLMUi3hZGYhC5mwFj9QWe0/3owb
         AaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xQ+GmITu1UBL82c2OOxEU+5GVCJZBz0JV2g6rO5syUA=;
        b=Wj5FEpEM8p32vHaBKAtVybh3S0z/k7HR+VurmDVB56BF62cn5A0wrJitf8huqTU1MQ
         rDtOtEbteFPhlWtToKp0DriOKr9SLKQ1+tk2oB75ystCRMazc8mFJvldG+Gn2R958VCL
         EMVuOZKxCpldmQf/wQTeKJXLwgBo4DZJkRZXTrlnCh8fj/QKDsIrZgkXS8V2u3WSGiNk
         rB31KGn1mRvkPHklf8GZEQjxAE1pB3Tw3TPgjC/t2RWnJ06W6f61dPfcfBJKZgQ9QUxE
         g0acnqkAMI7qyPasKzc+7Fg5lOPKl6NLv5tlfhr71YbBA9xojOckcdN+T0VAtB4aK5H4
         qQyw==
X-Gm-Message-State: ABuFfoitakK12ElWrxptlPWtkDbzeSAVVGdzK53CYwdauoZQFikvhzJN
        gVLQnoo9FyRRnKPUCGbgJ3nKuI8GNxdq1pOV/rPGSgay9dLF73UdWQJLNUVxWJk+fUpe2d0NPg4
        CCgkOfD2eoUu6Ggvt882xPda0l8dc
X-Received: by 2002:a24:5214:: with SMTP id d20-v6mr6389630itb.24.1540069083683;
        Sat, 20 Oct 2018 13:58:03 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62McDdBEbGsQGQDfxxccpNobEH5ISnvA8IDkIlyt102VMXir3bxYvMKN/JaS2QaVgIDUx9ecw==
X-Received: by 2002:a24:5214:: with SMTP id d20-v6mr6389618itb.24.1540069083499;
        Sat, 20 Oct 2018 13:58:03 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id l142-v6sm4101910itl.23.2018.10.20.13.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Oct 2018 13:58:02 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, Ken Wang <Ken.Wang@amd.com>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/amdgpu: fix a missing-check bug
Date:   Sat, 20 Oct 2018 15:57:54 -0500
Message-Id: <1540069075-18358-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In amdgpu_read_bios_from_rom(), the header of the VBIOS is firstly copied
to 'header' from an IO memory region through
amdgpu_asic_read_bios_from_rom(). Then the header is checked to see whether
it is a valid header. If yes, the whole VBIOS, including the header, is
then copied to 'adev->bios'. The problem here is that no check is enforced
on the header after the second copy. Given that the device also has the
permission to access the IO memory region, it is possible for a malicious
device controlled by an attacker to modify the header between these two
copies. By doing so, the attacker can supply compromised VBIOS, which can
cause undefined behavior of the kernel and introduce potential security
issues.

This patch rewrites the header in 'adev->bios' using the header acquired in
the first copy.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index a5df80d..ac701f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -181,6 +181,8 @@ static bool amdgpu_read_bios_from_rom(struct amdgpu_device *adev)
 	/* read complete BIOS */
 	amdgpu_asic_read_bios_from_rom(adev, adev->bios, len);
 
+	memcpy(adev->bios, header, AMD_VBIOS_SIGNATURE_END);
+
 	if (!check_atom_bios(adev->bios, len)) {
 		kfree(adev->bios);
 		return false;
-- 
2.7.4

