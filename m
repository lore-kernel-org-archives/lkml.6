Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F5CC4321E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEF220839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEEF220839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeIFAJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:09:37 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38189 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbeIFAJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:36 -0400
Received: by mail-oi0-f68.google.com with SMTP id x197-v6so15933406oix.5;
        Wed, 05 Sep 2018 12:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=esRW4epyy+tbCOE/OOJYFszu2Y4geAOJ7tPyxf0XQ90=;
        b=UdtoerTgkdQIQj7B6Q9rQUVXEKionMBVczHwOdmxNxmTkUfjb+oPrSpoaFTpgyKJO1
         HwgpRInQdbjKUWtSwFfyErjZ7f1SzM9uxs2jBkhaM1NziImdDGfL+DRrJxAzQ9CIGVkv
         5pSpPMq73kWIXaLH4AeXMzX8+8ok+Qf0XJ37HC8tSD4a39VkVf7XKthY9QQPDGGPsFjm
         dnCLK/SOQVGVErUaImnfzUsYnLwQLNAE4VJqth4i/BzG0rKGURaTJuLtazNB5SkbmZ8m
         zkBSGNuIx0ZJGbt9f0bxsq0HYV38HdkSG5Zr2sDNnfD2kIA8Kf5uwgv+nCiRiiH3iEGd
         TlGg==
X-Gm-Message-State: APzg51CaNQKs/7u5ffXYXeR5G0d9w7qxrf8Lbq2fJqhWuCsk5UZwudLA
        6Aozt3fNcPOKNl3Ur79nXRiZpoM=
X-Google-Smtp-Source: ANB0Vda3uGGmtCm9niLbNULBjEc3hEpAog7xnev4aH0NQzINrAjb2fW7zml31F8m4eRs7vQoibsm0w==
X-Received: by 2002:aca:4aca:: with SMTP id x193-v6mr7630941oia.211.1536176277944;
        Wed, 05 Sep 2018 12:37:57 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:37:57 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH 15/21] SH: use for_each_of_cpu_node iterator
Date:   Wed,  5 Sep 2018 14:37:32 -0500
Message-Id: <20180905193738.19325-16-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
has the side effect of defaulting to iterating using "cpu" node names in
preference to the deprecated (for FDT) device_type == "cpu".

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/sh/boards/of-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index 26789ad28193..cde370cad4ae 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -64,7 +64,7 @@ static void sh_of_smp_probe(void)

 	init_cpu_possible(cpumask_of(0));

-	for_each_node_by_type(np, "cpu") {
+	for_each_of_cpu_node(np) {
 		const __be32 *cell = of_get_property(np, "reg", NULL);
 		u64 id = -1;
 		if (cell) id = of_read_number(cell, of_n_addr_cells(np));
--
2.17.1
