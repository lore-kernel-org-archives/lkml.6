Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83155C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3202F20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Uj1mic3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3202F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965150AbeFSGWk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:22:40 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45247 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755871AbeFSGWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:22:39 -0400
Received: by mail-pl0-f67.google.com with SMTP id c23-v6so10359646plz.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 23:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j8s0TAuSNsuLdux4SAMv+jRxP4SYWf2yPorJEZb9jx8=;
        b=Uj1mic3zDz6Z2oSd/jGGHWZJimt+WErG8U+OYtREgRhXeRWI5P5G2DobsfO5hNIOPa
         AKE83+YAwe13h14UbPiZP1gudq/FI+rsAArftQYx8/yuA2TPL3kVR0v3KpasuCIC1h+j
         6MK81J76aDM9HlgVkcpAC5LAgXzoYU6CAE8VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j8s0TAuSNsuLdux4SAMv+jRxP4SYWf2yPorJEZb9jx8=;
        b=Poh/E4hwTgNr4geK2OUGd7N4vqbbTHNKttQJTX6Lze8e/9/zS93L2ND99dffhNgIua
         /9uF4dkqKTFY7xaZp1jmYwzv1qC5+GPHuoq12ZBhp11m5GMfco2YzFHGxeMR52jWazQb
         7gsuIEEc8eeilm4yj1SAL5qCQBfjTDfiWizP3wOU3CLyhYG37LdCaicBbQYy/IZLDthe
         0YVXPVPUfhpCieM8+zeezsR6lLbscC41SXLLHY1cxu9R0x5v7LmyncSVfectXACq/jGh
         aIrNGO7eKpS2rUfbTsojaudxRbKhPupC8h1V1qJeax0iNGnwptc0RRHJqzGMGbN3nicg
         hbxA==
X-Gm-Message-State: APt69E2W28WdXvhhQyf8lp1FW19vlS4ZsG2Rp7WEBUkrq+fqci7cel/U
        QzAVeU9GYjrFe2WmeeMnoUAdBiB9BQQ=
X-Google-Smtp-Source: ADUXVKKlmeq15x5FeRYwmUAgpkbcJBKb0ygat9Yu/Hs2E4nLgJIS+crLGEYIy8UATB/Fwown5Ybq4w==
X-Received: by 2002:a17:902:9b92:: with SMTP id y18-v6mr17050963plp.57.1529389358520;
        Mon, 18 Jun 2018 23:22:38 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id z19-v6sm19564858pgv.12.2018.06.18.23.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 23:22:38 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>
Subject: [PATCH 2/2] rcutorture: Fix rcu_barrier successes counter
Date:   Mon, 18 Jun 2018 23:22:15 -0700
Message-Id: <20180619062215.221564-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180619062215.221564-1-joel@joelfernandes.org>
References: <20180619062215.221564-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

rcutorture currently increments both successes and error counters for
the rcu_barrier test incase of errors. It should only increment the
error counter incase of errors so make it do so.

Test: Introduced rcu_barrier errors by returning from the barrier
callback without incrementing the callback counter.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index f2cde4dd432d..3faaabc99b60 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1722,8 +1722,9 @@ static int rcu_torture_barrier(void *arg)
 			       atomic_read(&barrier_cbs_invoked),
 			       n_barrier_cbs);
 			WARN_ON_ONCE(1);
+		} else {
+			n_barrier_successes++;
 		}
-		n_barrier_successes++;
 		schedule_timeout_interruptible(HZ / 10);
 	} while (!torture_must_stop());
 	torture_kthread_stopping("rcu_torture_barrier");
-- 
2.18.0.rc1.244.gcf134e6275-goog

