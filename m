Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E98C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC8A214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQbNoYNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC8A214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbeKLIRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730600AbeKLIRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:20 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 449F4223CE;
        Sun, 11 Nov 2018 22:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975244;
        bh=O007p9wAdW6a2EdWkF4orv5RUQiNYImQKy8HUvAGcAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UQbNoYNQvFKPEqlCC0p8Kmq9OwE9bOyqrpkkkhhRfFWgb3DAkiidqNmNz4UHvWJPf
         3MDG11uvYQXETnFEI83TOp4pDgD/jBBteBunyiib/Ve4xyhIVn+WmJNeji0fXlO4P/
         4Lx9QozC+Jb3YdEC/S64GvrM0uirRJxWOh2cIPao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Robinson <pbrobinson@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 093/361] efi/x86: Call efi_parse_options() from efi_main()
Date:   Sun, 11 Nov 2018 14:17:20 -0800
Message-Id: <20181111221632.759756914@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/compressed/eboot.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -738,6 +738,7 @@ efi_main(struct efi_config *c, struct bo
 	struct desc_struct *desc;
 	void *handle;
 	efi_system_table_t *_table;
+	unsigned long cmdline_paddr;
 
 	efi_early = c;
 
@@ -756,6 +757,15 @@ efi_main(struct efi_config *c, struct bo
 		setup_boot_services32(efi_early);
 
 	/*
+	 * make_boot_params() may have been called before efi_main(), in which
+	 * case this is the second time we parse the cmdline. This is ok,
+	 * parsing the cmdline multiple times does not have side-effects.
+	 */
+	cmdline_paddr = ((u64)hdr->cmd_line_ptr |
+			 ((u64)boot_params->ext_cmd_line_ptr << 32));
+	efi_parse_options((char *)cmdline_paddr);
+
+	/*
 	 * If the boot loader gave us a value for secure_boot then we use that,
 	 * otherwise we ask the BIOS.
 	 */


