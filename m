Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAADC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A9D25C99
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MNSUkjrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A9D25C99
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755649AbeFYPWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:22:08 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:38845 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755601AbeFYPWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:22:06 -0400
Received: by mail-qt0-f201.google.com with SMTP id v14-v6so10552736qto.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=O1Fezu9CqPlSNth+F+Z5QgItPWD//dFu45UefS0Ip0U=;
        b=MNSUkjrKTvoBT9WvJC+sAVKgRhNVF0W49Oe3CFl8nygMV4knSd9Qwhaye2ypG9m+7Z
         VfIqQAlF5eDch+dbxVjThkRaWLISsUEn45YXBq4C7evXchCN4yvVYBjbSjeeYep68i0Y
         UN8NyKB3a8cLBaHFAgLMVTQCkuIDE9lFdBIZR5K0/ylyHcZybicJv+duApBH3IGylYBl
         3Qv1bHqA9d2I8dYLLeXkrmcHZQSwTkOUecAFCd3CHm5TPWjmsrrsixJNr1AqexBflRVW
         k/jxPYnIG2r9cbCznZ4eiDXAxdJKzOLU32auxaiYamVVb5Yu/Uq3LHGUHnAVPKfkyHtv
         o6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=O1Fezu9CqPlSNth+F+Z5QgItPWD//dFu45UefS0Ip0U=;
        b=II9pc73fQgzeoLQfdmCA0XZHhHj8GWonwlUQcy8wa6jJqQYhjgnGzUEoLNRvgFNp0R
         8JwFESjW+tvmg1PTQ/sIeMEKjaDZnCAb8dSbj5Qkoe8SmvkcSZSuVveQQm8MRo8MT3IR
         DUX1bgMtvYKmNmKdNYqYbceHUIjvSQYKw6ZLrEflsj5yO6B/RPMm8betA8KlVW4fdn9o
         bknfV05B7WfWORZYzmb6IyAPbu26W0xjGIrd0dM6Bxi/huGOylQ69M2JrcOS1YCqWMr4
         fu/AD8OeouGJZfAKGhvwhRNmsLw1pqGNVWXLtd3XMJLVp7S5piaZBfxvO3A8lufd99W/
         fSGA==
X-Gm-Message-State: APt69E1l9cA0xE/ZhQa1xqVTfjvCKlSdZ+JRF4GYS+YalkpOAf3aVWID
        aNWtlPti2bh+eu9a5cHnGQsPtoei0A==
X-Google-Smtp-Source: AAOMgpf1YV5qYdTbrCw5ldOjL6YU2RorW1PseeXs95UxNzAiVzUi3ymq97GBBUdUWMLhBXAdHFgK5xvjyQ==
MIME-Version: 1.0
X-Received: by 2002:a0c:e5d1:: with SMTP id u17-v6mr7286521qvm.0.1529940125595;
 Mon, 25 Jun 2018 08:22:05 -0700 (PDT)
Date:   Mon, 25 Jun 2018 17:22:00 +0200
Message-Id: <20180625152200.200145-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH net] netfilter: nf_log: don't hold nf_log_mutex during user access
From:   Jann Horn <jannh@google.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        jannh@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old code would indefinitely block other users of nf_log_mutex if
a userspace access in proc_dostring() blocked e.g. due to a userfaultfd
region. Fix it by moving proc_dostring() out of the locked region.

This is a followup to commit 266d07cb1c9a ("netfilter: nf_log: fix
sleeping function called from invalid context"), which changed this code
from using rcu_read_lock() to taking nf_log_mutex.

Fixes: 266d07cb1c9a ("netfilter: nf_log: fix sleeping function calle[...]")
Signed-off-by: Jann Horn <jannh@google.com>
---
 net/netfilter/nf_log.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index 426457047578..95b92954b896 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -442,14 +442,17 @@ static int nf_log_proc_dostring(struct ctl_table *table, int write,
 		rcu_assign_pointer(net->nf.nf_loggers[tindex], logger);
 		mutex_unlock(&nf_log_mutex);
 	} else {
+		struct ctl_table tmp = *table;
+
+		tmp.data = buf;
 		mutex_lock(&nf_log_mutex);
 		logger = nft_log_dereference(net->nf.nf_loggers[tindex]);
 		if (!logger)
-			table->data = "NONE";
+			strlcpy(buf, "NONE", sizeof(buf));
 		else
-			table->data = logger->name;
-		r = proc_dostring(table, write, buffer, lenp, ppos);
+			strlcpy(buf, logger->name, sizeof(buf));
 		mutex_unlock(&nf_log_mutex);
+		r = proc_dostring(&tmp, write, buffer, lenp, ppos);
 	}
 
 	return r;
-- 
2.18.0.rc2.346.g013aa6912e-goog

