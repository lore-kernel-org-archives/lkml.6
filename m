Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFF7C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39522563B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39522563B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030454AbeGARSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:18:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36862 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031375AbeGAQjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:39:12 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 626F2A73;
        Sun,  1 Jul 2018 16:39:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4.17 058/220] powerpc/64s: Fix DT CPU features Power9 DD2.1 logic
Date:   Sun,  1 Jul 2018 18:21:22 +0200
Message-Id: <20180701160910.776342717@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit 749a0278c2177b2d16da5d8b135ba7f940bb4199 upstream.

In the device tree CPU features quirk code we want to set
CPU_FTR_POWER9_DD2_1 on all Power9s that aren't DD2.0 or earlier. But
we got the logic wrong and instead set it on all CPUs that aren't
Power9 DD2.0 or earlier, ie. including Power8.

Fix it by making sure we're on a Power9. This isn't a bug in practice
because the only code that checks the feature is Power9 only to begin
with. But we'll backport it anyway to avoid confusion.

Fixes: 9e9626ed3a4a ("powerpc/64s: Fix POWER9 DD2.2 and above in DT CPU features")
Cc: stable@vger.kernel.org # v4.17+
Reported-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/dt_cpu_ftrs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -711,7 +711,8 @@ static __init void cpufeatures_cpu_quirk
 		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TM_HV_ASSIST;
 		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TM_XER_SO_BUG;
 		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD2_1;
-	} else /* DD2.1 and up have DD2_1 */
+	} else if ((version & 0xffff0000) == 0x004e0000)
+		/* DD2.1 and up have DD2_1 */
 		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD2_1;
 
 	if ((version & 0xffff0000) == 0x004e0000) {


