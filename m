Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55645C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2466C2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2466C2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbeLCXHj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:07:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42007 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbeLCXHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:07:39 -0500
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wB3N7SQ0632272
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 3 Dec 2018 15:07:28 -0800
Date:   Mon, 03 Dec 2018 15:07:20 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20181203103811.17056-1-jgross@suse.com>
References: <20181203103811.17056-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] x86/boot: clear rsdp address in boot_params for broken loaders
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
CC:     sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
From:   hpa@zytor.com
Message-ID: <2489CC78-0410-4F0D-9D79-7905868B51BC@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 3, 2018 2:38:11 AM PST, Juergen Gross <jgross@suse.com> wrote:
>In case a broken boot loader doesn't clear its struct boot_params clear
>rsdp_addr in sanitize_boot_params().
>
>This fixes commit e6e094e053af75 ("x86/acpi, x86/boot: Take RSDP
>address from boot params if available") e.g. for the case of a boot via
>systemd-boot.
>
>Fixes: e6e094e053af75 ("x86/acpi, x86/boot: Take RSDP address from boot
>params if available")
>Reported-by: Gunnar Krueger <taijian@posteo.de>
>Tested-by: Gunnar Krueger <taijian@posteo.de>
>Signed-off-by: Juergen Gross <jgross@suse.com>
>---
> arch/x86/include/asm/bootparam_utils.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/arch/x86/include/asm/bootparam_utils.h
>b/arch/x86/include/asm/bootparam_utils.h
>index a07ffd23e4dd..f6f6ef436599 100644
>--- a/arch/x86/include/asm/bootparam_utils.h
>+++ b/arch/x86/include/asm/bootparam_utils.h
>@@ -36,6 +36,7 @@ static void sanitize_boot_params(struct boot_params
>*boot_params)
> 	 */
> 	if (boot_params->sentinel) {
> 		/* fields in boot_params are left uninitialized, clear them */
>+		boot_params->acpi_rsdp_addr = 0;
> 		memset(&boot_params->ext_ramdisk_image, 0,
> 		       (char *)&boot_params->efi_info -
> 			(char *)&boot_params->ext_ramdisk_image);

Isn't this already covered by the memset()? If not, we should extend the memset() to maximal coverage.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
