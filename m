Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB71C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D97720661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yPQopcs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D97720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeH3WyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:54:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbeH3WyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:54:06 -0400
Received: from jouet.infradead.org (unknown [189.43.51.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E8B7205F4;
        Thu, 30 Aug 2018 18:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535655033;
        bh=n9F6AzQMSS0Zpr7/zZgP12eOlMwdFpq3YhYoAGdW49I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yPQopcs+BXtSUpQBdZGV9wLiBHCZ+CVI0U7LrivdFFUVkxNbcaDAZhyx5zNndNHtu
         BU4dSdfB2F2ioay1qmrC6tVX1ksWi2jsDG2G6rAIYu1OnhG4YFxOmQQ1V9NramSqtD
         wLKcDeyPViVPwhSYB6W5tqO8/f7pWbXib56JKQlY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 0F18B141C3F; Thu, 30 Aug 2018 15:50:27 -0300 (-03)
Date:   Thu, 30 Aug 2018 15:50:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        srikar@linux.vnet.ibm.com, oleg@redhat.com, mhiramat@kernel.org,
        liu.song.a23@gmail.com, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v9 4/4] perf probe: Support SDT markers having reference
 counter (semaphore)
Message-ID: <20180830185026.GI6097@kernel.org>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <20180820044250.11659-5-ravi.bangoria@linux.ibm.com>
 <20180830144531.3011e185@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830144531.3011e185@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 30, 2018 at 02:45:31PM -0400, Steven Rostedt escreveu:
> 
> Arnaldo,
> 
> I'm going to be playing with some of the probe code which may conflict
> with these patches, so I would like to pull these in my tree. But this
> patch requires an Acked-by from you before I can pull it in.
> 
> You OK with this?

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Thanks!
> 
> -- Steve
> 
> 
> On Mon, 20 Aug 2018 10:12:50 +0530
> Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:
> 
> > With this, perf buildid-cache will save SDT markers with reference
> > counter in probe cache. Perf probe will be able to probe markers
> > having reference counter. Ex,
> > 
> >   # readelf -n /tmp/tick | grep -A1 loop2
> >     Name: loop2
> >     ... Semaphore: 0x0000000010020036
> > 
> >   # ./perf buildid-cache --add /tmp/tick
> >   # ./perf probe sdt_tick:loop2
> >   # ./perf stat -e sdt_tick:loop2 /tmp/tick
> >     hi: 0
> >     hi: 1
> >     hi: 2
> >     ^C
> >      Performance counter stats for '/tmp/tick':
> >                  3      sdt_tick:loop2
> >        2.561851452 seconds time elapsed
> > 
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
