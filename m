Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50479ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CC82085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ElHyYk3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CC82085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeJ0GCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 02:02:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34083 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbeJ0GCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 02:02:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id w19-v6so2478143eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 14:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3K6SqR+g4h84dvT64My/Y2arGiA5tvTZGkr85MFLugg=;
        b=ElHyYk3oLlVi/nIm3w63VgMKMN5vbHC5qfp2uuF9OHj/XebiRlfLmD2gZNw1zhiGuM
         1aN8KNaMpujLbL/L2zQJPBKjlx/imQQbu0AGQmAu0Dl9ZSfAEDw35/VleOwEZS6t2TwZ
         Y0yTHagHOZJTcjwng04x4sIkCF4cSjv4EVXrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3K6SqR+g4h84dvT64My/Y2arGiA5tvTZGkr85MFLugg=;
        b=K3n5bV4zySLGE4B+wx/sr+IbwFJ+3+sE0JOxQ14yRfbsYv08QWNqp89QNXfkQm1DLu
         wNBN8lzAbUCvmeYqvY5usKIWk4rTdNFjpXogy0yB0Ud/eIKm0HciyGTkYPObC9VX15kQ
         xOa4Be40SBFlIHc1Lhf+QK7HfuGb2IGwMj/Sd2waZ4g9McJ3YW6zDNEyOdDLwOGYPR+b
         wYHp5aGWvbtmkNphozCa+dZQQZ/HvHag5WEUHRyqFpYbPkaK7f9YAB35ezotQlQkNm5j
         /esiIpwXTSz22JV1JXTEuntCL5lWm4zyfhXUToJpMlqS+WRRWRASXOWLj0V8Ff3IGNpc
         CT9w==
X-Gm-Message-State: AGRZ1gJ5qLh3DuSKlfWuuWMmHLBDv4VZTMvN7asmYeTsjQ6mYaUoszUb
        iPGxq+2nHTek50Z0f0qYloc4Tg==
X-Google-Smtp-Source: AJdET5fa45vUKVlyffjx4+x+Q0WMeiNrDKaw6R4nF3o5IVy/MJXo4bmDQOjcxi9t0n3kOI60vh1J/A==
X-Received: by 2002:a50:913d:: with SMTP id e58-v6mr4227670eda.148.1540589009792;
        Fri, 26 Oct 2018 14:23:29 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id r28-v6sm1727791eda.25.2018.10.26.14.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 14:23:29 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ptp: drop redundant kasprintf() to create worker name
Date:   Fri, 26 Oct 2018 23:22:59 +0200
Message-Id: <20181026212300.5827-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with -Wformat-nonliteral, gcc complains

drivers/ptp/ptp_clock.c: In function ‘ptp_clock_register’:
drivers/ptp/ptp_clock.c:239:26: warning: format not a string literal and no format arguments [-Wformat-nonliteral]
            worker_name : info->name);

kthread_create_worker takes fmt+varargs to set the name of the
worker, and that happens with a vsnprintf() to a stack buffer (that is
then copied into task_comm). So there's no reason not to just pass
"ptp%d", ptp->index to kthread_create_worker() and avoid the
intermediate worker_name variable.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/ptp/ptp_clock.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 7eacc1c4b3b1..5419a89d300e 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -232,12 +232,8 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	init_waitqueue_head(&ptp->tsev_wq);
 
 	if (ptp->info->do_aux_work) {
-		char *worker_name = kasprintf(GFP_KERNEL, "ptp%d", ptp->index);
-
 		kthread_init_delayed_work(&ptp->aux_work, ptp_aux_kworker);
-		ptp->kworker = kthread_create_worker(0, worker_name ?
-						     worker_name : info->name);
-		kfree(worker_name);
+		ptp->kworker = kthread_create_worker(0, "ptp%d", ptp->index);
 		if (IS_ERR(ptp->kworker)) {
 			err = PTR_ERR(ptp->kworker);
 			pr_err("failed to create ptp aux_worker %d\n", err);
-- 
2.19.1.6.gbde171bbf5

