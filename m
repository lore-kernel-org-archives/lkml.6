Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C66C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10E021473
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10E021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeHWL0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:26:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41810 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeHWL0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:26:50 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4EB7EBB6;
        Thu, 23 Aug 2018 07:58:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 18/79] ARC: Enable machine_desc->init_per_cpu for !CONFIG_SMP
Date:   Thu, 23 Aug 2018 09:52:54 +0200
Message-Id: <20180823074919.909220617@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>

[ Upstream commit 2f24ef7413a4d91657ef04e77c27ce0b313e6c95 ]

machine_desc->init_per_cpu() hook is supposed to be per cpu
initialization and would seem to apply  equally to UP and/or SMP.
Infact the comment in header file seems to suggest it works for
UP too, which was not the case and this patch.

This enables !CONFIG_SMP build for platforms such as hsdk.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
[vgupta: trimmeed changelog]
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/include/asm/mach_desc.h |    2 --
 arch/arc/kernel/irq.c            |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

--- a/arch/arc/include/asm/mach_desc.h
+++ b/arch/arc/include/asm/mach_desc.h
@@ -34,9 +34,7 @@ struct machine_desc {
 	const char		*name;
 	const char		**dt_compat;
 	void			(*init_early)(void);
-#ifdef CONFIG_SMP
 	void			(*init_per_cpu)(unsigned int);
-#endif
 	void			(*init_machine)(void);
 	void			(*init_late)(void);
 
--- a/arch/arc/kernel/irq.c
+++ b/arch/arc/kernel/irq.c
@@ -31,10 +31,10 @@ void __init init_IRQ(void)
 	/* a SMP H/w block could do IPI IRQ request here */
 	if (plat_smp_ops.init_per_cpu)
 		plat_smp_ops.init_per_cpu(smp_processor_id());
+#endif
 
 	if (machine_desc->init_per_cpu)
 		machine_desc->init_per_cpu(smp_processor_id());
-#endif
 }
 
 /*


