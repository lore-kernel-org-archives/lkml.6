Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E16DECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61C220870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61C220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeGPO5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:57:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:61923 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbeGPO5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:57:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 07:29:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,361,1526367600"; 
   d="scan'208";a="73176973"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 16 Jul 2018 07:29:54 -0700
Received: from [10.252.208.117] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E138158013E;
        Mon, 16 Jul 2018 07:29:52 -0700 (PDT)
Subject: Re: [PATCH] [RESEND] perf/x86/intel/uncore: Fix the index of PCU.3
 Broadwell CPUs
To:     Ingo Molnar <mingo@kernel.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Kan Liang <kan.liang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
References: <20180710233158.21037-1-msys.mizuma@gmail.com>
 <20180715223444.GA16209@gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <7d97606b-67b6-4eb7-48ca-99250edc3fba@linux.intel.com>
Date:   Mon, 16 Jul 2018 10:29:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180715223444.GA16209@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/2018 6:34 PM, Ingo Molnar wrote:
> 
> * Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> 
>> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>>
>> commit 15a3e845b01c ("perf/x86/intel/uncore: Fix SBOX support for
>> Broadwell CPUs") introduced PCU.3 for Broadwell CPU. Unfortunately,
>> the driver_data of PCU.3 conflicts to QPI Port 2 filter.
>>
>>      { /* QPI Port 2 filter  */
>>              PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f46),
>>              .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 2),
>>
>>      { /* PCU.3 (for Capability registers) */
>>              PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),
>>              .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
>>                                                 HSWEP_PCI_PCU_3),
>>                               // HSWEP_PCI_PCU_3 == 2
> 
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -1030,6 +1030,7 @@ enum {
>>   	SNBEP_PCI_QPI_PORT0_FILTER,
>>   	SNBEP_PCI_QPI_PORT1_FILTER,
>>   	HSWEP_PCI_PCU_3,
>> +	BDX_PCI_PCU_3,
>>   };
> 
> So we use a magic '2' enumerator in the 'QPI Port 2 filter', and that overlaps
> with HSWEP_PCI_PCU_3, right?
> 
> Shouldn't we clean up all the enumerators and not use magic numbers, and this fix
> the conflict?
>

Yes, it should fix the conflict. I will clean up the code.

Thanks,
Kan


> Thanks,
> 
> 	Ingo
> 
