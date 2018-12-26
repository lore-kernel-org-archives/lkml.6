Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCBBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAF221741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864204;
	bh=LMvhGygNhgmStr1mSVvzrlPEwDY8bekcnZdgjUhf5bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UruvfCDR/7fswyIX1Iparvzd83c5ODP2+d+kLxLv0WRgyEsItWOBt0uF7AA8GObX9
	 6j8XgC5InMsp9DDD8Ha4y0jQ1CDHd3W+TP8rj7M3iWmuEEhVswWlVw9YBY+3Ka+kMK
	 BLBCqFBkZQg1I9J2nVJnsALW6TKItRxZ5qGYcXN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbeLZWnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:43:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729389AbeLZWlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:41:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 695182054F;
        Wed, 26 Dec 2018 22:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864080;
        bh=LMvhGygNhgmStr1mSVvzrlPEwDY8bekcnZdgjUhf5bU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sPPdH0UAs5BPXnnhh9Q6ElNGhC6MlXnqFDcalWX6NlD5OwhVR37t7GRrEeGRoaM4J
         u/HR1AT5//QFWMXagE72vKoXJSMcCDBqs/N9iNUdL5P/AcUNSxI2QpgyKmrJKHaQFv
         +IHswKL3KinJR4ZmjDWH8mRXJmu1JPIctXI84Of0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>, security@kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 44/59] x86/mtrr: Don't copy uninitialized gentry fields back to userspace
Date:   Wed, 26 Dec 2018 17:38:24 -0500
Message-Id: <20181226223839.150262-44-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 32043fa065b51e0b1433e48d118821c71b5cd65d ]

Currently the copy_to_user of data in the gentry struct is copying
uninitiaized data in field _pad from the stack to userspace.

Fix this by explicitly memset'ing gentry to zero, this also will zero any
compiler added padding fields that may be in struct (currently there are
none).

Detected by CoverityScan, CID#200783 ("Uninitialized scalar variable")

Fixes: b263b31e8ad6 ("x86, mtrr: Use explicit sizing and padding for the 64-bit ioctls")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
Cc: security@kernel.org
Link: https://lkml.kernel.org/r/20181218172956.1440-1-colin.king@canonical.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mtrr/if.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 558444b23923..c2987daa6a6b 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -173,6 +173,8 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 	struct mtrr_gentry gentry;
 	void __user *arg = (void __user *) __arg;
 
+	memset(&gentry, 0, sizeof(gentry));
+
 	switch (cmd) {
 	case MTRRIOC_ADD_ENTRY:
 	case MTRRIOC_SET_ENTRY:
-- 
2.19.1

