Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57660C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7602064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcBYga1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7602064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeKBAuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:50:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43403 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeKBAuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:50:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so5127898plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ISTWYgSfuqfCPvWeQpdWr+HAcMuMtG3S5UyOPP/UgiA=;
        b=qcBYga1TgYweJhmtgAfgZEdO7tHYZIQ4OIKpNs/ap2hPhg8Y8W5BinajG0Ze1aN5s4
         ej566QU1lf26R8CtCjLSZ3EflSPT6YEOKgzwSiwNjjWj8cliUe8vnL1/NPmbcr9lz5J3
         5iRGRqpj6JRzvwKMCqL5ou6fuaH0YaJK8VmmXWDlTNp/mOwHKNHPHZ6gAwnNdv28luzA
         zrha5afVhXyNn/VPygpj0Rt/abO18+UU+j6IUqvgQ3MD2vlp5l1ADQPZUDrLQCpQhxpo
         4lOepmaGz9QTN4mz5URtZxb7BrKk+BQknMQwJHd1s32Lwkr02NuUOBUUt5ix3B8mqvS3
         1pGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ISTWYgSfuqfCPvWeQpdWr+HAcMuMtG3S5UyOPP/UgiA=;
        b=MUgeImfs2UBmNNRSg9vnvCL/xQ3MLwMzdwfxwBjv4Gv5KfalPVTyo2iYICSPuL0I8S
         qwJ792pfF52EzCwLbboEZW+PGHQWR0J0V/0cxQbzBTifHX8P6N8zk98sb15F67cxUdFZ
         YaZGTt7J3YwGdEPSiy3D5p4UQpvs2vj132oM6Yf0u9q90iNDwlpDQpAWtrJJvxE6tZgr
         IMb3JBItJbBr5sZ6C2j2ZXuQiRxzB2B1f5F/jEvhZeu4O1+Qhuo/j5/r0qY5xrB8FLnK
         1Pyy2oX1p6Hn5H5aWypUQtZ4lCZXta0blKE1VYtG8nAgglNj/38N2+5bFXEwBp4dJ8Nc
         sZKQ==
X-Gm-Message-State: AGRZ1gLXmNWVzRyYu/7o/2FSwUuGM6QBmwAt7wiZtkZE7uSRSvA+Me3u
        SodC5UvD5Zzkzzl+CMRc/hG0G59MGBw=
X-Google-Smtp-Source: AJdET5e+zbAUGR/w5OS+Y06u8oS9RUG5CdIVWtkn4RqExQwMh/kH1D/iO9lCQGVSRfj5lX+5TiYeKA==
X-Received: by 2002:a17:902:59d6:: with SMTP id d22-v6mr8127791plj.116.1541087203736;
        Thu, 01 Nov 2018 08:46:43 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id u12-v6sm27636917pfi.83.2018.11.01.08.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 08:46:43 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] ring-buffer: fix small typo
Date:   Thu,  1 Nov 2018 11:46:40 -0400
Message-Id: <20181101154640.23162-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/trace/ring_buffer_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index ffba6789c0e2..0564f6db0561 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -362,7 +362,7 @@ static void ring_buffer_producer(void)
 			hit--; /* make it non zero */
 		}
 
-		/* Caculate the average time in nanosecs */
+		/* Calculate the average time in nanosecs */
 		avg = NSEC_PER_MSEC / (hit + missed);
 		trace_printk("%ld ns per entry\n", avg);
 	}
-- 
2.17.0

