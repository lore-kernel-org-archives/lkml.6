Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73722C0044B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3874D2245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZntydDL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3874D2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbeKLTuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:50:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36994 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbeKLTt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:49:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so7461989wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 01:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=95cHSgXhObq6AUCu/Rr/+wEQTPHLVt9I8/orFJ2tnV8=;
        b=ZntydDL3A95QZ0Q9bqPS7efY9/AnOcRfFMoWhJjuF9Gk55eXToWWO0MFVufb41xZUb
         nHLiTbmFBZG9+1cdt8aSYqRhhgzNW6mvo/J47vdQ+DPObGyWLAiX1dVnw6VnyGsWrHIX
         7rTjNGD9VyfMoQr33985it7yVDU+01tI7ZnNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=95cHSgXhObq6AUCu/Rr/+wEQTPHLVt9I8/orFJ2tnV8=;
        b=MZB64cJcPtmwcsGUQEThjLZ1KdvjATBNxreRdw1n6w1tV4flWc8xUCUqNYxtHWNdig
         zrU7ra3Biteu7gfB/Ag5Etn6uHsgKvM6VAgJwsxm/1xUPy3kUCFLvSYoKh/zgBtxnFeX
         kRSX4CEoUAYewYFmxIebMsO/vsm5hrGuoapICZZcZUeHH9FfHlLxXU3vwFTGUfMG3O3I
         VA/yqZhsgFmkgj75MC0i4e+nki6adEaW6wLw1zSfGNXFdj5B/YaH34L7jpLHySjxIiyt
         YEGGeFkVNK2uonB3WBIPL91DWLFvaaivuKvkhm65vZbx6vhPWx97ZOsDOq5aU66IqRHd
         IkdA==
X-Gm-Message-State: AGRZ1gKIeGdjlwb7PWgj1WKx327Dk666oeBpXS5KJ5RgUlF11mQJzi98
        iAJE8D99VBil+wDT6WqONPJpbw==
X-Google-Smtp-Source: AJdET5eIJV6u6HegcE4uV2vFatX404HGAoD92vBcn00/LSxYXW6IXRwdLIzD2IsbIvSV20KQIm8j7w==
X-Received: by 2002:a1c:3b06:: with SMTP id i6-v6mr6807918wma.18.1542016650265;
        Mon, 12 Nov 2018 01:57:30 -0800 (PST)
Received: from localhost.localdomain ([93.68.220.21])
        by smtp.gmail.com with ESMTPSA id r14-v6sm21273089wro.8.2018.11.12.01.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 01:57:29 -0800 (PST)
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
Subject: [PATCH 11/12] doc, bfq-iosched: fix a few clerical errors
Date:   Mon, 12 Nov 2018 10:56:31 +0100
Message-Id: <20181112095632.69114-12-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20181112095632.69114-1-paolo.valente@linaro.org>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes a few clerical errors in
Documentation/block/bfq-iosched.txt.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 Documentation/block/bfq-iosched.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/block/bfq-iosched.txt b/Documentation/block/bfq-iosched.txt
index 8d8d8f06cab2..6d7dd5ab8554 100644
--- a/Documentation/block/bfq-iosched.txt
+++ b/Documentation/block/bfq-iosched.txt
@@ -42,7 +42,7 @@ sustainable throughputs, on the same systems as above:
 
 BFQ works for multi-queue devices too.
 
-The table of contents follow. Impatients can just jump to Section 3.
+The table of contents follows. Impatients can just jump to Section 3.
 
 CONTENTS
 
@@ -51,7 +51,7 @@ CONTENTS
  1-2 Server systems
 2. How does BFQ work?
 3. What are BFQ's tunables and how to properly configure BFQ?
-4. BFQ group scheduling
+4. Group scheduling with BFQ
  4-1 Service guarantees provided
  4-2 Interface
 
@@ -294,7 +294,7 @@ too.
 per-process ioprio and weight
 -----------------------------
 
-Unless the cgroups interface is used (see "4. BFQ group scheduling"),
+Unless the cgroups interface is used (see "4. Group scheduling with BFQ"),
 weights can be assigned to processes only indirectly, through I/O
 priorities, and according to the relation:
 weight = (IOPRIO_BE_NR - ioprio) * 10.
-- 
2.16.1

