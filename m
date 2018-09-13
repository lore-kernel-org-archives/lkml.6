Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C000C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACEC2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACEC2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeIMNPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:15:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbeIMNPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:15:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7508D3084043;
        Thu, 13 Sep 2018 08:07:20 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-49.ams2.redhat.com [10.36.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CCC7A5D6AA;
        Thu, 13 Sep 2018 08:07:15 +0000 (UTC)
Subject: Re: [PATCH v3] x86/vdso: Handle clock_gettime(CLOCK_TAI) in vDSO
To:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>
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
 <59403142-1073-3926-65dd-ac55ead357b9@redhat.com>
 <alpine.DEB.2.21.1809121623430.9957@nanos.tec.linutronix.de>
 <DEC1E2DC-2D89-4955-81FC-4EDCF3692214@amacapital.net>
From:   Florian Weimer <fweimer@redhat.com>
Message-ID: <0120ea99-fcac-839a-ef8f-1daa74c17bec@redhat.com>
Date:   Thu, 13 Sep 2018 10:07:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <DEC1E2DC-2D89-4955-81FC-4EDCF3692214@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 13 Sep 2018 08:07:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 07:11 PM, Andy Lutomirski wrote:
>> The multiplexer interfaces need much more surgery and talking about futex,
>> we'd need to sit down with quite some people and identify the things they
>> actually care about before just splitting it up and keeping the existing
>> overloaded trainwreck the same.
>>
> There’s also the issue of how much the speedup matters. For futex, maybe a better interface saves 3ns, but a futex syscall is hundreds of ns. clock_gettime() is called at high frequency and can be ~25ns. Saving a few ns is a bigger deal.

My concern is that the userspace system call wrappers currently do not 
know how many arguments the individual operations take and what types 
the arguments have (hence the “type-polymorphic” nature I mentioned). 
This could be a problem for on-stack argument passing (where you might 
read values beyond the end of the stack, and glibc avoids that most of 
the time by having enough cruft on the stack), and for architectures 
which pass pointers and integers in different registers (like some m68k 
ABIs do for the return value).

Thanks,
Florian
