Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AB2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B091208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWpggvOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B091208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeH1DEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:04:30 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:43278 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeH1DE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:04:28 -0400
Received: by mail-ed1-f53.google.com with SMTP id z27-v6so432832edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B6S1YfaalLQeOoG1AXl7LMHN6ZItLjkjAXpv/5xk+0A=;
        b=bWpggvOo2b3yJbU+IGn980gmzktuyLs2yvC3yFeJxVbmfDDsFbvN9XFBC2lCSAoCct
         Dofv0nlucHgBXhIr/DEXAAbjZad+JmJvB95F/DPs0hLTtxF7k6YqYxqO8NFllHzpHWBb
         UbA5PlDEG+PkER7BJUynImU9luiUv0be/MFIyknjMbYlsFEsPCq9NRTaNVnhoWCXRHIM
         INJv+95kUWHVzIbbmW8JW88IjEK4t3A8OtDA5ErwvRnET0++y+DkaEkKX5p749HgETJ4
         dpsUc6h5+wEgMLpCzfxjzzn/p/vMCAWFGc3l2fySvi7ShJnTXf6BHE9DEQ2e0rbOPsw3
         31oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B6S1YfaalLQeOoG1AXl7LMHN6ZItLjkjAXpv/5xk+0A=;
        b=Kmhk5k+3g9Tejp9lWipsHh29PVkuWGenXLYm0v+B4tjdXFKYP++TdOn8enP3G6xpXN
         P6FijxDtpRe+WRgXMyz+aitLgQPy7ujZz+LAv9D7UomEtBSXYb0C9l50ZValIu3cvgHf
         eYC2B7rW54BydhDfWyKSGaOwCwlTSmLv0lvAXrILTatejjAic9yefYwXtF+F8s0ajbQT
         sPSn3FVSnK7FiYBlrzdtJP1TYmuC6xM4oyxjkQArYX1q1QDeqKWgzEEEe2S/fuNJX4Bs
         Eu32iLLKXww3c+LkGgGYza87tFE1IWk+70Gl8uUjCTL5ww4oxbghU7Pp0HMjO3kPJas8
         73tA==
X-Gm-Message-State: APzg51BYTqNSubgCuNw4Js0aayaRY3a6Ye+S2QHL40pP3KFH7HuwhRyr
        z9G4hOGfg4XhbEf8Lj8yGw==
X-Google-Smtp-Source: ANB0VdZ7qWab30LpRaS9Rm7AxZCkl+dozyN5O+mi9n8B1rnw7jnFfL3MxkU74nS3ULKvucs8K7Xp5A==
X-Received: by 2002:a50:8e09:: with SMTP id 9-v6mr18544251edw.101.1535411741810;
        Mon, 27 Aug 2018 16:15:41 -0700 (PDT)
Received: from localhost.localdomain (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id u3-v6sm173918edo.44.2018.08.27.16.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 16:15:41 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 11/13] proc: readdir /proc/*/task
Date:   Tue, 28 Aug 2018 02:15:01 +0300
Message-Id: <20180827231503.26899-11-adobriyan@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827231503.26899-1-adobriyan@gmail.com>
References: <20180827231503.26899-1-adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 fs/proc/base.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 33f444721965..668e465c86b3 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3549,11 +3549,11 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
 	for (task = first_tid(proc_pid(inode), tid, ctx->pos - 2, ns);
 	     task;
 	     task = next_tid(task), ctx->pos++) {
-		char name[10 + 1];
-		unsigned int len;
+		char name[10], *p = name + sizeof(name);
+
 		tid = task_pid_nr_ns(task, ns);
-		len = snprintf(name, sizeof(name), "%u", tid);
-		if (!proc_fill_cache(file, ctx, name, len,
+		p = _print_integer_u32(p, tid);
+		if (!proc_fill_cache(file, ctx, p, name + sizeof(name) - p,
 				proc_task_instantiate, task, NULL)) {
 			/* returning this tgid failed, save it as the first
 			 * pid for the next readir call */
-- 
2.16.4

