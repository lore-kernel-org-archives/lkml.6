Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E696C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206D921903
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="kMWqEwHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfAZPli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 10:41:38 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25431 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfAZPli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 10:41:38 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548517236; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=S5txlIsSx1Nm7Q2J8jxFFbX2/XKxH4yPHIwngjpEQ2qn+6cwzBbFrtYArWCyDoFPmPt+JxGMJ6uL0P3OCbAs+/hgGW6eQpk7ySBcB/xaHgqpjhhyU5iyBBB6ZyED3KaPBi5UfI0vvO0mLnZ1kyPGQZiStlEoHZhhHNcVnNRILPY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548517236; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=46tXNgI05PgEtGevE0wr+wI42b/WbtGWxI0TXl+yTPU=; 
        b=e71vRRT/fe2k95W/ZNTEQAHniEx+vps2h4masZ0zVmhxYcznBJvze3agbAcoX0yHMXbve4vThC5NXuRhbjYTRLvQui3e0zLd/ktWwAP9CcWSiqP72JVeiKxGlV9oLROQMChlFa13LbDtgGk3XR0AEviU3PtrCLORJM2EQ6MAgxk=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=IbHvaTDR9v5iGg2YmOM6yucYZf4B9fKiwpqGHue2bh3o74c3xcuKYfYji0LbB+mfRLss1gEv9bbK
    LRKfSbTfM3MOJJwyFLvfOB3KwlYEynDRtkrlVDnZC5gug2Kdq5Nb  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548517236;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=889;
        bh=46tXNgI05PgEtGevE0wr+wI42b/WbtGWxI0TXl+yTPU=;
        b=kMWqEwHjf8T6kVc39OYLthvHZkiXRwpBkFSp+iTgO8oYK9bvUz3B2bV3P+UmDdhF
        8ug32PCjXcKIS7pOobIkmiWyhFSt/Vk2zlaNE6Vg1dTYCZYSAltZqMdTt+gcNGfdPT5
        6NdKwXwCUUbHAgbWn0NgPhbNcSX3wW4VDEbo4bS4=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548517234537416.8434024978051; Sat, 26 Jan 2019 07:40:34 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, jason@lakedaemon.net, tglx@linutronix.de,
        syq@debian.org, jiaxun.yang@flygoat.com, 772753199@qq.com
Subject: [PATCH 3/4] Irqchip: Ingenic: Add support for the X1000.
Date:   Sat, 26 Jan 2019 23:38:42 +0800
Message-Id: <1548517123-60058-4-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548517123-60058-1-git-send-email-zhouyanjie@zoho.com>
References: <1548517123-60058-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing the irq-ingenic driver on the X1000 Soc.
X1000 is a 1.0GHz processor for IoT. It has MIPS32 XBurst RISC core
with double precision hardware float point unit.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 drivers/irqchip/irq-ingenic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index 69be219..0b643c7 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -177,3 +177,4 @@ static int __init intc_2chip_of_init(struct device_node *node,
 IRQCHIP_DECLARE(jz4770_intc, "ingenic,jz4770-intc", intc_2chip_of_init);
 IRQCHIP_DECLARE(jz4775_intc, "ingenic,jz4775-intc", intc_2chip_of_init);
 IRQCHIP_DECLARE(jz4780_intc, "ingenic,jz4780-intc", intc_2chip_of_init);
+IRQCHIP_DECLARE(x1000_intc, "ingenic,x1000-intc", intc_2chip_of_init);
-- 
2.7.4


