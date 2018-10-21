Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D78C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4831820779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UEkLLoYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4831820779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeJVRby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:31:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60440 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeJVRbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dk+/QBzDSdWsLGgbPnMkPmi3THDf+mrJK+Ns2s9JnV8=; b=UEkLLoYneEav5IUvIm9qJiFQEa
        NOhw1fxD3f74Oxx7FH1TOyG59sW9+YG2148SH8rtkOAL1feyh+6y8EBTsHZAczrikWPAjSclmwd1s
        GVrV5JNoHLI/4Dih78EMcUpmOkbvKikVAlUuzG+qEXxSw5dbr3EGieuGcQu04z5bnGTGsYAU8E0Ob
        BnqwHYx78PfHzTTdHiRW+M97QNr3y0huhv4DbZPFQiZxTb3yG2V59tCGEk3Yl7MSMWgQU0XAjt40C
        6J4kHxP154hV3WeZybazOpEKC8vYyZEB1L8V1BKyqfOMkq3X8tQE1Y4TuNam82z1T5oo/hz82hvAn
        Km36x2UA==;
Received: from [167.98.65.38] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEWHj-0006my-Na; Mon, 22 Oct 2018 09:14:03 +0000
Received: by worktop (Postfix, from userid 1000)
        id 55AD96E0885; Sun, 21 Oct 2018 22:13:58 +0200 (CEST)
Date:   Sun, 21 Oct 2018 22:13:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Robert Richter <rric@kernel.org>,
        Brendan Gregg <bgregg@netflix.com>,
        linux-kernel@vger.kernel.org, oprofile-list@lists.sf.net
Subject: Re: [RFC] Merging ftrace_stack, perf_callchain, oprofile->backtrace
 and stack_trace
Message-ID: <20181021201358.GF4931@worktop.programming.kicks-ass.net>
References: <20181021093106.mhjpb2rnx6kstjki@ryuk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181021093106.mhjpb2rnx6kstjki@ryuk>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 08:31:06PM +1100, Aleksa Sarai wrote:
> Hi all,
>=20
> I'm currently working on a patchset to make kretprobes produce
> reasonable stack traces[1], and it appears this is a generic problem
> across the entire kernel -- you can see the same kretprobe_trampoline()
> issue when using ftrace just as much as bpf_trace.
>=20
> However, in working on this patch, I've noticed that there appear to be
> several different implementations of "get the stack trace from this
> pt_regs" which all appear quite similar. Namely:
>=20
>   * struct ftrace_stack;
>   * struct perf_callchain_entry; [**]
>   * struct stack_trace;

the perf thing also does userspace stack, where the others do not afaik.
And for the kernel part it already uses the regular kernel unwinder.

I'm not sure what you're proposing.
