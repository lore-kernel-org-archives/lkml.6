Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32153C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B3A2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NulEkyw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388152AbfAaQLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:11:04 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38965 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbfAaQLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:11:03 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so2739107lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 08:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l8ZZE/CQHJf/B+Br/+OZnPG545feQjEVeVkqxdQKkp0=;
        b=NulEkyw7WRGZfONt3e2rFzs9IFb84cAfNJcAgwD/UdiCtw/e5wReNIOU9KHl7SvheN
         0I2NwQRGNpNE212NvAb3sBUsZi7MOhVHNSJviVZHs+BG9M6UVR3gV85ur9rCH1KMgKM/
         f5fTxjcYk3zQnYAJC1Y/Gv+0HBQuJc+JJUGfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l8ZZE/CQHJf/B+Br/+OZnPG545feQjEVeVkqxdQKkp0=;
        b=IIWTY516psBIQQr+w/h58WLtifpCs33oS3WB2CJp+Y4Qn0KvlywK6ZbybWynRf2HNG
         eIb2F+zsCUFGnq3MuMV415hAMttD2ranTWODP93WIZHX/jPXeHS0o3zN7VjPUIMlDzbZ
         3YZ41EJ1nbvZq9lu2SBZ9Igq2zovIJXOnZ5EUK+lvPomPxvwAQZK3zP+eQzMUY54xz2x
         lkSvlOmDZcWb/z/7j3UpidmyJMoqfAshE5QfYpJKQlHt1Kb3ww2/nYexHhSnkM152GQf
         V1lYoutsS1Ppr3KtiGZxUCVF2gAXSKiJb0AmoUb332mnCRxWTBVt6cwJVmCxanfZ2S/i
         ciHQ==
X-Gm-Message-State: AJcUukeGntH9vp7V6jXMTJS1i45K5KuOLOBpLvIyG3+SuemNGxL6OwDd
        ecyjOINZDBFproNigdIep8RoaovaanXD/g==
X-Google-Smtp-Source: ALg8bN5jFb2AXccaSAAVgnX28SjZIcZYLh7UGufvd6HCHsSuZONlbB9tZPsUROf8nbxDO1s9DUimXg==
X-Received: by 2002:a19:4345:: with SMTP id m5mr27334183lfj.142.1548951061287;
        Thu, 31 Jan 2019 08:11:01 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id z17sm324322lfh.9.2019.01.31.08.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 08:11:00 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     akpm@linux-foundation.org
Cc:     rppt@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] mm: sparse: Use '%pa' with 'phys_addr_t' type
Date:   Thu, 31 Jan 2019 17:10:46 +0100
Message-Id: <20190131161046.21886-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following build warning:

mm/sparse.c: In function ‘sparse_buffer_init’:
mm/sparse.c:438:69: warning: format ‘%lx’ expects argument of type ‘long
  unsigned int’, but argument 6 has type ‘phys_addr_t’ {aka ‘long long
  unsigned int’} [-Wformat=]
   panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%lx\n",
                                                                   ~~^

Rework to use '%pa' and not '%lx'. Use a local variable of phys_addr_t
to print the reference with '%pa'.

Fixes: 1c3c9328cde0 ("treewide: add checks for the return value of memblock_alloc*()")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 mm/sparse.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 1471f06c6468..6a2b0a9359d7 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -409,16 +409,17 @@ struct page __init *sparse_mem_map_populate(unsigned long pnum, int nid,
 {
 	unsigned long size = section_map_size();
 	struct page *map = sparse_buffer_alloc(size);
+	phys_addr_t addr = __pa(MAX_DMA_ADDRESS);
 
 	if (map)
 		return map;
 
 	map = memblock_alloc_try_nid(size,
-					  PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
+					  PAGE_SIZE, addr,
 					  MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 	if (!map)
-		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%lx\n",
-		      __func__, size, PAGE_SIZE, nid, __pa(MAX_DMA_ADDRESS));
+		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%pa\n",
+		      __func__, size, PAGE_SIZE, nid, &addr);
 
 	return map;
 }
@@ -429,14 +430,15 @@ static void *sparsemap_buf_end __meminitdata;
 
 static void __init sparse_buffer_init(unsigned long size, int nid)
 {
+	phys_addr_t addr = __pa(MAX_DMA_ADDRESS);
 	WARN_ON(sparsemap_buf);	/* forgot to call sparse_buffer_fini()? */
 	sparsemap_buf =
 		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
-						__pa(MAX_DMA_ADDRESS),
+						addr,
 						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 	if (!sparsemap_buf)
-		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%lx\n",
-		      __func__, size, PAGE_SIZE, nid, __pa(MAX_DMA_ADDRESS));
+		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%pa\n",
+		      __func__, size, PAGE_SIZE, nid, &addr);
 
 	sparsemap_buf_end = sparsemap_buf + size;
 }
-- 
2.20.1

