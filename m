Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60250C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B77420989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Dhf5GeME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbfA3Qc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:32:58 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:53342 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732122AbfA3Qc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:32:57 -0500
Received: from mailhost.synopsys.com (unknown [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 935D024E2594;
        Wed, 30 Jan 2019 08:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548865976; bh=cQROuIfwaCGRo0d5c7aWOHiy/zKoIrzsOOYdVZnyQjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dhf5GeMEo012QyPu2hM4DvQG5ROTpgSyfoG4GX0AXHYkhHPsnjYE/OINdQEtHXW/R
         LLSAcDXX/lmesZboAZYj3xCzKNsgExvXK1zpC0V1o2CsXJ5oVP7y994Sm9MUM4usKN
         8cPhNMyOmIBa2AS3F+/+M3y7s/LqC9b7eOVvfhu79BLLS5oJN00fICjPwNI5HnhqZP
         gLFCcj3yyl1//fV9I//gg4C7aOzEqiiKYqBxbKrUyf5VsLV8qKyuCcttFPQ54O+9ke
         mxkfK1ShZQYOJ9YCPO2ezLjzylqTUFtMlreMwwCap46PxgTSbCOqgN+cboHydK/scF
         33fdxKNiXq0hg==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.46])
        by mailhost.synopsys.com (Postfix) with ESMTP id 33546A0093;
        Wed, 30 Jan 2019 16:32:55 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH v2 5/5] ARC: boot log: print unaligned memory access details
Date:   Wed, 30 Jan 2019 19:32:44 +0300
Message-Id: <20190130163244.10870-6-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190130163244.10870-1-Eugeniy.Paltsev@synopsys.com>
References: <20190130163244.10870-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This now prints both HW feature status (exists, enabled / disabled)
and SW status (used / not used).

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/setup.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index feb90093e6b1..e465cae3f661 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -270,10 +270,17 @@ static char *arc_cpu_mumbojumbo(int cpu_id, char *buf, int len)
 #ifdef __ARC_UNALIGNED__
 	ua = 1;
 #endif
-	n += i = scnprintf(buf + n, len - n, "%s%s%s%s%s%s",
+	n += i = scnprintf(buf + n, len - n, "%s%s%s%s",
 			   IS_AVAIL2(cpu->isa.atomic, "atomic ", CONFIG_ARC_HAS_LLSC),
-			   IS_AVAIL2(cpu->isa.ldd, "ll64 ", CONFIG_ARC_HAS_LL64),
-			   IS_AVAIL1(cpu->isa.unalign, "unalign "), IS_USED_RUN(ua));
+			   IS_AVAIL2(cpu->isa.ldd, "ll64 ", CONFIG_ARC_HAS_LL64));
+
+	if (cpu->isa.unalign) {
+		i += scnprintf(buf + n, len - n, "unalign (%s, %s)",
+			       IS_ENABLED(CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS) ?
+					  "enabled" : "disabled",
+			       ua ? "used" : "not used");
+		n += i;
+	}
 
 	if (i)
 		n += scnprintf(buf + n, len - n, "\n\t\t: ");
-- 
2.14.5

