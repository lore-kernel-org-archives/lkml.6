Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E789C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FD72148C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00FD72148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeJCVEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:04:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:62930 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbeJCVEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:04:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 07:15:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="75093890"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 03 Oct 2018 07:15:37 -0700
Received: from [10.251.17.70] (kliang2-mobl1.ccr.corp.intel.com [10.251.17.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7E0075801E6;
        Wed,  3 Oct 2018 07:15:36 -0700 (PDT)
Subject: Re: [PATCH] perf/x86/intel: Add counter freezing quirk for Goldmont
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        eranian@google.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, x86@kernel.org
References: <1538515812-8808-1-git-send-email-kan.liang@linux.intel.com>
 <alpine.DEB.2.21.1810030803260.1435@nanos.tec.linutronix.de>
 <b3834054-cb2c-2074-7b7d-ad9eb4961a07@linux.intel.com>
 <alpine.DEB.2.21.1810031550550.23677@nanos.tec.linutronix.de>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <a72002d5-be3a-1f51-dc26-ac4e962586d2@linux.intel.com>
Date:   Wed, 3 Oct 2018 10:15:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1810031550550.23677@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/2018 9:55 AM, Thomas Gleixner wrote:
> On Wed, 3 Oct 2018, Liang, Kan wrote:
>> On 10/3/2018 2:10 AM, Thomas Gleixner wrote:
>>> There is another variant of model/stepping micro code verification code in
>>> intel_snb_pebs_broken(). Can we please make this table based and use a
>>> common function? That's certainly not the last quirk we're going to have.
>>>
>>> We already have a table based variant of ucode checking in
>>> bad_spectre_microcode(). It's trivial enough to generalize that.
>>>
>>
>> Sure, I will generalize the bad_spectre_microcode(), rename it to
>> is_bad_intel_microcode(), and move it to
>> arch\x86\kernel\cpu\microcode\intel.c.
> 
> I suggest: is_bad_microcode() and have it in cpu/microcode/core.c unless
> you are claiming that bad microcode() is an intel only feature.
>

Yes, other platforms also have microcode issues.
To make it more generic, I think we also need to extend the struct 
sku_microcode to check vendor and family.
The "model" in struct x86_cpu_id is u16. I will also change "model" and 
"stepping" to u16.

struct sku_microcode {
	u16 vendor;
	u16 family;
	u16 model;
	u16 stepping;
	u32 microcode;
};

Thanks,
Kan
