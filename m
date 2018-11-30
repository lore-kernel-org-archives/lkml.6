Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80505C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F28020666
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F28020666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeK3Otg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:49:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbeK3Otg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:49:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 66B8930024E2;
        Fri, 30 Nov 2018 03:41:44 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-100.pek2.redhat.com [10.72.12.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C3427C82C;
        Fri, 30 Nov 2018 03:41:33 +0000 (UTC)
Date:   Fri, 30 Nov 2018 11:41:29 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, linux-ia64@vger.kernel.org,
        linux-efi@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        ard.biesheuvel@linaro.org, tony.luck@intel.com,
        fenghua.yu@intel.com, bhe@redhat.com
Subject: Re: [PATCH 1/2 v8] resource: add the new I/O resource descriptor
 'IORES_DESC_RESERVED'
Message-ID: <20181130034129.GA26791@dhcp-128-65.nay.redhat.com>
References: <20181129080956.20776-1-lijiang@redhat.com>
 <20181129080956.20776-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129080956.20776-2-lijiang@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 30 Nov 2018 03:41:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/18 at 04:09pm, Lianbo Jiang wrote:
> When doing kexec_file_load, the first kernel needs to pass the e820
> reserved ranges to the second kernel. But kernel can not exactly
> match the e820 reserved ranges when walking through the iomem resources
> with the descriptor 'IORES_DESC_NONE', because several e820 types(
> e.g. E820_TYPE_RESERVED_KERN/E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820
> _TYPE_RESERVED) are converted to the descriptor 'IORES_DESC_NONE'. It
> may pass these four types to the kdump kernel, that is not desired result.
> 
> So, this patch adds a new I/O resource descriptor 'IORES_DESC_RESERVED'
> for the iomem resources search interfaces. It is helpful to exactly
> match the reserved resource ranges when walking through iomem resources.
> 
> In addition, since the new descriptor 'IORES_DESC_RESERVED' is introduced,
> these code originally related to the descriptor 'IORES_DESC_NONE' need to
> be updated. Otherwise, it will be easily confused and also cause some
> errors. Because the 'E820_TYPE_RESERVED' type is converted to the new
> descriptor 'IORES_DESC_RESERVED' instead of 'IORES_DESC_NONE', it has been
> changed.
> 
> Suggested-by: Dave Young <dyoung@redhat.com>

This was suggested by Boris instead :) 

> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/ia64/kernel/efi.c |  4 ++++
>  arch/x86/kernel/e820.c |  2 +-
>  arch/x86/mm/ioremap.c  | 13 ++++++++++++-
>  include/linux/ioport.h |  1 +
>  kernel/resource.c      |  6 +++---
>  5 files changed, 21 insertions(+), 5 deletions(-)
> 
> 
[snip]

Thanks
Dave
