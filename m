Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0052C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CCB20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547820302;
	bh=jEBSzl58appSjU0nqrxGJx6uu4e5Df5edpmlJd7GOdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zRTFKu4Cbflkn4dYksywm/KUCL2f53aNglh4IQtsvmCC1dwFh8RVBcbP/jsruZw1o
	 9+stxOxkenTS1Ihufyrw5SPrBXsZulNwqmK5xbvYeNIvKOgboQfVNnqF4zBptvm/YW
	 FFTmP+5x0aogZ3funO0l5L2j1IGRCdG0vRyyfK2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfAROFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:05:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40695 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbfAROEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:04:40 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18-v6so11727170lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 06:04:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cftGcUhp2hIXsQQzx8A/AHnCjsMjkAUMb50zkj+yZSs=;
        b=jJk6cESLiQAGVNNa4JtLeY/LcH1rUpmGyGKsVYA7qYWznSn564SDU0oVaT1IgZ4riq
         QNC+Ip5ArsrL+wW1ybGzpzcbQdwnZk+kv0yXw5Pga/JBnjB/m+xb8Muat9kYvr4wm3Rl
         aSmG4dW84FjfUvUdvTsRiOh/SX00l0IMbcCKaqPaKycXbIQVpQqRofAUeqZ4ianhIbIS
         fZGJMt/jYXvXD/HsUw+Q3SNgHDhPdWdmOPdiaaOiMNjuRF8kgfv10uuW5eOSf2xG2j/J
         6mukmhvUG+eJBeE6Wdhrmn7GndtjwJolcdw4NNcvoqjghXXwo1x0Z+zCA9sDMYnsJ4Ls
         hmGQ==
X-Gm-Message-State: AJcUukeHQOCov4hE73u3SeuiB2sEMI8XHt76lYyIE/fWMuzhcNAVKDhn
        IG/41Fco3ggvSDsDaP+Ct3Y=
X-Google-Smtp-Source: ALg8bN5tYIZ/UQG+zxGyHjxBCq4l7Z8pL9JfunFn8k77LKgh4w0vXxESS+zGGhrcpqPtWVyXzoHY3w==
X-Received: by 2002:a2e:6595:: with SMTP id e21-v6mr13144023ljf.123.1547820277864;
        Fri, 18 Jan 2019 06:04:37 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id x21sm809550lfe.6.2019.01.18.06.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:04:35 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gkUlB-0002W5-Dv; Fri, 18 Jan 2019 15:04:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Andreas Schwab <schwab@suse.de>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/5] riscv: treat cpu devicetree nodes without status as enabled
Date:   Fri, 18 Jan 2019 15:03:07 +0100
Message-Id: <20190118140308.9599-5-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118140308.9599-1-johan@kernel.org>
References: <20190118140308.9599-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the Linux convention and treat devicetree nodes without a status
property as enabled rather than disabled, while also allowing "ok" as a
shorthand for "okay".

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/riscv/kernel/cpu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 974d374fd36b..d1d9bfd5a89f 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -22,7 +22,7 @@
  */
 int riscv_of_processor_hartid(struct device_node *node)
 {
-	const char *isa, *status;
+	const char *isa;
 	u32 hart;
 
 	if (!of_device_is_compatible(node, "riscv")) {
@@ -39,12 +39,8 @@ int riscv_of_processor_hartid(struct device_node *node)
 		return -ENODEV;
 	}
 
-	if (of_property_read_string(node, "status", &status)) {
-		pr_warn("CPU with hartid=%d has no \"status\" property\n", hart);
-		return -ENODEV;
-	}
-	if (strcmp(status, "okay")) {
-		pr_info("CPU with hartid=%d has a non-okay status of \"%s\"\n", hart, status);
+	if (!of_device_is_available(node)) {
+		pr_info("CPU with hartid=%d is not available\n", hart);
 		return -ENODEV;
 	}
 
-- 
2.20.1

