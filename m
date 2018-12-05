Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF51C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148332082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="ZWghYkQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148332082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maine.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeLERL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:11:26 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:34543 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeLERLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:11:25 -0500
Received: by mail-qt1-f171.google.com with SMTP id r14so23153703qtp.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ARbZl7ZFIC0HyL1HIGoFKDl/4KccDvtxVrptMLox3GY=;
        b=ZWghYkQP0dpXeESfA/Dp8XOrtcYVmF7qjGqOIlEiTuS/MfsQY/q/Iz0DMNWXWuhICy
         cNH3xaDInF/oLEmlwVPDVKfOSwQsXHOsbwsnpXWUGaY2S6xgzTl0rkttivgY9a+MIncQ
         sNgxAgrYhQ0ToBz6VjnyPvISyJDiuJB6ZQ9Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ARbZl7ZFIC0HyL1HIGoFKDl/4KccDvtxVrptMLox3GY=;
        b=LKVT1ptcrDwE9vT1KpNcJ15eRkW4n+AnJ+4KWitQxmGZ/VC3ZnGkrAk2zxOeyKgmPU
         +w/TpdHBnwOfDPmTEIuSZ7aLyknF7fJb6FLhLLs/Qi4AVszZw7h3NXW/MTwNBalLwE/k
         lJu437BZRTHP+oPzcGT8Ntv80yvrU9ea4VU8t0zhAeT7nFj4CsSSCLroQ5Sg5VNLn9Tc
         DCuWYOsEn8Gb8nSeZBmkOsX/GwH3iw3TPGMrA+CnVhYDO4/1l7RATbPZnvoCmhpRGacO
         CZem1uWs2rPX3nEVzfVfrbd3lc2Z4pSdhv9UoZBDWCAnOgG+fEgbgstTCSySfaM9iU2b
         EhQg==
X-Gm-Message-State: AA+aEWa2xL64dnmYTRdQh8t0VPFijjCfTcIm1ejJrV35SoXx6+Te/F4b
        mmP/h/Urk2KT6DzVECdU5OfN/A==
X-Google-Smtp-Source: AFSGD/WYrY5qKORthbzui26yn8FWD6Oy8t1ZXEyzJXR9wZ7OagJk6FhFYsEUUya+2cuj8XbOvHOCTA==
X-Received: by 2002:aed:2249:: with SMTP id o9mr24701373qtc.13.1544029884398;
        Wed, 05 Dec 2018 09:11:24 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id j38sm17622747qtj.72.2018.12.05.09.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 09:11:23 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Wed, 5 Dec 2018 12:11:19 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Jiri Olsa <jolsa@redhat.com>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf: perf_fuzzer triggers GPF in perf_prepare_sample
In-Reply-To: <20181205163838.GA3836@krava>
Message-ID: <alpine.DEB.2.21.1812051208580.29892@macbook-air>
References: <alpine.DEB.2.21.1812041039220.19558@macbook-air> <20181205124538.GA19343@krava> <20181205163838.GA3836@krava>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018, Jiri Olsa wrote:

> On Wed, Dec 05, 2018 at 01:45:38PM +0100, Jiri Olsa wrote:
> > On Tue, Dec 04, 2018 at 10:54:55AM -0500, Vince Weaver wrote:
> > > Hello,
> > > 
> > > I was able to trigger another oops with the perf_fuzzer with current git.
> > > 
> > > This is 4.20-rc5 after the fix for the very similar oops I previously 
> > > reported got committed.
> > > 
> > > It seems to be pointing to the same location in the source as 
> > > before, I guess maybe triggered a different way?
> > 
> > nice.. yep, looks the same
> > 
> > > 
> > > Unfortunately this crash is not easily reproducible like the last one was.
> > 
> > will check
> 
> what model are hitting this on?

Haswell.  6/60/3.

While I can't deterministically trigger this, the fuzzer usually hits it
within an hour or two.  Is there any debug or printk messages I can
add that would help figure out what's going on?

Vince


