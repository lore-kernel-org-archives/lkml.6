Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8975C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E5520848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E5520848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeJZSTr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:19:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46502 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbeJZSTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:19:47 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oGiQcV3wI_D8; Fri, 26 Oct 2018 11:43:24 +0200 (CEST)
Received: from [10.220.194.219] (x2f7fadb.dyn.telefonica.de [2.247.250.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DDAC41EC0786;
        Fri, 26 Oct 2018 11:43:23 +0200 (CEST)
Date:   Fri, 26 Oct 2018 10:43:21 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20181026093630.8520-1-lijiang@redhat.com>
References: <20181026093630.8520-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
To:     Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org
CC:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, bhe@redhat.com, dyoung@redhat.com
From:   Boris Petkov <bp@alien8.de>
Message-ID: <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 26, 2018 10:36:30 AM GMT+01:00, Lianbo Jiang <lijiang@redhat.com> wrote:
>For AMD machine with SME feature, makedumpfile tools need to know
>whether the crash kernel was encrypted or not. 

Why?

> So it is necessary
>to write the sme_me_mask to vmcoreinfo.
>
>Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>---
> arch/x86/kernel/machine_kexec_64.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/arch/x86/kernel/machine_kexec_64.c
>b/arch/x86/kernel/machine_kexec_64.c
>index 4c8acdfdc5a7..dcfdb64d1097 100644
>--- a/arch/x86/kernel/machine_kexec_64.c
>+++ b/arch/x86/kernel/machine_kexec_64.c
>@@ -357,6 +357,8 @@ void arch_crash_save_vmcoreinfo(void)
> 	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
> 			pgtable_l5_enabled());
> 
>+	VMCOREINFO_NUMBER(sme_me_mask);

No we're not going to expose a kernel-internal mask to userspace. 

If at all needed, add functions to kexec which figure out whether we are encrypted or not and export that result as a kexec variable.


-- 
Sent from a small device: formatting sux and brevity is inevitable. 
