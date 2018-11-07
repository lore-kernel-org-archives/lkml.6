Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CB8C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 05:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C3520862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 05:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C3520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeKGOwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 09:52:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbeKGOwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 09:52:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE55687632;
        Wed,  7 Nov 2018 05:23:52 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A5BD68725;
        Wed,  7 Nov 2018 05:23:48 +0000 (UTC)
Date:   Wed, 7 Nov 2018 13:23:45 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        akpm@linux-foundation.org, dyoung@redhat.com
Subject: Re: [PATCH 2/2 v5] x86/kexec_file: add reserved e820 ranges to kdump
 kernel e820 table
Message-ID: <20181107052345.GQ27491@MiWiFi-R3L-srv>
References: <20181107050019.6663-1-lijiang@redhat.com>
 <20181107050019.6663-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107050019.6663-3-lijiang@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 07 Nov 2018 05:23:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/18 at 01:00pm, Lianbo Jiang wrote:
> E820 reserved ranges is useful in kdump kernel, it has been added in
> kexec-tools code.
> 
> One reason is PCI mmconf (extended mode) requires reserved region otherwise
> it falls back to legacy mode, and also outputs the following kernel log.

OK, it falls back to legacy mode, and also output kernel log, except of
these, does it crash kernel? kdump kernel hang? Can we leave it if it
only ouptut kernel log?

> 
> Example:
> ......
> [   19.798354] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> [   19.800653] [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
> [   19.800995] PCI: not using MMCONFIG
> ......
> 
> The correct kernel log is like this:
> ......
> [    0.082649] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> [    0.083610] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
> ......
> 
> Furthermore, when AMD SME kdump support, it needs to map dmi table area
> as decrypted. For normal boot, these ranges sit in e820 reserved ranges,
> thus the early ioremap code naturally map them as decrypted. If it also
> has same e820 reserve setup in kdump kernel then it will just work like
> normal kernel.

Why do we care? If don't fix, what's happening?

Lianbo, for a bug fix, please describe the problems. Then give out the
analysis about root cause. 


> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/kernel/crash.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index ae724a6e0a5f..d3167125800e 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -384,6 +384,10 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>  	walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1, &cmd,
>  			memmap_entry_callback);
>  
> +	cmd.type = E820_TYPE_RESERVED;
> +	walk_iomem_res_desc(IORES_DESC_NONE, 0, 0, -1, &cmd,
> +			   memmap_entry_callback);
> +
>  	/* Add crashk_low_res region */
>  	if (crashk_low_res.end) {
>  		ei.addr = crashk_low_res.start;
> -- 
> 2.17.1
> 
