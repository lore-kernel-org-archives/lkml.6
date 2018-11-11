Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34068C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B0D20872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNp+n6/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B0D20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732999AbeKLJnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:43:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729525AbeKLIS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:26 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 044FD223CB;
        Sun, 11 Nov 2018 22:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975311;
        bh=9QrDgurJfpklA+V/Zreigr7MBAtuXFYMWEmHPARX4lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZNp+n6/vhjAsfvzgh8bDrcnIpIHVxb49hJoFiyvDU2/6PY6nXR0JbqLWkK6rO1kxq
         XBZTw9NYXyw+QuseioPcRYZrS89qP2vbHyAwzy7IpLy+63ARX8sx3zm215ekFCU0Il
         N+ClVfllJr6p6lys5omqASkynVpTDI+jTzzB52Yk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 4.19 282/361] powerpc/tm: Fix HFSCR bit for no suspend case
Date:   Sun, 11 Nov 2018 14:20:29 -0800
Message-Id: <20181111221655.978383172@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Neuling <mikey@neuling.org>

commit dd9a8c5a87395b6f05552c3b44e42fdc95760552 upstream.

Currently on P9N DD2.1 we end up taking infinite TM facility
unavailable exceptions on the first TM usage by userspace.

In the special case of TM no suspend (P9N DD2.1), Linux is told TM is
off via CPU dt-ftrs but told to (partially) use it via
OPAL_REINIT_CPUS_TM_SUSPEND_DISABLED. So HFSCR[TM] will be off from
dt-ftrs but we need to turn it on for the no suspend case.

This patch fixes this by enabling HFSCR TM in this case.

Cc: stable@vger.kernel.org # 4.15+
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/setup_64.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -243,13 +243,19 @@ static void cpu_ready_for_interrupts(voi
 	}
 
 	/*
-	 * Fixup HFSCR:TM based on CPU features. The bit is set by our
-	 * early asm init because at that point we haven't updated our
-	 * CPU features from firmware and device-tree. Here we have,
-	 * so let's do it.
+	 * Set HFSCR:TM based on CPU features:
+	 * In the special case of TM no suspend (P9N DD2.1), Linux is
+	 * told TM is off via the dt-ftrs but told to (partially) use
+	 * it via OPAL_REINIT_CPUS_TM_SUSPEND_DISABLED. So HFSCR[TM]
+	 * will be off from dt-ftrs but we need to turn it on for the
+	 * no suspend case.
 	 */
-	if (cpu_has_feature(CPU_FTR_HVMODE) && !cpu_has_feature(CPU_FTR_TM_COMP))
-		mtspr(SPRN_HFSCR, mfspr(SPRN_HFSCR) & ~HFSCR_TM);
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		if (cpu_has_feature(CPU_FTR_TM_COMP))
+			mtspr(SPRN_HFSCR, mfspr(SPRN_HFSCR) | HFSCR_TM);
+		else
+			mtspr(SPRN_HFSCR, mfspr(SPRN_HFSCR) & ~HFSCR_TM);
+	}
 
 	/* Set IR and DR in PACA MSR */
 	get_paca()->kernel_msr = MSR_KERNEL;


