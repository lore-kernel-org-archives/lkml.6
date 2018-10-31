Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156DFECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D2A2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D2A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbeKADts convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:49:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:32462 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730097AbeKADtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:49:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2018 11:50:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,447,1534834800"; 
   d="scan'208";a="104205132"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga001.fm.intel.com with ESMTP; 31 Oct 2018 11:50:30 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 31 Oct 2018 11:50:30 -0700
Received: from crsmsx152.amr.corp.intel.com (172.18.7.35) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 31 Oct 2018 11:50:30 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.85]) by
 CRSMSX152.amr.corp.intel.com ([169.254.5.46]) with mapi id 14.03.0415.000;
 Wed, 31 Oct 2018 12:50:28 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/fsgsbase/64: Fix the base write helper functions
Thread-Topic: [PATCH] x86/fsgsbase/64: Fix the base write helper functions
Thread-Index: AQHUcHXzyJaeP41KZUe+LIVY1qL3yKU4sc2AgAFnCgA=
Date:   Wed, 31 Oct 2018 18:50:28 +0000
Message-ID: <362EF130-C3AF-4C3B-883E-48DCBC5EA5C3@intel.com>
References: <20181030172719.6753-1-chang.seok.bae@intel.com>
 <CALCETrUddNZYHKgRarNkHANTnahUCtO5o5YrrNfwCqTmFKGefw@mail.gmail.com>
In-Reply-To: <CALCETrUddNZYHKgRarNkHANTnahUCtO5o5YrrNfwCqTmFKGefw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.152.7]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0CBABD93E1AED64AAF70404F928DEC8D@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 30, 2018, at 14:25, Andy Lutomirski <luto@kernel.org> wrote:
> 
> On Tue, Oct 30, 2018 at 10:28 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>> 
>> Factor out the code to change index from x86_fsbase_write_cpu() and
>> x86_gsbase_write_cpu_inactive(). Now the code is located in
>> do_arch_prctl_64().
>> 
> 
>> @@ -359,9 +351,7 @@ unsigned long x86_fsbase_read_task(struct task_struct *task)
>> {
>>        unsigned long fsbase;
>> 
>> -       if (task == current)
>> -               fsbase = x86_fsbase_read_cpu();
>> -       else if (task->thread.fsindex == 0)
>> +       if (task->thread.fsindex == 0)
> 
> I'm okay with this change but, if you do it, please add:
> 
> WARN_ON_ONCE(task == current);
> 
> and make it be in a separate patch.
> 

Okay. Let me unchange those read functions, as it does what is claimed to do.

>>                gsbase = task->thread.gsbase;
>>        else
>>                gsbase = x86_fsgsbase_read_task(task, task->thread.gsindex);
>> @@ -392,12 +380,8 @@ int x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase)
>>        if (unlikely(fsbase >= TASK_SIZE_MAX))
>>                return -EPERM;
>> 
>> -       preempt_disable();
>>        task->thread.fsbase = fsbase;
>> -       if (task == current)
>> -               x86_fsbase_write_cpu(fsbase);
>>        task->thread.fsindex = 0;
> 
> I'm confused.  You're still setting fsindex to zero here.
> 

These task write functions are getting thiner, although I agree
the index update should move out.

> ret = x86_gsbase_write_task(task, arg);
> if (ret == 0) {
>  /* ARCH_SET_GS has always overwritten the index and the base.  Zero
> is the most sensible value to put in the index, and is the only value
> that makes any sense if FSGSBASE is unavailable. */
>  if (task == current)
>    loadseg(GS, 0);
>  else
>    task->thread.gsindex = 0;
> }

Thank you for the clarification. I think writing base  should come right after loadseg().

Chang

