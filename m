Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34938C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C6820864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C6820864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392650AbeKVSUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:20:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeKVSUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:20:23 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 149C03001921;
        Thu, 22 Nov 2018 07:42:10 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4935527C21;
        Thu, 22 Nov 2018 07:42:05 +0000 (UTC)
Date:   Thu, 22 Nov 2018 15:42:02 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com, x86@kernel.org,
        kexec@lists.infradead.org, mingo@redhat.com, bp@alien8.de,
        tglx@linutronix.de, akpm@linux-foundation.org
Subject: Re: [PATCH 1/2 v7] resource: add the new I/O resource descriptor
 'IORES_DESC_RESERVED'
Message-ID: <20181122074202.GA8524@dhcp-128-65.nay.redhat.com>
References: <20181115095529.21220-1-lijiang@redhat.com>
 <20181115095529.21220-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115095529.21220-2-lijiang@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 22 Nov 2018 07:42:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 at 05:55pm, Lianbo Jiang wrote:
> The upstream kernel can not accurately add the e820 reserved type to
> kdump krenel e820 table.
> 
> Kdump uses walk_iomem_res_desc() to iterate io resources, then adds
> the matched resource ranges to the e820 table for kdump kernel. But,
> when convert the e820 type into the iores descriptor, several e820
> types are converted to 'IORES_DESC_NONE' in this function e820_type
> _to_iores_desc(). So the walk_iomem_res_desc() will get unnecessary
> types(such as E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820_TYPE_KERN) when
> walk through io resources by the descriptor 'IORES_DESC_NONE'.
> 
> This patch adds the new I/O resource descriptor 'IORES_DESC_RESERVED'
> for the iomem resources search interfaces. It is helpful to exactly
> match the reserved resource ranges when walking through iomem resources.
> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
> Changes since v5:
> 1. Improve the patch log
> 
> Changes since v6:
> 1. Modify this patch, and add the new I/O resource descriptor
>    'IORES_DESC_RESERVED' for the iomem resources search interfaces.
> 2. Improve patch log.
> 
>  arch/x86/kernel/e820.c | 2 +-
>  include/linux/ioport.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 50895c2f937d..57fafdafb860 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1048,10 +1048,10 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
>  	case E820_TYPE_NVS:		return IORES_DESC_ACPI_NV_STORAGE;
>  	case E820_TYPE_PMEM:		return IORES_DESC_PERSISTENT_MEMORY;
>  	case E820_TYPE_PRAM:		return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
> +	case E820_TYPE_RESERVED:	return IORES_DESC_RESERVED;
>  	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
>  	case E820_TYPE_RAM:		/* Fall-through: */
>  	case E820_TYPE_UNUSABLE:	/* Fall-through: */
> -	case E820_TYPE_RESERVED:	/* Fall-through: */
>  	default:			return IORES_DESC_NONE;
>  	}
>  }
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index da0ebaec25f0..6ed59de48bd5 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -133,6 +133,7 @@ enum {
>  	IORES_DESC_PERSISTENT_MEMORY_LEGACY	= 5,
>  	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
>  	IORES_DESC_DEVICE_PUBLIC_MEMORY		= 7,
> +	IORES_DESC_RESERVED			= 8,
>  };

There more works for a new iores desc. Originally IORES_DESC_NONE
is assumed to include reserved e820 type so all code path relates to
IORES_DESC_NONE should be carefully checked and ensure they still work after
your changes.

>  
>  /* helpers to define resources */
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave
