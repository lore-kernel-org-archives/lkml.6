Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83940C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3831820882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3831820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeILTZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:25:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726677AbeILTZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:25:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5498287AA9;
        Wed, 12 Sep 2018 14:20:20 +0000 (UTC)
Received: from oldenburg.str.redhat.com (dhcp-192-212.str.redhat.com [10.33.192.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81E99FA981;
        Wed, 12 Sep 2018 14:20:16 +0000 (UTC)
Subject: Re: [PATCH v3] x86/vdso: Handle clock_gettime(CLOCK_TAI) in vDSO
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180901015935.CCF0B18E20A9@virtux64.softrans.com.au>
 <CALCETrU4PzskO9pE6G4EkXNRRX3Mu7Vvjv1P8XgrfRMdgGDZSg@mail.gmail.com>
 <alpine.DEB.2.21.1809092159440.1402@nanos.tec.linutronix.de>
 <dde36e93-a21b-6223-8ffc-6dd11f687d38@redhat.com>
 <alpine.DEB.2.21.1809121616040.9957@nanos.tec.linutronix.de>
From:   Florian Weimer <fweimer@redhat.com>
Message-ID: <59403142-1073-3926-65dd-ac55ead357b9@redhat.com>
Date:   Wed, 12 Sep 2018 16:20:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809121616040.9957@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 12 Sep 2018 14:20:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 12 Sep 2018 14:20:20 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'fweimer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 04:17 PM, Thomas Gleixner wrote:
> On Wed, 12 Sep 2018, Florian Weimer wrote:
>> On 09/09/2018 10:05 PM, Thomas Gleixner wrote:
>>> See the patch below. It's integrating TAI without slowing down everything
>>> and it definitely does not result in indirect calls.
>>>
>>> On a HSW it slows down clock_gettime() by ~0.5ns. On a SKL I get a speedup
>>> by ~0.5ns. On a AMD Epyc server it's 1.2ns speedup. So it somehow depends
>>> on the uarch and I also observed compiler version dependend variations.
>>
>> Does this mean glibc can keep using a single vDSO entrypoint, the one we
>> have today?
> 
> We have no intention to change that.

Okay, I was wondering because Andy seemed to have proposed just that.

> But we surely could provide separate entry points as an extra to avoid a
> bunch of conditionals.

We could adjust to that, but the benefit would be long-term because it's 
an ABI change for glibc, and they tend to take a long time to propagate.

But I must say that clock_gettime is an odd place to start.  I would 
have expected any of the type-polymorphic multiplexer interfaces (fcntl, 
ioctl, ptrace, futex) to be a more natural starting point. 8-)

Thanks,
Florian
