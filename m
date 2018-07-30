Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A577FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A18D20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A18D20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sympatico.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeG3Ily (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 04:41:54 -0400
Received: from simcoe207srvr.owm.bell.net ([184.150.200.207]:41125 "EHLO
        torfep01.bell.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726463AbeG3Ily (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 04:41:54 -0400
Received: from bell.net torfep01 184.150.200.158 by torfep01.bell.net
          with ESMTP
          id <20180730070820.HGLQ3030.torfep01.bell.net@torspm02.bell.net>
          for <linux-kernel@vger.kernel.org>;
          Mon, 30 Jul 2018 03:08:20 -0400
Received: from arcusix ([67.71.42.39]) by torspm02.bell.net with ESMTP
          id <20180730070820.MLVF31064.torspm02.bell.net@arcusix>;
          Mon, 30 Jul 2018 03:08:20 -0400
Message-ID: <2bc48efc86800949761b8f4d3a165a9f9c25c57e.camel@sympatico.ca>
Subject: Re: [PATCH 0/3] PTI x86-32 Updates and Fixes
From:   "David H. Gutteridge" <dhgutteridge@sympatico.ca>
To:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        jroedel@suse.de, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 30 Jul 2018 03:08:14 -0400
In-Reply-To: <1532533683-5988-1-git-send-email-joro@8bytes.org>
References: <1532533683-5988-1-git-send-email-joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cloudmark-Analysis: v=2.2 cv=JtkelIwC c=1 sm=0 tr=0 a=/4BQ6POolEllGJf7n1YyrQ==:17 a=IkcTkHD0fZMA:10 a=R9QF1RCXAYgA:10 a=k_m-kdumAAAA:8 a=Q1IQS8c1w_6sp_oRIawA:9 a=QEXdDO2ut3YA:10 a=2aFmp3DG3lfw9CblUY6y:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-25 at 17:48 +0200, Joerg Roedel wrote:
> Hi,
> 
> here are three patches on-top of tip/x86/pti to update the
> vmallo_fault() fix and also with another important fix.
> 
> The first two patches remove the WARN_ON_ONCE(in_nmi) from
> the vmalloc_fault() function and revert the previous fix, as
> discussed at the last patch-set.
> 
> The third patch is an important fix for a silent memory
> corruption issue found by the trinity fuzzer, which did take
> a while to track down. But I found it and with the fix the
> fuzzer already runs for couple of hours now and the VM is
> still alive.
> 
> Regards,
> 
> 	Joerg
> 
> Joerg Roedel (3):
>   x86/mm: Remove in_nmi() warning from vmalloc_fault()
>   Revert "perf/core: Make sure the ring-buffer is mapped in all
>     page-tables"
>   x86/kexec: Allocate 8k PGDs for PTI
> 
>  arch/x86/kernel/machine_kexec_32.c |  5 +++--
>  arch/x86/mm/fault.c                |  2 --
>  kernel/events/ring_buffer.c        | 16 ----------------
>  3 files changed, 3 insertions(+), 20 deletions(-)

Hi Joerg,

I've found no significant issues in my testing of this patch set.
The only minor thing I noted is that in your previous "v8" patch set
([PATCH 38/39] x86/mm/pti: Add Warning when booting on a PCID capable
CPU), it reports the warning on non-PCID capable CPUs: I think you
intended a bitwise "&", not a logical "&&" in the if statement?

Tested-by: David H. Gutteridge <dhgutteridge@sympatico.ca>

Regards,

Dave


