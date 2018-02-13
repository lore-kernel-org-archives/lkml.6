Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965662AbeBMTfK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:35:10 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:56135 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965313AbeBMTfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:35:09 -0500
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH] ARC: Don't check presense of Timer1 in SMP builds
Date: Tue, 13 Feb 2018 22:35:04 +0300
Message-Id: <20180213193504.28671-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of SMP we use GFRC from ARconnect and Timer1 is left
untouched. Still with that check in place we're panicing if Timer1
is missing in current hardware which is quite unexpected.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---
 arch/arc/kernel/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index cf97f7d88934..1142d76a7e8f 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -391,8 +391,10 @@ static void arc_chk_core_config(void)
 	if (!cpu->extn.timer0)
 		panic("Timer0 is not present!\n");
 
+#ifndef CONFIG_SMP
 	if (!cpu->extn.timer1)
 		panic("Timer1 is not present!\n");
+#endif
 
 #ifdef CONFIG_ARC_HAS_DCCM
 	/*
-- 
2.11.0
