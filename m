Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A121BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F0520652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547820280;
	bh=8+eWiP6D4VZIet5eg2mHUjpcjrT5TEX3kts54x7YN2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YUMJ9GSJ73V5p2bs0LcvZPiFSsK67iU+rGt4KkoTgJrwJxNjso2Gz9tNKkbr+auWj
	 I6ihrm5GXGKnJFabs/OVX2BEiLPjLKbSIoogGw0hduEJnvJ3j1VVkfemsLELwHQ2Du
	 A9lAi/gvdnf+t0Sq2PQO4MXRwlL5DRQEFpQMSuBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfAROEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:04:38 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39071 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfAROEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:04:38 -0500
Received: by mail-lf1-f65.google.com with SMTP id n18so10562996lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 06:04:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cmUXM58BMaiJjpGLA3Yxvgez8I0gKgtgs8JTbgTggBI=;
        b=Mtrg5xhwX+xtYflqI5wjV7u3EBeoEUIa82EYuGb9I8TEXbaiTgHgxcDs6jlzByC4ly
         +3lKUYJq21+G4j6YFO75ajjd7GsO2XvNuoTHBD3KhopzfmyQjARUatElmzMpdXXpd8K6
         ltqE/Xyr6kQN1f8CJUyM6jCt+BFjp2Lypke7nDm3zIQFMQJyi9T97dYIQ5Af7gGuddAL
         BTH8focg3UPnc6A8pdJ+3djAQuvimfINGjwApB6DXzVH8uXcQ+PN+/FB04/yOXYawlVr
         mXH0l06f6ZGYKregDGI6uEIhlaY6pwVnogqytLS5mkors3fgxEOC5nj9d9wXDi35YPB2
         LHog==
X-Gm-Message-State: AJcUukeDA5E+qTJNbD1xg42rc1cj0d6umNuS1I6Sj/VtG4DBNJDBsrhP
        HBpKPUZXC6CGCjf+OG8ztpo=
X-Google-Smtp-Source: ALg8bN6ZyIQtwvoCv4X5xICG4zkSKseDpH/7qfL0DfctUWNjTB5g2KO/0iF3NGF1XRY/SSz28BzQUg==
X-Received: by 2002:ac2:4194:: with SMTP id z20mr7107719lfh.74.1547820276099;
        Fri, 18 Jan 2019 06:04:36 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id g85-v6sm765405lji.17.2019.01.18.06.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:04:35 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gkUlB-0002Vv-8r; Fri, 18 Jan 2019 15:04:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Andreas Schwab <schwab@suse.de>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/5] riscv: use pr_info and friends
Date:   Fri, 18 Jan 2019 15:03:05 +0100
Message-Id: <20190118140308.9599-3-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118140308.9599-1-johan@kernel.org>
References: <20190118140308.9599-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the pr_info and pr_err macros instead of printk with explicit log
levels.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/riscv/kernel/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 6e079e94b638..5c15bb0560ee 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -76,11 +76,11 @@ static void __init setup_initrd(void)
 	unsigned long size;
 
 	if (initrd_start >= initrd_end) {
-		printk(KERN_INFO "initrd not found or empty");
+		pr_info("initrd not found or empty");
 		goto disable;
 	}
 	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
-		printk(KERN_ERR "initrd extends beyond end of memory");
+		pr_err("initrd extends beyond end of memory");
 		goto disable;
 	}
 
@@ -88,7 +88,7 @@ static void __init setup_initrd(void)
 	memblock_reserve(__pa(initrd_start), size);
 	initrd_below_start_ok = 1;
 
-	printk(KERN_INFO "Initial ramdisk at: 0x%p (%lu bytes)\n",
+	pr_info("Initial ramdisk at: 0x%p (%lu bytes)\n",
 		(void *)(initrd_start), size);
 	return;
 disable:
-- 
2.20.1

