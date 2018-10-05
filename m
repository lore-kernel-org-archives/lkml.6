Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B132C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4711B208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4711B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbeJEPql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:46:41 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:55213 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbeJEPql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:46:41 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.51 with ESMTP; 5 Oct 2018 17:48:54 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.151 with ESMTP; 5 Oct 2018 17:48:54 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Fri, 5 Oct 2018 17:48:54 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Subject: Re: [PATCH v9 2/3]: perf record: enable asynchronous trace writing
Message-ID: <20181005084854.GE3768@sejong>
References: <ded47c34-9e92-6bd2-9522-a927a7237011@linux.intel.com>
 <5ed78452-ff2b-dfe5-ec29-888971cb4b55@linux.intel.com>
 <20181005071615.GC3768@sejong>
 <dc944fcf-cbb6-9b88-bc1c-606eb027a6ac@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc944fcf-cbb6-9b88-bc1c-606eb027a6ac@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 11:31:11AM +0300, Alexey Budankov wrote:
> Hi,

Hi,

> 
> On 05.10.2018 10:16, Namhyung Kim wrote:
> > On Wed, Oct 03, 2018 at 07:12:10PM +0300, Alexey Budankov wrote:
> <SNIP>
> >> +static void record__aio_sync(struct perf_mmap *md)
> >> +{
> >> +	struct aiocb *cblock = &md->cblock;
> >> +	struct timespec timeout = { 0, 1000 * 1000  * 1 }; // 1ms
> >> +
> >> +	do {
> >> +		if (cblock->aio_fildes == -1 || record__aio_complete(md, cblock))
> >> +			return;
> >> +
> >> +		while (aio_suspend((const struct aiocb**)&cblock, 1, &timeout)) {
> >> +			if (!(errno == EAGAIN || errno == EINTR))
> >> +				pr_err("failed to sync perf data, error: %m\n");
> > 
> > Is there somthing we can do in this error case?  Any chance it gets
> > stuck in the loop?
> 
> Not really. Currently, in glibc, it can block on a mutex only.

OK, I was thinking of a situation where the aio_suspend() keeps
returning a same error code repeated..


> 
> > 
> > 
> >> +		}
> >> +	} while (1);
> >> +}
> >> +
> >> +static int record__aio_pushfn(void *to, struct aiocb *cblock, void *bf, size_t size)
> >> +{
> >> +	off_t off;
> >> +	struct record *rec = to;
> >> +	int ret, trace_fd = rec->session->data->file.fd;
> >> +
> >> +	rec->samples++;
> >> +
> >> +	off = lseek(trace_fd, 0, SEEK_CUR);
> >> +	lseek(trace_fd, off + size, SEEK_SET);
> > 
> > It'd be nice if these lseek() could be removed and use
> > rec->bytes_written instead.
> 
> Well, this could be implemented like this avoiding lseek() in else branch:
> 
> 	off = lseek(trace_fd, 0, SEEK_CUR);
> 	ret = record__aio_write(cblock, trace_fd, bf, size, off);
> 	if (!ret) {
> 		lseek(trace_fd, off + size, SEEK_SET);
> 		rec->bytes_written += size;
> 
> 		if (switch_output_size(rec))
> 			trigger_hit(&switch_output_trigger);
> 	}

Oh I meant the both like:

	off = rec->bytes_written;
 	ret = record__aio_write(cblock, trace_fd, bf, size, off);
 	if (!ret) {
 		rec->bytes_written += size;

		...


> > 
> > 
> >> +	ret = record__aio_write(cblock, trace_fd, bf, size, off);
> >> +	if (!ret) {
> >> +		rec->bytes_written += size;
> >> +
> >> +		if (switch_output_size(rec))
> >> +			trigger_hit(&switch_output_trigger);
> > 
> > Doesn't it need the _sync() before the trigger?  Maybe it should be
> > moved to record__mmap_read_evlist() or so..
> 
> Currently trigger just updates variable state.
> The state is then checked thru separate API at __cmd_record() where 
> record__mmap_read_sync() is called prior switching to a new trace file 
> or finishing collection.
> 
> >>  
> <SNIP>
> >>  		if (map->base) {
> >> +#ifndef HAVE_AIO_SUPPORT
> >>  			if (perf_mmap__push(map, rec, record__pushfn) != 0) {
> >>  				rc = -1;
> >>  				goto out;
> >>  			}
> >> +#else
> >> +			if (!rec->opts.nr_cblocks) {
> >> +				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
> >> +					rc = -1;
> >> +					goto out;
> >> +				}
> >> +			} else {
> >> +				/*
> >> +				 * Call record__aio_sync() to wait till map->data buffer
> >> +				 * becomes available after previous aio write request.
> >> +				 */
> >> +				record__aio_sync(map);
> >> +				if (perf_mmap__aio_push(map, rec, record__aio_pushfn) != 0) {
> >> +					rc = -1;
> >> +					goto out;
> >> +				}
> >> +			}
> >> +#endif
> > 
> > If dummy aio functions are provided, the #ifdef can be removed and
> > just use the #else part assuming opts.nr_cblocks == 0.
> 
> Yes, it looks a little bit cumbersome. Would this be more compact?

Why not exposing opts.nr_cblocks regardless of the #ifdef?  It'll have
0 when it's not compiled in.  Then it could be like below (assuming
you have all the dummy aio funcitons):


> 
> 		if (map->base) {
> 			if (!rec->opts.nr_cblocks) {
> 				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
> 					rc = -1;
> 					goto out;
> 				}
> 			} else {
> 				int idx;
> 				/*
> 				 * Call record__aio_sync() to wait till map->data buffer
> 				 * becomes available after previous aio write request.
> 				 */
> 				idx = record__aio_sync(map, false);
> 				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn) != 0) {
> 					rc = -1;
> 					goto out;
> 				}
> 			}
> 		}
> 

Thanks,
Namhyung

