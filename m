Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CF8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FAD20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547816472;
	bh=LwWz5DEjqY1exz+w190/9lABtDyyXJb2rwYdsRiMoNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xBSCohjtb+ZczlYJ5aQZWM+aU4/MraFJmeNIlHHsN4j8t1g1u9ByLN9QY7FonwdKf
	 9wUlivRIIcDVP2ELTZlt3MHMwKb9jbMCEA1y3PavgR5+JEcwXiHRpf6YZerS3x1fZP
	 8ELfbmemIV7qOXiSSXJBAQzPdP0RqeYSPcAkmfyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfARNBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:01:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfARNBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:01:10 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.100.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19AD720823;
        Fri, 18 Jan 2019 13:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547816469;
        bh=LwWz5DEjqY1exz+w190/9lABtDyyXJb2rwYdsRiMoNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UBoEH/EzEkP5+++/nbWaSTYotWFNgfa+z9OEhFeQf96ZBZbW+dfQrpM+Hdxyorn3Y
         w9PB1NTjrE4kYQVJgL2rLicUhJiI9HKmiq/Hqn26ImSwlEVO0UqcWTLgPAp3A0wcTn
         scKgC/+jDO6Rt9BBJl83qlmSQKA9tun2Wac4KdGk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6F38341AB5; Fri, 18 Jan 2019 10:01:06 -0300 (-03)
Date:   Fri, 18 Jan 2019 10:01:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf, script: Fix crash with printing mixed trace point
 and other events
Message-ID: <20190118130106.GH5823@kernel.org>
References: <20190117194834.21940-1-andi@firstfloor.org>
 <20190118094919.GA28346@krava>
 <20190118125920.GG5823@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118125920.GG5823@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 18, 2019 at 09:59:20AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jan 18, 2019 at 10:49:19AM +0100, Jiri Olsa escreveu:
> > On Thu, Jan 17, 2019 at 11:48:34AM -0800, Andi Kleen wrote:
> > > From: Andi Kleen <ak@linux.intel.com>
> 
> > > perf script crashes currently when printing mixed trace points and other
> > > events because the trace format does not handle events without trace
> > > meta data. Add a simple check to avoid that.
> 
> > > % cat > test.c
> > > main()
> > > {
> > >     printf("Hello world\n");
> > > }
> > > ^D
> > > % gcc -g -o test test.c
> > > % sudo perf probe -x test 'test.c:3'
> > > % perf record -e '{cpu/cpu-cycles,period=10000/,probe_test:main}:S' ./test
> > > % perf script
> > > <segfault>
> 
> > > Signed-off-by: Andi Kleen <ak@linux.intel.com>
>  
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Thanks, tested and applied.
> 
> While testing I found something odd, the cycles events are not showing
> the CPU and the probe events shows a "negative" CPU column,
> investigating.

The sample_type for those two events:

[root@quaco wb]# perf evlist -v
cpu/cpu-cycles,period=10000/: type: 4, size: 112, config: 0x3c, { sample_period, sample_freq }: 10000, sample_type: IP|TID|TIME|READ|IDENTIFIER, read_format: ID|GROUP, disabled: 1, mmap: 1, comm: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1
probe_libc:malloc: type: 2, size: 112, config: 0x790, sample_type: IP|TID|TIME|READ|CPU|PERIOD|RAW|IDENTIFIER, read_format: ID|GROUP, sample_id_all: 1, exclude_guest: 1
# Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events
[root@quaco wb]#

- Arnaldo
