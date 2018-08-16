Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6E9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 03:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5902098B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 03:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5902098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbeHPGDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 02:03:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:27714 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbeHPGDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 02:03:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2018 20:08:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,245,1531810800"; 
   d="scan'208";a="81741934"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.4]) ([10.239.13.4])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2018 20:08:26 -0700
Subject: Re: [LKP] a13c600e15 ("x86/mm/pti: Move user W+X check into .."):
 WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:283 note_page
To:     Joerg Roedel <jroedel@suse.de>, kernel test robot <lkp@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, LKP <lkp@01.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
References: <5b6cc146.lVmfvLKHKgZxC5d8%lkp@intel.com>
 <20180810083504.55pljlr733lctz5k@suse.de>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <f867895e-24c8-7c4d-869c-8cdfb1e0e82d@intel.com>
Date:   Thu, 16 Aug 2018 11:08:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180810083504.55pljlr733lctz5k@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/10/2018 04:35 PM, Joerg Roedel wrote:
> On Fri, Aug 10, 2018 at 06:33:42AM +0800, kernel test robot wrote:
>> commit a13c600e15de44ccf03df28d3311ef3cb754ed9b
>> Author:     Joerg Roedel <jroedel@suse.de>
>> AuthorDate: Wed Aug 8 13:16:40 2018 +0200
>> Commit:     Thomas Gleixner <tglx@linutronix.de>
>> CommitDate: Thu Aug 9 20:42:07 2018 +0200
>>
>>      x86/mm/pti: Move user W+X check into pti_finalize()
> Okay, I found the problem and the diff below fixes it.
The patch works well.
Tested-by: kernel test robot <rong.a.chen@intel.com>

>
> Ingo, Thomas, can you fold that diff into above commit or do you prefer
> a separate patch?
>
> Thanks and sorry for the hassle,
>
>
>         Joerg
>
> diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
> index 026a89aa16d7..d1435c78ae4f 100644
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -629,5 +629,6 @@ void pti_finalize(void)
>   	pti_clone_entry_text();
>   	pti_clone_kernel_text();
>   
> -	debug_checkwx_user();
> +	if (__supported_pte_mask & _PAGE_NX)
> +		debug_checkwx_user();
>   }
> _______________________________________________
> LKP mailing list
> LKP@lists.01.org
> https://lists.01.org/mailman/listinfo/lkp

