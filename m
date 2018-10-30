Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1AAC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1275D2082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOwgddOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1275D2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeJ3U3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:29:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45764 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeJ3U3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:29:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id c24-v6so8553819lfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0c4qq4Ww0v5TJSITOLozxcLN7WvXMS6Pv+NS1rx0eYU=;
        b=gOwgddOR+rM/NtNShdA4L1NNw1ah30l4AEuLYCWkGLxRpGkzqsuwELBEJyXstMxvks
         r3xIVi8YMesJ+WLA6wEeQtB+6AHhfluoImBdENXlMGxg9GKiRGYsCdFDGvJOiJ6Tlyvn
         8coK+mZ5pGtFlOWi8EUhQ4xAw8yLu8MTg5tik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0c4qq4Ww0v5TJSITOLozxcLN7WvXMS6Pv+NS1rx0eYU=;
        b=FvF2KvcZOumuE9MvdYyXujZOJc4xo6OW/KvPV3V7apiy+rfEnWY4Cg5Ko3YJsZQENq
         4XQfZ9QF0xB76Xh0rlOg+ZbnwYYQNW0mTOYs+3nteKrK7USMbk9LKExpqYGVultk/GE0
         m/AL8HFWeToenDGP/EsmJvLETyQosTlCzGjvaiWc9vQ9ClVd9jaXLGccV2CNYte0Onrt
         /x+4zahRjAct8YrWb5zMb9veE/6JDUC+WNY/an7vjZuoUSF8jNc2YQgBZD8gvy1hgaqp
         Mml8Ur0CPCiQTtdQUcrPTViNfbqHsT/FSI5sBxzT015aEiLiafEjpIv2I0Z2wP0TUzL2
         JZIg==
X-Gm-Message-State: AGRZ1gKNWl0Sr2oQJ30jrkFRBTUqeQvjqc5qkYHILytutQ4L9kRVRC2F
        lrXkZYApARjBh6eXh2CDKbRLmA==
X-Google-Smtp-Source: AJdET5cBHlupzI8DFEfRW+LDvxxFFzuGpyilXSNopOL7zP/54j9IfzjkvZ65UOZv4HAurPUmo0LM8A==
X-Received: by 2002:a19:41c4:: with SMTP id o187mr1719486lfa.32.1540899393326;
        Tue, 30 Oct 2018 04:36:33 -0700 (PDT)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id l67-v6sm3776781lfg.45.2018.10.30.04.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 04:36:32 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        tj@kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 2/2] writeback: don't decrement wb->refcnt if !wb->bdi
Date:   Tue, 30 Oct 2018 12:35:45 +0100
Message-Id: <20181030113545.30999-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181030113545.30999-1-anders.roxell@linaro.org>
References: <20181030113545.30999-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This happened while running in qemu-system-aarch64, the AMBA PL011 UART
driver when enabling CONFIG_DEBUG_TEST_DRIVER_REMOVE.
arch_initcall(pl011_init) came before subsys_initcall(default_bdi_init),
devtmpfs' handle_remove() crashes because the reference count is a NULL
pointer only because wb->bdi hasn't been initialized yet.

Rework so that wb_put have an extra check if wb->bdi before decrement
wb->refcnt and also add a WARN_ON_ONCE to get a warning if it happens again
in other drivers.

Fixes: 52ebea749aae ("writeback: make backing_dev_info host cgroup-specific bdi_writebacks")
Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 include/linux/backing-dev-defs.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 9a6bc0951cfa..c31157135598 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -258,6 +258,14 @@ static inline void wb_get(struct bdi_writeback *wb)
  */
 static inline void wb_put(struct bdi_writeback *wb)
 {
+	if (WARN_ON_ONCE(!wb->bdi)) {
+		/*
+		 * A driver bug might cause a file to be removed before bdi was
+		 * initialized.
+		 */
+		return;
+	}
+
 	if (wb != &wb->bdi->wb)
 		percpu_ref_put(&wb->refcnt);
 }
-- 
2.19.1

