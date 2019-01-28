Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18EEC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFDD2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692105;
	bh=TrK4TzUbEa8NHDE+3Mekqoji7J0q/eCjEvKbZwkzAg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f6m5nOAaMtzax29WN9GzoZEzsiAitiuFL5OgEoNWRS2iJkuvBFFTlU2rBXArZuaxW
	 H89kT5fr3U77f8wnO7Nd+UxskA226g4OMg6ICmKosyYT7IHyD+vf8AkJN87y8gQNzY
	 mJ5SpcxBx2Bbeu+vvflftG+Yoq4CJml0S9up/ANc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387707AbfA1QPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732968AbfA1QPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:15:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF18B20879;
        Mon, 28 Jan 2019 16:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692101;
        bh=TrK4TzUbEa8NHDE+3Mekqoji7J0q/eCjEvKbZwkzAg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xokMRaoXasnMP0OL/j/WORr2d9m8Q5ZIl8aa7sE/F+Rqrzuq0yIPujszXKtFHKDwn
         TRnpE0S9mr97NCak8xzNjXGS6LLcb3TcDl1e9Y85YEv47rPRP2fRmLspcIKeoJGT/j
         4BWf7d8DE3OA/m0yaEnDs6tuzBsOwaxlu4n0mfMI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        tj@kernel.org, johannes.berg@intel.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 067/170] timekeeping: Use proper seqcount initializer
Date:   Mon, 28 Jan 2019 11:10:17 -0500
Message-Id: <20190128161200.55107-67-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit ce10a5b3954f2514af726beb78ed8d7350c5e41c ]

tk_core.seq is initialized open coded, but that misses to initialize the
lockdep map when lockdep is enabled. Lockdep splats involving tk_core seq
consequently lack a name and are hard to read.

Use the proper initializer which takes care of the lockdep map
initialization.

[ tglx: Massaged changelog ]

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org
Cc: tj@kernel.org
Cc: johannes.berg@intel.com
Link: https://lkml.kernel.org/r/20181128234325.110011-12-bvanassche@acm.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/timekeeping.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 2cafb49aa65e..1ce7c404d0b0 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -41,7 +41,9 @@
 static struct {
 	seqcount_t		seq;
 	struct timekeeper	timekeeper;
-} tk_core ____cacheline_aligned;
+} tk_core ____cacheline_aligned = {
+	.seq = SEQCNT_ZERO(tk_core.seq),
+};
 
 static DEFINE_RAW_SPINLOCK(timekeeper_lock);
 static struct timekeeper shadow_timekeeper;
-- 
2.19.1

