Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FBFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0DC21901
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863882;
	bh=c6FOA6+KbPqSrNkOkvYWi9rnDVXi93Yw89QOlc5Me6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V7t3YZN8ShnMK8Ac9qBwWRLfgo++aMKg/So5RdtlTtnUhrD2NrJwBQbEWxaeu1vbm
	 0ra9Odj5Ffe89E8q1Y0nejKTAgascUirAGHYbFnUMzNzTHASn+42PcUv0IYffkJcX2
	 DaGUi/EIjUIytiIHVcHlZYhO3fmYZ9KXALmp/Noo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeLZWiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:38:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbeLZWiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:38:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E22CF21741;
        Wed, 26 Dec 2018 22:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863879;
        bh=c6FOA6+KbPqSrNkOkvYWi9rnDVXi93Yw89QOlc5Me6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1JRdsb13/BK1lzqwOjOYCkq6Qd74idc3PG3Wv88n5M/5SM1IrsSj5sAsOmD+SDR9T
         91HdY5j4P6ptpKCTGBOhuaymc12D2K5oadGeiRhUneNVqsN1vK+l2IJeyKe9QbiZfO
         JLrtV8GfonCtw6Dl5a2Xb2Zj5sJsw7V8Xu+CYhDU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>, security@kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 69/97] x86/mtrr: Don't copy uninitialized gentry fields back to userspace
Date:   Wed, 26 Dec 2018 17:35:29 -0500
Message-Id: <20181226223557.149329-69-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
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
index 40eee6cc4124..254683b503a9 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -165,6 +165,8 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 	struct mtrr_gentry gentry;
 	void __user *arg = (void __user *) __arg;
 
+	memset(&gentry, 0, sizeof(gentry));
+
 	switch (cmd) {
 	case MTRRIOC_ADD_ENTRY:
 	case MTRRIOC_SET_ENTRY:
-- 
2.19.1

