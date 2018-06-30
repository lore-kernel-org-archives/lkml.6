Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC80C6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 00:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F0B280C2
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 00:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F0B280C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755289AbeF3A4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 20:56:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:43402 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753435AbeF3A4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 20:56:42 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5U0tXhb001343;
        Fri, 29 Jun 2018 19:55:34 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id w5U0tUKI001338;
        Fri, 29 Jun 2018 19:55:30 -0500
Date:   Fri, 29 Jun 2018 19:55:30 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Pekka Enberg <penberg@kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Christoph Lameter <cl@linux.com>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [Update] Regression in 4.18 - 32-bit PowerPC crashes on boot - bisected to commit 1d40a5ea01d5
Message-ID: <20180630005530.GX16221@gate.crashing.org>
References: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net> <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 02:01:46PM -0700, Linus Torvalds wrote:
> On Fri, Jun 29, 2018 at 1:42 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
> But the real question is what the problem was the *first* time around.
> I assume that has scrolled off the screen? This part:
> 
>   _exception_pkey+0x58/0x128
>   ret_from_except_full+0x0/0x4
>   --- interrupt: 700 at free_pgd_range+0x19c/0x30c
>        LR = free_pgd_range+0x19c/0x30c
>   free_pgtables+0xa/0xb
>   exit_mnap+0xf4/0x16c
>   mmput+0x64/0xf0
> 
> Does reverting that commit 1d40a5ea01d5 make everything work for you?
> Because if so, judging by the deafening silence on this so far, I
> think that's what we should do.
> 
> That said, can some ppc person who knows the 32-bit ppc code and maybe
> knows what that "interrupt: 700" means talk about that oddity in the
> trace, please?

700 is "program interrupt"; here it probably means a BUG() happened (which
does a trap instruction, which causes a 700).  The stuff that scrolled away
should tell more.


Segher
