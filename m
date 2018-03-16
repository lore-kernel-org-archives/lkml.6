Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbeCPPS4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 11:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751665AbeCPPSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 11:18:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A318F217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AG47ELsYpX4tzir0OnzXfpowwHP61oJiyyalLF8LQT5hK/ohDevgshuSY5pUCN4DjT1Fvrs8ps8ac4JVDJMZIVmOO80=
MIME-Version: 1.0
In-Reply-To: <4d5dc903-0e88-e1b9-9761-43a84865c45b@monstr.eu>
References: <20180309125106.GA1644@salem.gmr.ssr.upm.es> <CAL_JsqLenrLARsjHvkkL3ByuXARPShz-VAEBDE2FukJc=vD+Sg@mail.gmail.com>
 <20180312075252.GA15895@salem.gmr.ssr.upm.es> <242c2823-258b-d3bb-cd0a-e4eee6b979c6@monstr.eu>
 <4d5dc903-0e88-e1b9-9761-43a84865c45b@monstr.eu>
From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Mar 2018 10:18:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLY5+Za_TjxyoH_ozoi8S-6L47eZ94W8qdV9DsO4HLXHw@mail.gmail.com>
Message-ID: <CAL_JsqLY5+Za_TjxyoH_ozoi8S-6L47eZ94W8qdV9DsO4HLXHw@mail.gmail.com>
Subject: Re: Bug: Microblaze stopped booting after 0fa1c579349fdd90173381712ad78aa99c09d38b
To: Michal Simek <monstr@monstr.eu>
Cc: "Alvaro G. M." <alvaro.gamez@hazent.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 10:04 AM, Michal Simek <monstr@monstr.eu> wrote:
> On 12.3.2018 11:21, Michal Simek wrote:
>> On 12.3.2018 08:52, Alvaro G. M. wrote:
>>> On Fri, Mar 09, 2018 at 01:05:11PM -0600, Rob Herring wrote:
>>>> On Fri, Mar 9, 2018 at 6:51 AM, Alvaro G. M. <alvaro.gamez@hazent.com> wrote:
>>>>> Hi,
>>>>>
>>>>> I've found via git bisect that 0fa1c579349fdd90173381712ad78aa99c09d38b
>>>>> makes microblaze unbootable.
>>>>>
>>>>> I'm sorry I can't provide any console output, as nothing appears at all,
>>>>> even when setting earlyprintk (or at least I wasn't able to get anything
>>>>> back!).
>>>>
>>>> Ah, looks like microblaze doesn't set CONFIG_NO_BOOTMEM and so
>>>> memblock_virt_alloc() doesn't work for CONFIG_HAVE_MEMBLOCK &&
>>>> !CONFIG_NO_BOOTMEM. AFAICT, microblaze doesn't really need bootmem and
>>>> it can be removed, but I'm still investigating. Can you try out this
>>>> branch[1].
>>>>
>>>> Rob
>>>>
>>>> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
>>>> microblaze-fixes
>>>
>>> Hi, Rob!
>>>
>>> This branch does indeed solve the issue. My microblaze system is now
>>> booting as it did before, and everything seems normal now. Thanks!
>>>
>>> Tested-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
>>>
>>
>> I have tested it and I can also confirm that your two patches are fixing
>> issue with
>>
>> 809d0e2c: 00240034 26000000 746f6f62 206d656d    4.$....&bootmem
>> 809d0e3c: 6f6c6c61 666f2063 33353220 62203830    alloc of 25308 b
>> 809d0e4c: 73657479 69616620 2164656c 00000000    ytes failed!....
>> 809d0e5c: 00000000 0029003c 06000000 6e72654b    ....<.).....Kern
>> 809d0e6c: 70206c65 63696e61 6e202d20 7320746f    el panic - not s
>>
>> Can you please update that second commit with reasonable description and
>> send it out? I will take it via my tree and will send pull request to Linus.
>>
>
> I couldn't wait to fix current issue till 4.16 is done that's why I have
> sent that patches with updated commit message to lkml.

Thanks for writing my commit msg. :) I got distracted looking at
whether other arches got broken too and didn't get this sent out.

BTW, there is a more simple fix of just moving setup_memory() call to
before unflattening if you prefer for 4.16.

Rob
