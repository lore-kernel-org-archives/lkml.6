Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754782AbeDQQsZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:48:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:11680 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753592AbeDQQsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:48:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,464,1517904000";
   d="scan'208";a="32662371"
Subject: Re: 4.17.0-rc1 doesn't boot.
To: Mike Galbraith <efault@gmx.de>, Borislav Petkov <bp@alien8.de>,
        =?UTF-8?Q?J=c3=b6rg_Otte?= <jrg.otte@gmail.com>
References: <CADDKRnAp1EKCAosD-kLNRaJ4qJppUtmmP1n76wzcvNUVa0fQzg@mail.gmail.com>
 <20180417081458.GA2894@pd.tnic>
 <CADDKRnDmycResXxAsfYfM6sFoWffD_v_cMoR4XF7OxUps3mU+Q@mail.gmail.com>
 <20180417142715.GL18640@pd.tnic>
 <CADDKRnBtQKz5S3EdJbrVH8PN9_qTrSQ3owcK=PfxToHdxpu8rA@mail.gmail.com>
 <20180417153101.GB2894@pd.tnic> <1523980839.7093.1.camel@gmx.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <017d65c5-748b-eeae-a020-fa4473f4507c@linux.intel.com>
Date: Tue, 17 Apr 2018 09:48:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523980839.7093.1.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 09:00 AM, Mike Galbraith wrote:
> On Tue, 2018-04-17 at 17:31 +0200, Borislav Petkov wrote:
>> On Tue, Apr 17, 2018 at 05:21:30PM +0200, Jörg Otte wrote:
>>> finished bisection.
>>> 39114b7a743e6759bab4d96b7d9651d44d17e3f9 is the first bad commit
>>> (x86/pti: Never implicitly clear _PAGE_GLOBAL for kernel image).
>>
>> Looks like you're not the only one:
>>
>> http://marc.info/?i=20180417150130.GA11166@ak-laptop.emea.nsn-net.net
> 
> I'm hitting this too, but only with PREEMPT_RT.  I put a bandaid on it
> (tell pti_kernel_image_global_ok() to return true for PREEMPT_RT) while
> waiting to see if it was really really as non-rt as it appeared to be.

It looks like pti_init() is too early for
change_page_attr()/set_memory_nonglobal() because they look for
irqs_off().  This *should* be OK in practice because we only need to
flush the boot CPU, not the others.  That's what ends up causing the
BUG_ON().

But, there's apparently something else going on too because things don't
boot even with that BUG_ON() backed out.

The good news is that its easy to reproduce.
