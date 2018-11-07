Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46DEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8139F20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gTCDgFBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8139F20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbeKGSKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:10:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeKGSKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K9/KClUuX3eCznPYQdg2PQEdTsgVCy0aiW7Z/qIwSzc=; b=gTCDgFBF3duIYB/1FthKUoVdu
        IHAcyswF74scm45gGICbzzQ6Q/+c1WeFNnEMj983KHjElgbu3oHTWyvswSg7A2Nm5XH9EHsJwktHH
        JBDXev+F4uU3XevPQ9XCZwESPPBBAyVeQmT6gko3kjRcp6emaNytemJz9vdju2UFdvlRshVvcWBjZ
        ZR7Y/Qh02kunF0ISZ/lOlB/87L7+iUIsL1mV/SmEuZynCXE9mLRqsX7q7dYV3K4oR8z6Ix8nGnWra
        Ar3o6rVrQgEBfYRGFVmrlLYAzMGr2LTBkN4NI0pHvN2ZWvyOuX38ipxrU+oWGdFitEN4cPvZ+XGVq
        9jZxPSsyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKJOV-0001vh-Hg; Wed, 07 Nov 2018 08:40:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C203E2029F883; Wed,  7 Nov 2018 09:40:57 +0100 (CET)
Date:   Wed, 7 Nov 2018 09:40:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net,
        acme@kernel.org
Subject: Re: [RFC perf,bpf 1/5] perf, bpf: Introduce PERF_RECORD_BPF_EVENT
Message-ID: <20181107084057.GG9781@hirez.programming.kicks-ass.net>
References: <20181106205246.567448-1-songliubraving@fb.com>
 <20181106205246.567448-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106205246.567448-2-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 12:52:42PM -0800, Song Liu wrote:
> For better performance analysis of BPF programs, this patch introduces
> PERF_RECORD_BPF_EVENT, a new perf_event_type that exposes BPF program
> load/unload information to user space.
> 
>         /*
>          * Record different types of bpf events:
>          *   enum perf_bpf_event_type {
>          *      PERF_BPF_EVENT_UNKNOWN          = 0,
>          *      PERF_BPF_EVENT_PROG_LOAD        = 1,
>          *      PERF_BPF_EVENT_PROG_UNLOAD      = 2,
>          *   };
>          *
>          * struct {
>          *      struct perf_event_header header;
>          *      u16 type;
>          *      u16 flags;
>          *      u32 id;  // prog_id or map_id
>          * };
>          */
>         PERF_RECORD_BPF_EVENT                   = 17,
> 
> PERF_RECORD_BPF_EVENT contains minimal information about the BPF program.
> Perf utility (or other user space tools) should listen to this event and
> fetch more details about the event via BPF syscalls
> (BPF_PROG_GET_FD_BY_ID, BPF_OBJ_GET_INFO_BY_FD, etc.).

Why !? You're failing to explain why it cannot provide the full
information there.
