Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9033DC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5389821907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qUD230Ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBGWrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:47:21 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:16335 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGWrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549579642; x=1581115642;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=w+SCEwgUybnuONj7QDPg4mrU5sjaWAW5sJxaJQa+js0=;
  b=qUD230AdBJTtwC864CILaeX1AynQQAPbN5R6DTFKdfzBCnK0bNtkdUx2
   fuWjmQEelpZDRKPZX9rMJv1x4SLjk/6AXkpdruKP640k9HYA9iVRyeWQw
   uFJ2yB0DnddNshDATcARxtYyZEqTypvtDiKBDDnnIqIMR+qNGnLnW7NaG
   Yl5gNiFaxtmrpnnz/4gne7k7+ErgjHVrJrm1DSy619VWJ8qptf8TXa27c
   S+nXRdwu8uLFbtxtaLfd9wQUVZIGMszSRNwpCdcCmPp0kQB3OgLTu4tXI
   HlwyXJ//B4KHrdOe04eQixTpO3roUSsNv7WQodApV8N6q6Bm8NAAxuPlO
   w==;
X-IronPort-AV: E=Sophos;i="5.58,345,1544457600"; 
   d="scan'208";a="102523174"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2019 06:47:22 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Feb 2019 14:28:05 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.121]) ([10.196.159.121])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2019 14:47:21 -0800
Subject: Re: [PATCH] arch: riscv: fix logic error in parse_dtb
To:     Andreas Schwab <schwab@suse.de>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "paul@pwsan.com" <paul@pwsan.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
References: <alpine.DEB.2.21.9999.1812171913510.29609@viisi.sifive.com>
 <mvmr2cjy7xx.fsf@suse.de>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <893c55bd-07e1-6ea4-6d67-5d225d9f2db1@wdc.com>
Date:   Thu, 7 Feb 2019 14:47:20 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <mvmr2cjy7xx.fsf@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/19 6:44 AM, Andreas Schwab wrote:
> The function early_init_dt_scan returns true if a DTB was detected.
> 
> Fixes: 8fd6e05c7463 ("arch: riscv: support kernel command line forcing when no DTB passed")
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>   arch/riscv/kernel/setup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 45e9a2f053dc..84f19ca6d88b 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -140,7 +140,7 @@ asmlinkage void __init setup_vm(void)
>   
>   void __init parse_dtb(unsigned int hartid, void *dtb)
>   {
> -	if (!early_init_dt_scan(__va(dtb)))
> +	if (early_init_dt_scan(__va(dtb)))
>   		return;
>   
>   	pr_err("No DTB passed to the kernel\n");
> 

Good catch. I was surprised to see "No DTB passed.." message with rc5.

Reviewed-by: Atish Patra <atish.patra@wdc.com>

Regards,
Atish
