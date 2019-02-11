Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479CAC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135342075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="1bj/j4qv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfBKMZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:25:22 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38574 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfBKMZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:25:19 -0500
Received: by mail-lf1-f67.google.com with SMTP id n15so3452799lfe.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KPfj6O2aC060Aqi37cieoJdRqiRZa7RZ5+dNEdZ/P94=;
        b=1bj/j4qvjt92z2YEKndx3N/g6jFbxGaZJ7pCGJf/pl0Ul3ogiiUjttyADP2GErlMuY
         brvWbrLgR1YlLiScjSGyHuUa6XKrg1q+cQKIowPryuYh1Qn6wv9AZdk68yRUTYQGaPTc
         2y0F/oaEh5cclchgFjrrd421BIIgHUp7W8BaNF7MSklfLWlgs7zW3G7mYctncr4jUKJq
         Kbm8yRQdrwQEIHrNSy9srlRyBbJLqm5UzIySHHDc0gVC5Cy6iFK/abEvXRwLmXOsMjxH
         IMHygEwX8IRSIge6RttFv1io1HFodXqLYM1D3n31Vf4jLv/Fugf7KeAXOn5b1ExjN6cb
         GQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KPfj6O2aC060Aqi37cieoJdRqiRZa7RZ5+dNEdZ/P94=;
        b=DcH4tpWa8HyLrwzk3FzOY5Im/0xOLL1z81eDdAmvMUbTbLdworp4/sLx7dALGRBl8g
         K1Ic83nqdb5XIk2I4fLzCF9TlesTOAkuD89B86ggabLa4sMgHi7wie/nygXDfiG7xI6J
         efSQTPop7xE1BW5Li3WPCN6NISLdMkyLy3RKfx4SyHm4Y3Ul0HvCSbPOClNNJKPmFAWd
         RCoZDE+QRy4CViBTcdWc0Som/8rgAambDPTjqaCmrgw8AOX8YqPic3eQHEkeG2yQIJRc
         kca44IXiEXq9wPBQQo19m0H/UKOfksFRenp+BnhPTc34o0CabxrnjUAF7JyxxSSPJDQg
         2/UA==
X-Gm-Message-State: AHQUAuaK4g/gFMg8lD1w5gbFA2VQ/p8pBBeFGyRzZO1jqcajChpyiBgk
        X2nlVf+Zw4fMjt7fdlqelMcg9A==
X-Google-Smtp-Source: AHgI3Ib6zsrnmy/UsnGMsHx8SinEpiwhMUQqjeMu5ETC9jQVXPbXZgTd+5HeQPgwocZuinsuhxpbMg==
X-Received: by 2002:ac2:4343:: with SMTP id o3mr19806315lfl.129.1549887917145;
        Mon, 11 Feb 2019 04:25:17 -0800 (PST)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id d70sm2278481lfe.14.2019.02.11.04.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:25:16 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 1/8] lightnvm: pblk: stop taking the free lock in in pblk_lines_free
Date:   Mon, 11 Feb 2019 13:25:02 +0100
Message-Id: <20190211122509.19910-2-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190211122509.19910-1-mb@lightnvm.io>
References: <20190211122509.19910-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

pblk_line_meta_free might sleep (it can end up calling vfree, depending
on how we allocate lba lists), and this can lead to a BUG()
if we wake up on a different cpu and release the lock.

As there is no point of grabbing the free lock when pblk has shut down,
remove the lock.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index f9a3e47b6a93..eb0135c77805 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -584,14 +584,12 @@ static void pblk_lines_free(struct pblk *pblk)
 	struct pblk_line *line;
 	int i;
 
-	spin_lock(&l_mg->free_lock);
 	for (i = 0; i < l_mg->nr_lines; i++) {
 		line = &pblk->lines[i];
 
 		pblk_line_free(line);
 		pblk_line_meta_free(l_mg, line);
 	}
-	spin_unlock(&l_mg->free_lock);
 
 	pblk_line_mg_free(pblk);
 
-- 
2.19.1

