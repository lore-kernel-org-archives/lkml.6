Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C75C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D561206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iq/XePQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbfAIMll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:41:41 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35200 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfAIMll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wzK4gIQSUPXGwglDZM6nDv3mNaiaBpPSmB0PbjHzc3o=; b=Iq/XePQvvz64m1G/19U0CIhm4
        TwxvUZUqEiOUKqhUk4w4vDBxVySnjj8NbFZt50PY7dfNEOdbPRGG0KJz6YVbilqKMNHmEzU2bQRdH
        qw816SRTfn9NayOmcUhJuAi5LD2Ucl+BIN2ca7i9k6HoYaFFTYY7ACvoLebT21vA0qgZwfUt9eGbl
        Yn3W5yn1DgcDaG3IjxlKeZnJ8bqgspdZUq23rXKL5wIZ5QeMpGsk+4sCECUC7PrXARQWgd6x0prgr
        2FOgM4kHPTS+lPZIoSIpeziU+PgnOa6Hw5iFm8+NFmpBmqJ1mrYsXx+qxjmnv+dr76nU6cSnuALzY
        bePxJ3Jag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghDAs-0000XX-Jr; Wed, 09 Jan 2019 12:41:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3445207C0078; Wed,  9 Jan 2019 13:41:31 +0100 (CET)
Date:   Wed, 9 Jan 2019 13:41:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Song Liu <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Message-ID: <20190109124131.GI1900@hirez.programming.kicks-ass.net>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-4-songliubraving@fb.com>
 <20190108202915.GE30894@hirez.programming.kicks-ass.net>
 <dd3ca24b-4da5-b0b1-9d1c-e5ed3fe297d2@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd3ca24b-4da5-b0b1-9d1c-e5ed3fe297d2@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 08:45:19PM +0000, Alexei Starovoitov wrote:
> On 1/8/19 12:29 PM, Peter Zijlstra wrote:
> > On Thu, Dec 20, 2018 at 10:29:00AM -0800, Song Liu wrote:
> >> The following example shows kernel symbols for a BPF program with 7
> >> sub programs:
> >>
> >>      ffffffffa0257cf9 t bpf_prog_b07ccb89267cf242_F
> >>      ffffffffa02592e1 t bpf_prog_2dcecc18072623fc_F
> >>      ffffffffa025b0e9 t bpf_prog_bb7a405ebaec5d5c_F
> >>      ffffffffa025dd2c t bpf_prog_a7540d4a39ec1fc7_F
> >>      ffffffffa025fcca t bpf_prog_05762d4ade0e3737_F
> >>      ffffffffa026108f t bpf_prog_db4bd11e35df90d4_F
> >>      ffffffffa0263f00 t bpf_prog_89d64e4abf0f0126_F
> >>      ffffffffa0257cf9 t bpf_prog_ae31629322c4b018__dummy_tracepoi
> > 
> > We should probably specify somewhere that the name can include a
> > '[module]' part just like normal kallsyms. Even though you don't
> > currently use that.
> 
> there is no [module] equivalent in bpf land.

I know; although you could consider each program it's own separate
module. But what I meant was, we should probably document the name[]
format somewhere, maybe in the PERF_RECORD_KSYMBOL comment.

The "symbol [module]" syntax can be used to create a DSO sort key, so
you could simply put in "[bpf]" for all BPF generated symbols and have
everything BPF grouped in perf-report when sorted on DSO.

It doesn't have any other implications.

Similarly, I would suggest "[ftrace]" for all the ftrace trampolines
(which are currently not exposed but really should be).
