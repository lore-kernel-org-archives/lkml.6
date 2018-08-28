Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A8BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48532089E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48532089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeH1MgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:36:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726975AbeH1MgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:36:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCD7D26A3D;
        Tue, 28 Aug 2018 08:45:24 +0000 (UTC)
Received: from krava (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id 54FA8A9E7A;
        Tue, 28 Aug 2018 08:45:23 +0000 (UTC)
Date:   Tue, 28 Aug 2018 10:45:22 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2]: perf util: map data buffer for preserving
 collected data
Message-ID: <20180828084522.GD23727@krava>
References: <e92805d0-3338-2ce5-5e88-369d406fe0a7@linux.intel.com>
 <e5591d27-5386-1d41-b09b-421316f75d07@linux.intel.com>
 <20180827083303.GD24695@krava>
 <2284a8e8-d90e-bd99-89c1-0b125ba2e205@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2284a8e8-d90e-bd99-89c1-0b125ba2e205@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 28 Aug 2018 08:45:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 28 Aug 2018 08:45:24 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 12:02:35PM +0300, Alexey Budankov wrote:
> Hi,
> 
> On 27.08.2018 11:33, Jiri Olsa wrote:
> > On Thu, Aug 23, 2018 at 07:42:09PM +0300, Alexey Budankov wrote:
> > 
> > SNIP
> > 
> >> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> >> index fc832676a798..e71d46cb01cc 100644
> >> --- a/tools/perf/util/mmap.c
> >> +++ b/tools/perf/util/mmap.c
> >> @@ -155,6 +155,10 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
> >>  
> >>  void perf_mmap__munmap(struct perf_mmap *map)
> >>  {
> >> +	if (map->data != NULL) {
> >> +		munmap(map->data, perf_mmap__mmap_len(map));
> >> +		map->data = NULL;
> >> +	}
> >>  	if (map->base != NULL) {
> >>  		munmap(map->base, perf_mmap__mmap_len(map));
> >>  		map->base = NULL;
> >> @@ -190,6 +194,14 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
> >>  		map->base = NULL;
> >>  		return -1;
> >>  	}
> >> +	map->data = mmap(NULL, perf_mmap__mmap_len(map), PROT_READ | PROT_WRITE,
> >> +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > 
> > hum, why does map->data need to be mmap-ed?
> 
> The same way as for kernel buffers. If you see better alternatives it could be applied.

I meant why not just allocate them with mmaloc?

jirka
