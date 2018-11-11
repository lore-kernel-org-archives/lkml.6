Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A321BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A9B214F1
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQfp9GSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A9B214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391477AbeKLI3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:29:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:33028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405010AbeKLIZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:25:15 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6391223CB;
        Sun, 11 Nov 2018 22:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975717;
        bh=KIbYYaPabS8PZyKEVvUmeksvA0RNI7W8Tksl3KEpYp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQfp9GSz/QpNYxQopvHxJsz4NzJ2rWwDpx6ANeF3m2g83RI0buBE1hU+VjM2dSl5U
         hXe1Bs+cWOmHC8zDuMv2yBGBvaONGYLrptz1s+42KvImL8t51HzzyUptvBfUJzjScM
         KfCNdscWJmZ1X5fwKir1HabXX6XQx/aJy68fdMxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia Hongtao <hongtao.jia@freescale.com>,
        Scott Wood <scottwood@freescale.com>,
        Radu Rendec <radu.rendec@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 115/141] powerpc/msi: Fix compile error on mpc83xx
Date:   Sun, 11 Nov 2018 14:26:14 -0800
Message-Id: <20181111221643.794988295@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
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

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 0f99153def98134403c9149128e59d3e1786cf04 upstream.

mpic_get_primary_version() is not defined when not using MPIC.
The compile error log like:

arch/powerpc/sysdev/built-in.o: In function `fsl_of_msi_probe':
fsl_msi.c:(.text+0x150c): undefined reference to `fsl_mpic_primary_get_version'

Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
Signed-off-by: Scott Wood <scottwood@freescale.com>
Reported-by: Radu Rendec <radu.rendec@gmail.com>
Fixes: 807d38b73b6 ("powerpc/mpic: Add get_version API both for internal and external use")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/mpic.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -392,7 +392,14 @@ extern struct bus_type mpic_subsys;
 #define	MPIC_REGSET_TSI108		MPIC_REGSET(1)	/* Tsi108/109 PIC */
 
 /* Get the version of primary MPIC */
+#ifdef CONFIG_MPIC
 extern u32 fsl_mpic_primary_get_version(void);
+#else
+static inline u32 fsl_mpic_primary_get_version(void)
+{
+	return 0;
+}
+#endif
 
 /* Allocate the controller structure and setup the linux irq descs
  * for the range if interrupts passed in. No HW initialization is


