Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCAAC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10A620857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="qj05xz3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfBAE5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 23:57:14 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37030 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfBAE5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 23:57:13 -0500
Received: by mail-qk1-f195.google.com with SMTP id g125so3330510qke.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 20:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZyfqNSgV7sbHHKf6GgHwEJjj9JK6z7ZkNg8CfEE8r3I=;
        b=qj05xz3WgtljNNSNzrUl/+5aWQIJ56oIIBdLbo95C8lC3RoRbf1Dnk3pKF0YWZakDA
         U/gkYIWajbXocX3JIHknN2rYGqm35i1QhIVy2mnOP59QLd/OPPqeM9LKfdNK4xRxKt8l
         X1J4VfVTn5CAdOjcS7mNBXVokP4Cb0Y2eyi8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZyfqNSgV7sbHHKf6GgHwEJjj9JK6z7ZkNg8CfEE8r3I=;
        b=BR8yAF+gYWcfMas1kTm+KMEKUE8Xt0khxQToWHMtOfXkHHQXQFbv+XjgrpEJJHe+jn
         57ZAVTykqpvyeDarrz5bSwFuEmtJr35/cujqNWEqzG07xoUAA39CbJ4Hi64YyW5rAr19
         PU36he73ZSKrxRx5eTuIVvHGQTSLHmfNuzE9yEt4BA1yylnnHVq5HnRByVpV/5uEZndU
         xT4SQAjluYZPoIFERWFJgJYjywN3B9bGnyUx2djQJ3U8D20uec+BrZFB24NKvgNTQyxw
         Hq3ya8oFBhXTXcjzM/7fwzdjKdLwxLDlUFjg6gSaQZv8gSRinNcqfVhX05CgxX3qjWr1
         DKFw==
X-Gm-Message-State: AJcUukfaEtCLM9jOvcLc97HWZP1+NxtWRScu6YXqsRkN0+vDIDiRTmdS
        ixKJe+FGOR/wbslA+lb3tlsKxZDuuVk5wQ==
X-Google-Smtp-Source: ALg8bN6lky0j7eyRR8l1KOMYo4dQ4KTM3ZIwK7hNi4saong4PPJYdTlx4rmfiM+LF+ZalHu/+2Xb/g==
X-Received: by 2002:a37:34f:: with SMTP id 76mr34530117qkd.347.1548997032847;
        Thu, 31 Jan 2019 20:57:12 -0800 (PST)
Received: from localhost (rrcs-108-176-24-99.nyc.biz.rr.com. [108.176.24.99])
        by smtp.gmail.com with ESMTPSA id o8sm3924052qkg.60.2019.01.31.20.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 20:57:12 -0800 (PST)
Date:   Thu, 31 Jan 2019 23:57:11 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm, memcg: Handle cgroup_disable=memory when getting memcg
 protection
Message-ID: <20190201045711.GA18302@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memcg is NULL if we have CONFIG_MEMCG set, but cgroup_disable=memory on
the kernel command line.

Fixes: 8a907cdf0177ab40 ("mm, memcg: proportional memory.{low,min} reclaim")
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/memcontrol.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 290cfbfd60cd..49742489aa56 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -335,6 +335,9 @@ static inline bool mem_cgroup_disabled(void)
 
 static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg)
 {
+	if (mem_cgroup_disabled())
+		return 0;
+
 	return max(READ_ONCE(memcg->memory.emin), READ_ONCE(memcg->memory.elow));
 }
 
-- 
2.20.1

