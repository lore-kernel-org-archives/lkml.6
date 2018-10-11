Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BA2C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F205213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lV43t0rM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F205213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbeJKXFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbeJKXFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:05:14 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CA942098A;
        Thu, 11 Oct 2018 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272251;
        bh=xN3gr7J2i4EurL/6Ttw3mQf0UcDKmsRtKvxuUcH+XKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lV43t0rMA8dvR1OV+24Dcym6552DwpxHuvST930obiGG9ghYSLCA6Da+RAiOtldmX
         YjvTIIckQf25n14MseKNeX3Y0g4Zno3+dVmPg3PVQfiqtRkI40lx3qIJj3ce311hbx
         HgpJnoVmLc8HXMZfme7nMYfsp3i01KXdv7aL/Ae8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ethan Tuttle <ethan@ethantuttle.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 042/120] ARM: mvebu: declare asm symbols as character arrays in pmsu.c
Date:   Thu, 11 Oct 2018 17:33:43 +0200
Message-Id: <20181011152551.486009874@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ethan Tuttle <ethan@ethantuttle.com>

[ Upstream commit d0d378ff451a66e486488eec842e507d28145813 ]

With CONFIG_FORTIFY_SOURCE, memcpy uses the declared size of operands to
detect buffer overflows.  If src or dest is declared as a char, attempts to
copy more than byte will result in a fortify_panic().

Address this problem in mvebu_setup_boot_addr_wa() by declaring
mvebu_boot_wa_start and mvebu_boot_wa_end as character arrays.  Also remove
a couple addressof operators to avoid "arithmetic on pointer to an
incomplete type" compiler error.

See commit 54a7d50b9205 ("x86: mark kprobe templates as character arrays,
not single characters") for a similar fix.

Fixes "detected buffer overflow in memcpy" error during init on some mvebu
systems (armada-370-xp, armada-375):

(fortify_panic) from (mvebu_setup_boot_addr_wa+0xb0/0xb4)
(mvebu_setup_boot_addr_wa) from (mvebu_v7_cpu_pm_init+0x154/0x204)
(mvebu_v7_cpu_pm_init) from (do_one_initcall+0x7c/0x1a8)
(do_one_initcall) from (kernel_init_freeable+0x1bc/0x254)
(kernel_init_freeable) from (kernel_init+0x8/0x114)
(kernel_init) from (ret_from_fork+0x14/0x2c)

Signed-off-by: Ethan Tuttle <ethan@ethantuttle.com>
Tested-by: Ethan Tuttle <ethan@ethantuttle.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-mvebu/pmsu.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -117,8 +117,8 @@ void mvebu_pmsu_set_cpu_boot_addr(int hw
 		PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
 }
 
-extern unsigned char mvebu_boot_wa_start;
-extern unsigned char mvebu_boot_wa_end;
+extern unsigned char mvebu_boot_wa_start[];
+extern unsigned char mvebu_boot_wa_end[];
 
 /*
  * This function sets up the boot address workaround needed for SMP
@@ -131,7 +131,7 @@ int mvebu_setup_boot_addr_wa(unsigned in
 			     phys_addr_t resume_addr_reg)
 {
 	void __iomem *sram_virt_base;
-	u32 code_len = &mvebu_boot_wa_end - &mvebu_boot_wa_start;
+	u32 code_len = mvebu_boot_wa_end - mvebu_boot_wa_start;
 
 	mvebu_mbus_del_window(BOOTROM_BASE, BOOTROM_SIZE);
 	mvebu_mbus_add_window_by_id(crypto_eng_target, crypto_eng_attribute,


