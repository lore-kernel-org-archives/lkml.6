Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967209AbeBNKXt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:23:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967123AbeBNKXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:23:47 -0500
Subject: Re: VMs freezing when host is running 4.14
To: Josh Poimboeuf <jpoimboe@redhat.com>,
        Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: =?UTF-8?B?546L6YeR5rWm?= <jinpuwang@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "KVM-ML (kvm@vger.kernel.org)" <kvm@vger.kernel.org>, x86@kernel.org
References: <20171121161821.b6k3hdl3wgia5f5q@torres.zugschlus.de>
 <20171122093945.5afa2di2g7qhf4eb@torres.zugschlus.de>
 <CAD9gYJK7TOnfp+fnAyisYRQf--_TQv8J7h+kWH6KL98xNUH0bA@mail.gmail.com>
 <20171201144358.7yffztjhylfxxytn@torres.zugschlus.de>
 <20180108091025.2sup55jlpzbouo3d@torres.zugschlus.de>
 <20180211133941.gayg52r3bqbtptvm@torres.zugschlus.de>
 <20180214020445.ebu4fhnmogqehunb@treble>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62aa6b81-5456-07dc-cf64-e46747d3a70d@redhat.com>
Date: Wed, 14 Feb 2018 11:23:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180214020445.ebu4fhnmogqehunb@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2018 03:04, Josh Poimboeuf wrote:
> On Sun, Feb 11, 2018 at 02:39:41PM +0100, Marc Haber wrote:
>> Hi,
>>
>> after in total nine weeks of bisecting, broken filesystems, service
>> outages (thankfully on unportant systems), 4.15 seems to have fixed the
>> issue. After going to 4.15, the crashes never happened again.
>>
>> They have, however, happened with each and every 4.14 release I tried,
>> which I stopped doing with 4.14.15 on Jan 28.
>>
>> This means, for me, that the issue is fixed and that I have just wasted
>> nine weeks of time.
>>
>> For you, this means that you have a crippling, data-eating issue in the
>> current long-term releae kernel. I do sincerely hope that I never have
>> to lay my eye on any 4.14 kernel and hope that no major distribution
>> will release with this version.
> 
> I saw something similar today, also in kvm_async_pf_task_wait().  I had
> -tip in the guest (based on 4.16.0-rc1) and Fedora
> 4.14.16-300.fc27.x86_64 on the host.

Hi Josh/Marc,

this is fixed by

    commit 2a266f23550be997d783f27e704b9b40c4010292
    Author: Haozhong Zhang <haozhong.zhang@intel.com>
    Date:   Wed Jan 10 21:44:42 2018 +0800

    KVM MMU: check pending exception before injecting APF
    
    For example, when two APF's for page ready happen after one exit and
    the first one becomes pending, the second one will result in #DF.
    Instead, just handle the second page fault synchronously.
    
    Reported-by: Ross Zwisler <zwisler@gmail.com>
    Message-ID: <CAOxpaSUBf8QoOZQ1p4KfUp0jq76OKfGY4Uxs-Gg8ngReD99xww@mail.gmail.com>
    Reported-by: Alec Blayne <ab@tevsa.net>
    Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

and it will be in 4.14.20.  Unfortunately I only heard about this issue
last week.

Thanks,

Paolo
