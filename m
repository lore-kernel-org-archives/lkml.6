Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A832C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFBD20869
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TAJBWDGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFBD20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389601AbeKPU42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:56:28 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:47770 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389504AbeKPU40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:56:26 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 93B0624E0F71;
        Fri, 16 Nov 2018 02:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542365079; bh=ptQ72Js7imq4lkt06zd7bcpddq8Vm576WAOYacKoaqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TAJBWDGHAAJe6u3HYX1Y5gxY4PDbFEkx8FbhMSvZjv/JggK1rbKML4JYtTG0De94/
         Oo/Ad5bbuEYRu09BpZMv80JPLF1MR8Ys1tSOOlKjO+9pzsXOHcO6jBuolhhdJ7jV9e
         MXio0RT1LuUy++vql7SmRNsA5ggaPKLL7Yfq/aHV2C00CeG6ypJIO7yINWrzT2Xjp0
         O0mwRupUDgmjAHo3mE8GFNO4YG/lwT17Ec9JlKUzdKAUW1xIAfk9HyEI1xO5L5QNxh
         vksPkLjoLzEOvQn3N6z+aNpOjzHQY1xn0erjHfl7ma+3YcfT+AvVGw5Lz+2FZVpEhl
         0MMuWX7miiyDw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id DF5FD55BF;
        Fri, 16 Nov 2018 02:44:37 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 3/3] ARC: show detaled SmaRT configuration in mumbojumbo
Date:   Fri, 16 Nov 2018 13:44:27 +0300
Message-Id: <20181116104427.25264-4-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181116104427.25264-1-Eugeniy.Paltsev@synopsys.com>
References: <20181116104427.25264-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add information about SmaRT entries number and SmaRT SW support.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/setup.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index c5641e6ffc2a..20fe3fcf8306 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -210,8 +210,7 @@ static void read_arc_build_cfg_regs(void)
 	READ_BCR(ARC_REG_AP_BCR, bcr);
 	cpu->extn.ap = bcr.ver ? 1 : 0;
 
-	READ_BCR(ARC_REG_SMART_BCR, bcr);
-	cpu->extn.smart = bcr.ver ? 1 : 0;
+	cpu->extn.smart = smart_exist() ? 1 : 0;
 
 	READ_BCR(ARC_REG_RTT_BCR, bcr);
 	cpu->extn.rtt = bcr.ver ? 1 : 0;
@@ -333,12 +332,20 @@ static char *arc_extn_mumbojumbo(int cpu_id, char *buf, int len)
 			       IS_AVAIL1(cpu->extn.fpu_sp, "SP "),
 			       IS_AVAIL1(cpu->extn.fpu_dp, "DP "));
 
-	if (cpu->extn.debug)
-		n += scnprintf(buf + n, len - n, "DEBUG\t\t: %s%s%s\n",
+	if (cpu->extn.debug) {
+		n += scnprintf(buf + n, len - n, "DEBUG\t\t: %s%s",
 			       IS_AVAIL1(cpu->extn.ap, "ActionPoint "),
-			       IS_AVAIL1(cpu->extn.smart, "smaRT "),
 			       IS_AVAIL1(cpu->extn.rtt, "RTT "));
 
+		if (smart_supported())
+			n += scnprintf(buf + n, len - n, "SmaRT (%u entries)\n",
+				       smart_stack_size());
+		else if (smart_exist())
+			n += scnprintf(buf + n, len - n, "SmaRT (outdated)\n");
+		else
+			n += scnprintf(buf + n, len - n, "\n");
+	}
+
 	if (cpu->dccm.sz || cpu->iccm.sz)
 		n += scnprintf(buf + n, len - n, "Extn [CCM]\t: DCCM @ %x, %d KB / ICCM: @ %x, %d KB\n",
 			       cpu->dccm.base_addr, TO_KB(cpu->dccm.sz),
-- 
2.14.5

