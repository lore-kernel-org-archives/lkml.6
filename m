Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751043AbeC2ASA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 20:18:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:13538 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbeC2AR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 20:17:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,374,1517904000";
   d="scan'208";a="212171952"
Subject: Re: [PATCH 00/11] Use global pages with PTI
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
References: <20180323174447.55F35636@viggo.jf.intel.com>
 <CA+55aFwEC1O+6qRc35XwpcuLSgJ+0GP6ciqw_1Oc-msX=efLvQ@mail.gmail.com>
 <be2e683c-bf0a-e9ce-2f02-4905f6bd56d3@linux.intel.com>
 <alpine.DEB.2.21.1803271526260.1964@nanos.tec.linutronix.de>
 <c0e7ca0b-dcb5-66e2-9df6-f53e4eb22781@linux.intel.com>
 <alpine.DEB.2.21.1803271949250.1618@nanos.tec.linutronix.de>
 <20180327200719.lvdomez6hszpmo4s@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        the arch/x86 maintainers <x86@kernel.org>, namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <0d6ea030-ec3b-d649-bad7-89ff54094e25@linux.intel.com>
Date: Wed, 28 Mar 2018 17:17:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327200719.lvdomez6hszpmo4s@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2018 01:07 PM, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
>>> systems.  Atoms are going to be the easiest thing to get my hands on,
>>> but I tend to shy away from them for performance work.
>> What I have in mind is that I wonder whether the whole circus is worth it
>> when there is no performance advantage on PCID systems.

I was waiting on trying to find a relatively recent Atom system (they
actually come in reasonably sized servers [1]), but I'm hitting a snag
there, so I figured I'd just share a kernel compile using Ingo's
perf-based methodology on a Skylake desktop system with PCIDs.  Here's
the kernel compile:

No Global pages (baseline): 186.951 seconds time elapsed  ( +-  0.35% )
28 Global pages (this set): 185.756 seconds time elapsed  ( +-  0.09% )
                             -1.195 seconds (-0.64%)

Lower is better here, obviously.

I also re-checked everything using will-it-scale's llseek1 test[2] which
is basically a microbenchmark of a halfway reasonable syscall.  Higher
here is better.

No Global pages (baseline): 15783951 lseeks/sec
28 Global pages (this set): 16054688 lseeks/sec
			     +270737 lseeks/sec (+1.71%)

So, both the kernel compile and the microbenchmark got measurably faster.

1.
https://ark.intel.com/products/97933/Intel-Atom-Processor-C3955-16M-Cache-up-to-2_40-GHz
2.
https://github.com/antonblanchard/will-it-scale/blob/master/tests/lseek1.c
