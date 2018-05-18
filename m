Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753087AbeERJT4 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:19:56 -0400
Received: from smtp-out6.electric.net ([192.162.217.189]:51807 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeERJTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:19:49 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Nadav Amit'" <namit@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC: "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH 0/6] Macrofying inline assembly for better compilation
Thread-Topic: [PATCH 0/6] Macrofying inline assembly for better compilation
Thread-Index: AQHT7jb3bgwHyh+4Jkuhj2LenJssC6Q1Njbg
Date: Fri, 18 May 2018 09:20:40 +0000
Message-ID: <8737d8d4c7e84c47938e9b1aaeae16b9@AcuMS.aculab.com>
References: <20180517161402.78089-1-namit@vmware.com>
In-Reply-To: <20180517161402.78089-1-namit@vmware.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit
> Sent: 17 May 2018 17:14
> This patch-set deals with an interesting yet stupid problem: kernel code
> that does not get inlined despite its simplicity. There are several
> causes for this behavior: "cold" attribute on __init, different function
> optimization levels; conditional constant computations based on
> __builtin_constant_p(); and finally large inline assembly blocks.
> 
> This patch-set deals with the inline assembly problem. I separated these
> patches from the others (that were sent in the RFC) for easier
> inclusion.
> 
> The problem with inline assembly is that inline assembly is often used
> by the kernel for things that are other than code - for example,
> assembly directives and data. GCC however is oblivious to the content of
> the blocks and assumes their cost in space and time is proportional to
> the number of the perceived assembly "instruction", according to the
> number of newlines and semicolons. Alternatives, paravirt and other
> mechanisms are affected, causing code not to be inlined, and degrading
> compilation quality in general.
> 
> The solution that this patch-set carries for this problem is to create
> an assembly macro, and then call it from the inline assembly block.  As
> a result, the compiler sees a single "instruction" and assigns the more
> appropriate cost to the code. In addition, this patch-set removes
> unneeded new-lines from common x86 inline asm's, which "confuse" GCC
> heuristics.

Can't you get the same effect by using always_inline ?

	David
