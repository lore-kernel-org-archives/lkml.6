Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662BCC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0C02075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="A/KTUzaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0C02075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeJIScB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:32:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45019 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeJIScA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:32:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so641515pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=scqHsI3HlhjRne5zqhqQcdC0bvrSN31aH4jvWzbjnHs=;
        b=A/KTUzajkUFoYYKFrg1YawGzpQCPE3174xtLwhMe/CMAgnvsGwFpV8m5jTtG+MmQFG
         BAnyLvbq5FCuKNfqFgkFY/dUGAD+KtgMwY5diduwONK9nSkFgjBlFtxs70Egre3HYajg
         Q3w5x5WxQ1Xh+zKLPM+PQNreUhYPQjHlvmRjaDvINrKpBEi8ZtCX6RG6NW5ZzCJsjl8t
         MivqkAmopb8PpCDJtz1O/DHyT/WoUxwF3uZOtj92nKTe2GOFwc5Y+5MNo/O++hUIkPLo
         uNz9L39cf10otGg5Q+7N4Vk9lUoNPxCXlzFESDEHgfK7twJZWEg5FP/Ex311oDEAMdke
         B2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=scqHsI3HlhjRne5zqhqQcdC0bvrSN31aH4jvWzbjnHs=;
        b=Wv97utJqdmKLFclZaJ8QM3Teqz99BZyDb6mhn7jx7oCXsPa+DVi2QeUh1DZr+v8W5l
         4vPXQCsKKVTsTLJJqytkc1IjlqYO1qdTAxf4CF8OY2vu0Clahe3NjXIta+lDPVDGcpJ3
         7Qj7sdTx4FC92zIOetbylGNXYztlRT/CCvlaDIv8CwTRYr/zhVXOZ/Yh9uLpgv2YkSrG
         C0Gcjfl+BPT/p5iThBiz1IF46teb0j0PdxMT2+EHset95QKyFNR4rrQXHAJZGuWw71BS
         hrFgEkAX8b0LtXo6/XIbC9XKp7diYwQzAPsyab8XKh80abw0v9ySdSSwnkJVCM4YmhOP
         MILg==
X-Gm-Message-State: ABuFfohZFESLxpUebgx6tu1e9OLD90XO/Le450A9veS/8e4bsJYA1+S9
        9fjZt6a/vnJll4RKE2EvQP5ojkwn67Lm6g==
X-Google-Smtp-Source: ACcGV613HIo9cyNGOvkPkx9nqescbZcXBaeAWCB5YFRsDT0lqQS8aer+1XujBd9gwe7mOxJCW94osQ==
X-Received: by 2002:a63:b04f:: with SMTP id z15-v6mr23485255pgo.442.1539083733101;
        Tue, 09 Oct 2018 04:15:33 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:15:31 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 41/45] lightnvm: pblk: guarantee mw_cunits on read buffer
Date:   Tue,  9 Oct 2018 13:12:11 +0200
Message-Id: <20181009111215.7653-42-mb@lightnvm.io>
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

From: Javier González <javier@javigon.com>

OCSSD 2.0 defines the amount of data that the host must buffer per chunk
to guarantee reads through the geometry field mw_cunits. This value is
the base that pblk uses to determine the size of its read buffer.
Currently, this size is set to be the closes power-of-2 to mw_cunits
times the number of parallel units available to the pblk instance for
each open line (currently one). When an entry (4KB) is put in the
buffer, the L2P table points to it. As the buffer wraps up, the L2P is
updated to point to addresses on the device, thus guaranteeing mw_cunits
at a chunk level.

However, given that pblk cannot write to the device under ws_min
(normally ws_opt), there might be a window in which the buffer starts
wrapping up and updating L2P entries before the mw_cunits value in a
chunk has been surpassed.

In order not to violate the mw_cunits constrain in this case, account
for ws_opt on the read buffer creation.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index b2c49fc006c9..e0db0cb3122d 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -195,7 +195,8 @@ static int pblk_rwb_init(struct pblk *pblk)
 	unsigned long buffer_size;
 	int pgs_in_buffer;
 
-	pgs_in_buffer = max(geo->mw_cunits, geo->ws_opt) * geo->all_luns;
+	pgs_in_buffer = (max(geo->mw_cunits, geo->ws_opt) + geo->ws_opt)
+								* geo->all_luns;
 
 	if (write_buffer_size && (write_buffer_size > pgs_in_buffer))
 		buffer_size = write_buffer_size;
-- 
2.17.1

