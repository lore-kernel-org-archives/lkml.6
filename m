Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB67BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7939321917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545405697;
	bh=x3KBl0dOSWhDRMKMlfJVvi7TTYF2/bkVfFt+sqoAWls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=mxOQgWRxV4wFCqNd1ToDWvzJmS4/LeeLxecMQKOqF4r0W8qQxXIWHfc7PJ1eaH34p
	 bNW8lIbArDLAQMcgOa4U5YKVesBPTIPl4ZDtd0xypvwQ5/+FAXA47rwAuq2LD8VA+S
	 xFPx7KMO9b3M5sjJ2k1I+0f+JA/+Y4sfbvASLAgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404160AbeLUPVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:21:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404104AbeLUPVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:21:31 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 185FA217D9;
        Fri, 21 Dec 2018 15:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545405690;
        bh=x3KBl0dOSWhDRMKMlfJVvi7TTYF2/bkVfFt+sqoAWls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=forv8qOd9oRnd8+Qcu7WdDP978r/TT08F0YA0h60jjCJJgSm6czy5r6tfVl0L9QRN
         89P8XbTT2MdVnlnM9wVTM/lvgIQPTTy9uxkDNbXwRh4UnxGHNgTx04ETPfOsr0B5i6
         nxg6hWpMHUfQ9k/lhxxFbsm41+qyU52qFUyn2pzU=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com
Subject: [PATCH RT 1/9] efi: Allow efi=runtime
Date:   Fri, 21 Dec 2018 09:21:13 -0600
Message-Id: <25f3709f40dc290bd5702feecb762dbd96ce6744.1545347029.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3.18.129-rt111 rt-stable review patch.  If anyone has any objections,
please let me know.

------------------
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 71bef7da4112ed2677d4f10a58202a5a4638fb90 ]

In case the option "efi=noruntime" is default at built-time, the user
could overwrite its sate by `efi=runtime' and allow it again.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/firmware/efi/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 297066df6946..e47c522e1d8f 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -59,6 +59,9 @@ static int __init parse_efi_cmdline(char *str)
 	if (parse_option_str(str, "noruntime"))
 		disable_runtime = true;
 
+	if (parse_option_str(str, "runtime"))
+		disable_runtime = false;
+
 	return 0;
 }
 early_param("efi", parse_efi_cmdline);
-- 
2.14.1

