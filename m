Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0252EC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F292168C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F292168C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeHHQXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:23:45 -0400
Received: from mout.gmx.net ([212.227.15.19]:41505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbeHHQXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:23:44 -0400
Received: from homer.simpson.net ([185.191.219.117]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQR3s-1fLnVV46Um-00ToOo; Wed, 08
 Aug 2018 16:03:46 +0200
Message-ID: <1533737025.4936.3.camel@gmx.de>
Subject: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
From:   Mike Galbraith <efault@gmx.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Wed, 08 Aug 2018 16:03:45 +0200
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4OaRbMUNKdS5N6WT2mWHkplEklvl+JbA1gUyE+r0CkYNxXCtz8m
 qLlp3WAWBO4p9IyZnB3pYdHIJjQ+dFlw1CxXwREwpMIhsq9vaWYTSlw4LtO2o+QPy0pZq4l
 e/xHJh6k2+BTTcMSebyPkcU9/3Y0jOVPPTZtiwbW9aCb7KM9cScNtucbBYjKle0ZwchS6+J
 yQNFaNmccM/yveQBXS9CQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qQAFQZwn6q0=:x0AAeCcvBMhY7kcrlFszs9
 kKvAbZHzreL5ERUVDQhiscQFPPLPAcWKCCISGzmi2rAh+j3xvq/e3m8QmVn967PwFgKTNWaV5
 ThvS3VOHuHr3npygQr1NDPgEH26zjsmkj8ucSiHbJbHtcbueBsK43LdaG+R1+cDbyKGl38A37
 W6XwWbX/aTRaF+5xK+ufMIim0vHyhIv89GNPAkgY7VkA4HaYrKlfNOIMplFiCpP6KAEVKG6q5
 l0aNXnNhs2n6xuK8Z601ADp/OyLyvnJNsNtpZYUUN9nIPA3QD50LRDUoj7p1wQ9VZKAjDNQ+Y
 cgFu91Si7i9zo23Etq3kPn98py3MgDcN/Ef9gJOQ1KcH1dezOo2K2nIos6M3v69qT2UYerHgr
 TBao0BZ/EwbtwNU55jTseIZhUQWaHTyqIHo+tlJtLYO4actNEq29l9YkiB4/19lH/6Z5n72Yw
 I5Kcn7+TPHJyaeA0jEq3RR3IY5lFSdB5rQRmOKoOcrvMuVgfK1rgBubYzW0cCeU8peN27ViWl
 At2sMdNolbL0nxCyZApzwhO+Ugkz8kvEN8xK5tQNtzhLHCXHLvA0Mdh+FwGf2PJfsxIY1ypxn
 wsjXoVKxUwTXJxx7tXfE7XkiPlGpfWOGCUg8/oI1NnGgS2xm+fzZv1xVc/5NiiHzQv9f/h62W
 IfOuK1MhZDeHoljD8ocKcxAMwSeR/zdaxSvvfQq7QNLQkpK8zIyoBgpp4wL8d2wpszDk07ARh
 W+2oqnOzjyQh7nVIRBcS8tPL1ZaX2bCDssk5Z2R6ZI4IZA3/l8Lbn2qK/P/TwjPgJ8o1wYg1y
 wICxOTg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting with efi=noruntime, we call efi_runtime_map_copy() while
loading the kdump kernel, and trip over a NULL efi.memmap.map.  Avoid
that and a useless allocation when the only mapping we can use (1:1)
is not available.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 arch/x86/kernel/kexec-bzimage64.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -122,9 +122,6 @@ static int setup_efi_info_memmap(struct
 	unsigned long efi_map_phys_addr = params_load_addr + efi_map_offset;
 	struct efi_info *ei = &params->efi_info;
 
-	if (!efi_map_sz)
-		return 0;
-
 	efi_runtime_map_copy(efi_map, efi_map_sz);
 
 	ei->efi_memmap = efi_map_phys_addr & 0xffffffff;
@@ -176,7 +173,7 @@ setup_efi_state(struct boot_params *para
 	 * acpi_rsdp=<addr> on kernel command line to make second kernel boot
 	 * without efi.
 	 */
-	if (efi_enabled(EFI_OLD_MEMMAP))
+	if (efi_enabled(EFI_OLD_MEMMAP) || !efi_enabled(EFI_MEMMAP))
 		return 0;
 
 	ei->efi_loader_signature = current_ei->efi_loader_signature;
@@ -338,7 +335,7 @@ static void *bzImage64_load(struct kimag
 	struct kexec_entry64_regs regs64;
 	void *stack;
 	unsigned int setup_hdr_offset = offsetof(struct boot_params, hdr);
-	unsigned int efi_map_offset, efi_map_sz, efi_setup_data_offset;
+	unsigned int efi_map_offset = 0, efi_map_sz = 0, efi_setup_data_offset = 0;
 	struct kexec_buf kbuf = { .image = image, .buf_max = ULONG_MAX,
 				  .top_down = true };
 	struct kexec_buf pbuf = { .image = image, .buf_min = MIN_PURGATORY_ADDR,
@@ -397,19 +394,22 @@ static void *bzImage64_load(struct kimag
 	 * have to create separate segment for each. Keeps things
 	 * little bit simple
 	 */
-	efi_map_sz = efi_get_runtime_map_size();
 	params_cmdline_sz = sizeof(struct boot_params) + cmdline_len +
 				MAX_ELFCOREHDR_STR_LEN;
 	params_cmdline_sz = ALIGN(params_cmdline_sz, 16);
-	kbuf.bufsz = params_cmdline_sz + ALIGN(efi_map_sz, 16) +
-				sizeof(struct setup_data) +
-				sizeof(struct efi_setup_data);
+	kbuf.bufsz = params_cmdline_sz + sizeof(struct setup_data);
+
+	/* Now add space for the efi stuff if we have a useable 1:1 mapping. */
+	if (!efi_enabled(EFI_OLD_MEMMAP) && efi_enabled(EFI_MEMMAP)) {
+		efi_map_sz = efi_get_runtime_map_size();
+		kbuf.bufsz += ALIGN(efi_map_sz, 16) + sizeof(struct efi_setup_data);
+		efi_map_offset = params_cmdline_sz;
+		efi_setup_data_offset = efi_map_offset + ALIGN(efi_map_sz, 16);
+	}
 
 	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
 	if (!params)
 		return ERR_PTR(-ENOMEM);
-	efi_map_offset = params_cmdline_sz;
-	efi_setup_data_offset = efi_map_offset + ALIGN(efi_map_sz, 16);
 
 	/* Copy setup header onto bootparams. Documentation/x86/boot.txt */
 	setup_header_size = 0x0202 + kernel[0x0201] - setup_hdr_offset;
