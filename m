Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEEEECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F4F20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="av1CxqpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F4F20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbeGQMOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:14:10 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40438 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730897AbeGQMOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:14:09 -0400
Received: by mail-pf0-f194.google.com with SMTP id e13-v6so376848pff.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zsxyWlJa5L1Gv7t8Xsms7pw8bNxF0HNNGy0CGtS1AO8=;
        b=av1CxqpND9tL7sjaBogagecvcJetC3oAWvnNxypjEI9WMLUHQvnzFPijEUNYszrv2Z
         fcgFtSx4HGUNSPkiwnabYDd/biIqVS3DHhJwsJum1NrX618ChCI1fmYhoUwYl04EPMII
         EF4VtyW2IqiAaqIuji999n3sxPfB7zMbCPulTCS/56gRndKKCYvviemHYK5kZqFiHods
         UWlYqIj3DbrTP1N5EUHDcvmoPnQCC5vhPek2CV5FoT/pFNVklwgtm/pkpasDbpyZqmIH
         z9OyI6SgZCiyav+dRXcAhn9NFVAoNy5R9K1lQuKN3q8NkemfOrvDFM1IAQdG0++/eoYz
         6FYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zsxyWlJa5L1Gv7t8Xsms7pw8bNxF0HNNGy0CGtS1AO8=;
        b=Z0FO5FdA0CI+wu2arJZEuX9xQQ5FcGJiUik7XKiU1JmgSsK7uzbUp/Zw18qf5rTQb+
         p3Bz166pgKRdg13DpDa4H8r1idIYqRcbGKmftl2g5OzAD+NJAURglD5yehcpCWO/yaN/
         cZoNlV4UuKbCAxxgMghCKx5yWh6T6QojFiwdk/CC5Z0Mo9ggx1h9SiOUe39TsM3vuct2
         yC3+ugky9I6Q3DXqOUA9dyy1ALdSV8u+iMrUle+nCgAHaVa51VbbMf31Ga8a7YYUBWBK
         VwWP52GrBe/EuFpJWGrV8SOG/+51AeQuGk+GZTsxtlARwoLEdTi6FUPJzIkeT21A/Bov
         v8GA==
X-Gm-Message-State: AOUpUlHZLH5xbP/7Q0CYcEWeNj3XXhSEo+NCvYs5uXuI+CH4m/zNQozX
        slS1XvFqOQF84HgKRk7CEJ+HvnW9
X-Google-Smtp-Source: AAOMgpdKSlpSxNSgGY0ksWmsXX+fvQbnKkweeoyQhZ6emF1MihY65ctxGtSX0uthlZTPNYhdhHCdIA==
X-Received: by 2002:a62:748:: with SMTP id b69-v6mr302636pfd.177.1531827715681;
        Tue, 17 Jul 2018 04:41:55 -0700 (PDT)
Received: from raghu-VirtualBox ([116.197.184.12])
        by smtp.gmail.com with ESMTPSA id y132-v6sm1608095pfb.91.2018.07.17.04.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 04:41:54 -0700 (PDT)
From:   RAGHU Halharvi <raghuhack78@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     RAGHU Halharvi <raghuhack78@gmail.com>, jhogan@kernel.org,
        ralf@linux-mips.org
Subject: [PATCH] mips:sgi-ip22:Check return value from kzalloc
Date:   Tue, 17 Jul 2018 17:11:45 +0530
Message-Id: <20180717114145.21856-1-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: RAGHU Halharvi <raghuhack78@gmail.com>
---
 arch/mips/sgi-ip22/ip22-gio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
index b225033aade6..5aaf40a1743b 100644
--- a/arch/mips/sgi-ip22/ip22-gio.c
+++ b/arch/mips/sgi-ip22/ip22-gio.c
@@ -363,6 +363,8 @@ static void ip22_check_gio(int slotno, unsigned long addr, int irq)
 		printk(KERN_INFO "GIO: slot %d : %s (id %x)\n",
 		       slotno, name, id);
 		gio_dev = kzalloc(sizeof *gio_dev, GFP_KERNEL);
+		if (!gio_dev)
+			return -ENOMEM;
 		gio_dev->name = name;
 		gio_dev->slotno = slotno;
 		gio_dev->id.id = id;
-- 
2.17.1

