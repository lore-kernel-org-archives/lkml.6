Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F79EC43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5FE20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z+Fl4OJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5FE20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732844AbeHABnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 21:43:31 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35588 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732805AbeHABnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 21:43:31 -0400
Received: by mail-pl0-f65.google.com with SMTP id w3-v6so7872296plq.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 17:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MKaP/zsQ/C9AJcu/cT5JowGOCZDXJ5vFUW/yzanzt98=;
        b=Z+Fl4OJyIu5Lo6Ro8lefz+ZYslOsgdonUSjo4vNSp2+l/lQZBMR5Cf17mg/VmIDZzj
         +Sxs5cENDu6kRJWZCEUdunsBn44tRvqDwp1ZxWgA/a7A10+IVp1RcZousOhskiHIiV6M
         lCjY14MveOzEADVABtqstS9QcqYoDZxu5xOWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MKaP/zsQ/C9AJcu/cT5JowGOCZDXJ5vFUW/yzanzt98=;
        b=K/nZMEcLiqbdWtlSZ/HC4+syS5ZAbMaIH6g2Yf5OUzt7KwuqC2Yd7Ccb39ekxiyw0L
         zRR3gzzuOW/5L4zCa65Lz7CGZ0M8aNQB1WCX8Ict6DIldetx+4C/F/D9pnU93VjK4VsZ
         6kMmgX68VD8jzzba86LqHTSclf3IxaLSScj2rQ205L/t2xW4Ic9MyasY1FeVusq1/dcj
         zjOoIHaHXDoVMuvvhkeC1EZ9UrhJZ5RH7yQRoPEd8U4rfcUfOZ5ehgEfQpg2l3eLvg5Y
         HNMTqUdM0gJqG0tuTBFy8J/uxWlojblQMs+AtWOIxJdLhlDTpFeRQmfd6Wox/+9j6s6K
         lTzw==
X-Gm-Message-State: AOUpUlEIhIr42AZhTsPYkEgYOnOk8P3cF4Q1XyKZhGzbKfTPRebCY9Ep
        ak7ksJ/yoJPXGX/ZJkb+Hh+yxQ==
X-Google-Smtp-Source: AAOMgpeG1zF6SNZ3O7jp/5vTsauGTlHQGyKIGmw6e8dg9TmgFDmMO/OBzsKWvt1M4Jtu7uiAFOMlLg==
X-Received: by 2002:a17:902:2ac3:: with SMTP id j61-v6mr9722408plb.172.1533081645475;
        Tue, 31 Jul 2018 17:00:45 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id k79-v6sm16749384pfa.22.2018.07.31.17.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 17:00:44 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@mellanox.com>, stable@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] RDMA/mlx5: Fix shift overflow in mlx5_ib_create_wq
Date:   Tue, 31 Jul 2018 17:00:39 -0700
Message-Id: <20180801000039.44314-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801000039.44314-1-keescook@chromium.org>
References: <20180801000039.44314-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

[   61.182439] UBSAN: Undefined behaviour in drivers/infiniband/hw/mlx5/qp.c:5366:34
[   61.183673] shift exponent 4294967288 is too large for 32-bit type 'unsigned int'
[   61.185530] CPU: 0 PID: 639 Comm: qp Not tainted 4.18.0-rc1-00037-g4aa1d69a9c60-dirty #96
[   61.186981] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-2.fc27 04/01/2014
[   61.188315] Call Trace:
[   61.188661]  dump_stack+0xc7/0x13b
[   61.190427]  ubsan_epilogue+0x9/0x49
[   61.190899]  __ubsan_handle_shift_out_of_bounds+0x1ea/0x22f
[   61.197040]  mlx5_ib_create_wq+0x1c99/0x1d50
[   61.206632]  ib_uverbs_ex_create_wq+0x499/0x820
[   61.213892]  ib_uverbs_write+0x77e/0xae0
[   61.248018]  vfs_write+0x121/0x3b0
[   61.249831]  ksys_write+0xa1/0x120
[   61.254024]  do_syscall_64+0x7c/0x2a0
[   61.256178]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   61.259211] RIP: 0033:0x7f54bab70e99
[   61.262125] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89
[   61.268678] RSP: 002b:00007ffe1541c318 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   61.271076] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f54bab70e99
[   61.273795] RDX: 0000000000000070 RSI: 0000000020000240 RDI: 0000000000000003
[   61.276982] RBP: 00007ffe1541c330 R08: 00000000200078e0 R09: 0000000000000002
[   61.280035] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004005c0
[   61.283279] R13: 00007ffe1541c420 R14: 0000000000000000 R15: 0000000000000000

Cc: <stable@vger.kernel.org> # 4.7
Fixes: 79b20a6c3014 ("IB/mlx5: Add receive Work Queue verbs")
Cc: syzkaller <syzkaller@googlegroups.com>
Reported-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/infiniband/hw/mlx5/qp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index a4f1f638509f..7fc156db643d 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -5365,7 +5365,10 @@ static int set_user_rq_size(struct mlx5_ib_dev *dev,
 
 	rwq->wqe_count = ucmd->rq_wqe_count;
 	rwq->wqe_shift = ucmd->rq_wqe_shift;
-	rwq->buf_size = (rwq->wqe_count << rwq->wqe_shift);
+	if (check_shift_overflow(rwq->wqe_count, rwq->wqe_shift,
+				 &rwq->buf_size))
+		return -EINVAL;
+
 	rwq->log_rq_stride = rwq->wqe_shift;
 	rwq->log_rq_size = ilog2(rwq->wqe_count);
 	return 0;
-- 
2.17.1

