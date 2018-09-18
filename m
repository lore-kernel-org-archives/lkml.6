Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1CBECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54892146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54892146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbeIRQr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 12:47:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728828AbeIRQr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 12:47:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6FEC7C058CA0;
        Tue, 18 Sep 2018 11:15:21 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5376917101;
        Tue, 18 Sep 2018 11:15:18 +0000 (UTC)
Date:   Tue, 18 Sep 2018 19:15:14 +0800
From:   Dave Young <dyoung@redhat.com>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH 2/2] x86/kexec_file: add reserved e820 ranges to 2nd
 kernel e820 table
Message-ID: <20180918111514.GA29447@dhcp-128-65.nay.redhat.com>
References: <20180918024837.17710-1-lijiang@redhat.com>
 <20180918024837.17710-3-lijiang@redhat.com>
 <20180918032024.GA22528@dhcp-128-65.nay.redhat.com>
 <a89c3f5e-1d6b-c464-730e-8c3a8234a1f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a89c3f5e-1d6b-c464-730e-8c3a8234a1f0@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 18 Sep 2018 11:15:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/18 at 06:20pm, lijiang wrote:
> 在 2018年09月18日 11:20, Dave Young 写道:
> > On 09/18/18 at 10:48am, Lianbo Jiang wrote:
> >> e820 reserved ranges is useful in kdump kernel, we have added this in
> >> kexec-tools code.
> >>
> >> One reason is PCI mmconf (extended mode) requires reserved region
> >> otherwise it falls back to legacy mode.
> >>
> >> When AMD SME kdump support, it needs to map dmi table area as unencrypted.
> >> For normal boot these ranges sit in e820 reserved ranges thus the early
> >> ioremap code naturally map them as unencrypted. So if we have same e820
> >> reserve setup in kdump kernel then it will just work like normal kernel.
> >>
> >> Signed-off-by: Dave Young <dyoung@redhat.com>
> >> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> >> ---
> >>  arch/x86/kernel/crash.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> >> index 3c113e6545a3..db453e9c117b 100644
> >> --- a/arch/x86/kernel/crash.c
> >> +++ b/arch/x86/kernel/crash.c
> >> @@ -384,6 +384,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
> >>  	walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1, &cmd,
> >>  			memmap_entry_callback);
> >>  
> >> +	/* Add all reserved ranges */
> >> +	cmd.type = E820_TYPE_RESERVED;
> >> +	flags = IORESOURCE_MEM;
> > 
> > Lianbo, rethink about this, we will miss other io resource types if only
> > match IORESOURCE_MEM here, can you redo the patch with just using "0"
> > for the passing flags?
> > 
> 
> This patches align on kexec-tools for e820 reserved ranges, if so, the kexec-tools also need to
> be improved for the other type, such as IORESOURCE_IO/BUS/DMA(...), right?

Kexec-tools just go through /proc/iomem "reserved" items and add them
these flags are not visible to it.  So we have done same in kexec-tools.

> 
> I will improve these patches and post v2 tomorrow.

Thanks!
Dave
