Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20E2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24C2208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24C2208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbeHWMVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:21:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51766 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733155AbeHWMVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:21:15 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 40EAFC5C;
        Thu, 23 Aug 2018 08:52:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greentime Hu <greentime@andestech.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 167/324] nds32: Fix the dts pointer is not passed correctly issue.
Date:   Thu, 23 Aug 2018 09:53:53 +0200
Message-Id: <20180823075004.448427986@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
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

From: Greentime Hu <greentime@andestech.com>

[ Upstream commit 6897e6ecb3167598cb45e1a1424dd4d5e3778837 ]

We found that the original implementation will only use the built-in dtb
pointer instead of the pointer pass from bootloader. This bug is fixed
by this patch.

Signed-off-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/nds32/kernel/setup.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/nds32/kernel/setup.c
+++ b/arch/nds32/kernel/setup.c
@@ -278,7 +278,8 @@ static void __init setup_memory(void)
 
 void __init setup_arch(char **cmdline_p)
 {
-	early_init_devtree( __dtb_start);
+	early_init_devtree(__atags_pointer ? \
+		phys_to_virt(__atags_pointer) : __dtb_start);
 
 	setup_cpuinfo();
 


