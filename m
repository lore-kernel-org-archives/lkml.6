Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482F0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 21:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2072621A4A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 21:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbfBPVBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 16:01:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33453 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbfBPVBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 16:01:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id i20so22408298otl.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 13:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0z+KTgeRvwZujLg3EVuY+zT8/OrsZ24eesGtYh1xIWE=;
        b=qO/OymcQ66aIET7uWb/AQZ40UylzosSdRdidk5BY96jKQfJS5pjw5GHeVy2WZ8/YFP
         vSlvOhOP0/Db2RuXVP5nS8oXOPNtY0vI6EntAc+mtpzk5KF9LTrNDuPtAkZcWu67YYXf
         9dNkHqVP8CERMLy8yG/WSqkFW5/pMYk1Nl5anX4bKFiWunGv6w/JXS41q8q5/hfNYv/v
         hclJI2tll04LPcmgB7DapHdsq/KTuzH0DDT2zbeUS4YgAsMX2UmaXweqXIFo57HLYSKe
         CytmvFpW/+Wa3ygWmem/e56nxfKUDhdOHgVMbow6+kgbErx9EfQ9GaMd++7hDZXebhKL
         ZuCw==
X-Gm-Message-State: AHQUAuYPcuT8C3s0s9/CaOn/HMATjgWoSLd2c/LY5jR8QgwE0chF0/8Z
        91NQaUfWPoc3I6irtsMBLdc=
X-Google-Smtp-Source: AHgI3IbqxTqfm5L5GLL7nh5PhkGypli4A5r4m7HU4XKZsfwJDNd1jng9Ws8Gah85O/9lz6CVj3P8Pg==
X-Received: by 2002:aca:b302:: with SMTP id c2mr9242937oif.144.1550350901884;
        Sat, 16 Feb 2019 13:01:41 -0800 (PST)
Received: from sultan-box.localdomain ([107.193.118.89])
        by smtp.gmail.com with ESMTPSA id 187sm4048138oid.22.2019.02.16.13.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 13:01:41 -0800 (PST)
From:   sultan@kerneltoast.com
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dm crypt: fix memory leak in dm_crypt_integrity_io_alloc() error path
Date:   Sat, 16 Feb 2019 13:00:22 -0800
Message-Id: <20190216210022.29483-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>

dm_crypt_integrity_io_alloc() allocates space for an integrity payload but
doesn't free it in the error path, leaking memory. Add a bio_integrity_free()
invocation upon error to fix the memory leak.

Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 drivers/md/dm-crypt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index dd538e6b2..f731e1fe0 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -939,8 +939,10 @@ static int dm_crypt_integrity_io_alloc(struct dm_crypt_io *io, struct bio *bio)
 
 	ret = bio_integrity_add_page(bio, virt_to_page(io->integrity_metadata),
 				     tag_len, offset_in_page(io->integrity_metadata));
-	if (unlikely(ret != tag_len))
+	if (unlikely(ret != tag_len)) {
+		bio_integrity_free(bio);
 		return -ENOMEM;
+	}
 
 	return 0;
 }
-- 
2.20.1

