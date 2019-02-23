Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D9DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DA920652
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PPEj7Vcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfBWGfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 01:35:13 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44386 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfBWGfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 01:35:02 -0500
Received: by mail-qt1-f196.google.com with SMTP id d2so5077778qti.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 22:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c11Ywbk20nC8e/qjunfo9WwGcMogUJINp1i/rWGd08s=;
        b=PPEj7VcsX7GuoS9pbDmowmREOrTcSy3Dj461kk5FZcZJFK1aPfti5PndMTK4chG0Af
         v5egDRsZIECwwjGy3GGyr/aCNrEkUBjw2CnB+5LssuW0QOKPd20jb6sC1Br4Ew6WH2T/
         ifjANVdD1BRTqfhSTjcMOQwJg4GPR2rK9OR8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c11Ywbk20nC8e/qjunfo9WwGcMogUJINp1i/rWGd08s=;
        b=jgHD52cOxHLiOYuCw3g9WJS7D84H5duogWj5SUsIrBD/2U41vgBgmkD9hWN+dC5E5m
         nanfZ/6BUyVxpmpVseZdwLLv1Jc3MqLl6RT//e/wGHpfejWXtLAMifjQDZgHiuEg1bQt
         qD69fD4NPlpNf7t3rqqhzZ9VdhN23b1BAG/jgL8VU9Z94E4B8QS+xKunxsfvtuSx59w9
         QD++Hbo2MdKhVRjsyjyo1KQ1SMp3h1l24tUtq3bo9TDezg/p9aPwQSdHjEvbJWauX+PS
         EJHnHG9LCXhgASDUJdJ2xutx6XdM/oXLo1K1X0yCa83gel6b8Vc3Qk838ewZr7PnpJ6o
         a+9A==
X-Gm-Message-State: AHQUAuaSRYqUerGRKIQ0cwGyt2IuNtFYe5SI4Y4WC38L7dBuSGGWD/Az
        XsO3SasUX3c612Q2Zzpn6HfgRxfH4AM=
X-Google-Smtp-Source: AHgI3IaQaWIDhu712jidCK5mnMSqSaUBd1cvjuYOZ04s+y+aFdPkG7M0MgZpCLNFmNw19uUjpE6x6Q==
X-Received: by 2002:ac8:19f5:: with SMTP id s50mr6018714qtk.25.1550903700787;
        Fri, 22 Feb 2019 22:35:00 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id d32sm2189408qtc.88.2019.02.22.22.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 22:35:00 -0800 (PST)
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
Subject: [PATCH v2 6/6] sched: Annotate perf_domain pointer with __rcu
Date:   Sat, 23 Feb 2019 01:34:34 -0500
Message-Id: <20190223063434.6793-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190223063434.6793-1-joel@joelfernandes.org>
References: <20190223063434.6793-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following sparse errors in sched/fair.c:

fair.c:6506:14: error: incompatible types in comparison expression
fair.c:8642:21: error: incompatible types in comparison expression

Using __rcu will also help sparse catch any future bugs.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ca6a79f57e7a..c8e6514433a9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -780,7 +780,7 @@ struct root_domain {
 	 * NULL-terminated list of performance domains intersecting with the
 	 * CPUs of the rd. Protected by RCU.
 	 */
-	struct perf_domain	*pd;
+	struct perf_domain __rcu *pd;
 };
 
 extern struct root_domain def_root_domain;
-- 
2.21.0.rc0.258.g878e2cd30e-goog

