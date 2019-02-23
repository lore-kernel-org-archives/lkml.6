Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADEAC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03FA20652
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oR7uWW5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfBWGfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 01:35:11 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39156 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfBWGfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 01:35:00 -0500
Received: by mail-qt1-f196.google.com with SMTP id o6so5120603qtk.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 22:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CqF7P151YJVMLZIvwWfeCbnvQFr03nry4lyp7ZYlhMI=;
        b=oR7uWW5YXfiw9asF+Ad74Itgz6k54aF+dHzzRvIVX3DTAM9N+XTP9dlnFfEdGhDwgq
         D+sBaV98aHp9dtAPdWiy1tr3ygPvTWz/EwwxVuZn7vjZGkZMyTYrbuAVsg2OoUn2s634
         Oay9Xr5t8Npx4mvey2RRgU8Z0tRiRYhaSl8EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CqF7P151YJVMLZIvwWfeCbnvQFr03nry4lyp7ZYlhMI=;
        b=f8wHsJhaE6ZUVa1I1r6lf8WBzaW74rMvhvEZvE7HOFbOWcGWC+3rfeo793O6kw0a6I
         5Jcb3Sk8v104+yfFfvINKWH+1AGaEbMOTcdH+aknv4B7I1535FmBwRFTumEn9LTqohAK
         WsnsbaoLGbtNSyqW7gsbSjloCSJMPAMC4ub07ZEy2oZKeZ9jQPh1+4lzcab8mb8PylHx
         7ATCEZR4b9lpOKxqYCYe5xx25f4IoJwz8kUuSpTy98lDi6GoTs7dXYrQDmkjIIoWB8Oy
         O3zhORNw3vXesoYoJcQORxKn8gSYHKj3/14ztAel0vqZuAl6GjsniE2+0jqeSXlQqhE8
         hsog==
X-Gm-Message-State: AHQUAubMn4R97qLUQ6acLjPC9c4X9IDpGATyyrP0xhV620O+c+BWGBeN
        sl/2cWlb4lW09R1TXX0hAWWU/vb0hzc=
X-Google-Smtp-Source: AHgI3Ib9Txqt1JH00OmpwHDqOocPB8iKGf16Cn0P15mQw+j+/8JuXRaNYadfDGqeQAA2qPTefc1nGQ==
X-Received: by 2002:a0c:ae27:: with SMTP id y36mr6195543qvc.185.1550903699062;
        Fri, 22 Feb 2019 22:34:59 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id d32sm2189408qtc.88.2019.02.22.22.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 22:34:58 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>, rcu@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: [PATCH v2 5/6] rcuwait: Annotate task_struct with __rcu
Date:   Sat, 23 Feb 2019 01:34:33 -0500
Message-Id: <20190223063434.6793-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190223063434.6793-1-joel@joelfernandes.org>
References: <20190223063434.6793-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This suppresses sparse error generated due to the recently added
rcu_assign_pointer sparse check.

percpu-rwsem.c:162:9: sparse: error: incompatible types in comparison expression
exit.c:316:16: sparse: error: incompatible types in comparison expression

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcuwait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 90bfa3279a01..563290fc194f 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -18,7 +18,7 @@
  * awoken.
  */
 struct rcuwait {
-	struct task_struct *task;
+	struct task_struct __rcu *task;
 };
 
 #define __RCUWAIT_INITIALIZER(name)		\
-- 
2.21.0.rc0.258.g878e2cd30e-goog

