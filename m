Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8A4C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE5C20873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOcSch0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfBKISq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:18:46 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43626 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKISq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:18:46 -0500
Received: by mail-pl1-f194.google.com with SMTP id f90so4727119plb.10;
        Mon, 11 Feb 2019 00:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qHB90A5LkE/SiEu5CM908fsd2TysXNxpX8MCxMMBXHU=;
        b=eOcSch0Vh5/7WT3fB2QbvHaDD9GqqxqRo730aDAijSAfqUwrieehYnxI4XXoIh1gHT
         ZUmgJMoDqGtdLEWVT823/ZrcA3wgH2mgYv5Z2uZccx3jWmYsvsRb8gbAM0Ldp32yjskP
         GNA29FA7wGtbQVqsVxvq1lwozafkOAVAWVFC5bvhCVEhjM1LHDFXvsNh8Iq7OL4qwPGc
         mwrCJH+qn15no7ow38w8df56FEndlzldCRmVrkd94/idRhQTHw6FPtijExLlUKqDQrAU
         d3SnGZMqBa26+yahIEpxuF0yza7EmyWRWig6Gsw5t7aCPmnjA08WqI0IQgMDRDVWYBl5
         dN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qHB90A5LkE/SiEu5CM908fsd2TysXNxpX8MCxMMBXHU=;
        b=JIiQ3Mz/N7b3x4p1rE0uv/wUJIdLUlgOJfokU41LNqseFd5jM8j9hYytIwrJvjTTTq
         yq842cUI5hn45bbnjOIcwIgFA0k846myCMTxVwjvaIvHqhvjoOrmnMSkicRF0xr94Bry
         mDS/Nx1JiZz33AWQyAKHNqHsKqDy4QSTUX21tYTN85ryPQ91G+jUsz1hHGl39wKwEow4
         FVQZc1TjQLbSPzWiuncFTpTDvF7/Q+GzxFtO4TavM9yxs/XrsnIOt91vNWL/Rt4X8IzL
         PAi2PoPPje2JHT+2ru7loA41MbY9EyuIYutpWqazsfzQ2F871D/KKbJ24NlZ7JHUEm4t
         TmSg==
X-Gm-Message-State: AHQUAuZOAPMLtVe+bNIpIbQU8g+iiL3KVMC4sMo0SVopEPqclXaLDM+J
        a9Y9bDTWC7ncof5mg5PXqJE=
X-Google-Smtp-Source: AHgI3IYRrxf/dxjKSMQXzZoKXc2/DjjawvfpWAEs+9SI//ll4nKG7dUC6AxykrpE6Peqr+mLL5EVVQ==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr36621679plr.128.1549873125405;
        Mon, 11 Feb 2019 00:18:45 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:180::1:1024])
        by smtp.gmail.com with ESMTPSA id 63sm12909740pfy.110.2019.02.11.00.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 00:18:44 -0800 (PST)
Date:   Mon, 11 Feb 2019 00:18:42 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH] perf, bpf: Retain kernel executable code in memory
 to aid Intel PT tracing
Message-ID: <20190211081840.j3vhyp3cffftb6m2@ast-mbp>
References: <20190207111901.2399-1-adrian.hunter@intel.com>
 <20190208232924.bpdjuaqufndigtd4@ast-mbp>
 <85ebb8e5-97a0-801a-8d5f-bc09a72047bb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85ebb8e5-97a0-801a-8d5f-bc09a72047bb@intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 09:54:01AM +0200, Adrian Hunter wrote:
> 
> Which is not really a real use-case.
..
> > perf analysis with PT becomes inaccurate and main goal
> > of retaining accurate instruction info is not achieved.
> 
> For the majority of real use-cases, yes it is.

In our fleet not a single server is using Intel PT, yet you're
proposing to penalize all of them with shrinker-based JIT freeing?
There is no negotiation here.
NACK

