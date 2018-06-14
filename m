Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 40EC0C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 03:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9E820864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 03:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C0evJZFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9E820864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935976AbeFNDaa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 23:30:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935858AbeFNDa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 23:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b6WsKdtUOFnJJrfLbdKH/eKLJ5e+r5+ABHAtJmdcA0I=; b=C0evJZFwUEuJ+RylN/9XkzcnF
        sxA/Uml++JThVkYdhYH4/GTVALMDeCu2th+sqdQ3bLMiUylTRSaMYXfQORuyQ9RHSUur58en3mrHR
        qXiAa/Mb4oVIXZQlnOZnonJgTfFmvKNOnkqypXvTe+IeWZ9/oI6ZW8IkK+PEDVJMCbAec5TrIME+h
        o94hMfE2yp2FX5GRdHq+yThB8/egW4TVjdo3LRaKYKSlFRXQzqlRxoX7e7R0U3KvA9cJJvjuIpFuT
        G8IB3/TWfZGpXrqXOOgCazoLq+sqifoxUhDyYGJR6o44SmWg4G0DCH507EUTJxN1WZB5rajOsMaXE
        XqlpPPjJw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTIxY-0000bv-DV; Thu, 14 Jun 2018 03:30:04 +0000
Subject: Re: [RFC PATCH 22/23] watchdog/hardlockup/hpet: Only enable the HPET
 watchdog via a boot parameter
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Don Zickus <dzickus@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Babu Moger <babu.moger@oracle.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-23-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <c2edf778-79cf-009d-6617-13e54ad8b93b@infradead.org>
 <20180614005839.GA22358@voyager>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2cde62b1-5218-0169-4f9d-1139f83a25c1@infradead.org>
Date:   Wed, 13 Jun 2018 20:30:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180614005839.GA22358@voyager>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 05:58 PM, Ricardo Neri wrote:
> On Tue, Jun 12, 2018 at 10:26:57PM -0700, Randy Dunlap wrote:
>> On 06/12/2018 05:57 PM, Ricardo Neri wrote:
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index f2040d4..a8833c7 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -2577,7 +2577,7 @@
>>>  			Format: [state][,regs][,debounce][,die]
>>>  
>>>  	nmi_watchdog=	[KNL,BUGS=X86] Debugging features for SMP kernels
>>> -			Format: [panic,][nopanic,][num]
>>> +			Format: [panic,][nopanic,][num,][hpet]
>>>  			Valid num: 0 or 1
>>>  			0 - turn hardlockup detector in nmi_watchdog off
>>>  			1 - turn hardlockup detector in nmi_watchdog on
>>
>> This says that I can use "nmi_watchdog=hpet" without using 0 or 1.
>> Is that correct?
> 
> Yes, this what I meant. In my view, if you set nmi_watchdog=hpet it
> implies that you want to activate the NMI watchdog. In this case, perf.
> 
> I can see how this will be ambiguous for the case of perf and arch NMI
> watchdogs.
> 
> Alternative, a new parameter could be added; such as nmi_watchdog_type. I
> didn't want to add it in this patchset as I think that a single parameter
> can handle the enablement and type of the NMI watchdog.
> 
> What do you think?

I think it's OK like it is.

thanks,
-- 
~Randy
