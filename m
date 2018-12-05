Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFA6C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A228F2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REENqno4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A228F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeLEM53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:57:29 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45235 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeLEM52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:57:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so8976474pgc.12;
        Wed, 05 Dec 2018 04:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PC7BrQmEfzWCr8q9sqrXP1JGYWzFjKewPiQemJx1DNk=;
        b=REENqno4/d51mTHYrue3cldbcPkdxNpHFa4zlIxLPRUUF0JqOYUX/KDggzm0HlXt5W
         DpFcKoK4dd9U3kGy9zCDS0HnFHhn6TLd7usWD8iPcioywms8swprXSalxof+hBj3U2bz
         mTVu8U9iQr6Jci5nU1gvFU0gM++wROJsoDbAPInW8A4GHREwxUw3xpJexleDpTH6ifgJ
         L+Wy8K50ovryqyksFLlN1hctjGsKcHBRBv8AVzmVvTQEiLVdyysYiCJm4P4Y+Yht3/Av
         We2B+RPLv0W5hkmXgCX3zF3wJEIwtW0cTdqbEZouP2eplC+W/B5tpPTtXvJH6Y9TIMr5
         y4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PC7BrQmEfzWCr8q9sqrXP1JGYWzFjKewPiQemJx1DNk=;
        b=LBt26rJ/zIua9bPappHFz3/PmDkg6a3WD5BRrgqfLWl2KQ15X8LR2pCjU9WEhbdbVp
         qa2Axstd8512ksiYGprJjIdaPV+bsC2gai2ubQM8QzelRs4gn8frqcBdxILloHl1Rhr1
         Ruv/fx/gwrKhrrd3Lx1PwwXpd6SJlYmhld7rZS9hxRErnKiuCqnNJt1mCxUOtzkNi4Hx
         ZLLIRecMt9eruYziS7ktG1Bd6p7VOoV6bpwYziGj+Ze5yUQtMQyHhemRkw/O0x9olWVm
         KEafdnzeG/jbecPJ2ICL+MIFrjf05Q7Ccg70XgZbWRMftan7zruZl0qaonDjLD3pS1q2
         crRg==
X-Gm-Message-State: AA+aEWZ6zWTjKJVxMLGJN8qfXVA+2jIdu2WObj+1gga2gfWM77hIVzbj
        KWiQeX3yyHJnoUi40Hb0rFo=
X-Google-Smtp-Source: AFSGD/VuQl72miiohZ3XiptcGveTLzp+ZOHFK00nEaLkb1XXXUVveUhCqFO8/rECSGblzCr9F19M5w==
X-Received: by 2002:a62:4156:: with SMTP id o83mr24133244pfa.72.1544014647578;
        Wed, 05 Dec 2018 04:57:27 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id q1sm26348898pfb.96.2018.12.05.04.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 04:57:26 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net, adobriyan@gmail.com, akpm@linux-foundation.org
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 3/5] procfs: fix double drop_sysctl_table()
Date:   Wed,  5 Dec 2018 20:56:28 +0800
Message-Id: <1544014590-14429-3-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544014590-14429-1-git-send-email-laoar.shao@gmail.com>
References: <1544014590-14429-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the callers will execute drop_sysctl_table() whatever the callee
insert_header() successes or fails.
So we can't execute drop_sysctl_table() in insert_header().

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/proc/proc_sysctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 89921a0..9aeb750 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -241,7 +241,6 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 	if (header->ctl_table == sysctl_mount_point)
 		clear_empty_dir(dir);
 	header->parent = NULL;
-	drop_sysctl_table(&dir->header);
 	return err;
 }
 
-- 
1.8.3.1

