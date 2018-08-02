Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2153AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6CB21566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rWva7jnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6CB21566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbeHBUGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:06:03 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3014 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731362AbeHBUGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533233629; x=1564769629;
  h=from:subject:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=nepBBRHcXV01Fl1uFKwqysIvhZZ9nSH4cStDubI5Q5Y=;
  b=rWva7jnRS1/4RLy/p+WOIPTgpypJ0/zkbiQhA+lp1oGFv0bCA4qtEPLx
   5OUJdXS9sscNl/MAXgHP1dqfkOGaWCcssg9q+rQpS7Al4PLyDxiIuaveN
   amzdVnUyIEdPwwhV5l4UAKgvFSxkqcf418VoJ7iviS0W6hlYxzfy0bFXF
   g+Mauxne2HDUY7p9LQO0j8XuWgHrDDWfgLsLjIKw60K8G4xh7xLk6iMPS
   4CLp9ENJOaZphOPoZxS4auCDLX9Sio04l9EwrAwZFSX/DksDsO+tcx7q3
   plu+CjQM81KZU8Sd2aUMJvkB3Uz5ZWWD4QbAnp2UBcHXe76BsJcu5xMme
   g==;
X-IronPort-AV: E=Sophos;i="5.51,436,1526313600"; 
   d="scan'208";a="89727596"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2018 02:13:49 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 02 Aug 2018 11:02:12 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Aug 2018 11:13:49 -0700
From:   Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH] RISC-V: Add preprocessor directives for boot_sec_cpu
To:     Zong Li <zong@andestech.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "greentime@andestech.com" <greentime@andestech.com>
References: <1533223376-10130-1-git-send-email-zong@andestech.com>
Message-ID: <27367ec8-fc26-c678-1883-299a084a5328@wdc.com>
Date:   Thu, 2 Aug 2018 11:13:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533223376-10130-1-git-send-email-zong@andestech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/18 8:23 AM, Zong Li wrote:
> The boot_sec_cpu is for hutplug CPU on SMP system. It should
> be conditional compiling. Otherwise, it causes undefined reference
> to `smp_callin' when compiling uniprocessor kernel.
> 
> Signed-off-by: Zong Li <zong@andestech.com>
> ---
>   arch/riscv/kernel/head.S | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 11066d5..9b6f601 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -154,6 +154,7 @@ END(_start)
>   .section .text
>   .global boot_sec_cpu
>   
> +#ifdef CONFIG_HOTPLUG_CPU
>   boot_sec_cpu:
>   	/* clear all pending flags */
>   	csrw sip, zero
> @@ -162,6 +163,7 @@ boot_sec_cpu:
>   	fence
>   
>   	tail smp_callin
> +#endif
>   
>   __PAGE_ALIGNED_BSS
>   	/* Empty zero page */
> 

Thanks for the fix. If you don't mind, I would like to merge it on top
of my cpu hotplug patch and resubmit together to avoid confusion.


Regards,
Atish

