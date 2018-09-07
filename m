Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5F4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CEB2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CEB2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeIGLUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:20:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:15867 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbeIGLUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:20:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 23:40:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,341,1531810800"; 
   d="scan'208";a="260599103"
Received: from unknown (HELO [10.239.13.3]) ([10.239.13.3])
  by fmsmga005.fm.intel.com with ESMTP; 06 Sep 2018 23:40:41 -0700
Message-ID: <5B921E84.4010008@intel.com>
Date:   Fri, 07 Sep 2018 14:45:24 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Andi Kleen <ak@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>
Subject: Re: [PATCH v2 1/8] perf/x86: add a function to get the lbr stack
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com> <1536233456-12173-2-git-send-email-wei.w.wang@intel.com> <20180907032811.GO27886@tassilo.jf.intel.com>
In-Reply-To: <20180907032811.GO27886@tassilo.jf.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 11:28 AM, Andi Kleen wrote:
>> +int perf_get_lbr_stack(struct perf_lbr_stack *stack)
>> +{
>> +	stack->lbr_nr = x86_pmu.lbr_nr;
>> +	stack->lbr_tos = x86_pmu.lbr_tos;
>> +	stack->lbr_from = x86_pmu.lbr_from;
>> +	stack->lbr_to = x86_pmu.lbr_to;
>> +
>> +	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
>> +		stack->lbr_info = MSR_LBR_INFO_0;
>> +	else
>> +		stack->lbr_info = 0;
> Seems weird to export the enum value if the enum isn't exported.
> How can it be used?
>

I'm not sure about the issue. The caller gets the value of 
MSR_LBR_INFO_0 (not the enum, LBR_FORMAT_INFO) only when the hardware 
supports it. If hardware doesn't support it, just sets it to 0, and 
there will be no lbr info msr to be passed through.

Best,
Wei
