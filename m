Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F718C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA392087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qZtn5S8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbfAHKKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:10:14 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48841 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbfAHKKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546942213; x=1578478213;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=1P8JDvo3dAoiLl00jnPlAemozrC3mVJkmqYB5frnj3k=;
  b=qZtn5S8uFWkyfCTxQTb7McGwV5r5CceCH074Vuv3+9xziLNg2aJgikmu
   MkPYQS5i3RsO3u0cojAsD2OMXM5xF3cxIYOdncBsakc9AWLVGVNH2YSCH
   2Kw7/UhwdbYAjxO8RbWm6MSauXB5R8/Ra4PWW77ZAkxMvN/3Rzz40wiXg
   gws8AISHAAYslyirDtA1xDtDJxpta7atUNSmesF08xUjibiWoUJt1HhHJ
   OI8CVNZ+OSOYH0Qo3Bo3yR01p/W1etlh+4SOS5oLsa0NKWjLQ11kHm/XS
   uqwPqfOfgDG9xXvDNUHE7Dav/nZ/tu2GCZ2CH91WqiajjAYnxWStEwoxd
   w==;
X-IronPort-AV: E=Sophos;i="5.56,453,1539619200"; 
   d="scan'208";a="103169116"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2019 18:10:13 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 08 Jan 2019 01:51:46 -0800
Received: from usa003532.ad.shared (HELO [10.86.59.202]) ([10.86.59.202])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Jan 2019 02:10:13 -0800
Subject: Re: [PATCH] RISC-V: fix bad use of of_node_put
To:     Andreas Schwab <schwab@suse.de>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
References: <1542755270-10433-1-git-send-email-atish.patra@wdc.com>
 <mvm8szwwo1o.fsf@suse.de>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <6326f9ba-695d-dc00-1b0c-c37a94c9b485@wdc.com>
Date:   Tue, 8 Jan 2019 02:10:12 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <mvm8szwwo1o.fsf@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 6:16 AM, Andreas Schwab wrote:
> of_find_node_by_type already calls of_node_put, don't call it again.
> 
> Fixes: 94f9bf118f ("RISC-V: Fix of_node_* refcount")
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>   arch/riscv/kernel/smpboot.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index fc185ecabb..18cda0e8cf 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -57,15 +57,12 @@ void __init setup_smp(void)
>   
>   	while ((dn = of_find_node_by_type(dn, "cpu"))) {
>   		hart = riscv_of_processor_hartid(dn);
> -		if (hart < 0) {
> -			of_node_put(dn);
> +		if (hart < 0)
>   			continue;
> -		}
>   
>   		if (hart == cpuid_to_hartid_map(0)) {
>   			BUG_ON(found_boot_cpu);
>   			found_boot_cpu = 1;
> -			of_node_put(dn);
>   			continue;
>   		}
>   
> @@ -73,7 +70,6 @@ void __init setup_smp(void)
>   		set_cpu_possible(cpuid, true);
>   		set_cpu_present(cpuid, true);
>   		cpuid++;
> -		of_node_put(dn);
>   	}
>   
>   	BUG_ON(!found_boot_cpu);
> 
Thanks for catching and fixing this.

Reviewed-by: Atish Patra <atish.patra@wdc.com>

Regards,
Atish
