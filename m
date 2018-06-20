Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6F0C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F96720693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gnz1qF59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F96720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754230AbeFTA0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:26:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36384 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeFTA0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=s1jxS5t8SlPiv2p6YQo4Zl1XKqCgEqKqDt2n4pChhHA=; b=gnz1qF59Vk9nt83esnY5uX/LJL
        yQ+ZrigOv+Wxx9jvRZnzvz5Hex/9mvqNljgaJwaTMnAWcbY43VM+xyGy56q/6oR4txxLs5RuUGPow
        spxgFYBx7squX0fVdoHUoRTjYfxWZdu+EG0jelePCxaI5jL00psxvBSOirKW/m0ztHiOQ5mtiPeQy
        Sm01wmgfRkfch/WwI+LIlQVvUu+nx3WR85UiyXen7qivUhYTK9HTai0wG9pZf0phAZy0Wydz2yRLL
        KRqIs8Pzhrftb2nAJ9r7vbQfH2FMs9jFy94N4F/6wixlahiXMJ89GgLG8OwVYnTbdQlaT4/kYC/LS
        PneH+pyg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVQw0-0003Re-Ky; Wed, 20 Jun 2018 00:25:17 +0000
Subject: Re: [RFC PATCH 17/23] watchdog/hardlockup/hpet: Convert the timer's
 interrupt to NMI
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
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
 <1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1806131128570.2280@nanos.tec.linutronix.de>
 <20180615020314.GA11625@voyager>
 <alpine.DEB.2.21.1806151029210.2079@nanos.tec.linutronix.de>
 <20180616005103.GC6659@voyager>
 <alpine.DEB.2.21.1806161517050.1582@nanos.tec.linutronix.de>
 <20180620001535.GA27531@voyager>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c040d4e7-f33b-9c93-6f5a-6bf960943e36@infradead.org>
Date:   Tue, 19 Jun 2018 17:25:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620001535.GA27531@voyager>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 05:15 PM, Ricardo Neri wrote:
> On Sat, Jun 16, 2018 at 03:24:49PM +0200, Thomas Gleixner wrote:
>> On Fri, 15 Jun 2018, Ricardo Neri wrote:
>>> On Fri, Jun 15, 2018 at 11:19:09AM +0200, Thomas Gleixner wrote:
>>>> On Thu, 14 Jun 2018, Ricardo Neri wrote:
>>>>> Alternatively, there could be a counter that skips reading the HPET status
>>>>> register (and the detection of hardlockups) for every X NMIs. This would
>>>>> reduce the overall frequency of HPET register reads.
>>>>
>>>> Great plan. So if the watchdog is the only NMI (because perf is off) then
>>>> you delay the watchdog detection by that count.
>>>
>>> OK. This was a bad idea. Then, is it acceptable to have an read to an HPET
>>> register per NMI just to check in the status register if the HPET timer
>>> caused the NMI?
>>
>> The status register is useless in case of MSI. MSI is edge triggered ....
>>
>> The only register which gives you proper information is the counter
>> register itself. That adds an massive overhead to each NMI, because the
>> counter register access is synchronized to the HPET clock with hardware
>> magic. Plus on larger systems, the HPET access is cross node and even
>> slower.
> 
> It starts to sound that the HPET is too slow to drive the hardlockup detector.
> 
> Would it be possible to envision a variant of this implementation? In this
> variant, the HPET only targets a single CPU. The actual hardlockup detector
> is implemented by this single CPU sending interprocessor interrupts to the
> rest of the CPUs.
> 
> In this manner only one CPU has to deal with the slowness of the HPET; the
> rest of the CPUs don't have to read or write any HPET registers. A sysfs
> entry could be added to configure which CPU will have to deal with the HPET
> timer. However, profiling could not be done accurately on such CPU.

Please forgive my simple question:

What happens when this one CPU is the one that locks up?

thnx,
-- 
~Randy
