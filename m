Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44D1C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DAB2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64DAB2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJPAGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:06:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbeJPAGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:06:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0DA27F6CE;
        Mon, 15 Oct 2018 16:20:25 +0000 (UTC)
Received: from treble (ovpn-125-6.rdu2.redhat.com [10.10.125.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87AAD770F8;
        Mon, 15 Oct 2018 16:20:24 +0000 (UTC)
Date:   Mon, 15 Oct 2018 11:20:22 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     natechancellor@gmail.com, Andrew Lutomirski <luto@kernel.org>,
        nick.desaulniers@gmail.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: annotate no_context with UNWIND_HINTS
Message-ID: <20181015162022.jia673dbkruo7k6f@treble>
References: <20181015003726.29103-1-nick.desaulniers@gmail.com>
 <CALCETrUZoBtxoR9u=72CSmNa-793EZySMd7TjH_BmHcrNSvLZg@mail.gmail.com>
 <20181015051705.GA20687@flashbox>
 <2CCAF5D3-1B11-43BF-93E4-72C2603A184F@amacapital.net>
 <20181015152221.GA16375@flashbox>
 <20181015153144.buuow3yof2njjzjm@treble>
 <CALCETrWtgjxSZOg=hqGe3hDDvpuBDZtjptHFDAuHYOaxs1CO_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrWtgjxSZOg=hqGe3hDDvpuBDZtjptHFDAuHYOaxs1CO_w@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 15 Oct 2018 16:20:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 09:03:40AM -0700, Andy Lutomirski wrote:
> That being said, the generic macro is:
> 
> # define unreachable() do { annotate_reachable(); do { } while (1); } while (0)
> 
> I'm probably missing some subtlety here, but shouldn't that be
> annotate_*un*reachable()?

That code should have had a comment, but that subtlety was intentional.
As I mentioned earlier, that was a hack for old versions of GCC which
didn't have __builtin_unreachable().  In those cases, GCC doesn't treat
"ud2" as fatal, so this was a way of telling objtool that.  Luckily we
can get rid of this hack now that the minimum supported GCC version has
gone up to 4.6.

-- 
Josh
