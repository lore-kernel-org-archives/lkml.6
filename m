Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68371ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FFC2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FFC2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbeIRE3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:29:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47942 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbeIRE3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:29:10 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 271CEC49;
        Mon, 17 Sep 2018 22:59:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 52/70] MIPS: generic: fix missing of_node_put()
Date:   Tue, 18 Sep 2018 00:42:25 +0200
Message-Id: <20180917211653.282736183@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 28ec2238f37e72a3a40a7eb46893e7651bcc40a6 ]

of_find_compatible_node() returns a device_node pointer with refcount
incremented and must be decremented explicitly.
 As this code is using the result only to check presence of the interrupt
controller (!NULL) but not actually using the result otherwise the
refcount can be decremented here immediately again.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19820/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/generic/init.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -159,6 +159,7 @@ void __init arch_init_irq(void)
 					    "mti,cpu-interrupt-controller");
 	if (!cpu_has_veic && !intc_node)
 		mips_cpu_irq_init();
+	of_node_put(intc_node);
 
 	irqchip_init();
 }


