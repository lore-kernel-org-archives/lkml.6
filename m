Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9482DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA9320898
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA9320898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeH1QMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:12:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727085AbeH1QMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:12:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79F872634A;
        Tue, 28 Aug 2018 12:21:18 +0000 (UTC)
Received: from krava (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id 35F1B2026D6B;
        Tue, 28 Aug 2018 12:21:17 +0000 (UTC)
Date:   Tue, 28 Aug 2018 14:21:16 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2]: perf record: enable asynchronous trace writing
Message-ID: <20180828122116.GJ23727@krava>
References: <bdd669cd-a6dc-d592-4655-33b7bfc46cbb@linux.intel.com>
 <6f83f9cd-263e-b073-487f-4c7570105a7d@linux.intel.com>
 <20180828085703.GG23727@krava>
 <38f9158b-dca5-2b09-99cb-f12bb62ad5dc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38f9158b-dca5-2b09-99cb-f12bb62ad5dc@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 28 Aug 2018 12:21:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 28 Aug 2018 12:21:18 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 02:31:04PM +0300, Alexey Budankov wrote:
> Hi,
> 
> On 28.08.2018 11:57, Jiri Olsa wrote:
> > On Mon, Aug 27, 2018 at 09:16:55PM +0300, Alexey Budankov wrote:
> > 
> > SNIP
> > 
> >> +	int trace_fd = rec->session->data->file.fd;
> >> +	struct aiocb **mmap_aio = rec->evlist->mmap_aio;
> >> +	int mmap_aio_size = 0;
> >> +	off_t off;
> >>  
> >>  	if (!evlist)
> >>  		return 0;
> >> @@ -528,14 +632,17 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
> >>  	if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
> >>  		return 0;
> >>  
> >> +	off = lseek(trace_fd, 0, SEEK_CUR);
> >> +
> >>  	for (i = 0; i < evlist->nr_mmaps; i++) {
> >>  		struct auxtrace_mmap *mm = &maps[i].auxtrace_mmap;
> >>  
> >>  		if (maps[i].base) {
> >> -			if (perf_mmap__push(&maps[i], rec, record__pushfn) != 0) {
> >> -				rc = -1;
> >> +			rc = perf_mmap__push(&maps[i], rec, record__pushfn, &off);
> >> +			if (rc < 0)
> >>  				goto out;
> >> -			}
> >> +			else if (rc > 0)
> >> +				mmap_aio[mmap_aio_size++] = &maps[i].cblock;
> > 
> > I understand the purpose of mmap_aio array, but I don't see a reason
> > to fill it in every time we call record__mmap_read_evlist
> 
> The cycle trips the same number of iterations over kernel buffers 
> for every call of record__mmap_read_evlist(). Called perf_mmap__push() 
> checks if there is data ready for spill in the corresponding buffer 
> and if there is no such data returns 0. So every time we execute 
> the cycle we get different set of buffers to spill and in this 
> circumstances dynamic filling of mmap_aio looks preferable.
> Lifetime management of perf_mmap object and referenced memory 
> is not related another thing.

argh.. the perf_mmap__push returns 0 for empty buffer, ok

jirka
