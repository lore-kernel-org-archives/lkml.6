Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCC7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8264F206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8264F206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbeGQJ2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:28:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:5661 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728983AbeGQJ2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:28:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 01:57:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="73419334"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by orsmga001.jf.intel.com with ESMTP; 17 Jul 2018 01:56:04 -0700
Subject: Re: [PATCH V4 3/3] x86: Add entry trampolines to kcore
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <1528289651-4113-1-git-send-email-adrian.hunter@intel.com>
 <1528289651-4113-4-git-send-email-adrian.hunter@intel.com>
 <20180606131631.GD12180@hirez.programming.kicks-ass.net>
 <20180606131946.GF24381@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <90e24c0c-6ec9-f2c0-54af-0a946b05e574@intel.com>
Date:   Tue, 17 Jul 2018 11:54:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180606131946.GF24381@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/18 16:19, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 06, 2018 at 03:16:31PM +0200, Peter Zijlstra escreveu:
>> On Wed, Jun 06, 2018 at 03:54:11PM +0300, Adrian Hunter wrote:
>>> Without program headers for PTI entry trampoline pages, the trampoline
>>> virtual addresses do not map to anything.
>>>
>>
>>>
>>> In addition, entry trampolines all map to the same page.  Represent that by
>>> giving the corresponding program headers in kcore the same offset.
>>>
>>> This has the benefit that, when perf tools uses /proc/kcore as a source for
>>> kernel object code, samples from different CPU trampolines are aggregated
>>> together.  Note, such aggregation is normal for profiling i.e. people want
>>> to profile the object code, not every different virtual address the object
>>> code might be mapped to (across different processes for example).
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>> Acked-by: Andi Kleen <ak@linux.intel.com>
>>> ---
>>>  arch/x86/mm/cpu_entry_area.c | 10 ++++++++++
>>>  fs/proc/kcore.c              |  7 +++++--
>>>  include/linux/kcore.h        | 13 +++++++++++++
>>>  3 files changed, 28 insertions(+), 2 deletions(-)
>>
>> This also adds the KCORE_REMAP functionality, but isn't mentioned at all
>> in the Changelog.
>>
>> Still, looks OK I suppose,
> 
> I can add a note about that,
>  
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Thanks, giving it some more hours and will apply and try to test it.

Any update on this?

