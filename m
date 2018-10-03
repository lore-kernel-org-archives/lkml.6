Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB67C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701EA21470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701EA21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJDBo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:44:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:38216 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbeJDBo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:44:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 11:54:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="94363999"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.135]) ([10.24.14.135])
  by fmsmga004.fm.intel.com with ESMTP; 03 Oct 2018 11:54:49 -0700
Subject: Re: [RFC PATCH 03/10] arch/x86: Re-arrange RDT init code
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "luto@kernel.org" <luto@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "jannh@google.com" <jannh@google.com>,
        "dima@arista.com" <dima@arista.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180924191841.29111-1-babu.moger@amd.com>
 <20180924191841.29111-4-babu.moger@amd.com>
 <09e1f4dc-7882-9bb4-f5a7-e9e7caafee84@intel.com>
 <ec7ea236-adca-246c-2d2a-56dc68a146f8@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <7c971383-1695-7905-603e-99ff5916f691@intel.com>
Date:   Wed, 3 Oct 2018 11:54:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ec7ea236-adca-246c-2d2a-56dc68a146f8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/2/2018 4:41 PM, Moger, Babu wrote:
> On 10/02/2018 02:21 PM, Reinette Chatre wrote:
>> On 9/24/2018 12:19 PM, Moger, Babu wrote:
>>>  static enum cpuhp_state rdt_online;
>>> @@ -866,8 +872,22 @@ static int __init rdt_late_init(void)
>>>  	struct rdt_resource *r;
>>>  	int state, ret;
>>>  
>>> -	if (!get_rdt_resources())
>>> +	/* Run quirks first */
>>> +	rdt_quirks();
>>> +
>>> +	rdt_alloc_capable = get_rdt_alloc_resources();
>>> +	rdt_mon_capable = get_rdt_mon_resources();
>>> +
>>> +	if (!(rdt_alloc_capable || rdt_mon_capable)) {
>>> +		pr_info("RDT allocation or monitoring not detected\n");
>>
>> This function ends with a log entry for every resource discovered. Is
>> this new log entry needed to indicate that such resources have not been
>> found? Could it not just be the absence of the other message?
> 
> As this is relatively new feature, so I added this info message. It helped
> me debug what went wrong. Otherwise, I don't see anything. I can remove it
> if the message is too annoying to the user.

This log entry is made after detection of resources/features supported
by the system. A user would find more information in the
presence/absence of the relevant CPU feature flags in /proc/cpuinfo.

Reinette
