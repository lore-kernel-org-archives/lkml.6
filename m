Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2BEC46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 00:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1428A22402
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 00:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROdHhA7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1428A22402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeHKDGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 23:06:40 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33149 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbeHKDGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 23:06:39 -0400
Received: by mail-qt0-f193.google.com with SMTP id c15-v6so12205209qtp.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 17:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=qjpWyHbFeAtpFdsgKiqboTNlIPziBETkN4ecKbIrDsc=;
        b=ROdHhA7NJzQk2woTyRiFM9wOnh5N7uJR3xDmTDChGsqejJkIAX5Jz0yvpOIeOhc8yu
         CN54RoyybYfWL8CSPAKbOYiwUfOvvF/6lqRP/JvIv0T1wVzZG/bGjH1Fp9hR2yQJQo4t
         oN7qQXPCkhe2Q4LWEsb35drAeyUTnOdK1QS6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=qjpWyHbFeAtpFdsgKiqboTNlIPziBETkN4ecKbIrDsc=;
        b=cnUdWml1DMMbtdlooU+OgncLk5mAuMXPFnslCw1J38gL6QV9JrqfyA38y2bsSG77ZX
         uqhyFTREVPbjZOj8lvjz5pVR9mAWz1CHybyjMBm6l6GtkQqiIwBgJERSnlae0yXmkAMI
         T5NfylHGX8bccRunFrQLHpRo5sUGu8LH/OCGfw7w8Ae1t2iCMlG/pmtJEsK8OHkIP49I
         rw5Uhwrq2BjYNhUSSDQhLPkQnIzwMGXTl5CjjLxgmkRKq6iRISCRuQ2Cr6ix7FxYWgG/
         dU/yREHJQpZWHPA8L8JYGhWSLJBb8A6hRjWWkPcRKtHEDAZ41K7F4CcxgWgDx08YstfU
         bsHQ==
X-Gm-Message-State: AOUpUlHQBxhJ3ULjNHf5XeYTrOUFBCA9YyHCF3SsHPvNv0yAeitMvBO8
        hAUd05fsUhj7HyOHi46Y4esTzw==
X-Google-Smtp-Source: AA+uWPyOoxfC9iSE9bmJXPHsPajfzGrUmRzeaenBEkStOCa7uv15nOFuQOXGqBeEbJvbswfh/OuCbA==
X-Received: by 2002:ac8:6c8:: with SMTP id j8-v6mr8298672qth.314.1533947667190;
        Fri, 10 Aug 2018 17:34:27 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id q195-v6sm6773790qke.13.2018.08.10.17.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 17:34:26 -0700 (PDT)
Date:   Fri, 10 Aug 2018 20:34:25 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Joe Perches <joe@perches.com>
cc:     Jeff Lien <jeff.lien@wdc.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, herbert@gondor.apana.org.au,
        tim.c.chen@linux.intel.com, martin.petersen@oracle.com,
        david.darrington@wdc.com, jeff.furlong@wdc.com
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
In-Reply-To: <b3c86ddd67a73c09e09f3e51d7fc70036f00fb7b.camel@perches.com>
Message-ID: <nycvar.YSQ.7.76.1808102027220.13885@knanqh.ubzr>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com> <9b5b906f42dfab78f382c90f66851717d258a15d.camel@perches.com> <nycvar.YSQ.7.76.1808101601110.13885@knanqh.ubzr> <b3c86ddd67a73c09e09f3e51d7fc70036f00fb7b.camel@perches.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018, Joe Perches wrote:

> On Fri, 2018-08-10 at 16:02 -0400, Nicolas Pitre wrote:
> > On Fri, 10 Aug 2018, Joe Perches wrote:
> > 
> > > On Fri, 2018-08-10 at 14:12 -0500, Jeff Lien wrote:
> > > > This patch provides a performance improvement for the CRC16 calculations done in read/write
> > > > workloads using the T10 Type 1/2/3 guard field.  For example, today with sequential write
> > > > workloads (one thread/CPU of IO) we consume 100% of the CPU because of the CRC16 computation
> > > > bottleneck.  Today's block devices are considerably faster, but the CRC16 calculation prevents
> > > > folks from utilizing the throughput of such devices.  To speed up this calculation and expose
> > > > the block device throughput, we slice the old single byte for loop into a 16 byte for loop,
> > > > with a larger CRC table to match.  The result has shown 5x performance improvements on various
> > > > big endian and little endian systems running the 4.18.0 kernel version.
> > > 
> > > Thanks.
> > > 
> > > This seems a sensible tradeoff for the 4k text size increase.
> > 
> > More like 7.5KB.  Would be best if this was configurable so the small 
> > version remained available.
> 
> Maybe something like: (compiled, untested)
> ---
>  crypto/Kconfig            |  10 +
>  crypto/crct10dif_common.c | 543 +++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 549 insertions(+), 4 deletions(-)
> 
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index f3e40ac56d93..88d9d17bb18a 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -618,6 +618,16 @@ config CRYPTO_CRCT10DIF
>  	  a crypto transform.  This allows for faster crc t10 diff
>  	  transforms to be used if they are available.
>  
> +config CRYPTO_CRCT10DIF_TABLE_SIZE
> +	int "Size of CRCT10DIF crc tables (as a power of 2)"
> +	depends on CRYPTO_CRCT10DIF
> +	range 1 5
> +	default 1 if EMBEDDED
> +	default 5

You could even make the prompt depend on EXPERT.

I like it!

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
