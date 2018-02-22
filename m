Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbeBVTgQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:36:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:31168 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbeBVTgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:36:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,378,1515484800";
   d="scan'208";a="19693812"
Subject: Re: Use higher-order pages in vmalloc
To: Andy Lutomirski <luto@kernel.org>
References: <151670492223.658225.4605377710524021456.stgit@buzz>
 <151670493255.658225.2881484505285363395.stgit@buzz>
 <20180221154214.GA4167@bombadil.infradead.org>
 <fff58819-d39d-3a8a-f314-690bcb2f95d7@intel.com>
 <20180221170129.GB27687@bombadil.infradead.org>
 <20180222065943.GA30681@dhcp22.suse.cz>
 <20180222122254.GA22703@bombadil.infradead.org>
 <20180222133643.GJ30681@dhcp22.suse.cz>
 <CALCETrU2c=SzWJCwuqqFuBVkC=nN27_ce4GxweCQXEwPAqnz7A@mail.gmail.com>
 <ab926942-92a2-de72-68a0-c250e72739f9@intel.com>
 <CALCETrUeSgVmjgNsUg+0sAacq_VeHsEPqOkRfHkij4xmADM_5A@mail.gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <cf07fba1-a787-9af3-682f-309ac52c9345@intel.com>
Date: Thu, 22 Feb 2018 11:36:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUeSgVmjgNsUg+0sAacq_VeHsEPqOkRfHkij4xmADM_5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 11:27 AM, Andy Lutomirski wrote:
> On Thu, Feb 22, 2018 at 7:19 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>> On 02/22/2018 11:01 AM, Andy Lutomirski wrote:
>>> On x86, if you shoot down the PTE for the current stack, you're dead.
>>
>> *If* we were to go do this insanity for vmalloc()'d memory, we could
>> probably limit it to kswapd, and also make sure that kernel threads
>> don't get vmalloc()'d stacks or that we mark them in a way to say we
>> never muck with them.
> 
> How does that help?  We need to make sure that the task whose stack
> we're migrating is (a) not running and (b) is not being switched in or
> out.  And we have to make sure that there isn't some *other* mm that
> has the task's stack in ASID's TLB space.
> 
> Maybe we take some lock so the task can't run, then flush the world,
> then release the lock.

Oh, I was thinking only of the case where you try to muck with your
*own* stack.  But, I see what you are saying about doing it to another
task on another CPU that is actively using the stack.

I think what you're saying is that we do not want to handle faults that
are caused by %esp being unusable.  Whatever we do, we've got to make
sure that no CPU has a stack in %esp that we are messing with.
