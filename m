Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636C1C070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 02:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3E320659
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 02:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Mlwn5C7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3E320659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeJOKNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 06:13:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35436 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeJOKNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 06:13:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id f8-v6so8527430plb.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 19:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FW952t4pDVRIR40MRoaiZ9nrLOWRH704jVPjM3WmWxs=;
        b=Mlwn5C7/wrQJVd+UiURagcyJO5cpPhr55BJM7UxHL6NOw3OymACNYp4c2gA0YJZu6j
         LiXx7b0BPNrB4h7lxWOE+QxhnNYiUxCS/vbwgGYJLNHQRd+wdmKFI+L/65HZLYOIVPHd
         k9rq/tdMyc5n/XSYtCTSuEVrFFG2+l3XvXF9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FW952t4pDVRIR40MRoaiZ9nrLOWRH704jVPjM3WmWxs=;
        b=M1BYu7NrJjwctCju58QXFDpGRFXAAOY4E24JBtXMENz8bh/g1r1/T4oGlNKbLKMv9E
         NvWQlVeNc9q8YtyhFkAQJo8NZpJW6AfQFEWHnQ6K7U8GwAMQte3FSrFzLLBf1q8jNPKz
         CUyCbd+sAg8V7tfUP2gZ0cx7ppyXScVuJIaUEWrQ4g8F7PrAiS/Fsbf8utjaOb7sVEtv
         TQ1q5EIDwp3zRtlSQjEVqIahMm8kFNWg5xsf4hryhhnrwg9aoxWYvEVyRvje2CE+AwqC
         aAhc+aCrBNkwAzEVkOosuJOL/6ujh+y+dasegt0axo4jndQCuHaZL7KbuENMq07dLsp0
         KZSA==
X-Gm-Message-State: ABuFfoiZg3HbhD11mVeIVgxwa9O2klPGrLh3H3SE/1cZbb6AyOeAu0xg
        euvAO092rPKvJgq53vmxi+IHuH/6oqc=
X-Google-Smtp-Source: ACcGV60w/su0bS0yurvCMClHGo+ROY50bplM0uiTJbN2U5YpPTJ4rylcLZ0AiNx38iztvCCExBgdsg==
X-Received: by 2002:a17:902:9004:: with SMTP id a4-v6mr15003989plp.166.1539570596075;
        Sun, 14 Oct 2018 19:29:56 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id z11-v6sm15302474pfd.99.2018.10.14.19.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 19:29:54 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH] doc: rcu: Fix code listing in performance and scalability requirements
Date:   Sun, 14 Oct 2018 19:29:42 -0700
Message-Id: <20181015022942.224250-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code listing under this section has a quick quiz that says line 19
uses rcu_access_pointer, but the code listing itself does not. Fix this.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../RCU/Design/Requirements/Requirements.html    |  2 +-
 kernel/sys.c                                     | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index 4fae55056c1d..f74a2233865c 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -1596,7 +1596,7 @@ used in place of <tt>synchronize_rcu()</tt> as follows:
 16   struct foo *p;
 17
 18   spin_lock(&amp;gp_lock);
-19   p = rcu_dereference(gp);
+19   p = rcu_access_pointer(gp);
 20   if (!p) {
 21     spin_unlock(&amp;gp_lock);
 22     return false;
-- 
2.19.0.605.g01d371f741-goog

