Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC43C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24FA20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24FA20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeJEONl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:13:41 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:39960 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeJEONk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:13:40 -0400
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 5 Oct 2018 16:16:15 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.121 with ESMTP; 5 Oct 2018 16:16:15 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Fri, 5 Oct 2018 16:16:15 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Subject: Re: [PATCH v9 2/3]: perf record: enable asynchronous trace writing
Message-ID: <20181005071615.GC3768@sejong>
References: <ded47c34-9e92-6bd2-9522-a927a7237011@linux.intel.com>
 <5ed78452-ff2b-dfe5-ec29-888971cb4b55@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ed78452-ff2b-dfe5-ec29-888971cb4b55@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 07:12:10PM +0300, Alexey Budankov wrote:
> 
> Trace file offset is calculated and updated linearly prior
> enqueuing aio write at record__pushfn().
> 
> record__aio_sync() blocks till completion of started AIO operation 
> and then proceeds.
> 
> record__mmap_read_sync() implements a barrier for all incomplete
> aio write requests.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  Changes in v9:
>  - enable AIO streaming only when --aio-cblocks option is specified explicitly
>  Changes in v8:
>  - split AIO completion check into separate record__aio_complete()
>  Changes in v6:
>  - handled errno == EAGAIN case from aio_write();
>  Changes in v5:
>  - data loss metrics decreased from 25% to 2x in trialed configuration;
>  - avoided nanosleep() prior calling aio_suspend();
>  - switched to per cpu multi record__aio_sync() aio
>  - record_mmap_read_sync() now does global barrier just before 
>    switching trace file or collection stop;
>  - resolved livelock on perf record -e intel_pt// -- dd if=/dev/zero of=/dev/null count=100000
>  Changes in v4:
>  - converted void *bf to struct perf_mmap *md in signatures
>  - written comment in perf_mmap__push() just before perf_mmap__get();
>  - written comment in record__mmap_read_sync() on possible restarting 
>    of aio_write() operation and releasing perf_mmap object after all;
>  - added perf_mmap__put() for the cases of failed aio_write();
>  Changes in v3:
>  - written comments about nanosleep(0.5ms) call prior aio_suspend()
>    to cope with intrusiveness of its implementation in glibc;
>  - written comments about rationale behind coping profiling data 
>    into mmap->data buffer;
> ---
>  tools/perf/builtin-record.c | 154 +++++++++++++++++++++++++++++++++++++++++++-
>  tools/perf/perf.h           |   3 +
>  tools/perf/util/mmap.c      |  73 +++++++++++++++++++++
>  tools/perf/util/mmap.h      |   4 ++
>  4 files changed, 233 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 0980dfe3396b..c63fe8c021a2 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -124,6 +124,118 @@ static int record__write(struct record *rec, struct perf_mmap *map __maybe_unuse
>  	return 0;
>  }
>  
> +#ifdef HAVE_AIO_SUPPORT
> +static int record__aio_write(struct aiocb *cblock, int trace_fd,
> +		void *buf, size_t size, off_t off)
> +{
> +	int rc;
> +
> +	cblock->aio_fildes = trace_fd;
> +	cblock->aio_buf    = buf;
> +	cblock->aio_nbytes = size;
> +	cblock->aio_offset = off;
> +	cblock->aio_sigevent.sigev_notify = SIGEV_NONE;
> +
> +	do {
> +		rc = aio_write(cblock);
> +		if (rc == 0) {
> +			break;
> +		} else if (errno != EAGAIN) {
> +			cblock->aio_fildes = -1;
> +			pr_err("failed to queue perf data, error: %m\n");
> +			break;
> +		}
> +	} while (1);
> +
> +	return rc;
> +}
> +
> +static int record__aio_complete(struct perf_mmap *md, struct aiocb *cblock)
> +{
> +	void *rem_buf;
> +	off_t rem_off;
> +	size_t rem_size;
> +	int rc, aio_errno;
> +	ssize_t aio_ret, written;
> +
> +	aio_errno = aio_error(cblock);
> +	if (aio_errno == EINPROGRESS)
> +		return 0;
> +
> +	written = aio_ret = aio_return(cblock);
> +	if (aio_ret < 0) {
> +		if (aio_errno != EINTR)
> +			pr_err("failed to write perf data, error: %m\n");
> +		written = 0;
> +	}
> +
> +	rem_size = cblock->aio_nbytes - written;
> +
> +	if (rem_size == 0) {
> +		cblock->aio_fildes = -1;
> +		/*
> +		 * md->refcount is incremented in perf_mmap__push() for
> +		 * every enqueued aio write request so decrement it because
> +		 * the request is now complete.
> +		 */
> +		perf_mmap__put(md);
> +		rc = 1;
> +	} else {
> +		/*
> +		 * aio write request may require restart with the
> +		 * reminder if the kernel didn't write whole
> +		 * chunk at once.
> +		 */
> +		rem_off = cblock->aio_offset + written;
> +		rem_buf = (void *)(cblock->aio_buf + written);
> +		record__aio_write(cblock, cblock->aio_fildes,
> +				rem_buf, rem_size, rem_off);
> +		rc = 0;
> +	}
> +
> +	return rc;
> +}
> +
> +static void record__aio_sync(struct perf_mmap *md)
> +{
> +	struct aiocb *cblock = &md->cblock;
> +	struct timespec timeout = { 0, 1000 * 1000  * 1 }; // 1ms
> +
> +	do {
> +		if (cblock->aio_fildes == -1 || record__aio_complete(md, cblock))
> +			return;
> +
> +		while (aio_suspend((const struct aiocb**)&cblock, 1, &timeout)) {
> +			if (!(errno == EAGAIN || errno == EINTR))
> +				pr_err("failed to sync perf data, error: %m\n");

Is there somthing we can do in this error case?  Any chance it gets
stuck in the loop?


> +		}
> +	} while (1);
> +}
> +
> +static int record__aio_pushfn(void *to, struct aiocb *cblock, void *bf, size_t size)
> +{
> +	off_t off;
> +	struct record *rec = to;
> +	int ret, trace_fd = rec->session->data->file.fd;
> +
> +	rec->samples++;
> +
> +	off = lseek(trace_fd, 0, SEEK_CUR);
> +	lseek(trace_fd, off + size, SEEK_SET);

It'd be nice if these lseek() could be removed and use
rec->bytes_written instead.


> +	ret = record__aio_write(cblock, trace_fd, bf, size, off);
> +	if (!ret) {
> +		rec->bytes_written += size;
> +
> +		if (switch_output_size(rec))
> +			trigger_hit(&switch_output_trigger);

Doesn't it need the _sync() before the trigger?  Maybe it should be
moved to record__mmap_read_evlist() or so..


> +	} else {
> +		lseek(trace_fd, off, SEEK_SET);
> +	}
> +
> +	return ret;
> +}
> +#endif
> +
>  static int process_synthesized_event(struct perf_tool *tool,
>  				     union perf_event *event,
>  				     struct perf_sample *sample __maybe_unused,
> @@ -136,7 +248,6 @@ static int process_synthesized_event(struct perf_tool *tool,
>  static int record__pushfn(struct perf_mmap *map, void *to, void *bf, size_t size)
>  {
>  	struct record *rec = to;
> -
>  	rec->samples++;
>  	return record__write(rec, map, bf, size);
>  }
> @@ -513,6 +624,24 @@ static struct perf_event_header finished_round_event = {
>  	.type = PERF_RECORD_FINISHED_ROUND,
>  };
>  
> +static void record__mmap_read_sync(struct record *rec __maybe_unused)
> +{
> +#ifdef HAVE_AIO_SUPPORT
> +	int i;
> +	struct perf_evlist *evlist = rec->evlist;
> +	struct perf_mmap *maps = evlist->mmap;
> +
> +	if (!rec->opts.nr_cblocks)
> +		return;
> +
> +	for (i = 0; i < evlist->nr_mmaps; i++) {
> +		struct perf_mmap *map = &maps[i];
> +		if (map->base)
> +			record__aio_sync(map);
> +	}
> +#endif
> +}
> +
>  static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
>  				    bool overwrite)
>  {
> @@ -535,10 +664,29 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  		struct perf_mmap *map = &maps[i];
>  
>  		if (map->base) {
> +#ifndef HAVE_AIO_SUPPORT
>  			if (perf_mmap__push(map, rec, record__pushfn) != 0) {
>  				rc = -1;
>  				goto out;
>  			}
> +#else
> +			if (!rec->opts.nr_cblocks) {
> +				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
> +					rc = -1;
> +					goto out;
> +				}
> +			} else {
> +				/*
> +				 * Call record__aio_sync() to wait till map->data buffer
> +				 * becomes available after previous aio write request.
> +				 */
> +				record__aio_sync(map);
> +				if (perf_mmap__aio_push(map, rec, record__aio_pushfn) != 0) {
> +					rc = -1;
> +					goto out;
> +				}
> +			}
> +#endif

If dummy aio functions are provided, the #ifdef can be removed and
just use the #else part assuming opts.nr_cblocks == 0.

Thanks,
Namhyung


>  		}
>  
>  		if (map->auxtrace_mmap.base && !rec->opts.auxtrace_snapshot_mode &&
> @@ -1057,6 +1205,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  			perf_evlist__toggle_bkw_mmap(rec->evlist, BKW_MMAP_DATA_PENDING);
>  
>  		if (record__mmap_read_all(rec) < 0) {
> +			record__mmap_read_sync(rec);
>  			trigger_error(&auxtrace_snapshot_trigger);
>  			trigger_error(&switch_output_trigger);
>  			err = -1;
> @@ -1068,6 +1217,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  			if (!trigger_is_error(&auxtrace_snapshot_trigger))
>  				record__read_auxtrace_snapshot(rec);
>  			if (trigger_is_error(&auxtrace_snapshot_trigger)) {
> +				record__mmap_read_sync(rec);
>  				pr_err("AUX area tracing snapshot failed\n");
>  				err = -1;
>  				goto out_child;
> @@ -1086,6 +1236,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  			 */
>  			if (rec->evlist->bkw_mmap_state == BKW_MMAP_RUNNING)
>  				continue;
> +			record__mmap_read_sync(rec);
>  			trigger_ready(&switch_output_trigger);
>  
>  			/*
> @@ -1139,6 +1290,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  			disabled = true;
>  		}
>  	}
> +	record__mmap_read_sync(rec);
>  	trigger_off(&auxtrace_snapshot_trigger);
>  	trigger_off(&switch_output_trigger);
