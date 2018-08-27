Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974BBC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E40120891
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E40120891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeH0Nvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:51:37 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:36659 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeH0Nvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:51:37 -0400
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 27 Aug 2018 19:05:36 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.121 with ESMTP; 27 Aug 2018 19:05:36 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Mon, 27 Aug 2018 19:05:36 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v2 2/2]: perf record: enable asynchronous trace writing
Message-ID: <20180827100536.GA8065@sejong>
References: <e92805d0-3338-2ce5-5e88-369d406fe0a7@linux.intel.com>
 <54cc11d7-3ef2-c856-052e-6e2c309ff743@linux.intel.com>
 <20180827083852.GF24695@krava>
 <a34aa784-e36c-02fd-3e9d-7df4bc61ffe2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a34aa784-e36c-02fd-3e9d-7df4bc61ffe2@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Aug 27, 2018 at 12:33:07PM +0300, Alexey Budankov wrote:
> Hi,
> 
> On 27.08.2018 11:38, Jiri Olsa wrote:
> > On Thu, Aug 23, 2018 at 07:47:01PM +0300, Alexey Budankov wrote:
> > 
> > SNIP
> > 
> >>  static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
> >>  				    bool overwrite)
> >>  {
> >>  	u64 bytes_written = rec->bytes_written;
> >> -	int i;
> >> -	int rc = 0;
> >> +	int i, rc = 0;
> >>  	struct perf_mmap *maps;
> >> +	int trace_fd = rec->session->data->file.fd;
> >> +	struct aiocb **mmap_aio = rec->evlist->mmap_aio;
> >> +	int mmap_aio_size = 0;
> >> +	off_t off;
> >>  
> >>  	if (!evlist)
> >>  		return 0;
> >> @@ -546,14 +620,17 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
> >>  	if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
> >>  		return 0;
> >>  
> >> +	off = lseek(trace_fd, 0, SEEK_CUR);
> >> +
> > 
> > with async write, do we need to query/set the offset like this
> > all the time?
> 
> It looks like we need it this way. Internally glibc AIO implements writes 
> using pwrite64 syscall in our case. The sycall requires offset as a parameter 
> and doesn't update file position on the completion.
> 
> > 
> > could we just keep/update the offset value in the 'struct perf_data_file'
> > and skip both lseek calls?
> 
> Don't see how it is possible. offset is different for every enqeued write 
> operation and write areas don't intersect for the whole writing loop. 
> To know the final file position it is required to iterate thru 
> the loop.

But as far as I can see the offset is linearly updated in
perf_mmap__push() and I guess those two lseek() calls will return
a same value as the last updated offset, no?

Thanks,
Namhyung
