Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FAEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FB72086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y/Vbw2dE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FB72086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbeKTCeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:34:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729796AbeKTCeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:34:11 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 468A620851;
        Mon, 19 Nov 2018 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542643809;
        bh=4mGBPujs40fWNNjSxex+U3yEF4zy9v4zzvfgc0PDaSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y/Vbw2dEHYOTASPaB8aT/uz2GopIRvEHbpPLiE0akB1wmdh8aTaQ1ew3BhePVw5JL
         wfQJpz+iA9ooW+/pzWJBlm8dMkkRaxPJ8TsQTTdq5edlxz55OYaclZ8oJ/ULmcj9Of
         xBxlKoPhmJyB1/nR8FYfkDbG7BmTY4tJaH3m8+RQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id D0E3D1443D6; Mon, 19 Nov 2018 08:10:06 -0800 (PST)
Date:   Mon, 19 Nov 2018 08:10:06 -0800
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Restore proper cwd on return from mnt ns
Message-ID: <20181119161006.GA13850@kernel.org>
References: <20181101170001.30019-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101170001.30019-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 01, 2018 at 06:00:01PM +0100, Jiri Olsa escreveu:
> Adding the current working directory to be part of the cookie
> and restoring it in the nsinfo__mountns_exit call.
 
> diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
> index cf8bd123cf73..fb0458b7e6aa 100644
> --- a/tools/perf/util/namespaces.c
> +++ b/tools/perf/util/namespaces.c

> @@ -199,9 +201,13 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
>  	if (snprintf(curpath, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
>  		return;
  
> +	oldcwd = get_current_dir_name();

Breaks the build with bionic (Android), where get_current_dir_name() is
not available:

/tmp/build/perf/libperf.a(libperf-in.o):hist.c:function nsinfo__mountns_enter: error: undefined reference to 'get_current_dir_name'
collect2: error: ld returned 1 exit status
Makefile.perf:534: recipe for target '/tmp/build/perf/perf' failed
make[2]: *** [/tmp/build/perf/perf] Error 1
Makefile.perf:206: recipe for target 'sub-make' failed
make[1]: *** [sub-make] Error 2
Makefile:69: recipe for target 'all' failed
make: *** [all] Error 2
make: Leaving directory '/git/linux/tools/perf'
[root@seventh ~]# 

The container builds are ongoing, its possoble that this becomes an
issue in uCLibc, wasn't on musl libc (Alpine Linux).

- Arnaldo
