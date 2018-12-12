Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7E7C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF2720839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rD6zanlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF2720839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeLLNP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:15:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56398 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeLLNP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VWGfsM5/R99XISuCGy5e6BKBzvgzu6SqfrX+DA3GClY=; b=rD6zanlEE4WciH43bWU0/Z9VV
        QTy7pIZmsdd11Ww4ld1YZn9Y6aKIqlSo27cQuQSojpOQ4bzBxeHy1ESSnIxAk+xghjRHD8MihV2p2
        UDW3e2o3kNA4ipm9z6LNVSrx4bS+3fJea0KDY1vFo2mn37o6j55ge7BtvXhSXdrtl+CCu08x2VXVv
        x2UC/jbzdvaYs/QrwNzKCziGdgeFc5Bd3zpmv/ma+ccz63i7Rd36eVh0zlgOheQ5mRTNFRpUUd+Et
        UxhS9MPTV5BddgxTcPVVYKfcIwizJ3TqVcu8DIWthZBkbmQFaRuswg3HR0Cofk4KDREwQDib8SQTG
        3vW6POrlw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gX4Mj-0004wN-RV; Wed, 12 Dec 2018 13:15:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A7742075BF38; Wed, 12 Dec 2018 14:15:49 +0100 (CET)
Date:   Wed, 12 Dec 2018 14:15:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        acme@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 perf, bpf-next 1/4] perf, bpf: Introduce
 PERF_RECORD_BPF_EVENT
Message-ID: <20181212131549.GZ5289@hirez.programming.kicks-ass.net>
References: <20181211233351.4036381-1-songliubraving@fb.com>
 <20181211233351.4036381-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211233351.4036381-2-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 03:33:47PM -0800, Song Liu wrote:
> For better performance analysis of BPF programs, this patch introduces
> PERF_RECORD_BPF_EVENT, a new perf_event_type that exposes BPF program
> load/unload information to user space.
> 
> Each BPF program may contain up to BPF_MAX_SUBPROGS (256) sub programs.
> The following example shows kernel symbols for a BPF program with 7
> sub programs:
> 
>     ffffffffa0257cf9 t bpf_prog_b07ccb89267cf242_F
>     ffffffffa02592e1 t bpf_prog_2dcecc18072623fc_F
>     ffffffffa025b0e9 t bpf_prog_bb7a405ebaec5d5c_F
>     ffffffffa025dd2c t bpf_prog_a7540d4a39ec1fc7_F
>     ffffffffa025fcca t bpf_prog_05762d4ade0e3737_F
>     ffffffffa026108f t bpf_prog_db4bd11e35df90d4_F
>     ffffffffa0263f00 t bpf_prog_89d64e4abf0f0126_F
>     ffffffffa0257cf9 t bpf_prog_ae31629322c4b018__dummy_tracepoi

Doesn't BPF have enough information to generate 'saner' names? Going by
the thing below, these sub-progs are actually functions, right?

>         /*
>          * Record different types of bpf events:
>          *  enum perf_bpf_event_type {
>          *     PERF_BPF_EVENT_UNKNOWN           = 0,
>          *     PERF_BPF_EVENT_PROG_LOAD         = 1,
>          *     PERF_BPF_EVENT_PROG_UNLOAD       = 2,
>          *  };
>          *
>          * struct {
>          *      struct perf_event_header header;
>          *      u32                             type;
>          *      u32                             flags;
>          *      u32                             id; // prog_id or other id
>          *      u32                             sub_id; // subprog id
>          *
>          *      // for bpf_prog types, bpf prog or subprog
>          *      u8                              tag[BPF_TAG_SIZE];
>          *      u64                             addr;
>          *      u64                             len;
>          *      char                            name[];
>          *      struct sample_id                sample_id;
>          * };
>          */

Isn't this mixing two different things (poorly)? The kallsym update and
the BPF load/unload ?

And while this tracks the bpf kallsyms, it does not do all kallsyms.

.... Oooh, I see the problem, everybody is doing their own custom
kallsym_{add,del}() thing, instead of having that in generic code :-(

This, for example, doesn't track module load/unload nor ftrace
trampolines, even though both affect kallsyms.

> +void perf_event_bpf_event_prog(enum perf_bpf_event_type type,
> +			       struct bpf_prog *prog)
> +{
> +	if (!atomic_read(&nr_bpf_events))
> +		return;
> +
> +	if (type != PERF_BPF_EVENT_PROG_LOAD &&
> +	    type != PERF_BPF_EVENT_PROG_UNLOAD)
> +		return;
> +
> +	if (prog->aux->func_cnt == 0) {
> +		perf_event_bpf_event_subprog(type, prog,
> +					     prog->aux->id, 0);
> +	} else {
> +		int i;
> +
> +		for (i = 0; i < prog->aux->func_cnt; i++)
> +			perf_event_bpf_event_subprog(type, prog->aux->func[i],
> +						     prog->aux->id, i);
> +	}
> +}


