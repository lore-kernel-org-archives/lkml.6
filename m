Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D157C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EF5224DB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ro5tTEs/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EF5224DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933916AbeFUWdb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:33:31 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33962 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933846AbeFUWd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:33:28 -0400
Received: by mail-pg0-f65.google.com with SMTP id q4-v6so2056022pgr.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 15:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QKg90FTuSuW27iG9WkPEeAv4vw/9V5gf4/0TnS9jz5U=;
        b=ro5tTEs/HRkysJu69zMDIb2AbN1vX9VkrXO1QdKWDKdggBbkfEcFWzM60dNj83LsNG
         oZain8dPBiVa92t4cALvbCH3Rt7HCkX1CVR9tigtOvZmDM6JL+e6aFG87BNKXkXIgrWx
         Aujf6t9AgEG2WdCVGMTbP3q8Fb7Qx8ILsdmb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QKg90FTuSuW27iG9WkPEeAv4vw/9V5gf4/0TnS9jz5U=;
        b=WSc5Exf4i3Ri8UWx+30opIBQ/vKw+2rWSZiivjvgb1sthtYlSPG89IeZmSTfRZou6e
         O5uQ7xwn1z/lfo1r9Q9XkrRhdwL3ymZ69BQqqR/t6y62l3+SK+4MJb7A/+BCo1e4Q2dH
         9SNwMtCP4S+x3TR0H7NSEe2eQt8ynZfkisTsYPjfmXgn8eE8SyD2gqStQJguCpA900Yh
         JBFQzn/W67SZmVRBuDaP0nCUJ8Ys2tfvDO+8tXeteF3lQLPI9NkPJBk1Vkvz4q5S3gz/
         If5/Jeoa63XpEGUDFC3QKE2CfuJ6mTx4RPKc6jswy6bbzFM5YmK9sdkBAAVcHCwy4wqW
         F7wg==
X-Gm-Message-State: APt69E0ISzI6UAX1wMkXdl2aeEST8svA3Ray+OiVVRC+RqTmL1qyY3WF
        zz7AYvrOQ0o2GXMkamt93fLkR5fQhCw=
X-Google-Smtp-Source: ADUXVKINawIAkOMUND7ttKW67qBSkWDDKycByql+PWAeWu8rKJF+KJGIIhAESZ6REhEoCBRsswz9mg==
X-Received: by 2002:a62:6b06:: with SMTP id g6-v6mr28893438pfc.96.1529620407637;
        Thu, 21 Jun 2018 15:33:27 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id x19-v6sm11060824pfi.5.2018.06.21.15.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 15:33:27 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v9 2/7] srcu: Add notrace variant of srcu_dereference
Date:   Thu, 21 Jun 2018 15:32:31 -0700
Message-Id: <20180621223236.211495-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180621223236.211495-1-joel@joelfernandes.org>
References: <20180621223236.211495-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

In the last patch in this series, we are making lockdep register hooks
onto the irq_{disable,enable} tracepoints. These tracepoints use the
_rcuidle tracepoint variant. In this series we switch the _rcuidle
tracepoint callers to use SRCU instead of sched-RCU. Inorder to
dereference the pointer to the probe functions, we could call
srcu_dereference, however this API will call back into lockdep to check
if the lock is held *before* the lockdep probe hooks have a chance to
run and annotate the IRQ enabled/disabled state.

For this reason we need a notrace variant of srcu_dereference since
otherwise we get lockdep splats. This patch adds the needed
srcu_dereference_notrace variant.

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/srcu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 3e72a291c401..67135d4a8a30 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -169,6 +169,11 @@ static inline int srcu_read_lock_held(const struct srcu_struct *sp)
  */
 #define srcu_dereference(p, sp) srcu_dereference_check((p), (sp), 0)
 
+/**
+ * srcu_dereference_notrace - no tracing and no lockdep calls from here
+ */
+#define srcu_dereference_notrace(p, sp) srcu_dereference_check((p), (sp), 1)
+
 /**
  * srcu_read_lock - register a new reader for an SRCU-protected structure.
  * @sp: srcu_struct in which to register the new reader.
-- 
2.18.0.rc2.346.g013aa6912e-goog

