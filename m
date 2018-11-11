Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A6DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 15:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2B7208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 15:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SwMQGd6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2B7208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeKLBJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 20:09:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35520 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbeKLBJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 20:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dOX9J4ag4QAFVVXuroGsDYZFFUeCHh8UKE0Sm9ltKsY=; b=SwMQGd6p+ogiX0hjsmdsAKMeF
        PnXpzMnIcDqurw1dbicnshfrdkDG70ouSlGc9uIicL6emkZkDLJBqFIgry9E/VCN9wi95MOTFJeZ+
        eqxfJBHXeLRb/pLWN4W39YpY7sxww0s78X6irFlv9DEijI1X0FltLm1jEDqEbBEuMO3QJuJcv5bTf
        6siwsUqwpHJPRK3O1LrBcYOTa39gAykT+th9g5OoVD8ASZAJjJPt9/Lig1UiAHjZelJasHZwSOOvB
        xVIwS/D3y8o5xlo+T6EFzIAkebXzjHFxXjIF+JMp+HBMMgMXmu+al/0sIaDvIHHxIZ5H4gV+cJzT4
        fYNk6FWgQ==;
Received: from [64.114.255.97] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLrXP-0007qU-8g; Sun, 11 Nov 2018 15:20:35 +0000
Received: by worktop (Postfix, from userid 1000)
        id B8B1C6E0405; Sun, 11 Nov 2018 16:20:34 +0100 (CET)
Date:   Sun, 11 Nov 2018 16:20:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC/RFT][PATCH v5] cpuidle: New timer events oriented governor
 for tickless systems
Message-ID: <20181111152034.GC3021@worktop>
References: <102783770.7hZjAahU8c@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <102783770.7hZjAahU8c@aspire.rjw.lan>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 06:25:07PM +0100, Rafael J. Wysocki wrote:
> +/*
> + * The SPIKE value is added to metrics when they grow and the DECAY_SHIFT value
> + * is used for decreasing metrics on a regular basis.
> + */
> +#define SPIKE		1024
> +#define DECAY_SHIFT	3

> +	if (idx_timer >= 0) {
> +		unsigned int hits = cpu_data->states[idx_timer].hits;
> +		unsigned int misses = cpu_data->states[idx_timer].misses;
> +
> +		hits -= hits >> DECAY_SHIFT;
> +		misses -= misses >> DECAY_SHIFT;
> +
> +		if (idx_timer > idx_hit) {
> +			misses += SPIKE;
> +			if (idx_hit >= 0)
> +				cpu_data->states[idx_hit].early_hits += SPIKE;
> +		} else {
> +			hits += SPIKE;
> +		}
> +
> +		cpu_data->states[idx_timer].misses = misses;
> +		cpu_data->states[idx_timer].hits = hits;
> +	}

That's a pulse-density-modulator, with a signal bound of:

  1024 == x/8 -> x := 8192

Anyway; I would suggest s/SPIKE/PULSE/ because of that.

