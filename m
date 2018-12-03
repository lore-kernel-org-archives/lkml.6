Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B98C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54132082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54132082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeLCKio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:38:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:46224 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbeLCKio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:38:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9849AC39;
        Mon,  3 Dec 2018 10:38:14 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     sstabellini@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, Juergen Gross <jgross@suse.com>
Subject: [PATCH] x86/boot: clear rsdp address in boot_params for broken loaders
Date:   Mon,  3 Dec 2018 11:38:11 +0100
Message-Id: <20181203103811.17056-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case a broken boot loader doesn't clear its struct boot_params clear
rsdp_addr in sanitize_boot_params().

This fixes commit e6e094e053af75 ("x86/acpi, x86/boot: Take RSDP
address from boot params if available") e.g. for the case of a boot via
systemd-boot.

Fixes: e6e094e053af75 ("x86/acpi, x86/boot: Take RSDP address from boot params if available")
Reported-by: Gunnar Krueger <taijian@posteo.de>
Tested-by: Gunnar Krueger <taijian@posteo.de>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/bootparam_utils.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
index a07ffd23e4dd..f6f6ef436599 100644
--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -36,6 +36,7 @@ static void sanitize_boot_params(struct boot_params *boot_params)
 	 */
 	if (boot_params->sentinel) {
 		/* fields in boot_params are left uninitialized, clear them */
+		boot_params->acpi_rsdp_addr = 0;
 		memset(&boot_params->ext_ramdisk_image, 0,
 		       (char *)&boot_params->efi_info -
 			(char *)&boot_params->ext_ramdisk_image);
-- 
2.16.4

