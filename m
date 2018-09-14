Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCA6ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889B020861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889B020861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeINOgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:36:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:23369 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbeINOgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:36:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 02:22:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,372,1531810800"; 
   d="scan'208";a="70800156"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 14 Sep 2018 02:22:40 -0700
Received: from [10.125.251.160] (abudanko-mobl.ccr.corp.intel.com [10.125.251.160])
        by linux.intel.com (Postfix) with ESMTP id D2F6658053F;
        Fri, 14 Sep 2018 02:22:37 -0700 (PDT)
Subject: Re: [PATCH] perf/x86/intel/lbr: Optimize context switches for LBR
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel-owner@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, Kan Liang <kan.liang@linux.intel.com>
References: <1536869331-63561-1-git-send-email-kan.liang@linux.intel.com>
 <dec78c67-0631-c4a7-95e1-4b931ce9ecd7@linux.intel.com>
 <20180914085409.GA27886@tassilo.jf.intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <529b2498-0515-e33c-ebcc-af2a5ca7d974@linux.intel.com>
Date:   Fri, 14 Sep 2018 12:22:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914085409.GA27886@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andi,

On 14.09.2018 11:54, Andi Kleen wrote:
>>> In principle the LBRs need to be flushed between threads. So does
>>> current code.
>>
>> IMHO, ideally, LBRs stack would be preserved and restored when 
>> switching between execution stacks. That would allow implementing 
>> per-thread statistical call graph view in Perf tools, fully based 
>> on HW capabilities. It could be advantageous for some cases, in 
>> comparison with traditional dwarf based call graph. 
> 
> This is already supported when you use LBR call stack mode
> (perf record --call-graph lbr)

Which kernel versions does it make sense to try?

Thanks,
Alexey

> 
> This change is only optimizing the case when call stack mode is not used.
> 
> Of course in call stack mode the context switch overhead is even higher,
> because it not only writes, but also reads.
> 
> -Andi
> 
