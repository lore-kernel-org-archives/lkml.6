Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C785EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800CE208D6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800CE208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeH0OY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:24:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726825AbeH0OY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:24:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F41BC87916;
        Mon, 27 Aug 2018 10:38:21 +0000 (UTC)
Received: from krava (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id C2F862166B41;
        Mon, 27 Aug 2018 10:38:19 +0000 (UTC)
Date:   Mon, 27 Aug 2018 12:38:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v2 2/2]: perf record: enable asynchronous trace writing
Message-ID: <20180827103819.GB3725@krava>
References: <e92805d0-3338-2ce5-5e88-369d406fe0a7@linux.intel.com>
 <54cc11d7-3ef2-c856-052e-6e2c309ff743@linux.intel.com>
 <20180827083852.GF24695@krava>
 <a34aa784-e36c-02fd-3e9d-7df4bc61ffe2@linux.intel.com>
 <20180827100536.GA8065@sejong>
 <3c0a8ecc-a68e-7e19-066c-096f7e318e1f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c0a8ecc-a68e-7e19-066c-096f7e318e1f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 27 Aug 2018 10:38:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 27 Aug 2018 10:38:22 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 01:25:35PM +0300, Alexey Budankov wrote:
> Hi Namhyung,
> 
> On 27.08.2018 13:05, Namhyung Kim wrote:
> > Hello,
> > 
> > On Mon, Aug 27, 2018 at 12:33:07PM +0300, Alexey Budankov wrote:
> >> Hi,
> >>
> >> On 27.08.2018 11:38, Jiri Olsa wrote:
> >>> On Thu, Aug 23, 2018 at 07:47:01PM +0300, Alexey Budankov wrote:
> >>>
> >>> SNIP
> >>>
> >>>>  static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
> >>>>  				    bool overwrite)
> >>>>  {
> >>>>  	u64 bytes_written = rec->bytes_written;
> >>>> -	int i;
> >>>> -	int rc = 0;
> >>>> +	int i, rc = 0;
> >>>>  	struct perf_mmap *maps;
> >>>> +	int trace_fd = rec->session->data->file.fd;
> >>>> +	struct aiocb **mmap_aio = rec->evlist->mmap_aio;
> >>>> +	int mmap_aio_size = 0;
> >>>> +	off_t off;
> >>>>  
> >>>>  	if (!evlist)
> >>>>  		return 0;
> >>>> @@ -546,14 +620,17 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
> >>>>  	if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
> >>>>  		return 0;
> >>>>  
> >>>> +	off = lseek(trace_fd, 0, SEEK_CUR);
> >>>> +
> >>>
> >>> with async write, do we need to query/set the offset like this
> >>> all the time?
> >>
> >> It looks like we need it this way. Internally glibc AIO implements writes 
> >> using pwrite64 syscall in our case. The sycall requires offset as a parameter 
> >> and doesn't update file position on the completion.
> >>
> >>>
> >>> could we just keep/update the offset value in the 'struct perf_data_file'
> >>> and skip both lseek calls?
> >>
> >> Don't see how it is possible. offset is different for every enqeued write 
> >> operation and write areas don't intersect for the whole writing loop. 
> >> To know the final file position it is required to iterate thru 
> >> the loop.
> > 
> > But as far as I can see the offset is linearly updated in
> > perf_mmap__push() and I guess those two lseek() calls will return
> > a same value as the last updated offset, no?
> 
> Yes, offset is linearly calculated by perf_mmap__push() code for 
> the next possible write operation, but file position is update by 
> the kernel only in the second lseek() syscall after the loop. 
> The first lseek() syscall reads that file position for 
> the next loop iterations.

does the file's offset need to get updated with lseek at all?
the async write gets offset.. so I'd think as long as we keep
offset value, we don't need to call lseek at all

jirka
