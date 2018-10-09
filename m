Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F2BC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF322075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="U9gcIOA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF322075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeJIScK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:32:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45036 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeJIScK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:32:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so641723pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UG5TyJ4mQLwlYDrNM4sIdv6PF17gqlPRsMtI7Jo8TAk=;
        b=U9gcIOA+BJPPcKUx2cJiROlhvWYAiUNyOkoHqMx+80x9BotdlkVhtc0j9krUyZ+Zka
         qd2NZ5DdSs6P7rMgUqukJfgwo9hXTv9HcG6IigLuBZ8RI4cLjZLK08KOQwNYkLzBsHyk
         xaoXuECGJ93bbINQQV9IqxK6uue8hIee9RXE+bs3+k4uWQNEQj/FjrS6LaRWuyR42hal
         7DyL5ymeIR1hXaKg6T+WhH/Ej7I3EhZYsQCB9UeUqL7soZlKfdEVGHqLuAziRVC2OJsK
         6iluUv1A1QDflPPEYy6C8Q44hz93iVgN+Kst0z4AV/mYeMzzTweeHUmfipZZSnQGARLh
         2hZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UG5TyJ4mQLwlYDrNM4sIdv6PF17gqlPRsMtI7Jo8TAk=;
        b=WeVB68xEHHMbbBMy8d84KMEVJ//OI9/iZ2X25ubdJIfnpbYTV9ERTbFYB2HCkQo1A8
         /m8hhKewD/4sOfgs/KoKG6FODSxSDApFBl29M0L8dXUtCVt7hDgGxlZLvhwwW2Nu126l
         XeYogwVkXwIUqtmIc2W8rrjmPmrR8TdGeMdRbFJataSy/fdil0dubM/bri7r5aaZm0Nv
         EFuz7wx9WC5kWYeUfUf1WJ6hTlYwz0fnF/pX4ZNNnUUzL8+7Zx/nhNmSFp8VoYv5+FH1
         YAwCWGyogTwUwA5vsqzLJvMHHwhzWb2LpBYTANVgsEkMROIzhjqK6CWU3hAu4HNcYBFN
         Eglw==
X-Gm-Message-State: ABuFfoh6UaZUtcMdeOWBrj44kANJ8xmEFhym4p26NSj/XjpG9MgPPS1Q
        /sxggFLOcu26KAO9QDJf3XIrEQ==
X-Google-Smtp-Source: ACcGV615r46l7cfrPXWMzgsZk6WYJifaV4XDqBZcOPpf5uduyRgcSl+9QppxAeQLZbLQB/GEa2w5Dw==
X-Received: by 2002:a63:501:: with SMTP id 1-v6mr24842199pgf.205.1539083743373;
        Tue, 09 Oct 2018 04:15:43 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:15:42 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhoujie Wu <zjwu@marvell.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 44/45] lightnvm: pblk: consider max hw sectors supported for max_write_pgs
Date:   Tue,  9 Oct 2018 13:12:14 +0200
Message-Id: <20181009111215.7653-45-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhoujie Wu <zjwu@marvell.com>

When do GC, the number of read/write sectors are determined
by max_write_pgs(see gc_rq preparation in pblk_gc_line_prepare_ws).

Due to max_write_pgs doesn't consider max hw sectors
supported by nvme controller(128K), which leads to GC
tries to read 64 * 4K in one command, and see below error
caused by pblk_bio_map_addr in function pblk_submit_read_gc.

[ 2923.005376] pblk: could not add page to bio
[ 2923.005377] pblk: could not allocate GC bio (18446744073709551604)

Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index e3573880dbda..e5239aba806b 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -407,6 +407,8 @@ static int pblk_core_init(struct pblk *pblk)
 	pblk->min_write_pgs = geo->ws_opt;
 	max_write_ppas = pblk->min_write_pgs * geo->all_luns;
 	pblk->max_write_pgs = min_t(int, max_write_ppas, NVM_MAX_VLBA);
+	pblk->max_write_pgs = min_t(int, pblk->max_write_pgs,
+		queue_max_hw_sectors(dev->q) / (geo->csecs >> SECTOR_SHIFT));
 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
 
 	pblk->pad_dist = kcalloc(pblk->min_write_pgs - 1, sizeof(atomic64_t),
-- 
2.17.1

