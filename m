Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02957C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FE52075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FE52075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeJHTud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:50:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeJHTud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:50:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B52A58831F;
        Mon,  8 Oct 2018 12:39:01 +0000 (UTC)
Received: from krava (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id 13E5D17497;
        Mon,  8 Oct 2018 12:38:59 +0000 (UTC)
Date:   Mon, 8 Oct 2018 14:38:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/3]: perf util: map data buffer for preserving
 collected data
Message-ID: <20181008123859.GD18757@krava>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <0ff162a6-67ab-9e73-8d7e-fa57c932ee45@linux.intel.com>
 <20181008105057.GD17270@krava>
 <f8ac7176-26a4-7114-3807-abdaffaa897c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8ac7176-26a4-7114-3807-abdaffaa897c@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 08 Oct 2018 12:39:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 03:03:18PM +0300, Alexey Budankov wrote:
> Hi,
> 
> On 08.10.2018 13:50, Jiri Olsa wrote:
> > On Mon, Oct 08, 2018 at 09:14:29AM +0300, Alexey Budankov wrote:
> <SNIP>
> >>  
> >> +#ifdef HAVE_AIO_SUPPORT
> >> +static void perf_mmap__aio_munmap(struct perf_mmap *map)
> >> +{
> >> +	if (map->data)
> >> +		zfree(&map->data);
> >> +}
> > 
> > if we really need to keep this optional for compilation,
> > please make it as single block with dummy functions
> > for when it's not compiled in, like:
> > 
> > #ifdef 
> > static void perf_mmap__aio_munmap(struct perf_mmap *map)
> > {
> > 	if (map->data)
> > 		zfree(&map->data);
> > }
> > #else
> > static void perf_mmap__aio_munmap(struct perf_mmap *map) { }
> > #endif
> 
> Ok.
> 
> > 
> > thanks,
> > jirka
> > 
> > 
> >> +#endif
> >> +
> >>  void perf_mmap__munmap(struct perf_mmap *map)
> >>  {
> >> +#ifdef HAVE_AIO_SUPPORT
> >> +	perf_mmap__aio_munmap(map);
> >> +#endif
> >>  	if (map->base != NULL) {
> >>  		munmap(map->base, perf_mmap__mmap_len(map));
> >>  		map->base = NULL;
> >> @@ -164,8 +175,40 @@ void perf_mmap__munmap(struct perf_mmap *map)
> >>  	auxtrace_mmap__munmap(&map->auxtrace_mmap);
> >>  }
> 
> Well, let's go with stub functions design as opposite to pure 
> conditional compilation. However this may, probably, result in 
> unintended Perf tool binary size growth, even if NO_AIO is 
> defined during compilation.

hum, empty functions are be optimized out

jirka
