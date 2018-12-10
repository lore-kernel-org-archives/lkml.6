Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33C2C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA9E2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA9E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbeLJUvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:51:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:60402 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbeLJUvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:51:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 12:51:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,339,1539673200"; 
   d="scan'208";a="117231463"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.96]) ([10.24.14.96])
  by orsmga002.jf.intel.com with ESMTP; 10 Dec 2018 12:51:35 -0800
Subject: Re: [PATCH] x86/resctrl: Ensure usage of CPUs are locked while needed
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        jithu.joseph@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <725073a1f4448e3c45ed7102229e6946ca2526d8.1543428144.git.reinette.chatre@intel.com>
 <20181210204915.GH5482@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <27626243-cc7d-d289-2ebd-de5c8cc193e2@intel.com>
Date:   Mon, 10 Dec 2018 12:51:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181210204915.GH5482@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 12/10/2018 12:49 PM, Borislav Petkov wrote:
> On Wed, Nov 28, 2018 at 10:22:07AM -0800, Reinette Chatre wrote:
>> The user triggers the creation of a pseudo-locked region when writing
>> the requested schemata to the schemata resctrl file. The pseudo-locking
>> of a region is required to be done on a CPU that is associated with the
>> cache on which the pseudo-locked region will reside. In order to run the
>> locking code on a specific CPU the needed CPU has to be selected and
>> ensured to remain online during the entire locking sequence.
>>
>> At this time the cpu_hotplug_lock is not taken during the pseudo-lock
>> region creation and it is thus possible for a CPU to be selected to run
>> the pseudo-locking code and then that CPU to go offline before the
>> thread is able to run on it.
>>
>> Fix this by ensuring that the cpu_hotplug_lock is taken while the CPU on
>> which code has to run needs to be controlled. Since the cpu_hotplug_lock
>> is always taken before rdtgroup_mutex the lock order is maintained.
>>
>> Fixes: e0bdfe8e36f3 ("x86/intel_rdt: Support creation/removal of pseudo-locked region")
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++++
>>  1 file changed, 4 insertions(+)
> 
> This looks like it wants to go in now, right?

Yes, please.

> 
> If so, pls redo this patch against tip/x86/urgent which has the old
> filenames, before the resctrl rename and reorg.

Will do.

Thank you

Reinette
