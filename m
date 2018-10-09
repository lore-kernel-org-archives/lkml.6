Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF94C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AE5214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="LkipdUf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AE5214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeJISbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:31:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36823 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeJISbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:31:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id l81-v6so683227pfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4gU25pj7KCGrk1A426M+00ETc+HESZlocWN9LctXo8U=;
        b=LkipdUf/i8NztQo9WFikm4b5nrXqX1Xgl+sK8rWKgZWCXQYYTJ/Gt6MdoDEcCMqnRm
         GqQiRiyeJR5HAQyPmHr9LxBKVdqv942gNWg7M4d2C2e4YB4h1cPJJw6hhALuZRtbMUNV
         JTqjPgv+sYgtJ/2fZUYnkLjwHydy0oPYy8AGNDaAK0PENzfi2IItc9tu+zzrPchisK17
         OVsSaq2KieYlaU0rgnBfC/BxnHdBAKTcErAfKiRQ3LBJQYuJorn+LQ7CA6RZMbut0ett
         V5lY4+la9Mg4/UEPkFys9OxvGdkedWLi4r2yBEBzG9acR36a352JNDA4fID6ltH9owdg
         Ha/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4gU25pj7KCGrk1A426M+00ETc+HESZlocWN9LctXo8U=;
        b=A6eka1cbFdDAwJulooMnKqSKk0e9ZAxGBECyL827T5OY+rUk92tcHJmli0fEhOI8od
         cek1wbMV8nnPdxg6RN8HNbCP/tu190/uP3kMlDU8Ky8xP84QS/bQLFzkRz15PggYq6L5
         nuvfennZdlrABtFK8Jvt3Wtd2ApjrY0dBPXPRoQZRuv0a6YKDk7YMwV6K+FqYOJYsLQO
         FnHnzXAoh85HLH5Gj/jXxjqVDte9DJuHfSHg9d6kg9J6GdAud5cZv4QpGisDI/QXFY/5
         C8vmh+4M/q4SK317KJYMquwrJebAHokjC+DtWdAPyRWyZoC6BpJk6vIwTb5gsAo35hkY
         2AVg==
X-Gm-Message-State: ABuFfoh90hREtwwzD5x4T0wYJYstHq0tCWYaThs51XPRMlmN8YpjBNP6
        mvW9EalkXjIKXBcr4huVqlLA1Q==
X-Google-Smtp-Source: ACcGV63VFTYuOJ4Q3T5v/m58AZXSetIHAjysrkM6s8ecwpa6XRuP8jnj2CbvzOrNjV3aQsyM2HQlKQ==
X-Received: by 2002:a63:a012:: with SMTP id r18-v6mr25670687pge.282.1539083684593;
        Tue, 09 Oct 2018 04:14:44 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:14:43 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 27/45] lightnvm: pblk: calculate line pad distance in helper
Date:   Tue,  9 Oct 2018 13:11:57 +0200
Message-Id: <20181009111215.7653-28-mb@lightnvm.io>
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

If a line is padded, calculate the pad distance directly on the helper
being used for this purpose.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-recovery.c | 13 ++++++++++---
 drivers/lightnvm/pblk.h          |  8 --------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 0322ab915ddc..8036c3eb6372 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -380,6 +380,15 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 	return ret;
 }
 
+static int pblk_pad_distance(struct pblk *pblk, struct pblk_line *line)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	int distance = geo->mw_cunits * geo->all_luns * geo->ws_opt;
+
+	return (distance > line->left_msecs) ? line->left_msecs : distance;
+}
+
 /* When this function is called, it means that not all upper pages have been
  * written in a page that contains valid data. In order to recover this data, we
  * first find the write pointer on the device, then we pad all necessary
@@ -495,9 +504,7 @@ static int pblk_recov_scan_all_oob(struct pblk *pblk, struct pblk_line *line,
 		line->left_msecs += nr_error_bits;
 		bitmap_clear(line->map_bitmap, line->cur_sec, nr_error_bits);
 
-		pad_secs = pblk_pad_distance(pblk);
-		if (pad_secs > line->left_msecs)
-			pad_secs = line->left_msecs;
+		pad_secs = pblk_pad_distance(pblk, line);
 
 		ret = pblk_recov_pad_oob(pblk, line, pad_secs);
 		if (ret)
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index a2cc581951ef..d123cff82589 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -986,14 +986,6 @@ static inline int pblk_line_vsc(struct pblk_line *line)
 	return le32_to_cpu(*line->vsc);
 }
 
-static inline int pblk_pad_distance(struct pblk *pblk)
-{
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct nvm_geo *geo = &dev->geo;
-
-	return geo->mw_cunits * geo->all_luns * geo->ws_opt;
-}
-
 static inline int pblk_ppa_to_line_id(struct ppa_addr p)
 {
 	return p.a.blk;
-- 
2.17.1

