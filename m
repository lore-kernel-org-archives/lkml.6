Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A154C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E7220823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IjJxFoeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E7220823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeJ3OHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 10:07:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43101 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeJ3OHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 10:07:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id g59-v6so901209plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 22:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCjkjiTRGgZL2A0FAx+5895V+sW9tiOmXxjM8S1+Okk=;
        b=IjJxFoePkltq37DEUMfY5cZa3fiOA909kBsNXCt/vf2itu+FsMoBX1SU8HhrtbHUPa
         MgcNU1BKTergtaT/vBzoVeH4zEn49UKos68wRO4/vU5QcbSdHPFA3KpMsoX/s7VE/IgU
         fGjE2eqFpzht0Q2mJGvnXGYo0+SLkAbss7ioQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCjkjiTRGgZL2A0FAx+5895V+sW9tiOmXxjM8S1+Okk=;
        b=Vh8mep3CEcDyG+WsndahvtU1l1fmgj2dNPfhBlmDRQRgfyWzvaA53U+ljZP8myf2hf
         xY6jFqc+zQ1mKK7gl68sw3PHXpAFmDMe152EsrS0NlKr3C3jkSZgKkRhF1JF6zOTniRJ
         rZUNNr6zBLKpJuoRfluVRtRr3Nk49/g663JhQ2gALwq9IYUoTIFNo/2XQ8hm3af0I1Cu
         PCSM22Z1cD2Ry7h1r7n/eFg8wZPEgOzVHFyuMjJDpflnV8W3xaaVV6uBP56NOrnYgoUv
         mQWAGMg5/Pgku2Rcb00w5qypcVo4kG8YVdWtn5n1NN5zj4T7HL88gzdC9y75ZN87SVN/
         o0lw==
X-Gm-Message-State: AGRZ1gLW+PKhJbDjyTCTlEHNOFXUdWU1IjncC8101EjojZSrOPyO5Ite
        0ixnbVPkXWO8YeZgfAuxSH/p03tjeuw=
X-Google-Smtp-Source: AJdET5cabykt6yrZFLTct9Z0C4l+VLI+9y3OMGbHfHame3WREXzHr6RT5eJk0gU6AAGkvhq/C2qbVA==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3-v6mr17238139plo.162.1540876539636;
        Mon, 29 Oct 2018 22:15:39 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id z5-v6sm10985602pfd.99.2018.10.29.22.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 22:15:38 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] doc: correct parameter in stallwarn
Date:   Mon, 29 Oct 2018 22:15:34 -0700
Message-Id: <20181030051534.256658-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stallwarn document incorrectly mentions 'fps=' instead of 'fqs='.
Correct that.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/stallwarn.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/stallwarn.txt b/Documentation/RCU/stallwarn.txt
index b01bcafc64aa..073dbc12d1ea 100644
--- a/Documentation/RCU/stallwarn.txt
+++ b/Documentation/RCU/stallwarn.txt
@@ -205,7 +205,7 @@ handlers are no longer able to execute on this CPU.  This can happen if
 the stalled CPU is spinning with interrupts are disabled, or, in -rt
 kernels, if a high-priority process is starving RCU's softirq handler.
 
-The "fps=" shows the number of force-quiescent-state idle/offline
+The "fqs=" shows the number of force-quiescent-state idle/offline
 detection passes that the grace-period kthread has made across this
 CPU since the last time that this CPU noted the beginning of a grace
 period.
-- 
2.19.1.568.g152ad8e336-goog

