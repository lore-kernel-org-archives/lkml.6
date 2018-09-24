Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0535ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618EC2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618EC2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbeIYAlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:41:37 -0400
Received: from shelob.surriel.com ([96.67.55.147]:36286 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeIYAlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:41:37 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g4VkD-0002qj-Lj; Mon, 24 Sep 2018 14:38:05 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kernel-team@fb.com, songliubraving@fb.com,
        mingo@kernel.org, will.deacon@arm.com, hpa@zytor.com,
        luto@kernel.org, npiggin@gmail.com
Subject: [PATCH 0/7] x86/mm/tlb: make lazy TLB mode even lazier
Date:   Mon, 24 Sep 2018 14:37:52 -0400
Message-Id: <20180924183759.23955-1-riel@surriel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus asked me to come up with a smaller patch set to get the benefits
of lazy TLB mode, so I spent some time trying out various permutations
of the code, with a few workloads that do lots of context switches, and
also happen to have a fair number of TLB flushes a second.

Both of the workloads tested are memcache style workloads, running
on two socket systems. One of the workloads has around 300,000
context switches a second, and around 19,000 TLB flushes.

The first patch in the series, of always using lazy TLB mode,
reduces CPU use around 1% on both Haswell and Broadwell systems.

The rest of the series reduces the number of TLB flush IPIs by
about 1,500 a second, resulting in a 0.2% reduction in CPU use,
on top of the 1% seen by just enabling lazy TLB mode.

These are the low hanging fruits in the context switch code.

The big thing remaining is the reference count overhead of
the lazy TLB mm_struct, but getting rid of that is rather a
lot of code for a small performance gain. Not quite what
Linus asked for :)


