Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D74C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6214D21545
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q2q63Ptt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6214D21545
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeHOXa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:30:57 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44423 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeHOXa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:30:56 -0400
Received: by mail-pl0-f66.google.com with SMTP id ba4-v6so946932plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c2h+fUPP5zAMcubDeC/T0Oi5S9R8LB+YSpYUoT/kx4w=;
        b=Q2q63Ptte/bax1CzOlJbr/mAKg7euOwxOdKiODPc6sIOlXEvxgWYNJ5R9ruHDhwwBt
         s45iC8opBw6rWNBHw0UjWAj2qDdmx9hKOhsYf4uvmXYqCKtqJzyww0CMWncJ9LffVu/4
         2Zm2kWLNW++muIddnJz17KX0TaMnl/Asm0mqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c2h+fUPP5zAMcubDeC/T0Oi5S9R8LB+YSpYUoT/kx4w=;
        b=i1r7Q/QM+paT+Jn+4av2f+Mn/dud9byQRNF4H/SAOBpb7VrCFxR6oay5EvLX6bV3zN
         CHaxNjtA6W0nuWVeUQxiwEtTp6FMi9PgM2Hqwa7VPeTxk1hLGL+/QSnXSwiwvLOOWKSK
         go/owVWSvfTxASsEYdDbnwnYf++tIjiKl3BA4s4uf9rrclwUE5foTVfUu7TTt2KSBn5d
         cOO0sTRE61xbzOFYDYH2QaTKqIa5di2catmW9OixxpTKc1lPQgWmXswCPwvWZbWjY4n0
         7l/h1KN3RRp6rBS51HKJgqibW6v4Z2g/HlAiHt87jQCtAC/d1AOmifYgN+J9jQTGR48k
         rPmw==
X-Gm-Message-State: AOUpUlF/X9eSd7tnrZOh7Zinv5RNjS6iXGAjy6UpDm+hqYFdrSdD1Ka9
        UZ0tRtg++RdPqKe12pWpEphugg==
X-Google-Smtp-Source: AA+uWPzf62J75VkkFDwiOE/CpEof7t1Ta21JMyyMbnXUm71EvU41r5jEsWkw4Tf0x69MJhvuikiKvQ==
X-Received: by 2002:a17:902:583:: with SMTP id f3-v6mr25721431plf.115.1534365432149;
        Wed, 15 Aug 2018 13:37:12 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id z20-v6sm54606269pfd.99.2018.08.15.13.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 13:37:11 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 2/6] firmware: coreboot: Unmap ioregion after device population
Date:   Wed, 15 Aug 2018 13:37:04 -0700
Message-Id: <20180815203708.67090-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180815203708.67090-1-swboyd@chromium.org>
References: <20180815203708.67090-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both callers of coreboot_table_init() ioremap the pointer that comes in
but they don't unmap the memory on failure. Both of them also fail probe
immediately with the return value of coreboot_table_init(), leaking a
mapping when it fails. The mapping isn't necessary at all after devices
are populated either, so we can just drop the mapping here when we exit
the function. Let's do that to simplify the code a bit and plug the leak.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Fixes: 570d30c2823f ("firmware: coreboot: Expose the coreboot table as a bus")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/google/coreboot_table.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 19db5709ae28..898bb9abc41f 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -110,7 +110,8 @@ int coreboot_table_init(struct device *dev, void __iomem *ptr)
 
 	if (strncmp(header.signature, "LBIO", sizeof(header.signature))) {
 		pr_warn("coreboot_table: coreboot table missing or corrupt!\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 
 	ptr_entry = (void *)ptr_header + header.header_bytes;
@@ -137,7 +138,8 @@ int coreboot_table_init(struct device *dev, void __iomem *ptr)
 
 		ptr_entry += entry.size;
 	}
-
+out:
+	iounmap(ptr);
 	return ret;
 }
 EXPORT_SYMBOL(coreboot_table_init);
@@ -146,7 +148,6 @@ int coreboot_table_exit(void)
 {
 	if (ptr_header) {
 		bus_unregister(&coreboot_bus_type);
-		iounmap(ptr_header);
 		ptr_header = NULL;
 	}
 
-- 
Sent by a computer through tubes

