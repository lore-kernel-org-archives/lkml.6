Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF26BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B928320862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzWNTT35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B928320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbeKGEkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387537AbeKGEkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:40:10 -0500
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04C9E20827;
        Tue,  6 Nov 2018 19:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541531609;
        bh=/B5fdhe/LCl7v5Tn3pTQHCA5SryMjYPhLl3nUGmhO3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bzWNTT35UyfMccIAWLlZQ4TLl0Ls0khj7OFkX9+CNaUVSTWzjeROMtF5HGlHa7jE2
         lT0QycGVlqdsMQT6clCZNqHCZuKAb9/qgEnYdtShJaDeu9HEy1GODMV9cR0/edDbKJ
         K9yoPkaSvbU4DtyBSdgTmbEUgDyeY86gWf2tSiUc=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id D8333142D18; Tue,  6 Nov 2018 16:13:25 -0300 (-03)
Date:   Tue, 6 Nov 2018 16:13:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, jbaron@akamai.com,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/2] perf-bench: Add epoll parallel epoll_wait benchmark
Message-ID: <20181106191325.GM7077@kernel.org>
References: <20181106152226.20883-1-dave@stgolabs.net>
 <20181106152226.20883-2-dave@stgolabs.net>
 <20181106182349.thdkpvshkna5vd7o@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106182349.thdkpvshkna5vd7o@linux-r8p5>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 06, 2018 at 10:23:49AM -0800, Davidlohr Bueso escreveu:
> Mind this fixlet for using et/oneshot and the multiq option.

Yes sir, applied the fixup to the first patch in the series, applied the
second, tested, merged.

- Arnaldo
 
> diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
> index c4c5ef60feb4..4e4efc5cfe22 100644
> --- a/tools/perf/bench/epoll-wait.c
> +++ b/tools/perf/bench/epoll-wait.c
> @@ -215,13 +215,13 @@ static void *workerfn(void *arg)
> 
> 		if (et) {
> 			ev.events = EPOLLIN | EPOLLET;
> -			ret = epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev);
> +			ret = epoll_ctl(efd, EPOLL_CTL_ADD, fd, &ev);
> 		}
> 
> 		if (oneshot) {
> 			/* rearm the file descriptor with a new event mask */
> 			ev.events |= EPOLLIN | EPOLLONESHOT;
> -			ret = epoll_ctl(epollfd, EPOLL_CTL_MOD, fd, &ev);
> +			ret = epoll_ctl(efd, EPOLL_CTL_MOD, fd, &ev);
> 		}
> 
> 		ops++;
> @@ -249,7 +249,7 @@ static void nest_epollfd(struct worker *w)
> 
> 	for (i = 0; i < nested; i++) {
> 		epollfdp[i] = epoll_create(1);
> -		if (epollfd < 0)
> +		if (epollfdp[i] < 0)
> 			err(EXIT_FAILURE, "epoll_create");
> 	}
> 
