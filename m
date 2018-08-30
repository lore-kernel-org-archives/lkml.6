Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91117C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BB52082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BB52082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeH3XJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:09:05 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36728 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbeH3XJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:09:03 -0400
Received: by mail-oi0-f65.google.com with SMTP id r69-v6so17396898oie.3;
        Thu, 30 Aug 2018 12:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NFRDAdeXgojs+I7CCW5N+ajSHg8zEmxjFne5PsPUOg0=;
        b=j+febYY946FONWbzXrB3GCNrKcEwOIQVRWf3xix30WNJZ9iChcK9sh7UU90KxdrqAj
         bjbJfRLgS8zA+i3qDG0NWSeh1L5nHn0n0oYrUZiqtdGnFZDckl68skNHh9EEFtpdcpm1
         L1mrzPpHvzB/LVERfvjyIiW6uLq4jnlaE8bzuq58+IW9hkE2qEWO2qE0uZs/dICwcNk5
         ffmDuF0oMav3fBKRY1T+GJ4zVU9l3s8X46OGVvC5DxqHj/Mr9yjv7DMO045BueGmCO+x
         jKH7gCLlIamlOcDJsXN9W9HpZonxwG5S/kUDMSL1xuDVFtU9jcSug92yb6stDTqH9glO
         Fh7g==
X-Gm-Message-State: APzg51BbcwgE3EEA5/5GHQXEBimBYZEd/Vimx0ZQHM82TvT25E6Pi5lA
        LIJI4PX3Tf7AcZqOpL7fUMvN+8k=
X-Google-Smtp-Source: ANB0VdYfHPB7vS5YdVcgx/G46dO8434wyPA4/b9Hfzhao4bijzIoFO9wf5QbwooQDQYswHVgBh2KNg==
X-Received: by 2002:aca:dec6:: with SMTP id v189-v6mr3622229oig.98.1535655926189;
        Thu, 30 Aug 2018 12:05:26 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id 22-v6sm4200423oix.58.2018.08.30.12.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:05:25 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] of/fdt: avoid re-parsing '#{address,size}-cells' in of_fdt_limit_memory
Date:   Thu, 30 Aug 2018 14:05:22 -0500
Message-Id: <20180830190523.31474-3-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830190523.31474-1-robh@kernel.org>
References: <20180830190523.31474-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we initialize dt_root_addr_cells and dt_root_size_cells earlier,
use them and simplify of_fdt_limit_memory.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/fdt.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 49abe18f1bde..fef4b2c8a171 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -44,28 +44,7 @@ void of_fdt_limit_memory(int limit)
 	int memory;
 	int len;
 	const void *val;
-	int nr_address_cells = OF_ROOT_NODE_ADDR_CELLS_DEFAULT;
-	int nr_size_cells = OF_ROOT_NODE_SIZE_CELLS_DEFAULT;
-	const __be32 *addr_prop;
-	const __be32 *size_prop;
-	int root_offset;
-	int cell_size;
-
-	root_offset = fdt_path_offset(initial_boot_params, "/");
-	if (root_offset < 0)
-		return;
-
-	addr_prop = fdt_getprop(initial_boot_params, root_offset,
-				"#address-cells", NULL);
-	if (addr_prop)
-		nr_address_cells = fdt32_to_cpu(*addr_prop);
-
-	size_prop = fdt_getprop(initial_boot_params, root_offset,
-				"#size-cells", NULL);
-	if (size_prop)
-		nr_size_cells = fdt32_to_cpu(*size_prop);
-
-	cell_size = sizeof(uint32_t)*(nr_address_cells + nr_size_cells);
+	int cell_size = sizeof(uint32_t)*(dt_root_addr_cells + dt_root_size_cells);
 
 	memory = fdt_path_offset(initial_boot_params, "/memory");
 	if (memory > 0) {
-- 
2.17.1

