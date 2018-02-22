Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbeBVT1l (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:27:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:51908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbeBVT1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:27:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57D521784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELv+mgBA2Ul301kXxBxtj0iL/AVF69qGnxTaHLKnVben+2oIW8K4eRqi46NO8yYpE+antD6MXPeuFRU9SQKVh7Q=
MIME-Version: 1.0
In-Reply-To: <ab926942-92a2-de72-68a0-c250e72739f9@intel.com>
References: <151670492223.658225.4605377710524021456.stgit@buzz>
 <151670493255.658225.2881484505285363395.stgit@buzz> <20180221154214.GA4167@bombadil.infradead.org>
 <fff58819-d39d-3a8a-f314-690bcb2f95d7@intel.com> <20180221170129.GB27687@bombadil.infradead.org>
 <20180222065943.GA30681@dhcp22.suse.cz> <20180222122254.GA22703@bombadil.infradead.org>
 <20180222133643.GJ30681@dhcp22.suse.cz> <CALCETrU2c=SzWJCwuqqFuBVkC=nN27_ce4GxweCQXEwPAqnz7A@mail.gmail.com>
 <ab926942-92a2-de72-68a0-c250e72739f9@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 22 Feb 2018 19:27:16 +0000
X-Gmail-Original-Message-ID: <CALCETrUeSgVmjgNsUg+0sAacq_VeHsEPqOkRfHkij4xmADM_5A@mail.gmail.com>
Message-ID: <CALCETrUeSgVmjgNsUg+0sAacq_VeHsEPqOkRfHkij4xmADM_5A@mail.gmail.com>
Subject: Re: Use higher-order pages in vmalloc
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 7:19 PM, Dave Hansen <dave.hansen@intel.com> wrote:
> On 02/22/2018 11:01 AM, Andy Lutomirski wrote:
>> On x86, if you shoot down the PTE for the current stack, you're dead.
>
> *If* we were to go do this insanity for vmalloc()'d memory, we could
> probably limit it to kswapd, and also make sure that kernel threads
> don't get vmalloc()'d stacks or that we mark them in a way to say we
> never muck with them.

How does that help?  We need to make sure that the task whose stack
we're migrating is (a) not running and (b) is not being switched in or
out.  And we have to make sure that there isn't some *other* mm that
has the task's stack in ASID's TLB space.

Maybe we take some lock so the task can't run, then flush the world,
then release the lock.
