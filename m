Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971DCC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A64F218E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546682790;
	bh=G8M8RgHseo/TBq2tuXts4C2plwGwer8RoNKr8nTy3EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VxUlrXdWETAC+yGxAzKeHD7W3wcmXShbJ+/t1hlGOwSoXtARah4TZvB7PNba5sSSF
	 6PLQQuQRei9ve0Hkv+tmIzPEQzZB/CyB4qqI9a/Ej4nOg+oWcsTmXZHm5AKVt0eXcp
	 s45lBJU2GTGUYDp9J4Ayt020L4gRHMpNCEEIAmiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfAEKG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 05:06:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfAEKG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 05:06:26 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [104.211.55.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29290214D8;
        Sat,  5 Jan 2019 10:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546682785;
        bh=G8M8RgHseo/TBq2tuXts4C2plwGwer8RoNKr8nTy3EQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aacXowM47IP+FSXeglElaxiH90dnAwyb13eK+ZOLgCZUCbVbHW96WidnEei8Bdmev
         mleo+AbS5Szhf1R7pMj0VeZbN7WeQC37NCKjoBQ2X71XUOxzx9jg+coGVLOay7yJfG
         RMGetimnDtXnsArsSOjYlNp8kWWPCSCJWHTHk4o0=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v6 10/11] x86/intel/lpss: Make PCI dependency explicit
Date:   Sat,  5 Jan 2019 10:06:05 +0000
Message-Id: <20190105100606.6673-11-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190105100606.6673-1-okaya@kernel.org>
References: <20190105100606.6673-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
satisfied implicitly through dependencies on CONFIG_ACPI have to be
specified directly. LPSS code relies on PCI infrastructure but this
dependency has not been explicitly called out.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a1ce34864eaf..d9b6a015d037 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -618,7 +618,7 @@ config X86_INTEL_QUARK
 
 config X86_INTEL_LPSS
 	bool "Intel Low Power Subsystem Support"
-	depends on X86 && ACPI
+	depends on X86 && ACPI && PCI
 	select COMMON_CLK
 	select PINCTRL
 	select IOSF_MBI
-- 
2.19.0

