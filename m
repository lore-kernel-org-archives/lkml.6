Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E5BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB007214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="IxJXz8GX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfA2WwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:52:21 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41807 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfA2WwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:52:21 -0500
Received: by mail-yb1-f193.google.com with SMTP id n6so3460539ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 14:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CdGe6/Yo7nLW7G75bv7nG6chpZyXCPNYdxAkMYBosTM=;
        b=IxJXz8GX+Si558KKavIbsvO0B/yuMzxRTq5nMLy0b0G3LkrObsJQQGpFEcCGUsi6oe
         4JjVOXscDG5xpT92OE2YncKi5Cr9W1LMIk2Dem0b23nYiXWx4jqDv0tpfYHiLAOAcVKZ
         elj6MRasJr7rx9vQ5q5lAV3Oyu8sctpbN88W4AypSPWc/2NDJzkfFkp8OT6rmP4quCld
         EZCrbwCr/q4Mi23riVQUt4Nxo+LgTebMZ/pgfMUSgmq30hFjIpCR6aE5nuy99AoZUqUm
         G+upda5RFlI1bgrp9xEVhJCesqZDLRjZa71FZDa7Afhf4pSfeYtv9Eh/+/iZWn4NWO6p
         xJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CdGe6/Yo7nLW7G75bv7nG6chpZyXCPNYdxAkMYBosTM=;
        b=RhqzPOL8UIN3Tby5i3J/aG8xfBVi1em0MxGZTv2dLyGk2gw8O6WHyd0iVY+6Du2bcC
         EnCk6xQSezs7rgpCcR8gFYHauNyLEOvHMscCo/yvuk9Tcl3HdVSdV6HNCdDh8+2Ubc10
         wN1U8DkcTVck9pH89dMMSY/3+YdSyb4jlmYZHbE2aZ1O1snelSvkeh9FjeWpVNxr6Vfb
         dOp8YLMp5ju7YVIWegIAESgKubU6k6OB7b5OaTz7s++HOUm4a3d4+NMozh67SkfY7YFD
         L4CL6u8pA8AE0YGW/Rhf4nIexjVvDEczDosNb2rsyHfOSylrAbOIzjS+SPZQ/Xxq81Lt
         Ej2g==
X-Gm-Message-State: AJcUukeKlvlDJoDJgI22/buYnbiihChKiSS8+Og4n0VDW4R6GRgMkIKx
        f2B9mKlgW0Bv7TJeL/IEuygQ2g==
X-Google-Smtp-Source: ALg8bN57QK38vWHBo8rZJC6vnnH5OxaLPeXVQNgsXBMAqWydnO9auwYqkwYC1qqQHzb0ZSeh5e5lug==
X-Received: by 2002:a5b:482:: with SMTP id n2mr26188297ybp.193.1548802339947;
        Tue, 29 Jan 2019 14:52:19 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:1d25])
        by smtp.gmail.com with ESMTPSA id n16sm18577333ywn.31.2019.01.29.14.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 14:52:19 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Babu Moger <babu.moger@amd.com>, Borislav Petkov <bp@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86: avoid confusion over the new RESCTRL config prompt
Date:   Tue, 29 Jan 2019 17:52:18 -0500
Message-Id: <20190129225218.15441-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Resource Control" is a very broad term for this CPU feature, and a
term that is also associated with containers, cgroups etc. This can
easily cause confusion.

Make the user prompt more specific.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 arch/x86/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

As somebody who works in "resource control", this prompt in oldconfig
certainly had me go wtf. Can we do something more specific?

Not insisting on this name, and I haven't renamed all the config
symbols yet, but we should probably fix this before 5.0 is released.

Thanks!

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 26387c7bf305..426677b759c0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -447,11 +447,11 @@ config RETPOLINE
 	  support for full protection. The kernel may run slower.
 
 config X86_RESCTRL
-	bool "Resource Control support"
+	bool "x86 cache control support"
 	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select KERNFS
 	help
-	  Enable Resource Control support.
+	  Enable x86 cache control support.
 
 	  Provide support for the allocation and monitoring of system resources
 	  usage by the CPU.
-- 
2.20.1

