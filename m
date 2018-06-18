Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1BCC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16B620864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16B620864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934122AbeFRIQK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:16:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52964 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934242AbeFRIQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:16:08 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 63C80C75;
        Mon, 18 Jun 2018 08:16:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 031/279] powerpc/64s: Default l1d_size to 64K in RFI fallback flush
Date:   Mon, 18 Jun 2018 10:10:16 +0200
Message-Id: <20180618080610.113679785@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

[ Upstream commit 9dfbf78e4114fcaf4ef61c49885c3ab5bad40d0b ]

If there is no d-cache-size property in the device tree, l1d_size could
be zero. We don't actually expect that to happen, it's only been seen
on mambo (simulator) in some configurations.

A zero-size l1d_size leads to the loop in the asm wrapping around to
2^64-1, and then walking off the end of the fallback area and
eventually causing a page fault which is fatal.

Just default to 64K which is correct on some CPUs, and sane enough to
not cause a crash on others.

Fixes: aa8a5e0062ac9 ('powerpc/64s: Add support for RFI flush of L1-D cache')
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
[mpe: Rewrite comment and change log]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/setup_64.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -864,6 +864,17 @@ static void init_fallback_flush(void)
 	int cpu;
 
 	l1d_size = ppc64_caches.l1d.size;
+
+	/*
+	 * If there is no d-cache-size property in the device tree, l1d_size
+	 * could be zero. That leads to the loop in the asm wrapping around to
+	 * 2^64-1, and then walking off the end of the fallback area and
+	 * eventually causing a page fault which is fatal. Just default to
+	 * something vaguely sane.
+	 */
+	if (!l1d_size)
+		l1d_size = (64 * 1024);
+
 	limit = min(ppc64_bolted_size(), ppc64_rma_size);
 
 	/*


