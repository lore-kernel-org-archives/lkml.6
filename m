Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E27ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDF620857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="PwkNx8vr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDF620857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maine.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeKIBlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:41:20 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39225 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKIBlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:41:19 -0500
Received: by mail-qk1-f195.google.com with SMTP id e4so27332551qkh.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 08:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IEMbJENmoZLXKePiWek5YqrFsU33ooTt7wfBA1G1VSY=;
        b=PwkNx8vrBlgieU8m3kuvtkzAQjQL7vkh05q4nO/teL8G+OwxQVmUS4o988lNW7Ds0M
         ozZGNCI4FM55CRmy2X5CbF7MrIWKcbA7+xT1AzxZQysOD2uer8Ugs8D5JaIlzoChrYXn
         tMXRpVvD54gI2Kl4xt9xGHfKTXBHNquWTGYm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IEMbJENmoZLXKePiWek5YqrFsU33ooTt7wfBA1G1VSY=;
        b=ZhbAxSM/KP6RxLt3ch8ZK9N7ZYSyHuZR7iu7zUTY4nOcdndPSXBNHX3HN2+aa/rxVB
         E252KtY3DO0rq3ToW1DnnML9dFo5yTU+P3yOdAFy9efJ+zkPGdNoNCjuNPzxcSPMLlAo
         rxHctlOf2RmHqLxjMazX3wYVadAlXng0MSZxXNzHFJ0c9nK6V930CWkDwRNMYZfxcb1r
         hbXmWtkLUX4CjpKPAU3L7SDLh84tZUD+3Xb7xrE0Xins8SXdLLGRGhAWUOh8jsfmY//c
         +kLKv9K+Z2B4Tks+FkSSeumqnzxLveirmwCxegyp27KNREay0syOK0A+i+AP5U/0ywoD
         Gzrg==
X-Gm-Message-State: AGRZ1gJfzX1LLNqerZD3yS9IlHobC0IBd3GVQDMnO9WSlWodUs49UQUU
        Ycl5myibT7os5fe+H2yCi0Heuw==
X-Google-Smtp-Source: AJdET5dA0sJivKAz2CJ9ieeU8+fA6MHJY304XXauK7SlFiCe29jdMbuXWp9eSPA/xkEms5Z8+Dv+Ag==
X-Received: by 2002:a0c:d7d1:: with SMTP id g17mr4987933qvj.183.1541693109861;
        Thu, 08 Nov 2018 08:05:09 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id f30-v6sm3506210qtf.50.2018.11.08.08.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 08:05:08 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 8 Nov 2018 11:05:07 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Vince Weaver <vincent.weaver@maine.edu>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        torvalds@linux-foundation.org
Subject: Re: perf: perf_fuzzer triggers NULL pointer dereference
In-Reply-To: <alpine.DEB.2.21.1811081041070.7406@macbook-air>
Message-ID: <alpine.DEB.2.21.1811081100490.7406@macbook-air>
References: <alpine.DEB.2.21.1811081041070.7406@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018, Vince Weaver wrote:

> [91760.326510] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> [91760.334876] PGD 0 P4D 0 
> [91760.337596] Oops: 0000 [#1] SMP PTI
> [91760.341332] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G        W         4.20.0-rc1+ #119
> [91760.349816] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014
> [91760.357723] RIP: 0010:perf_prepare_sample+0x82/0x4a0

so what's the best way to do the equivelent of addr2line on something like 
this, now that we aren't allowed to know the RIP anymore?

I probably knew at one point but I've spent the last 3 months doing 6502 
assembly language Demoscene coding and so apparently I've forgotten 
everything I once knew about x86_64 kernel interfaces.  (As can be 
imagined, Demoscene coding work is a lot more mentally rewarding than 
perf_fuzzer work).

Vince


