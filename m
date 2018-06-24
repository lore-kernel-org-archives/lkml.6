Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1D2C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 19:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6080252E4
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 19:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RRYTw8mz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6080252E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeFXTfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 15:35:01 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46457 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeFXTe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 15:34:59 -0400
Received: by mail-pf0-f195.google.com with SMTP id q1-v6so5430098pff.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 12:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oM8Tr8TK/eW4MzZR6eU5Xgrt37oTYon44hf7ccfXntQ=;
        b=RRYTw8mzSnt2oDezVTdlZxw6s/q0PDluprf5McDCvrMLCO93pTj0n1E0qZLVrEdsg9
         YJKjA88YjePR1N3z2Jn7CYANpmD7LKiIL1QXJiQKSGOsl959frHwIftmtA8vyQbXgIpe
         nPqBl2lp+Pge1a3GuEkFZAuvZnaEm3ubNN7UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oM8Tr8TK/eW4MzZR6eU5Xgrt37oTYon44hf7ccfXntQ=;
        b=uATel9BhvWSm9dhV2pBIOXL0lsiEUa0WF+Qhoj5E1yUPuRVNeTWi8GTCTa5yhUbsmo
         9Oe+NVhuoIA9G3tHQ6W2Mdp1Sq5nlXw2n5NjXLaMPjSMBHzP7bjN2buWc982NZIQRqu4
         fjd/xAvNGvMbuGehxuqR1Aq/oviquLoku8PKR9FbshUT7nw6cZT36o2RqeLOhD69m2b4
         p6oG0tIdz4E68EturD00Aurxw/V1kFOYBRzaQKLh8fC4/IqbIBscztjzA6Hn4D8ch305
         k1n2RxHUcJY6/meoYJ0A2USotmIi6pBx2leJgEsxpWX0w5Ky9lM7+RS1L3eMlTo87kwy
         FWhw==
X-Gm-Message-State: APt69E3zJk+cSawuW4cVKSx54P7mAijSD0kA73BP52f7hY6muU8Xdz2V
        4UO01VC8n2+02vAZImGxQGI6owmJQag=
X-Google-Smtp-Source: ADUXVKKuY/aAXYmP2XocxXXSox8AZnQ+QvizBCpsb0wGpecTyvQ6Cp4BwhA7OBD0XWUSvsLksKMz1w==
X-Received: by 2002:a62:84e:: with SMTP id c75-v6mr10215617pfd.35.1529868898855;
        Sun, 24 Jun 2018 12:34:58 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id n76-v6sm28132167pfg.98.2018.06.24.12.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 12:34:58 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, byungchul.park@lge.com
Subject: [RFC] doc: Improve rcu_dynticks::dynticks documentation
Date:   Sun, 24 Jun 2018 12:34:51 -0700
Message-Id: <20180624193451.250855-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The very useful RCU Data-Structures describes that the dynticks counter
of the rcu_dynticks data structure is incremented when we transitions to
or from dynticks-idle mode. However it doesn't mention that it is also
incremented due to transitions to and from user mode which for dynticks
purposes is an extended quiescent state.

I found this with tracing calls to rcu_dynticks_eqs_enter which can also
happen from rcu_user_enter. Lets add this information to the
Data-Structures document.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../RCU/Design/Data-Structures/Data-Structures.html       | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.html b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
index f5120a00f511..50be87e59937 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.html
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
@@ -1227,9 +1227,11 @@ to overflow the counter, this approach corrects the
 CPU enters the idle loop from process context.
 
 </p><p>The <tt>-&gt;dynticks</tt> field counts the corresponding
-CPU's transitions to and from dyntick-idle mode, so that this counter
-has an even value when the CPU is in dyntick-idle mode and an odd
-value otherwise.
+CPU's transitions to and from either dyntick-idle or user mode, so
+that this counter has an even value when the CPU is in dyntick-idle
+mode or user mode and an odd value otherwise. The transitions to/from
+user mode need to be counted for user mode adaptive-ticks support
+(see timers/NO_HZ.txt).
 
 </p><p>The <tt>-&gt;rcu_need_heavy_qs</tt> field is used
 to record the fact that the RCU core code would really like to
-- 
2.18.0.rc2.346.g013aa6912e-goog

