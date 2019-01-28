Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF00CC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EED20663
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697436;
	bh=bZXLlLwjL/uwi+TaaSmsa69GsIDJK9MXX6dC+DPasPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tx2agEGn6ytsltampWBokz8Q/9aJu6Ug9kz9xfVqmKD1zaSJIL70N6s3jWrC1peKm
	 hJOrKDoRhnAtffvnc+qbp85DOr7Zp79jW0nqB4BE7IgrSIQcaRXsiCNeV/47LBQInD
	 MFNs0w9futdUubQrO4tbQILHVdgsd5K/o8ciwKhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfA1PtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:49:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728662AbfA1PtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:49:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1D952147A;
        Mon, 28 Jan 2019 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690555;
        bh=bZXLlLwjL/uwi+TaaSmsa69GsIDJK9MXX6dC+DPasPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1MStPgDuircg8YNvTEZmAPbVVYXgKOKXM4Gk2wRO1PF6rCoQHTHxsnnPNh17DmkkL
         QGNkiXlVmN/RCre1E3NN9Tm6OZuLM0oK83uKkfTxcW8gEFW3D4x9NKEo8ADBh8Uwjv
         AbSCwz45bNukVppJjWBJgNUY+CSaNOVFY8cB/PqU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        tj@kernel.org, johannes.berg@intel.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 123/304] timekeeping: Use proper seqcount initializer
Date:   Mon, 28 Jan 2019 10:40:40 -0500
Message-Id: <20190128154341.47195-123-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
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
index 2d110c948805..6c9493495538 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -50,7 +50,9 @@ enum timekeeping_adv_mode {
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

