Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FFFC04AB9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD5D208DA
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="GBJHUm+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD5D208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeHRQcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:32:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44159 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeHRQcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:32:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id f23-v6so5968280edr.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8VU5yC6/rVj1cdBxmXTz6KDrCfPGY9v3moT0miaymQE=;
        b=GBJHUm+sKe6qQ5yDR8bHK+tVqeXmzOJDrraEDyzqKAgsgil4x+zzHoppHV2ZY+a8Nv
         NPiXZXYoLnsSdH6KPfjCtycFzQPgi8by9RHiAsiEN5sdiAFuiO2ijd22T8VG4f+vaWNY
         EixNlHZ/0y50HgVwplKQ4fiJ8zKEg3k9G81CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8VU5yC6/rVj1cdBxmXTz6KDrCfPGY9v3moT0miaymQE=;
        b=I885unnh0xFJSP/uu4k4W5OWWlyBfwUGzwtTcBseFtpQvYEugjZsdYhvp2+9jVaoJb
         DCoGmHGI/PXs2ikbbguehdGCqkBQRc285BZGGUTO+lB9BqnOg4F4TXKmT4V+angcCtUq
         5oLVK6N8guPhFaiahO+Wke3DUK0GN4e8K8GvUhyhpXwLWp1H5xIerWy/jpIQb48PjJJZ
         BMVmkhxpLfQVhDt5n5Zmr2+5nKpzS8CH0mJ7diHHqDXG5sjZiRx7EQ3u1IyL2zITUpAu
         6gAUA5aWpXBf10n+sw10RyQfr63pcBspKh/9IQMqpMwEy/1y34/XoDkZzgXDp8TjHgsl
         Wv+g==
X-Gm-Message-State: AOUpUlGZHAgEr4IzAoZ5oe2DJ5yHtfrRuYQKv4g3p7dvn3SzHgkgGswR
        8Pc3i4RHTXPm8hyyjhXJLn0XUQ==
X-Google-Smtp-Source: AA+uWPwgeZA84nYD9ZPnUcEiW811y1y7X6MaCAcrvtytZRPdjHKjtpaCMn4/jVoCnUtfZQMRF6yTDA==
X-Received: by 2002:a50:f78a:: with SMTP id h10-v6mr45249569edn.37.1534598689645;
        Sat, 18 Aug 2018 06:24:49 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-212.cgn.ip.fibianet.dk. [5.186.114.212])
        by smtp.gmail.com with ESMTPSA id a11-v6sm2739032edn.95.2018.08.18.06.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 06:24:49 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 7/8] powerpc/pseries: use seq_open_data in hcall_inst_seq_open
Date:   Sat, 18 Aug 2018 15:24:33 +0200
Message-Id: <20180818132434.9515-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180818132434.9515-1-linux@rasmusvillemoes.dk>
References: <20180818132434.9515-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code should check the return value of seq_open(); if it failed,
file->private_data is NULL. But we can avoid the issue entirely and
simplify the code by letting seq_open_data() set the ->private member.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Depends on 1/8 introducing seq_open_data.

arch/powerpc/platforms/pseries/hvCall_inst.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
index 6da320c786cd..4816916dc8a1 100644
--- a/arch/powerpc/platforms/pseries/hvCall_inst.c
+++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
@@ -92,14 +92,7 @@ static const struct seq_operations hcall_inst_seq_ops = {
 
 static int hcall_inst_seq_open(struct inode *inode, struct file *file)
 {
-	int rc;
-	struct seq_file *seq;
-
-	rc = seq_open(file, &hcall_inst_seq_ops);
-	seq = file->private_data;
-	seq->private = file_inode(file)->i_private;
-
-	return rc;
+	return seq_open_data(file, &hcall_inst_seq_ops, file_inode(file)->i_private);
 }
 
 static const struct file_operations hcall_inst_seq_fops = {
-- 
2.16.4

