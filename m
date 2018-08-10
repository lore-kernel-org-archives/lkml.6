Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432D5C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B4C218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BCFR34Gp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B4C218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeHJWdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 18:33:44 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43701 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbeHJWdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 18:33:44 -0400
Received: by mail-qt0-f194.google.com with SMTP id f18-v6so11554263qtp.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 13:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rfgl7nWwcXjgpaxppA5Ekhm9kG4iKHMbINuF4vQQ3L0=;
        b=BCFR34Gpefs11IfRGWX+rUdowaTCRnyzgAUXAcY707TZzupmzD7LjnKQ4luuBxy5M8
         BfzMkXOHE0Q3CNp3ee8q5N3C8mMYop51GQQpiQUHrSBIFQlC4F50fCjaShhx5BmDhZAv
         TuV/yMGtM9zIxoUznI9EUWhpXD+RQ4T7mjtoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rfgl7nWwcXjgpaxppA5Ekhm9kG4iKHMbINuF4vQQ3L0=;
        b=VQMtlXO37FkRoAB91Ib/Y+cv9roUi9KbqJtDXWHQJpZjFzNKkMmFSIJ/km+xeoench
         YjQYw7Ct1rU+YOqTEZTICPtZl+J4k2U+vC8pHJvfkoZJXpbwp4WS478QEa3uFAT42shb
         VH6ZaK5rMvmTgJZLF2aFXrk+VSk0ecNamQAklACFrOASmx052oWMAsZdvB8U7mV9Bw90
         PZkV01iVee5wmkigAo5oiiM75JLQ5ZfPxbQ9Y9wc70HLCwBvIfK3d2dEE3DLtTVdQXuU
         jcVh1ZqfdyqQO6VjGsfl1mwO/heT7A6uAG81jOcswA0yh7/egeRfrO4FGC6NL/lD5m3X
         ajzg==
X-Gm-Message-State: AOUpUlGFBoht3szBx5Dm3gkvNWJSIZ9YG0UKKw9J/uYPCph5EcbWUbrg
        bS1mAGUvQUwYwFbySs3HkZ3nqA==
X-Google-Smtp-Source: AA+uWPzlAdG6/PEWNJ40m885xLBcreNcjeYdvhCEAD+1RGe3SunrOWxOWNXKFVhEtbAHgvJ+1ftTmw==
X-Received: by 2002:ac8:4102:: with SMTP id q2-v6mr7998736qtl.222.1533931345098;
        Fri, 10 Aug 2018 13:02:25 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id 25-v6sm7389041qtx.91.2018.08.10.13.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 13:02:24 -0700 (PDT)
Date:   Fri, 10 Aug 2018 16:02:23 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Joe Perches <joe@perches.com>
cc:     Jeff Lien <jeff.lien@wdc.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, herbert@gondor.apana.org.au,
        tim.c.chen@linux.intel.com, martin.petersen@oracle.com,
        david.darrington@wdc.com, jeff.furlong@wdc.com
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
In-Reply-To: <9b5b906f42dfab78f382c90f66851717d258a15d.camel@perches.com>
Message-ID: <nycvar.YSQ.7.76.1808101601110.13885@knanqh.ubzr>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com> <9b5b906f42dfab78f382c90f66851717d258a15d.camel@perches.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018, Joe Perches wrote:

> On Fri, 2018-08-10 at 14:12 -0500, Jeff Lien wrote:
> > This patch provides a performance improvement for the CRC16 calculations done in read/write
> > workloads using the T10 Type 1/2/3 guard field.  For example, today with sequential write
> > workloads (one thread/CPU of IO) we consume 100% of the CPU because of the CRC16 computation
> > bottleneck.  Today's block devices are considerably faster, but the CRC16 calculation prevents
> > folks from utilizing the throughput of such devices.  To speed up this calculation and expose
> > the block device throughput, we slice the old single byte for loop into a 16 byte for loop,
> > with a larger CRC table to match.  The result has shown 5x performance improvements on various
> > big endian and little endian systems running the 4.18.0 kernel version.
> 
> Thanks.
> 
> This seems a sensible tradeoff for the 4k text size increase.

More like 7.5KB.  Would be best if this was configurable so the small 
version remained available.


Nicolas
