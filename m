Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEFEECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B332086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B332086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeGPErh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 00:47:37 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:6302 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbeGPErh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 00:47:37 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id CE797B51DCE7241F2C07;
        Mon, 16 Jul 2018 12:06:44 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6G46eDV071068;
        Mon, 16 Jul 2018 12:06:40 +0800 (GMT-8)
        (envelope-from jiang.biao2@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018071612064162-486051 ;
          Mon, 16 Jul 2018 12:06:41 +0800 
From:   Jiang Biao <jiang.biao2@zte.com.cn>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, hpa@zytor.com,
        x86@kernel.org, albcamus@gmail.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn
Subject: [PATCH 4/5] x86/pti: warn for unknown pti boot options
Date:   Mon, 16 Jul 2018 12:03:39 +0800
Message-Id: <1531713820-24544-5-git-send-email-jiang.biao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1531713820-24544-1-git-send-email-jiang.biao2@zte.com.cn>
References: <1531713820-24544-1-git-send-email-jiang.biao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-16 12:06:41,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-16 12:06:39,
        Serialize complete at 2018-07-16 12:06:39
X-MAIL: mse01.zte.com.cn w6G46eDV071068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using unknown pti boot options other than on/off/auto, we
select auto silently, which is sometimes confusing. Add warning for
unknown pti boot options like we do in
spectre_v2_select_mitigation().

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 arch/x86/mm/pti.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index a76b2cc..a368656 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -92,14 +92,14 @@ void __init pti_check_boottime_disable(void)
 			pti_mode = PTI_FORCE_OFF;
 			pti_print_if_insecure("disabled on command line.");
 			return;
-		}
-		if (ret == 2 && !strncmp(arg, "on", 2)) {
+		} else if (ret == 2 && !strncmp(arg, "on", 2)) {
 			pti_mode = PTI_FORCE_ON;
 			pti_print_if_secure("force enabled on command line.");
 			goto enable;
-		}
-		if (ret == 4 && !strncmp(arg, "auto", 4)) {
-			pti_mode = PTI_AUTO;
+		} else if (ret == 4 && !strncmp(arg, "auto", 4)) {
+			goto autosel;
+		} else {
+			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
 			goto autosel;
 		}
 	}
-- 
2.7.4

