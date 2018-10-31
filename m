Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18BDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A882C2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mttwqAwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A882C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeKAIGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbeKAIGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E25D20847;
        Wed, 31 Oct 2018 23:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027185;
        bh=Mw8EC2MR8S4zEcuXVC4fE3B8YWowHW/bBhF21Mgs6hY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mttwqAwhG+dN/SDaNOcPpwNafoP34sz/LTge02XevpWaqxuES1nzKQ4AdWCNcRwkv
         dm83Yr01gzwAud3aGxZmyMrBwB64o9JhXeLCuiSB4mF7Zr1afYOwpFJAt+ZBOh7LR8
         S5mMktFo4Oe9wZPsKWjNBAkUVzPOSlzOiRD02RgE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 048/146] efi/x86: Call efi_parse_options() from efi_main()
Date:   Wed, 31 Oct 2018 19:04:03 -0400
Message-Id: <20181031230541.28822-48-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit c33ce984435bb6142792802d75513a71e55d1969 ]

Before this commit we were only calling efi_parse_options() from
make_boot_params(), but make_boot_params() only gets called if the
kernel gets booted directly as an EFI executable. So when booted through
e.g. grub we ended up not parsing the commandline in the boot code.

This makes the drivers/firmware/efi/libstub code ignore the "quiet"
commandline argument resulting in the following message being printed:
"EFI stub: UEFI Secure Boot is enabled."

Despite the quiet request. This commits adds an extra call to
efi_parse_options() to efi_main() to make sure that the options are
always processed. This fixes quiet not working.

This also fixes the libstub code ignoring nokaslr and efi=nochunk.

Reported-by: Peter Robinson <pbrobinson@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/compressed/eboot.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 1458b1700fc7..8b4c5e001157 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -738,6 +738,7 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 	struct desc_struct *desc;
 	void *handle;
 	efi_system_table_t *_table;
+	unsigned long cmdline_paddr;
 
 	efi_early = c;
 
@@ -755,6 +756,15 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 	else
 		setup_boot_services32(efi_early);
 
+	/*
+	 * make_boot_params() may have been called before efi_main(), in which
+	 * case this is the second time we parse the cmdline. This is ok,
+	 * parsing the cmdline multiple times does not have side-effects.
+	 */
+	cmdline_paddr = ((u64)hdr->cmd_line_ptr |
+			 ((u64)boot_params->ext_cmd_line_ptr << 32));
+	efi_parse_options((char *)cmdline_paddr);
+
 	/*
 	 * If the boot loader gave us a value for secure_boot then we use that,
 	 * otherwise we ask the BIOS.
-- 
2.17.1

