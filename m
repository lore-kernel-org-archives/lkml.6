Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D78C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEF8223CB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+07G256"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEF8223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbeKLTtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:49:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33464 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbeKLTtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:49:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so8589191wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 01:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P3gM8CEth45UYnNHSZF98Zi/zDAo21J+oNJpFvTMXDU=;
        b=F+07G256OoZzsTmnbt0RELuT0heBN/K8A2OrFVYc5axzgzepR5T2xKkZNXlibAtKAJ
         809E2WdhkOSlr2VxSQawiDZ9b1WIzjE9faJ7tuvvOP/NGFenBt5I92R4MWTVciVtbKU9
         TdhCVPR+K7VkxBtuZ276fOv470Q1nrjMDL6vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P3gM8CEth45UYnNHSZF98Zi/zDAo21J+oNJpFvTMXDU=;
        b=lOF6HF/ELV/urYo1qNSxPsL9UJLD9sbBLDO5hr4KYpczpnD9TO2PToL59tJfRWLd7r
         fMZ00e9eEDw9JIQqQ09WPju2XxFcGAjhfT0Dx77nmC9xHGX+JFZDKLY2g246D1fbo2Dg
         q5+b2aFh8Z9ecrH8dJhrZ4TLFYTFzcwl+/b5/N/mM4DQ6Ao8rj9Yar2R/MqQeIUTU9x3
         GzpESeuw2MbmcoAJft8TqAwtQxvLK0T9pIgucwjoY0uphBNcuGbWR0jJzZhU1FM4Iotg
         gsobGZ7q7fdfTeMDH9fXVNx+fMeuRG/BDr+bnrIkERHBXks11IBPvebCs8xJu+4mHjnm
         /gDA==
X-Gm-Message-State: AGRZ1gJ5WFC6mQFm58SDknrJoxDwZVVLeUqsSfAyq36fYInc1oogM3tz
        hzOv7yB57aTBAehfaWU+REwlrA==
X-Google-Smtp-Source: AJdET5dmQXJVy08gMpQhoMpmynlctBhE45z6FLv3NNiUP+8moCL8RqcGeq1AsRtgkq2/wuSqduDtxw==
X-Received: by 2002:a5d:5544:: with SMTP id g4-v6mr311353wrw.222.1542016637942;
        Mon, 12 Nov 2018 01:57:17 -0800 (PST)
Received: from localhost.localdomain ([93.68.220.21])
        by smtp.gmail.com with ESMTPSA id r14-v6sm21273089wro.8.2018.11.12.01.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 01:57:17 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 06/12] block, bfq: align min and default weights with cfq
Date:   Mon, 12 Nov 2018 10:56:26 +0100
Message-Id: <20181112095632.69114-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20181112095632.69114-1-paolo.valente@linaro.org>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angelo Ruocco <angeloruocco90@gmail.com>

The I/O schedulers bfq and cfq expose a cgroup attribute with the same
meaning: weight.

This commit changes bfq default and min weights to match the ones set
by cfq.

Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 77651d817ecd..249d8128d3ee 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -22,13 +22,13 @@
 #define BFQ_IOPRIO_CLASSES	3
 #define BFQ_CL_IDLE_TIMEOUT	(HZ/5)
 
-#define BFQ_MIN_WEIGHT			1
+#define BFQ_MIN_WEIGHT			10
 #define BFQ_MAX_WEIGHT			1000
 #define BFQ_WEIGHT_CONVERSION_COEFF	10
 
 #define BFQ_DEFAULT_QUEUE_IOPRIO	4
 
-#define BFQ_WEIGHT_LEGACY_DFL	100
+#define BFQ_WEIGHT_LEGACY_DFL	500
 #define BFQ_DEFAULT_GRP_IOPRIO	0
 #define BFQ_DEFAULT_GRP_CLASS	IOPRIO_CLASS_BE
 
-- 
2.16.1

