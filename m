Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDC4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4D820883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aMqWDRYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbfAHT7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:59:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732990AbfAHT72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9j248iKVW68MgXqyHBMfVGKuzEdWnpCfGNszahvR+Cc=; b=aMqWDRYeSKVt1aq2RDm8HZElr
        aiowTqa3OwYQjZhe6N1Gf7C2/jtq21ieB1DpSGaF0MBfeEJ40MY3KhdMmMU9lfJd3AH5FhtzrKOlF
        OGgBsFwToUMizgiPrJKpYzWL+u+yCVAGdXwoWjKIgS4q8gnSQIuAIscDf8JIkoIysIkxaBDVR1uqU
        5Mi529FmTJDVRY6tyrRvgP6C3U60IVDnmAvgupf374A7Stqe1fQa9Aj7FIsOZD0NhV29BQfGABp6Z
        DE/Dw5iwPLjKzv3/ZjN00lAj4kU0ShGRIM4y35LAaK8umYxY1Gefi2AzEDLpTBMuxg6eV++6QNW79
        WOh/7LrMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggxX3-0004PZ-6t; Tue, 08 Jan 2019 19:59:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B49BF2028019A; Tue,  8 Jan 2019 20:59:23 +0100 (CET)
Date:   Tue, 8 Jan 2019 20:59:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        acme@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Message-ID: <20190108195923.GD30894@hirez.programming.kicks-ass.net>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-4-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220182904.4193196-4-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 10:29:00AM -0800, Song Liu wrote:
> +static void perf_event_bpf_emit_ksymbols(struct bpf_prog *prog,
> +					 enum perf_bpf_event_type type)
> +{
> +	bool unregister = type == PERF_BPF_EVENT_PROG_UNLOAD;
> +	int i;
> +
> +	if (prog->aux->func_cnt == 0) {
> +		perf_event_ksymbol(PERF_RECORD_MISC_KSYMBOL_TYPE_BPF,
> +				   (u64)(unsigned long)prog->bpf_func,
> +				   prog->jited_len, unregister,
> +				   perf_event_bpf_get_name, prog);
> +	} else {
> +		for (i = 0; i < prog->aux->func_cnt; i++) {
> +			struct bpf_prog *subprog = prog->aux->func[i];
> +
> +			perf_event_ksymbol(
> +				PERF_RECORD_MISC_KSYMBOL_TYPE_BPF,
> +				(u64)(unsigned long)subprog->bpf_func,
> +				subprog->jited_len, unregister,
> +				perf_event_bpf_get_name, subprog);
> +		}
> +	}
> +}

That's a bit unexpected, but yes sure, that works for now.

I was expecting it to be hooked up in your kallsym rbtree thing, but
whatever, we can fix that when needed.
