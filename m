Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD91DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F7E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXgucmk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F7E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbeK0XeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:34:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729426AbeK0Xdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:33:46 -0500
Received: from quaco.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63D5B2145D;
        Tue, 27 Nov 2018 12:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543322158;
        bh=OgDuSj1WrD6ffvKScfPb19Y7IQpo+TYr7IkNvlVvj9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jXgucmk4ZRiVUjRBF+bLYSHepJTZSp5gHFLWZ75F1ruBaoSeLR3pgiHIJMaS7cszQ
         IVD8YCyCfgaSdXnxRVDzup0rP6QQCB5bT2NHRWhlxlSahXmQg3seqgbTA6H7oVxGxy
         +6ZBlFf55Odd8TqvyEt5VpZ7FOH383Qe4nD3PONE=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id 4EADF4111C; Mon, 26 Nov 2018 15:45:40 -0300 (-03)
Date:   Mon, 26 Nov 2018 15:45:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        yuzhoujian@didichuxing.com, tmricht@linux.vnet.ibm.com,
        anton@samba.org
Subject: Re: [PATCH] perf stat: Fix shadow stats for clock events
Message-ID: <20181126184540.GC5518@kernel.org>
References: <20181115141745.GJ9600@krava>
 <20181116042843.24067-1-ravi.bangoria@linux.ibm.com>
 <20181116133555.GA30465@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116133555.GA30465@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 16, 2018 at 02:35:55PM +0100, Jiri Olsa escreveu:
> On Fri, Nov 16, 2018 at 09:58:43AM +0530, Ravi Bangoria wrote:
> > Commit 0aa802a79469 ("perf stat: Get rid of extra clock display
> > function") introduced scale and unit for clock events. Thus,
> > perf_stat__update_shadow_stats() now saves scaled values of
> > clock events in msecs, instead of original nsecs. But while
> > calculating values of shadow stats we still consider clock
> > event values in nsecs. This results in a wrong shadow stat
> > values. Ex,
> > 
> >   # ./perf stat -e task-clock,cycles ls
> >     <SNIP>
> >               2.60 msec task-clock:u    #    0.877 CPUs utilized
> >          2,430,564      cycles:u        # 1215282.000 GHz
> > 
> > Fix this by saving original nsec values for clock events in
> > perf_stat__update_shadow_stats(). After patch:
> > 
> >   # ./perf stat -e task-clock,cycles ls
> >     <SNIP>
> >               3.14 msec task-clock:u    #    0.839 CPUs utilized
> >          3,094,528      cycles:u        #    0.985 GHz
> > 
> > Reported-by: Anton Blanchard <anton@samba.org>
> > Suggested-by: Jiri Olsa <jolsa@redhat.com>
> > Fixes: 0aa802a79469 ("perf stat: Get rid of extra clock display function")
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
