Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754622AbeBGU1L (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:27:11 -0500
Received: from terminus.zytor.com ([65.50.211.136]:53603 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754397AbeBGU1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:27:09 -0500
Subject: Re: [RFC 0/3] x86: Patchable constants
To: Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: the arch/x86 maintainers <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180207145913.2703-1-kirill.shutemov@linux.intel.com>
 <CA+55aFxJO7kDNp6wRnU58Z6-sPbK1SqdzpgLBTAe54mdPjnd=g@mail.gmail.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <8fea57cc-8772-f8b4-3298-91b0de126358@zytor.com>
Date: Wed, 7 Feb 2018 12:20:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFxJO7kDNp6wRnU58Z6-sPbK1SqdzpgLBTAe54mdPjnd=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/18 09:01, Linus Torvalds wrote:
> 
> Look - much smaller code, and register %rcx isn't used at all. And no
> D$ miss on loading that constant (that is a constant depending on
> boot-time setup only).
> 
> It's rather more complex, but it actually gives a much bigger win. The
> code itself will be much better, and smaller.
> 
> The *infrastructure* for the code gets pretty hairy, though.
> 
> The good news is that the patch already existed to at least _some_
> degree. Peter Anvin did it about 18 months ago.
> 
> It was not really pursued all the way because it *is* a lot of extra
> complexity, and I think there was some other hold-up, but he did have
> skeleton code for the actual replacement.
> 
> There was a thread on the x86 arch list with the subject line
> 
>     Disgusting pseudo-self-modifying code idea: "variable constants"
> 
> but I'm unable to actually find the patch. I know there was at least a
> vert early prototype.
> 
> Adding hpa to the cc in the hope that he has some prototype code still
> laying around..
> 

The patchset I have is about 85% complete.  It mostly needs cleanup,
testing, and breaking into reasonable chunks (it got put on the
backburner for somewhat obvious reasons, but I don't think it'll take
very long at all to productize it.)

The main reason I haven't submitted it yet is that I got a bit overly
ambitious and wanted to implement a whole bunch of more complex
subcases, such as 64-bit shifts on a 32-bit kernel.  The win in that
case is actually quite huge, but it is requires data-dependent code
patching and not just immediate patching, which requires augmentation of
the alternatives framework.

	-hpa
