Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EE8ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112EB2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="hQIyFQAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112EB2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maine.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeKICXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:23:07 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42245 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKICXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:23:06 -0500
Received: by mail-qk1-f196.google.com with SMTP id m5so3897671qka.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 08:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6zTe9U4eVMVGlN13E3lWnRN7lUZ4APDipeHnvMeFxRo=;
        b=hQIyFQAdubwQXoXNLkX5N7iB/b3rGjkNzbFNHFHymv7+rICW53UzuNAcM8dYbtls9L
         z6W9okpDb3Vq2plb0JyjTOPu3EBeJejQ9I0MIsf/KnRhlMQnMCeOvCaSpnx6GP/UQCK4
         0jUAqtv8PfPy27oI/bbFhSnnEIWbzL6p7uSCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6zTe9U4eVMVGlN13E3lWnRN7lUZ4APDipeHnvMeFxRo=;
        b=M5gRLcadg6hiDYt6V+GmLIGVUfL6R7gKVFwADAjGoeTnHWunU/8XWY2kt1K9Y+6rmg
         9A08MGia0l/CZC+WyGJlnF1l9UFXRq11uMADSOquHClXrtryprjIyESK0W3E/iN53XPA
         r11SEOYCmLVwiuUmtBoTQklwVzVH4/hPYMsoJhytpykPPpM3E9wIW1wTH7CXRgXnwl9s
         Grn7FjKEyyJi+uYodv/y7QA/iVvpMPDfmR5ZUytljFlTt/G9sHi6CJ5wP8eYH8gwmoWW
         TIoGwonjVybnViyE8tvcbeEXA9IumuWTVAeE3mDt/EnE3sFGjj7xG/Fsjgu8+tfYCA6F
         Gv8g==
X-Gm-Message-State: AGRZ1gI4WtR86YQVSOq9BPIolNLQ6+VdWhewqLe4SszqqDn2+gIddFgD
        UQ/gJNZeRScUjqTLvLNjFpcywA==
X-Google-Smtp-Source: AJdET5eWBpL0o4Pl3mSlvlz8gYcmH64NbqS3CKQ6kv4YTPwIFzKKKaGKstk5MXCO7Nt9Y+/rkHf3Ag==
X-Received: by 2002:ac8:2fdc:: with SMTP id m28mr5341848qta.202.1541695606558;
        Thu, 08 Nov 2018 08:46:46 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id 33sm3977679qto.14.2018.11.08.08.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 08:46:45 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 8 Nov 2018 11:46:41 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
cc:     Vince Weaver <vincent.weaver@maine.edu>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        torvalds@linux-foundation.org
Subject: Re: perf: perf_fuzzer triggers NULL pointer dereference
In-Reply-To: <87a7mj5yx4.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1811081145220.8092@macbook-air>
References: <alpine.DEB.2.21.1811081041070.7406@macbook-air> <alpine.DEB.2.21.1811081100490.7406@macbook-air> <87a7mj5yx4.fsf@ashishki-desk.ger.corp.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018, Alexander Shishkin wrote:

> Vince Weaver <vincent.weaver@maine.edu> writes:
> 
> > On Thu, 8 Nov 2018, Vince Weaver wrote:
> >
> >> [91760.326510] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> >> [91760.334876] PGD 0 P4D 0 
> >> [91760.337596] Oops: 0000 [#1] SMP PTI
> >> [91760.341332] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G        W         4.20.0-rc1+ #119
> >> [91760.349816] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014
> >> [91760.357723] RIP: 0010:perf_prepare_sample+0x82/0x4a0
> >
> > so what's the best way to do the equivelent of addr2line on something like 
> > this, now that we aren't allowed to know the RIP anymore?
> 
> scripts/decode_stacktrace.sh works most of the time.
> 
> Sounds like BTS needs fixing up again. Thanks for looking at it though!

In case it matters, it looks like the address of the oops comes down to

	linux.git/kernel/events/core.c:6393

	size += data->callchain->nr;

Vince
