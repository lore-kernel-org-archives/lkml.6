Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC137C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A43218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546452671;
	bh=qMId2bziwri5Clvrn8TVsi0udASRvJOv/2773oXGXeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=foRgV059XNj0xfVFNa3ioV1tXN4P4rInKW1kH8BOLMnJhTkfk34QEhqnajpv3Gko8
	 NVAeas+wpw/TjcCY8IeW3CJa7bisbjufQe2Smhne/xxXkiXZSJ/lWOyVSN7bkk0sJK
	 H0dn78adnXSQU8l3DKwquPNCJUjMdkxqUNGIJlCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfABSLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:11:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbfABSLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:11:01 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [137.117.71.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07FDF218D3;
        Wed,  2 Jan 2019 18:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546452660;
        bh=qMId2bziwri5Clvrn8TVsi0udASRvJOv/2773oXGXeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R0+XmOBxH3MJnQWtCJBkbr/Ku8iB7svc1alTL9W5wcJ8HC9NWd0dM5dB2MTbd/2LN
         looqgEwWvV0sTGq0E09hVNwYgPfkLX+70Gw2UTcpC5J3oTGyOiejMfqlgOPBaWuDUS
         tSb3+7VtjupITszpc0roEe4gu9zzMeiwR4ENcyA8=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v5 10/11] x86/intel/lpss: Make PCI dependency explicit
Date:   Wed,  2 Jan 2019 18:10:37 +0000
Message-Id: <20190102181038.4418-11-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190102181038.4418-1-okaya@kernel.org>
References: <20190102181038.4418-1-okaya@kernel.org>
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
index cc4f0c6ee1ed..322a58ababb0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -617,7 +617,7 @@ config X86_INTEL_QUARK
 
 config X86_INTEL_LPSS
 	bool "Intel Low Power Subsystem Support"
-	depends on X86 && ACPI
+	depends on X86 && ACPI && PCI
 	select COMMON_CLK
 	select PINCTRL
 	select IOSF_MBI
-- 
2.19.0

