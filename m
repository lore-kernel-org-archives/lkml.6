Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C76C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CDE20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WYxsJrP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388205AbeLQQWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:22:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeLQQWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GzJw5OfqZmFeF3p28QfnsLekp01V+WlkztoA/o5MB54=; b=WYxsJrP404KuAZ2ACEgEdDK7l
        nkBSRImFxKA13t+MK5lTOYQiicpZuZKazn7bmwDj+2IlsDtct6CC1Uw6WDTGajnKe5y94U5mlc5op
        JB5tGoD4ja81ENX8kijklOQiBBew9EGn9tWwQH4/eh4vrLwfKl7UQX2NM92rUYee5AtGc7+UQbwfL
        2ViuXTBIbTq2flLaf1pz23VW7S8tAqbSk2oQIVIiaADY1FRuVqUPMslUQo7uYouhCVkKPxIWKf3QZ
        DOMqiWnScFsyY5gLOn1x4AtB1AMkSGsHZkPzq9fn/ETXvXZ5v/0mkje5LQSEN6aA7Qc4adrteE2di
        lnJN8TOyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYvez-0002p8-7C; Mon, 17 Dec 2018 16:22:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9126B20276ABC; Mon, 17 Dec 2018 17:22:23 +0100 (CET)
Date:   Mon, 17 Dec 2018 17:22:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, axboe@kernel.dk, dennis@kernel.org,
        dennisszhou@gmail.com, mingo@redhat.com, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 6/6] psi: introduce psi monitor
Message-ID: <20181217162223.GD2218@hirez.programming.kicks-ass.net>
References: <20181214171508.7791-1-surenb@google.com>
 <20181214171508.7791-7-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214171508.7791-7-surenb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 09:15:08AM -0800, Suren Baghdasaryan wrote:
> +ssize_t psi_trigger_parse(char *buf, size_t nbytes, enum psi_res res,
> +	enum psi_states *state, u32 *threshold_us, u32 *win_sz_us)
> +{
> +	bool some;
> +	bool threshold_pct;
> +	u32 threshold;
> +	u32 win_sz;
> +	char *p;
> +
> +	p = strsep(&buf, " ");
> +	if (p == NULL)
> +		return -EINVAL;
> +
> +	/* parse type */
> +	if (!strcmp(p, "some"))
> +		some = true;
> +	else if (!strcmp(p, "full"))
> +		some = false;
> +	else
> +		return -EINVAL;
> +
> +	switch (res) {
> +	case (PSI_IO):
> +		*state = some ? PSI_IO_SOME : PSI_IO_FULL;
> +		break;
> +	case (PSI_MEM):
> +		*state = some ? PSI_MEM_SOME : PSI_MEM_FULL;
> +		break;
> +	case (PSI_CPU):
> +		if (!some)
> +			return -EINVAL;
> +		*state = PSI_CPU_SOME;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	while (isspace(*buf))
> +		buf++;
> +
> +	p = strsep(&buf, "%");
> +	if (p == NULL)
> +		return -EINVAL;
> +
> +	if (buf == NULL) {
> +		/* % sign was not found, threshold is specified in us */
> +		buf = p;
> +		p = strsep(&buf, " ");
> +		if (p == NULL)
> +			return -EINVAL;
> +
> +		threshold_pct = false;
> +	} else
> +		threshold_pct = true;
> +
> +	/* parse threshold */
> +	if (kstrtouint(p, 0, &threshold))
> +		return -EINVAL;
> +
> +	while (isspace(*buf))
> +		buf++;
> +
> +	p = strsep(&buf, " ");
> +	if (p == NULL)
> +		return -EINVAL;
> +
> +	/* Parse window size */
> +	if (kstrtouint(p, 0, &win_sz))
> +		return -EINVAL;
> +
> +	/* Check window size */
> +	if (win_sz < PSI_TRIG_MIN_WIN_US || win_sz > PSI_TRIG_MAX_WIN_US)
> +		return -EINVAL;
> +
> +	if (threshold_pct)
> +		threshold = (threshold * win_sz) / 100;
> +
> +	/* Check threshold */
> +	if (threshold == 0 || threshold > win_sz)
> +		return -EINVAL;
> +
> +	*threshold_us = threshold;
> +	*win_sz_us = win_sz;
> +
> +	return 0;
> +}

How well has this thing been fuzzed? Custom string parser, yay!
