Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE15DECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB4E21522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bTijR68F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB4E21522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391561AbeIVEXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:23:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37876 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeIVEXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:23:02 -0400
Received: by mail-io1-f66.google.com with SMTP id v14-v6so13615697iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W7G1LyBYm4HSC5qCxaG9wMUa09GRXe4Qr33dj1P3c38=;
        b=bTijR68FboeRTVFAiAOqUUVXOOXvL8atzI170zC394IEbTNbsAMPfkPwXfsSZjeWKs
         a5ZgPDElseUuWwDKFLiGWnBxhGs8f/P8ex5DamkFzWyhY8r9Gu4O9ZKbr2Y3F87c2Hn7
         qgMIu/sIln9Z/vpL7gHx3iWSrcZUsHMpBItXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W7G1LyBYm4HSC5qCxaG9wMUa09GRXe4Qr33dj1P3c38=;
        b=hvpVIdtRQinYwKzmmdeCcIiAs2ztk0MS08XycnGSnHfM9ahYi/0vSeX7NUpebGOS0n
         x470QFqa9zCiyOW+3uopoM+ujj8+zagzvjnb/Qo28/q0iApxeVN4PeMYIhSK/TVWFSmU
         i5z07Vocu+7JcvG2k7AOSoXrLO23vEeFTb2MY8paR+X4JhBAmcDzxWOvFlJFflwjNj3A
         IeU6QWeUzWTe25W6V9jhbjnVam5Z+eN6m/mTmVhJsNSPFrq8LWtP6CPrQBuB/vDdBD56
         VEZxsC6OnGrRnK5Iv/kqAYeMXKyH0/ppDbDYVuPAm1PDXAwGKXZU9rvZWHp4oC8+hqJR
         D6oQ==
X-Gm-Message-State: ABuFfoizhtz/dS7O2FG0nnXrmh8axAD++d9TgY92No+mruzM0hdiA+OH
        Y/kymLMjgVX214Fsx3psWbNg7uK/zkt5nw==
X-Google-Smtp-Source: ACcGV6368inhHgu+ap5tfP0L0acEmPvk/pu4xAZEIOq8KsfmsI5d+1C3/Tj42qXUI1h/0MYOx2cAwA==
X-Received: by 2002:a6b:d00b:: with SMTP id x11-v6mr4250604ioa.181.1537569126661;
        Fri, 21 Sep 2018 15:32:06 -0700 (PDT)
Received: from joelaf-glaptop0.roam.corp.google.com ([207.164.22.36])
        by smtp.gmail.com with ESMTPSA id b195-v6sm2907320itc.42.2018.09.21.15.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 15:32:05 -0700 (PDT)
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
Subject: [PATCH RFC] Documentation: RCU: Clarify comment about fanout
Date:   Fri, 21 Sep 2018 18:31:53 -0400
Message-Id: <20180921223153.114728-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCU Data-Structures document describes a trick to test RCU with small
number of CPUs but with a larger tree. It wasn't immediately clear how
the document arrived at 16 CPUs which also requires setting the
FANOUT_LEAF to 2 instead of the default of 16. Clarify that.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../RCU/Design/Data-Structures/Data-Structures.html         | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.html b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
index 1d2051c0c3fc..791348977da7 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.html
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
@@ -127,9 +127,9 @@ CPUs, RCU would configure the <tt>rcu_node</tt> tree as follows:
 </p><p>RCU currently permits up to a four-level tree, which on a 64-bit system
 accommodates up to 4,194,304 CPUs, though only a mere 524,288 CPUs for
 32-bit systems.
-On the other hand, you can set <tt>CONFIG_RCU_FANOUT</tt> to be
-as small as 2 if you wish, which would permit only 16 CPUs, which
-is useful for testing.
+On the other hand, you can set <tt>CONFIG_RCU_FANOUT</tt> to be as small as 2
+and set <tt>CONFIG_RCU_FANOUT_LEAF</tt> to 2 if you wish, which would permit
+only 16 CPUs in a 4-level tree. This can be useful for testing.
 
 </p><p>This multi-level combining tree allows us to get most of the
 performance and scalability
-- 
2.19.0.444.g18242da7ef-goog

