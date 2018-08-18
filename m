Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE934C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7863E208D4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="KMM1Qe5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7863E208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeHRQcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:32:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34943 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbeHRQca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:32:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id e6-v6so5973241edr.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zk17HYVnUW58q1BR+6HYl6kqaH3L5J58mMwPolfdUbw=;
        b=KMM1Qe5vTRLN7KXhwDFKuGMbnvZcq8zfuoD3P7a00qb5GPO9kRJXvu7ZcumJgECqMi
         FWGHFCBN6hdMO4IE5uO3MzdbCs36Jc0gSe4yOOATvonVl5jIYxwxogOYIvwYajrrk1y3
         VR99P99AWsRR5GUBnNS9IjluXyFZRe8Awbm1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zk17HYVnUW58q1BR+6HYl6kqaH3L5J58mMwPolfdUbw=;
        b=JbtKjh603/OOX9aQWBKmy8LockqDqQiX207oETxwP37pA6hcr/AKX99iNJ7rf2RLcW
         5T/r36hYgKM+gF+rfRPzFQ0uLJnA1zyq009GPXQgSlpVS3SeGPtyz39Hphna3zV4iq2U
         cvDvAyLjqxtwS9pfqKVvnBbHjpFl2AToZ7pmPFV73Ko0NYKIHjBUiL2ykVmYAn/qZrxY
         hE2J74zf4yuzqulkoSYL56dhtDBvBJWvBFiWCvHqLNRE28g4e01B3YcHOOBQ1TVLPZZM
         lHM5sXG8fsdaiWKYNl4BLoHzUwjMnzgnPrV2NHr0XDs3RmS9Kt2p0srE0xkSXZyCtMQI
         47cw==
X-Gm-Message-State: AOUpUlGT+h2g1ZQvQehIpOykWQrcqOIQdYxwWxzIF+E++TWP9dYQ5tX1
        t0GUhjeXZ1akHOqwEMwAXI0KURYs8NO3fQ==
X-Google-Smtp-Source: AA+uWPxhrYDWnSfRi8u/2HjN9SurCTN4ESCd2SzEtbEfGZQw2TQwz8JPqoRglpGUxIzOj3kD8Npxzg==
X-Received: by 2002:a50:c181:: with SMTP id m1-v6mr3842455edf.199.1534598687404;
        Sat, 18 Aug 2018 06:24:47 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-212.cgn.ip.fibianet.dk. [5.186.114.212])
        by smtp.gmail.com with ESMTPSA id a11-v6sm2739032edn.95.2018.08.18.06.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 06:24:46 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-nfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 5/8] nfsd: use seq_open_data() in exports_net_open()
Date:   Sat, 18 Aug 2018 15:24:31 +0200
Message-Id: <20180818132434.9515-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180818132434.9515-1-linux@rasmusvillemoes.dk>
References: <20180818132434.9515-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the seq_open_data() helper, exports_net_open() essentially becomes
a oneliner.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Depends on 1/8 introducing seq_open_data.

fs/nfsd/nfsctl.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index d107b4426f7e..483a849b9ce1 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -135,17 +135,9 @@ static const struct file_operations transaction_ops = {
 
 static int exports_net_open(struct net *net, struct file *file)
 {
-	int err;
-	struct seq_file *seq;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	err = seq_open(file, &nfs_exports_op);
-	if (err)
-		return err;
-
-	seq = file->private_data;
-	seq->private = nn->svc_export_cache;
-	return 0;
+	return seq_open_data(file, &nfs_exports_op, nn->svc_export_cache);
 }
 
 static int exports_proc_open(struct inode *inode, struct file *file)
-- 
2.16.4

