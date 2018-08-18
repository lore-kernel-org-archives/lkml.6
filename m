Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8B9C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DEE208DA
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Ubd1Wxfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DEE208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeHRQc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:32:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45618 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeHRQc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:32:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id s16-v6so5972435edq.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 06:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=viWNe3TzEQhqJk5ASZThGtH1epiz2Jr0E6XW1xgqJ1E=;
        b=Ubd1Wxfn/t83uXAwrSk3edjWwuxwYXUxXQ35mI0p0elMUodrtwoBBN7Ufof+i2mhRZ
         loLlOjhKiG/bKM4DqbhzBCrkmE45BgEhgTJD461AsmeDFUsOH1Zu/ZMgfwdlIZ20Cv0i
         y30In/uTeo7fR1VTdwwjwS66D1TXI+UO/d0mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=viWNe3TzEQhqJk5ASZThGtH1epiz2Jr0E6XW1xgqJ1E=;
        b=QzA8EAtf7cSr8cS+aYU+1WcyC/HS+k8XacGQ5pnfsEuil0avv3MJ3AemLyeEnMyhAk
         8D0ZLUivnSl0SKvWq+w9Ym34dhkSKZ97yTldK5j5CpZgjJLrDiKeOzKMsAsf/6crUldV
         eqrbfha/dTVy543XFUwkAFa0hz1Jiyg6COOpCwQSRxFhvHZXbHDl+IO4FV9JfxwngYjo
         /ME9qF8faxt+PdhKfQx39iiWb5UdK4+s80A0Uch6Cjv75MHmI9z6llnSlLCtEq2oVh3C
         6Wpx1dFOsq3KO2JHsz/7GgHtAY4a2w4zgQTe11oSzE+9TcnBSGNdyTiVAuAVwPTBSQhu
         RzVQ==
X-Gm-Message-State: AOUpUlH6CNZbxbxc/9a/AdO+7RNsrwv07srKliNHa+MffO0JJ+WLmses
        9xkWUCrP2lBZBHFRR06FMyY4fMAztxtZXg==
X-Google-Smtp-Source: AA+uWPz5qxBKZyaYD6PX6u+TTVwLruGHkOkAsYV+xrLqTdzaiCl7D53LtbJlcwACWCfsi4SW7pCS6g==
X-Received: by 2002:a50:de8e:: with SMTP id c14-v6mr46269874edl.196.1534598685509;
        Sat, 18 Aug 2018 06:24:45 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-212.cgn.ip.fibianet.dk. [5.186.114.212])
        by smtp.gmail.com with ESMTPSA id a11-v6sm2739032edn.95.2018.08.18.06.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 06:24:45 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/8] seq_file: use seq_open_data in __seq_open_private
Date:   Sat, 18 Aug 2018 15:24:29 +0200
Message-Id: <20180818132434.9515-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180818132434.9515-1-linux@rasmusvillemoes.dk>
References: <20180818132434.9515-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/seq_file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 518a72e444d9..5cc4670294e7 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -632,18 +632,15 @@ void *__seq_open_private(struct file *f, const struct seq_operations *ops,
 {
 	int rc;
 	void *private;
-	struct seq_file *seq;
 
 	private = kzalloc(psize, GFP_KERNEL_ACCOUNT);
 	if (private == NULL)
 		goto out;
 
-	rc = seq_open(f, ops);
+	rc = seq_open_data(f, ops, private);
 	if (rc < 0)
 		goto out_free;
 
-	seq = f->private_data;
-	seq->private = private;
 	return private;
 
 out_free:
-- 
2.16.4

