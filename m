Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ACFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8865A21741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864918;
	bh=lvy3Tp7WTDgJksiH2lWtQCNM0gHW3RFgYjlxYeoxlQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ITfUUqoJ8RfSbWuAmbbYKRFZH5SENl6DEEwc8Psq11v/hIKiGHx3bCnapkiDQ55m6
	 xjwCim1YdX5Kl9in43gcJbFkIXiIRlRgLWUxttt7lv3xqavrNgy7fcpo8RyWiTZU4X
	 LUjfytTwClA5Rlt9Yv51PEc51qvqUwDSZsMqWNOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbeLZWy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:54:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730266AbeLZWyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:54:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90BD9218A5;
        Wed, 26 Dec 2018 22:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864892;
        bh=lvy3Tp7WTDgJksiH2lWtQCNM0gHW3RFgYjlxYeoxlQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZIFR59xIcFlH/HHwT7K8J45WJb2uvsa+NZun0xYvUvLl9gIZT+W2O5pfmlQSZBhlV
         k++jTos50jtwIa496GOZsWvHxjJgdgiJC5kWSQoXTd1Vgy4VNzzh8xgNK0/YM8qBSZ
         37c6droJMPuBX3m0k62RX5FMxkcpoapE5qr05XQ8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>, security@kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 30/35] x86/mtrr: Don't copy uninitialized gentry fields back to userspace
Date:   Wed, 26 Dec 2018 17:41:37 -0500
Message-Id: <20181226224142.150866-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226224142.150866-1-sashal@kernel.org>
References: <20181226224142.150866-1-sashal@kernel.org>
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
index 6d9b45549109..d5b2a08e2b66 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -172,6 +172,8 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 	struct mtrr_gentry gentry;
 	void __user *arg = (void __user *) __arg;
 
+	memset(&gentry, 0, sizeof(gentry));
+
 	switch (cmd) {
 	case MTRRIOC_ADD_ENTRY:
 	case MTRRIOC_SET_ENTRY:
-- 
2.19.1

