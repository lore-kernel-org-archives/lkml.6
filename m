Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02277ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05002081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3cy4HcbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05002081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeKIAgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:36:31 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37624 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeKIAga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PX2vCXgd9PUHUkmWFd4nDqiQOB3Jv6+9WSonyIROxuE=; b=3cy4HcbD0j9qLOr3Ek7WWFZmq
        anR++4ARdcLyOSs8KCHwi0xVgVgoGvuAYf9jFijSIlulY1ektL+2t/NVq+sEwy6EoTBWp8uoOas3e
        S+8dyOdMNdufgxDfQJ0ZXgVzyh5nuaUsIeR10I4SZrbOhMjqKVmSyyDSbc2vsOUSx3AEE4TkFRMlM
        Nis35/5mrWrLBs2qzynIgazD4PSX4p4T96rnvgkLhx1Yj6llTf+/3vCNTIVVOW2R6729JPmqURELg
        jkzZykFO1P/uz0E3iG7WVNs0kuwz481/gKmpH20FtbCwJK1XqDDEKw7Zz9n9gyx05mlzhRPL2fpG/
        wfzPdKqsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKlnL-0002Wa-5B; Thu, 08 Nov 2018 15:00:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42B0820284F98; Thu,  8 Nov 2018 16:00:28 +0100 (CET)
Date:   Thu, 8 Nov 2018 16:00:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [RFC perf,bpf 1/5] perf, bpf: Introduce PERF_RECORD_BPF_EVENT
Message-ID: <20181108150028.GU9761@hirez.programming.kicks-ass.net>
References: <20181106205246.567448-1-songliubraving@fb.com>
 <20181106205246.567448-2-songliubraving@fb.com>
 <20181107084057.GG9781@hirez.programming.kicks-ass.net>
 <31067290-4B66-4AA1-8027-607397BC0264@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31067290-4B66-4AA1-8027-607397BC0264@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 06:25:04PM +0000, Song Liu wrote:
> 
> 
> > On Nov 7, 2018, at 12:40 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Tue, Nov 06, 2018 at 12:52:42PM -0800, Song Liu wrote:
> >> For better performance analysis of BPF programs, this patch introduces
> >> PERF_RECORD_BPF_EVENT, a new perf_event_type that exposes BPF program
> >> load/unload information to user space.
> >> 
> >>        /*
> >>         * Record different types of bpf events:
> >>         *   enum perf_bpf_event_type {
> >>         *      PERF_BPF_EVENT_UNKNOWN          = 0,
> >>         *      PERF_BPF_EVENT_PROG_LOAD        = 1,
> >>         *      PERF_BPF_EVENT_PROG_UNLOAD      = 2,
> >>         *   };
> >>         *
> >>         * struct {
> >>         *      struct perf_event_header header;
> >>         *      u16 type;
> >>         *      u16 flags;
> >>         *      u32 id;  // prog_id or map_id
> >>         * };
> >>         */
> >>        PERF_RECORD_BPF_EVENT                   = 17,
> >> 
> >> PERF_RECORD_BPF_EVENT contains minimal information about the BPF program.
> >> Perf utility (or other user space tools) should listen to this event and
> >> fetch more details about the event via BPF syscalls
> >> (BPF_PROG_GET_FD_BY_ID, BPF_OBJ_GET_INFO_BY_FD, etc.).
> > 
> > Why !? You're failing to explain why it cannot provide the full
> > information there.
> 
> Aha, I missed this part. I will add the following to next version. Please
> let me know if anything is not clear.

> 
> This design decision is picked for the following reasons. First, BPF 
> programs could be loaded-and-jited and/or unloaded before/during/after 
> perf-record run. Once a BPF programs is unloaded, it is impossible to 
> recover details of the program. It is impossible to provide the 
> information through a simple key (like the build ID). Second, BPF prog
> annotation is under fast developments. Multiple informations will be 
> added to bpf_prog_info in the next few releases. Including all the
> information of a BPF program in the perf ring buffer requires frequent 
> changes to the perf ABI, and thus makes it very difficult to manage 
> compatibility of perf utility. 

So I don't agree with that reasoning. If you want symbol information
you'll just have to commit to some form of ABI. That bpf_prog_info is an
ABI too.

And relying on userspace to synchronously consume perf output to
directly call into the kernel again to get more info (through another
ABI) is a pretty terrible design.

So please try harder. NAK on this.
