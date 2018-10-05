Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF09C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FF92064E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FF92064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeJERyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:54:16 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:48770 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727965AbeJERyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 13:54:15 -0400
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.52 with ESMTP; 5 Oct 2018 19:55:57 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.127 with ESMTP; 5 Oct 2018 19:55:57 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Fri, 5 Oct 2018 19:55:57 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Subject: Re: [PATCH v9 2/3]: perf record: enable asynchronous trace writing
Message-ID: <20181005105557.GF3768@sejong>
References: <ded47c34-9e92-6bd2-9522-a927a7237011@linux.intel.com>
 <5ed78452-ff2b-dfe5-ec29-888971cb4b55@linux.intel.com>
 <20181005071615.GC3768@sejong>
 <dc944fcf-cbb6-9b88-bc1c-606eb027a6ac@linux.intel.com>
 <20181005084854.GE3768@sejong>
 <4ee1c347-674b-ac61-65cf-55fb71a7cc2b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ee1c347-674b-ac61-65cf-55fb71a7cc2b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 05, 2018 at 12:39:10PM +0300, Alexey Budankov wrote:
> Hi,
> 
> On 05.10.2018 11:48, Namhyung Kim wrote:
> > On Fri, Oct 05, 2018 at 11:31:11AM +0300, Alexey Budankov wrote:
> <SNIP>
> >>
> >> Well, this could be implemented like this avoiding lseek() in else branch:
> >>
> >> 	off = lseek(trace_fd, 0, SEEK_CUR);
> >> 	ret = record__aio_write(cblock, trace_fd, bf, size, off);
> >> 	if (!ret) {
> >> 		lseek(trace_fd, off + size, SEEK_SET);
> >> 		rec->bytes_written += size;
> >>
> >> 		if (switch_output_size(rec))
> >> 			trigger_hit(&switch_output_trigger);
> >> 	}
> > 
> > Oh I meant the both like:
> > 
> > 	off = rec->bytes_written;
> >  	ret = record__aio_write(cblock, trace_fd, bf, size, off);
> >  	if (!ret) {
> >  		rec->bytes_written += size;
> > 
> > 		...
> > 
> 
> It still have to adjust the file pos thru lseek() prior leaving 
> record__aio_pushfn() so space in trace file would be pre-allocated for 
> enqueued record and file pos be moved beyond the record data, 
> possibly for the next record.

For that purpose, isn't it better calling ftruncate() with a
reasonable batch size to reduce number of syscalls?


> 
> > 
> <SNIP>
> > 
> > Why not exposing opts.nr_cblocks regardless of the #ifdef?  It'll have
> > 0 when it's not compiled in.  Then it could be like below (assuming
> > you have all the dummy aio funcitons):
> > 
> > 
> >>
> >> 		if (map->base) {
> >> 			if (!rec->opts.nr_cblocks) {
> >> 				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
> >> 					rc = -1;
> >> 					goto out;
> >> 				}
> >> 			} else {
> >> 				int idx;
> >> 				/*
> >> 				 * Call record__aio_sync() to wait till map->data buffer
> >> 				 * becomes available after previous aio write request.
> >> 				 */
> >> 				idx = record__aio_sync(map, false);
> >> 				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn) != 0) {
> >> 					rc = -1;
> >> 					goto out;
> >> 				}
> >> 			}
> >> 		}
> >>
> 
> Well, if it has AIO symbols + opts.nr_cblocks exposed unconditionally of 
> HAVE_AIO_SUPPORT, but keeps the symbols implementation under the define, then
> as far aio-cblocks option is not exposed thru command line, we end up in
> whole bunch of symbols referenced under the else branch that, after all, 
> can cause Perf binary size increase, which is, probably, worth avoiding.

I think it's ok as long as they're empty.

Thanks,
Namhyung
