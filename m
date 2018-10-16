Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1A2C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD2A20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzC4JrpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD2A20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeJPWzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbeJPWzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:55:05 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D87205C9;
        Tue, 16 Oct 2018 15:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539702253;
        bh=ULzu8A0DDmMqQAnQMTOyDRrCPG2MM4nSmvlC8LEOLCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GzC4JrpRDxyqAZLUiAqxVsMpSckh/WXf8czn3/b4H1O4t8bgNguugR2aznYmNXqhd
         Ppmbq4mNljpxJxlVQuWpBV+CecGXsiGSoiye0NHQUTOrGbsA9PpJ0EE29x2Vtlmvj/
         h4YI5ST0m9cenfmTBq3BS69OzzcnFAtx3PRWFweE=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id A8AF6142C5E; Tue, 16 Oct 2018 12:04:10 -0300 (-03)
Date:   Tue, 16 Oct 2018 12:04:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jarod Wilson <jarod@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] tools/perf: fix use of alternatives to find JDIR
Message-ID: <20181016150410.GA3849@kernel.org>
References: <20180906221812.11167-1-jarod@redhat.com>
 <20180910080546.GA31644@krava>
 <20181016130959.GA6979@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016130959.GA6979@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 16, 2018 at 03:09:59PM +0200, Jiri Olsa escreveu:
> On Mon, Sep 10, 2018 at 10:05:46AM +0200, Jiri Olsa wrote:
> > On Thu, Sep 06, 2018 at 06:18:12PM -0400, Jarod Wilson wrote:
> > > When a build is run from something like a cron job, the user's $PATH is
> > > rather minimal, of note, not including /usr/sbin in my own case. Because
> > > of that, an automated rpm package build ultimately fails to find
> > > libperf-jvmti.so, because somewhere within the build, this happens...
> > > 
> > > /bin/sh: alternatives: command not found
> > > /bin/sh: alternatives: command not found
> > > Makefile.config:849: No openjdk development package found, please install
> > > JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
> > > 
> > > ...and while the build continues, libperf-jvmti.so isn't built, and things
> > > fall down when rpm tries to find all the %files specified. Exact same
> > > system builds everything just fine when the job is launched from a login
> > > shell instead of a cron job, since alternatives is in $PATH, so openjdk is
> > > actually found.
> > > 
> > > The test required to get into this section of code actually specifies the
> > > full path, as does a block just above it, so let's do that here too.
> > > 
> > > CC: Peter Zijlstra <peterz@infradead.org>
> > > CC: Ingo Molnar <mingo@redhat.com>
> > > CC: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > CC: Jiri Olsa <jolsa@redhat.com>
> > > CC: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Jarod Wilson <jarod@redhat.com>
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> Arnaldo,
> could you please pull in this one?

Sure, I thought I had already, will now.

- Arnaldo
