Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B803C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3715220874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJPw/IX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3715220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754712AbeFRFKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 01:10:43 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36587 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754288AbeFRFKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 01:10:40 -0400
Received: by mail-pg0-f66.google.com with SMTP id m5-v6so6966261pgd.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 22:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P8F/rdx0Dg+tbAP4xRKVzOUZryhhTxWfkI38tLb+Eck=;
        b=AJPw/IX/VN0XwcK1Ched1kGfQBYDjuanEYGEs/y4J+hLXkavQTnpY6xZNhinOXqWvP
         PE1fQ4QPcFombM4wCpzkn2u7sslK0CiLeOW1//tilXlowC3BtVpVJ1LtSLA8qeyaiduA
         xrgUHPr0fPSe175W02wB8+lHCUmhx1OiZiucM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P8F/rdx0Dg+tbAP4xRKVzOUZryhhTxWfkI38tLb+Eck=;
        b=CZL5uwNfWexJheLtjbU8t9nTnrCJxx5ZRQswJMeo+kwW+KBZRpaKBNiCLDj70UWN73
         93yT1QfK1E0OfpfILsXA2UtEqcbL7PborF7SuqIxFTEBcR6DjC6xgb1uaVqTKQSCR8sq
         v2wx7cJ/8tDWJuiwTzxwchDqRjIgobHfUL7I275n7nC0erbCr9rE/sZ1RtuBLbGKkGFk
         +Ho1rCbzWcpg91q1i84A/PSZ55/ImSLgY/R7JXA+syIepOIRNFvrI/daFmPsRTzABNC6
         Xdcd6kJoHPFuIh06npD0j953X/IduqxcPR2r5+Ojsn8hmuPm5yIFBPv0yBiMq9XKRcB6
         eZsQ==
X-Gm-Message-State: APt69E35WcooU7/B2kv7emgM2DqTJVBY+DVGduLqLIHrNslxFr1IFHKb
        cH61ghzTFC5IzZwyNIHmblLpRQ==
X-Google-Smtp-Source: ADUXVKJVirLlTDUHU6z/KRqCP5W0Aj2gSu3rHcMljQe38O9Hh2aWLjfXj4jyjGqbjLizwD3v1Rtdag==
X-Received: by 2002:a63:902:: with SMTP id 2-v6mr9540897pgj.3.1529298640259;
        Sun, 17 Jun 2018 22:10:40 -0700 (PDT)
Received: from localhost.localdomain (li1181-92.members.linode.com. [45.79.82.92])
        by smtp.gmail.com with ESMTPSA id l15-v6sm29051710pfg.88.2018.06.17.22.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jun 2018 22:10:39 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Kim Phillips <kim.phillips@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/6] perf cs-etm: Bail out immediately for instruction sample failure
Date:   Mon, 18 Jun 2018 13:09:55 +0800
Message-Id: <1529298599-3876-3-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
References: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the instruction sample failure has happened, it isn't necessary to
execute to the end of the function cs_etm__flush().  This commit is to
bail out immediately and return the error code.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 822ba91..8b2c099 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -939,6 +939,9 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 		err = cs_etm__synth_instruction_sample(
 			etmq, addr,
 			etmq->period_instructions);
+		if (err)
+			return err;
+
 		etmq->period_instructions = 0;
 
 		/*
-- 
2.7.4

