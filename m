Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA9CECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B0921570
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwZuEh+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B0921570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeI0PIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:08:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44391 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeI0PIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:08:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so1639985wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AsXgWn/5EH4o89e3p8kGpDNY5N+XM/ydDKBocV+pJDQ=;
        b=VwZuEh+HHm/qu9eI3ww/1j57RkEa2/295JWTMV2PmQIwqDtmgBXcFmr8Av4NUrpNI9
         plP/GvIoxmKqZ1VG671jDKl06ckGuNDV5Ijp3LpRD7WF3nk9R9i7Sbw/nQMlpyTki1Gv
         Mzz5dxJteq2vM4AbVJMmAUFJ3Iqe+nMPYDOuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AsXgWn/5EH4o89e3p8kGpDNY5N+XM/ydDKBocV+pJDQ=;
        b=pa2guMAuQTRvvVsjKsPQXME+QR/hJFUjLQLbDF9rZQ2rg2P3LqwNDx7MzXYoBdr6q1
         Dui6MwFOG5fpth7gmqqlvw9h0RNxcukbTxC6xvm5cq4lKwOP3lmuV6Bnp6wrX3QTn0Eh
         n/sxyqzZ4EEINcR8z6fC3FUSeX7UtQwKdHRZDJsQI0b3ARsEpONwjJXPolDThKuHV9ov
         XWm0RJKm9bnx6pTUibhne0P+wtM/H9FIyCx7qjLqHbKwd/eT4JiwSH51m4/X71fU8Bzk
         fEfeqvYbJvG9qrbGdtaeYE4VndUAil9OdRu+Y37LecLV33SpQ0q/RdQA73oxcYyUg51a
         Gw3Q==
X-Gm-Message-State: ABuFfojmQqLMAN6kfKUQ2AwtgS+Q9X5bLLCDTZ7R0zhcNdzmiC4Q3oEV
        5TzUA8PCKj7HY3dDvJBqIGNWYEU5K48=
X-Google-Smtp-Source: ACcGV63B66v8YM8XuBmSnbEbWa36TWdZjYWX8uT1h9jI6Yr8LKiGTuu8s2EXdLAz5GInilZWqaa/xg==
X-Received: by 2002:a5d:50cf:: with SMTP id f15-v6mr8271923wrt.128.1538038270936;
        Thu, 27 Sep 2018 01:51:10 -0700 (PDT)
Received: from rev03.home ([2a01:cb1d:112:6f00:546e:3c44:5966:2f5e])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1304055wrd.74.2018.09.27.01.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 01:51:10 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Alistair Strachan <astrachan@google.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ivan Hu <ivan.hu@canonical.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Robinson <pbrobinson@redhat.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 10/11] efi/x86: Call efi_parse_options() from efi_main()
Date:   Thu, 27 Sep 2018 10:50:37 +0200
Message-Id: <20180927085039.8391-11-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
References: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

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
2.18.0

