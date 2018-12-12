Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FF1C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2A320879
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o96bmAUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2A320879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeLLMGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:06:43 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58362 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeLLMGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KE0Uju2EMJOC0Ptn9MvAloDfVA2Vqan93O5UwJjfey0=; b=o96bmAURhLugHIhEhZ+ahhCoy
        g/6GRTbJ/F5OE8BlNy/ZILDpjVVe7ZqyMOXp80cjq29zYG0xxVaPltpiBopdExsNJpKuSseinO9Fd
        oSRKsztgz0BTZ2rpAZHpoMaSv/WUdvlGao8UTeHL8RD8yWscayQctg4RbjiRsCaz3LJBCcIgygF9C
        sMw70C0ZRYqXO4p9L3ys8DhOffXziRCmHXNj2qfXGddWiKZyA/CATnoWm7otWUOT2V6LNgn+nnFES
        pXwCAutDtbTjMxajUZxYn1j93c0A+C7y7Nc6QwH4PXaARg+HI8OuVMgNpxz45dI4TgYuQPYLpt9bC
        LyiF9Fz/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gX3Hf-0007iV-Jg; Wed, 12 Dec 2018 12:06:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 031992075BD0D; Wed, 12 Dec 2018 13:06:32 +0100 (CET)
Date:   Wed, 12 Dec 2018 13:06:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        acme@kernel.org
Subject: Re: [PATCH v3 perf, bpf-next 1/4] perf, bpf: Introduce
 PERF_RECORD_BPF_EVENT
Message-ID: <20181212120632.GY5289@hirez.programming.kicks-ass.net>
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
> +static void perf_event_bpf_output(struct perf_event *event,
> +				   void *data)
> +{
> +	struct perf_bpf_event *bpf_event = data;
> +	struct perf_output_handle handle;
> +	struct perf_sample_data sample;
> +	char name[KSYM_NAME_LEN];
> +	int name_len;
> +	int ret;
> +
> +	if (!perf_event_bpf_match(event))
> +		return;
> +
> +	/* get prog name and round up to 64 bit aligned */
> +	bpf_get_prog_name(bpf_event->prog, name);
> +	name_len = strlen(name) + 1;
> +	while (!IS_ALIGNED(name_len, sizeof(u64)))
> +		name[name_len++] = '\0';

Does this not require something like:

	BUILD_BUG_ON(KSYM_NAME_LEN % sizeof(u64));
