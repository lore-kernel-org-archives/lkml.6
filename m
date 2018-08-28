Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27301C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA460208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA460208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeH1Kyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 06:54:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:18275 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbeH1Kyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 06:54:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 00:04:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,298,1531810800"; 
   d="scan'208";a="66525402"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.137]) ([10.237.72.137])
  by fmsmga008.fm.intel.com with ESMTP; 28 Aug 2018 00:04:35 -0700
Subject: Re: Removing entry trampoline and associated reversions
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <CALCETrWqg82HxGEa6Locag=M6ytgOamvRyG96dT+Hqm2QwZ3pg@mail.gmail.com>
 <CALCETrVNUd3YahKEjF3mwNMz-zfp9AdvK+OV8uEvSyrX9TPymA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <03bee514-277e-a077-ada0-41a3aa67dd04@intel.com>
Date:   Tue, 28 Aug 2018 10:02:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALCETrVNUd3YahKEjF3mwNMz-zfp9AdvK+OV8uEvSyrX9TPymA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/18 19:42, Andy Lutomirski wrote:
> [gah -- accidentally hit send]
> 
> On Mon, Aug 27, 2018 at 9:42 AM, Andy Lutomirski <luto@kernel.org> wrote:
>> Hi all-
>>
>> We had an unfortunate conflict.  Adrian did all the plumbing to get
>> entry_trampoline to play nicelyh with kcore and perf.  Meanwhile, I
>> was working on getting rid of the entry trampoline.  Adrian's code is
>> merged and mine is finally in good shape, and there's an obvious
>> conflict.
>>
>> So I did a bunch of reverts, all but one of which were clean.  The
>> series is here:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/pti

We are kind of stuck with the 'perf tools' changes as they are.  That is
because CONFIG_KASAN changes the size of the cpu entry area, which means
that the kernel patches are still potentially useful for kernels from v4.15
to v4.19 incl., which in turn means we still need 'perf tools' support for them.

If we didn't want to support that, we still need the tools workaround that
hard-codes the trampoline addresses for v4.15 to v4.19.  And possibly we
would need to ensure perf.data files (and copies of kcore) with trampoline
maps recorded, are still handled correctly.

>>
>> and the messy revert is here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/pti&id=50ef6380e448650b48db979d7d1f20a325b0a273

Should be able to get rid of KCORE_REMAP and kcore_list.vaddr also.

> 
> Is this the right approach?
> 

You could leave the tools changes to me if you want.
