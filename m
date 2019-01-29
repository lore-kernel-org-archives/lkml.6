Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEBEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2442084C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="djoXGnsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfA2LHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:07:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35731 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbfA2LHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:07:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so21587909wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 03:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NergthX5oSNRCeJESFYVsMGHKG3cwu/m8eBx+7n5JOE=;
        b=djoXGnsK11deAS6J4IpmOiUJzQK9Kh7UxFQ1sIfWXNRnsCRYdWvW0iAmNOyyvH1U5l
         ORyYOSUQzOHLOCqOg8RLHcMw3X44QxZocHBXJf/enpRVP2QWwBZEQTd1ADwMLsAu7YOh
         D74Y4PF0RgKe7o69H7P4Au761wDwXZIkzxtm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NergthX5oSNRCeJESFYVsMGHKG3cwu/m8eBx+7n5JOE=;
        b=jU4PZSREA/iWQiFUfzVHXMtG1wPRUX2xXoLQuhBHhRzK5T09W0fdEe7NOySthAvUYf
         A8ykWXQDsHA8pLVr1VjCXVLzs3mOobUB4lSh5i7ifh0QKhyOrNEHKsvKHvtCuH3Fq7gu
         OKZm60oYNXx3TtYlVy1pBUSImgoPOEtQGyojdyOitqm3h4AQY48xf0dnW4D8Vsd0ezRl
         jQTZcn5/IWljDSEvJmFeXqKXN449GRatZCtH+wPPoe4cXmDCI64rRVxdC687wCjgrvxa
         hH5/CC00wKZn4tnF5/FiktiG5WL+hJHaIa/brQz4BPYf3DRgpBVJh5wq21WSeOM9/udv
         0EeQ==
X-Gm-Message-State: AJcUuketau9O8h7xOe+Pg1BvyHL6FjHsDi+agvWvWJupo0/5GPJzTCGR
        rU4wWbMFMcNK8M0yosv96VW21Q==
X-Google-Smtp-Source: ALg8bN7KyU4T2hntASzwapUm1qGbXPcwc372C+KpSmztKCfyCq9jXBrjLPKcmlxaBmqmGaTtpBWGHA==
X-Received: by 2002:adf:9361:: with SMTP id 88mr24827980wro.204.1548760022218;
        Tue, 29 Jan 2019 03:07:02 -0800 (PST)
Received: from localhost.localdomain ([88.147.67.218])
        by smtp.gmail.com with ESMTPSA id s132sm2066112wmf.28.2019.01.29.03.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 03:07:01 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, mancha@tower-research.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 04/14] block, bfq: remove case of redirected bic from insert_request
Date:   Tue, 29 Jan 2019 12:06:28 +0100
Message-Id: <20190129110638.12652-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129110638.12652-1-paolo.valente@linaro.org>
References: <20190129110638.12652-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit 18e5a57d7987 ("block, bfq: postpone rq preparation to
insert or merge"), the destination queue for a request was chosen by a
different hook than the one that then inserted the request. So,
between the execution of the two hooks, the bic of the process
generating the request could happen to be redirected to a different
bfq_queue. As a consequence, the destination bfq_queue stored in the
request could be wrong. Such an event does not need to ba handled any
longer.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b0e8006475be..a9275ed57726 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4633,8 +4633,6 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 	bool waiting, idle_timer_disabled = false;
 
 	if (new_bfqq) {
-		if (bic_to_bfqq(RQ_BIC(rq), 1) != bfqq)
-			new_bfqq = bic_to_bfqq(RQ_BIC(rq), 1);
 		/*
 		 * Release the request's reference to the old bfqq
 		 * and make sure one is taken to the shared queue.
-- 
2.20.1

