Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F47C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551E720659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YVEYxnRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551E720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbeIFX4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:56:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48254 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbeIFX4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TbCJemBeYn2d/PcRK+9PCtc9GPZqjR9OEk8bVqA6j4Q=; b=YVEYxnRB3SoGJgi3ew9sexrPK
        D96c5L++n4FcObvJwhwTjt6JZ3S3RttUva7sI430qxxtCbkbXOPLpxuHyl8FFqhQyf/GZCzmgVItl
        5t4hE2QVTvsmcY4nh1+wCw7RevQWxoas6h2W22WLH2unqLPCKCkaKYgCGRefmhpf9QcEmZUWwjHf0
        9752M7C3U8cKeBQnoKtCrL+llSC9klW7Mga1MvMDuelW71pnrHLV78Q4PkVPQMg/zsKH4FSKwoTar
        HX83tRdyrPyGxeuBo/6R7BYbv7roAJa4jD6pmTKq8MWMnU2u+1S/zX+MGJSL1krdCE/REZui8HL21
        n+k/+Gqwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxzoP-0004WZ-7d; Thu, 06 Sep 2018 19:19:39 +0000
Received: by worktop (Postfix, from userid 1000)
        id 130EC6E0AA9; Thu,  6 Sep 2018 21:19:22 +0200 (CEST)
Date:   Thu, 6 Sep 2018 21:19:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Message-ID: <20180906191922.GB4816@worktop.programming.kicks-ass.net>
References: <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
 <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com>
 <20180906081300.GF24082@hirez.programming.kicks-ass.net>
 <20180906101641.GG24142@hirez.programming.kicks-ass.net>
 <6703CD9F-2D84-4449-A423-A4DC24677673@vmware.com>
 <20180906171754.GJ24106@hirez.programming.kicks-ass.net>
 <9AF220A3-D783-442E-8E5B-AD0150628347@vmware.com>
 <32902EEE-FF64-4C12-A043-1848CC927C88@amacapital.net>
 <20180906183157.GK24106@hirez.programming.kicks-ass.net>
 <9F76711C-393C-4F8D-B460-26D400458690@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9F76711C-393C-4F8D-B460-26D400458690@vmware.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 06:38:30PM +0000, Nadav Amit wrote:
> Note that patch 1/6 is still needed to fix false lockdep shoutouts due to a
> recent patch.

For some reason I do not appear to have 1/6 in my inbox. Let me dig
through lkml.
