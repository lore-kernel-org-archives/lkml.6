Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47429C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 23:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CE421522
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 23:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vTv36d/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CE421522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbeIWFg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 01:36:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37631 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeIWFg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 01:36:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id q1-v6so2045007plr.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 16:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r0fzSEurK9u6mTyvxIb4LtJ6W8I9yFfacIDnT2Xs+n8=;
        b=vTv36d/RzWjkVrpzgElIrekqekd/fJPW4KYnTH28l8nll7erCLIsuc7Exc6rupIC2l
         R09/BkX8Xwkiv0csNf/lX2fxCW0qaqWArMJPXoQ1rnlaehBQ+oFuj64MVdH6XFwWZPx+
         eqYzeoPUw6oF6v5N2Uz4H2R4WZTyn3tTaZ/HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r0fzSEurK9u6mTyvxIb4LtJ6W8I9yFfacIDnT2Xs+n8=;
        b=mrF1EUj/bgw9MLirVVbySpVYpz5MEhWN1Q+rVp0NUqErtwvdT9GL69EwOXkOUJyvsE
         dgfIxdGZXrrnAL1Ahv2MQYeeoFHKaFDZ78IBbkcdegDcB+2gwTuvW3sfLoa8A/K/t7WX
         4jYNL8LrEDDZkNKzLQa7GBFD68TZV+flWN6YxJjLvjlnShCjCH0tUMM4tDC6fjWUpMZ8
         c4MTAwOrhkXevJd88GhKvr2/6Sef+k1bqFf3Q5b6JPE+TCuyDdJXjjXnKLZ1YWtgtSAh
         z+fShRaim5/HrOAV/NhwWPJ02zB4aDtNovtRUs5PqYKXU9+lZXUsHRvT5oPDRnf6dLA2
         v7rg==
X-Gm-Message-State: ABuFfojjt9i3biUqYih0f3vQyaCqr9Tkn+JDFd8ozodM4NSUlroPrg6y
        MhTNFbDPTChmN7xiwGqEAvunXDenkW0=
X-Google-Smtp-Source: ACcGV61c0pLNFQI6NkxF0XXx0ET7K9rmiXtZexUNLAJOXi2PM9Scp7WI6YpeNYGzd7MDg+0udZ6Dhg==
X-Received: by 2002:a17:902:6f16:: with SMTP id w22-v6mr4238148plk.127.1537659698448;
        Sat, 22 Sep 2018 16:41:38 -0700 (PDT)
Received: from joelaf-glaptop0.roam.corp.google.com (c-98-210-118-128.hsd1.ca.comcast.net. [98.210.118.128])
        by smtp.gmail.com with ESMTPSA id h4-v6sm32377789pgp.13.2018.09.22.16.41.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 16:41:37 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RFC 1/3] rcu: tree: Remove unused externs
Date:   Sat, 22 Sep 2018 19:41:25 -0400
Message-Id: <20180922234127.94970-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These aren't used anymore. Remove them.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 703e19ff532d..57a937ac51c2 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -398,17 +398,6 @@ static const char *tp_rcu_varname __used __tracepoint_string = rcu_name;
 #define RCU_NAME rcu_name
 #endif /* #else #ifdef CONFIG_TRACING */
 
-/*
- * RCU implementation internal declarations:
- */
-extern struct rcu_state rcu_sched_state;
-
-extern struct rcu_state rcu_bh_state;
-
-#ifdef CONFIG_PREEMPT_RCU
-extern struct rcu_state rcu_preempt_state;
-#endif /* #ifdef CONFIG_PREEMPT_RCU */
-
 int rcu_dynticks_snap(struct rcu_data *rdp);
 
 #ifdef CONFIG_RCU_BOOST
-- 
2.19.0.444.g18242da7ef-goog

