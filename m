Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DB5C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6633214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ih3ouotV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfAUHeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:34:20 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36292 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfAUHeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:34:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so9402477plo.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+hmdyO+P7OhnxtWxgXzXr5h3FZef89nOTZIJP5d5FhI=;
        b=Ih3ouotVPm9Czxle1biBqpvAo/Snbb+l7E7QHDXERYBaKN8C29vG8ltB9Dg4s11e2g
         BEZyjFIxrUwVRje83XZnK7OWTAO/8glD3mYT/K2qPKnO6ng/ziRz37Gsk6VH5nBRrHMQ
         1RY7TFUBIkW/qmEA/zwVcVYK+04HhZ01m13aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+hmdyO+P7OhnxtWxgXzXr5h3FZef89nOTZIJP5d5FhI=;
        b=g97F5NqdIaJrf1e6CyJAEjMuctuAdR98vK6+p4VTQ4atF+OQmAAhUecHd73MJXbsE5
         WA2tOXtk+IU4US6tb3qqIzi5r2UgHk9g8h3QjIZWL5xe7+GvT9Sqka0xbsrda278cPF9
         cxbzOQ0xQs5CPdXtT4fghSI/ghfJ7Cq5V1IhRNUeHdk2Nnht+8KTpY3QAu0EEyFufrzi
         4LOQ/Smn5aKtxu9FFDhwkzlin/PAINP88vzAo+7I363TZV1RVUDFTv/3e5/Se4D3ZoM5
         ARESA2PyaCkv8U6YmXgL2zilwnG5mXKdDLQg1wyklSO4KQqKPwP1M47hPKjLZSCHniPw
         Ah9w==
X-Gm-Message-State: AJcUukesPkg5zAOMQCwygu6x/wslwL3WtLZVK8OSN+QvTsRq79Ekj9oc
        zCPWIRLrxPGs/ZQAneIlcPjjSQ==
X-Google-Smtp-Source: ALg8bN79em6x5NhHPF5tMk1F4ff43D118VqGvJk2fMPHOx7NBFjfZoz7F7oQ+MSntuArcjsWBFEdJw==
X-Received: by 2002:a17:902:4624:: with SMTP id o33mr28598916pld.289.1548056057171;
        Sun, 20 Jan 2019 23:34:17 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id r6sm19483243pgk.91.2019.01.20.23.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 23:34:16 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR
        (REMOTEPROC) SUBSYSTEM), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] remoteproc: elf_loader: Use memset_io instead of memset.
Date:   Mon, 21 Jan 2019 15:34:08 +0800
Message-Id: <20190121073408.56557-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190121073408.56557-1-pihsun@chromium.org>
References: <20190121073408.56557-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use memset_io and memcpy_toio instead of memset and memcpy in
rproc_elf_load_segments, since the target ptr may be device memory.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
This fix issue while trying to load ELF firmware based on
https://lore.kernel.org/patchwork/patch/1033804/, that the memset(...,
0) would use "dc zva" instruction on aarch64, which cause kernel crash
since the target is device memory.
---
 drivers/remoteproc/remoteproc_elf_loader.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index b17d72ec8603bc..17f1815757dc54 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -159,7 +159,7 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 		u32 memsz = phdr->p_memsz;
 		u32 filesz = phdr->p_filesz;
 		u32 offset = phdr->p_offset;
-		void *ptr;
+		void __iomem *ptr;
 
 		if (phdr->p_type != PT_LOAD)
 			continue;
@@ -191,7 +191,7 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 
 		/* put the segment where the remote processor expects it */
 		if (phdr->p_filesz)
-			memcpy(ptr, elf_data + phdr->p_offset, filesz);
+			memcpy_toio(ptr, elf_data + phdr->p_offset, filesz);
 
 		/*
 		 * Zero out remaining memory for this segment.
@@ -201,7 +201,7 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 		 * this.
 		 */
 		if (memsz > filesz)
-			memset(ptr + filesz, 0, memsz - filesz);
+			memset_io(ptr + filesz, 0, memsz - filesz);
 	}
 
 	return ret;
-- 
2.20.1.321.g9e740568ce-goog

