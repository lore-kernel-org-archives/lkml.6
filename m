Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA61C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A05222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EaEbAYCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbfBLRRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:17:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36447 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731798AbfBLRQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id r124so1553163pgr.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AqOVPM1vkj1BcrdjSYH7HyHM4JuITQIO8J2Q0BieCKs=;
        b=EaEbAYCmXtoB46vY9L0sicfUIQl51y7gdkSivvKVXdgCulNJFy3rGyTHCYw7FsdztW
         QGbtQdVdQ13XLwiDeCegaCUYqUOonZlJklzCrQiXmv2hbBnsOncAyHpuLQoc94IU+Onn
         czV39rUvqxM5LG6U0m+E8kVYtgyZYcp/y3zVaoXoQOhxH9v3cwHLwpZOtCNUXn1hDe7Q
         feyHanRxoQyS9Tx+fZNEnxHxy9AQkwaoWGR1RwmvOF+wmhHcr/zvF0Z1ls4anxSBBLym
         o6aTw29G7Ml/Zs47lwpeNF4q7LNXMppTazLo9qyWW7rKkAtdOK9lbbEkScHamCX3nDnr
         /2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AqOVPM1vkj1BcrdjSYH7HyHM4JuITQIO8J2Q0BieCKs=;
        b=ahuhOOySDKkhI4WZZ2jhanPAh2dfoNvuTlyue29mj7BGmk2xPKUNHjzPf7iycczRHa
         Q3DvM5l+eIbMLAAI0a1AZiWsxElNRZtHZ0IhFLXPHv4sivErCAlaxkgz8JGsBr0AtbZF
         KUTE/Jg1kDZ87U2EmnCv6/nlRjglzSUYRxpGdguQEkgXKN9fMLHCSzhtMEfZlb51jvm+
         l8434habZc+Y5oyCqARtFroYMVMuiQtGMCNPzKTdAQj2Say8J0SETjTQ92mX3kgQ6Dau
         ioXVRBur6fDiE2kKdDKnos1pF+/oTHCnYJZiBwYO7l4QkZ5K3yoxb3sVoj8Xpxup8nkq
         GVbg==
X-Gm-Message-State: AHQUAuZrAelVQK2leM1fHEr/Ke1sLxeK0JMgveYAIz25TuCXtUfpVxkd
        yJQ+dDByUaeHF6+aJwvpMD+Q/Q==
X-Google-Smtp-Source: AHgI3IZaJXtXTQDon+7FcG+ky50OtOVGuRKECwblcEt3mUY/WcWqaOd7g0So5MYe93TVcpTZFzXveQ==
X-Received: by 2002:a63:2ccd:: with SMTP id s196mr4551020pgs.194.1549991790712;
        Tue, 12 Feb 2019 09:16:30 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:16:30 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     suzuki.poulose@arm.com, mingo@redhat.com, peterz@infradead.org,
        jolsa@redhat.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] perf tools: Rethink kernel address initialisation
Date:   Tue, 12 Feb 2019 10:16:14 -0700
Message-Id: <20190212171618.25355-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving initialisation of the kernel start address to function
cs_etm__setup_queues(), considered to be the common denominator for
queue initialisation.  That way we don't have to repeat the same code
at different places.

No change of functionatlity is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index c9a5b4935209..2d2de898ea68 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -523,6 +523,9 @@ static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
 	unsigned int i;
 	int ret;
 
+	if (!etm->kernel_start)
+		etm->kernel_start = machine__kernel_start(etm->machine);
+
 	for (i = 0; i < etm->queues.nr_queues; i++) {
 		ret = cs_etm__setup_queue(etm, &etm->queues.queue_array[i], i);
 		if (ret)
@@ -1490,14 +1493,10 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
-	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct cs_etm_buffer buffer;
 	size_t buffer_used, processed;
 	int err = 0;
 
-	if (!etm->kernel_start)
-		etm->kernel_start = machine__kernel_start(etm->machine);
-
 	/* Go through each buffer in the queue and decode them one by one */
 	while (1) {
 		buffer_used = 0;
-- 
2.17.1

