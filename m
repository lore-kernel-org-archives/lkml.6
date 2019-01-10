Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811F0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51580206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxwXrkMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfAJQBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:01:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38138 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfAJQBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:01:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so5361582plb.5;
        Thu, 10 Jan 2019 08:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=70ftbVxR298Asw2Ow0anQXUxDuy5RknOAgPyr50bVv4=;
        b=cxwXrkMAS7796TWzBDeNEoPt/+UoPXw3g9YtX+hVx5mg430ONcMrlxSmu3+GuB6fU3
         3RVs9CJBTjLknOGxSmjgN6RNw0Ah+ehXQMfrSrD9Ol60kcEnU8N2c1ur5oG3zogH+87K
         +JkRUNEguowAQ8ai3q9YpwyYwUnWFly7ObHyx5SiSi35JL/ttn8+cv60VFmKcBJt0Vbs
         7rqaVB3r6YFP5Q1m9KMBdYPCk3ts0DZdUCIjFbzEiUKnWd51kiF6+QuVurRVb9Z0CV2s
         VAqMyrQSLMxOojw4gqm4ataJVibNClcfWc021bGJEJnhdgj22g6uF9My1M/D5z88EEva
         2QuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=70ftbVxR298Asw2Ow0anQXUxDuy5RknOAgPyr50bVv4=;
        b=UEP8Myj5pHEyTGW5Uo0gScBcPud1/ipsTDzKmcWlIcLnPQnZgAhXNUFOVhRH3XORJh
         BqotBemnALbe1pbzVH0jGMhHXgAuH0hpr2+20eJe5QuVVySS5UU6pwdgS7tDDrx1s7Rv
         FIV/rB+YpumSyyRSJrdnyl1844CrqmQnIOILO63dEj4fL3BH3B6mOQWE24OluCEmuGcW
         Q4zY6X5s3E1+zKL6/dZBOS4JBSLC9yj7xfn9Ht9VKFovVa7nv9Hu7zvqR3veskP1l2Ef
         guCDJ1NYFLKK4XyZUFNm30BmlrT9AOkKnKiT89EB47Bv5MEUybk4VxCYgjFyB9S2upPd
         wwMQ==
X-Gm-Message-State: AJcUukeGToUc7MAZj+zky0PzolAs4EYEsuTZvVIc6EQ1+ZB9EUgHTeWg
        X+qjDtCG9WM7h0JppPi0LQE=
X-Google-Smtp-Source: ALg8bN5qK917oxBJhDBueI/R9nNul9+JHcLn37ZqT53or3qlwuuD4azbuIMh3czcfbxrQQ+zABXqyg==
X-Received: by 2002:a17:902:f01:: with SMTP id 1mr10525718ply.143.1547136080016;
        Thu, 10 Jan 2019 08:01:20 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([42.110.130.38])
        by smtp.gmail.com with ESMTPSA id v72sm60178382pfd.163.2019.01.10.08.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 08:01:19 -0800 (PST)
Date:   Thu, 10 Jan 2019 21:31:14 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, Ariel.Elior@cavium.com, davem@davemloft.net,
        mst@redhat.com, jasowang@redhat.com, john.fastabend@gmail.com,
        parri.andrea@gmail.com, dhowells@redhat.com, ebiederm@xmission.com,
        james.morris@microsoft.com, paul@paul-moore.com,
        zohar@linux.vnet.ibm.com, mjg59@google.com,
        viro@zeniv.linux.org.uk, richard_c_haines@btinternet.com,
        sargun@sargun.me
Cc:     jrdr.linux@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: [PATCH] include/linux: Remove duplicate header
Message-ID: <20190110160114.GA5641@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate headers which are included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 include/linux/perf_event.h | 1 -
 include/linux/ptr_ring.h   | 1 -
 include/linux/qed/qed_if.h | 1 -
 include/linux/security.h   | 1 -
 4 files changed, 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 53c500f0ca79..8d7a2b65514b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -53,7 +53,6 @@ struct perf_guest_info_callbacks {
 #include <linux/atomic.h>
 #include <linux/sysfs.h>
 #include <linux/perf_regs.h>
-#include <linux/workqueue.h>
 #include <linux/cgroup.h>
 #include <asm/local.h>
 
diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 6894976b54e3..627b7aa067e0 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -26,7 +26,6 @@
 #include <linux/cache.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
-#include <linux/cache.h>
 #include <linux/slab.h>
 #include <asm/errno.h>
 #endif
diff --git a/include/linux/qed/qed_if.h b/include/linux/qed/qed_if.h
index a47321a0d572..9ebdb60f605a 100644
--- a/include/linux/qed/qed_if.h
+++ b/include/linux/qed/qed_if.h
@@ -38,7 +38,6 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/skbuff.h>
-#include <linux/types.h>
 #include <asm/byteorder.h>
 #include <linux/io.h>
 #include <linux/compiler.h>
diff --git a/include/linux/security.h b/include/linux/security.h
index ac0ef467d25e..2915ea6a5b77 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -30,7 +30,6 @@
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/fs.h>
 
 struct linux_binprm;
 struct cred;
-- 
2.17.1

