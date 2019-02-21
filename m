Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E46C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8352086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="uye2tYOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfBUFuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:50:16 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39366 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfBUFuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 00:50:07 -0500
Received: by mail-qt1-f194.google.com with SMTP id o6so30221032qtk.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 21:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ugol0rgDCJ10tdYejpAP4lSNDuzdaHwVbfjsfuyPKr4=;
        b=uye2tYOOC0bZ39eWdPJnH1bptH+S4Cs9o0M6xgMzLkhahm4hMVUOBbQkW51Ti19KMR
         oerpGE8JpjWjD4HGM4SeomN1VM20+2cy3mnkc8I/+NV3bEp6ey8gbknhjyzULWebul0a
         6udN8DWGUjVYkGNzqLEre31/UHMSHjLYlYWYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ugol0rgDCJ10tdYejpAP4lSNDuzdaHwVbfjsfuyPKr4=;
        b=SfMmbi5ZW0iN02R+VC9TVnVbYubIrWXHqQxu2kfBKFwyrJETnSmxbW+wt13FZrqxqq
         zc3zr8Zx56y7SwUaITHT6HNuY9wt/ct6GxIGNU++LjRjBF3prGgT+C4IWsej/fqSDmEG
         Q+by50fHdzEVZFGH5yqk80NVl3LYBLi2ZcujOdvtZ37MV+WR892f1ua3BRuo2fEkGRba
         tNHNgIxV3lRVmjbLqz4kgWjbMID09ej4uX5k/SqVdW6hPRKW8rBbXVfREIkFodxN+Ah5
         GWGmDMKN36SYpaqkA3ZuOVkXXhePArMEBMthUJQZHigVEQOZaZ/K21tUk7q/jT7rvEfo
         sA5Q==
X-Gm-Message-State: AHQUAuYykPhkNLZCq+5wrwo5RHlR8tUTO4e+4s4eaMFriqeD7mIdEaVB
        GDc55pBa6LFQzUIIUmEHm3ZsAg9fLf4=
X-Google-Smtp-Source: AHgI3IY1x2CsKnOyckwybfdh/IC8vE4HGJ48wjA9vpW4LbhlPy2SxC91fb7T2aBEZJUZvnNh7C0Y8A==
X-Received: by 2002:a0c:b60d:: with SMTP id f13mr4809691qve.209.1550728205769;
        Wed, 20 Feb 2019 21:50:05 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id k185sm11561219qkd.62.2019.02.20.21.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 21:50:04 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        Ingo Molnar <mingo@redhat.com>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: [PATCH RFC 5/5] rcuwait: Replace rcu_assign_pointer() with WRITE_ONCE
Date:   Thu, 21 Feb 2019 00:49:42 -0500
Message-Id: <20190221054942.132388-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190221054942.132388-1-joel@joelfernandes.org>
References: <20190221054942.132388-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This suppresses a sparse error generated due to the recently added
rcu_assign_pointer sparse check below. It seems WRITE_ONCE should be
sufficient here.

>> kernel//locking/percpu-rwsem.c:162:9: sparse: error: incompatible
types in comparison expression (different address spaces)

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcuwait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 90bfa3279a01..9e5b4760e6c2 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -44,7 +44,7 @@ extern void rcuwait_wake_up(struct rcuwait *w);
 	 */                                                             \
 	WARN_ON(current->exit_state);                                   \
 									\
-	rcu_assign_pointer((w)->task, current);				\
+	WRITE_ONCE((w)->task, current);					\
 	for (;;) {							\
 		/*							\
 		 * Implicit barrier (A) pairs with (B) in		\
-- 
2.21.0.rc0.258.g878e2cd30e-goog

