Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D543CC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D4121722
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D4121722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeH0Bct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 21:32:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726823AbeH0Bct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 21:32:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7FFB98076895;
        Sun, 26 Aug 2018 21:48:59 +0000 (UTC)
Received: from krava (ovpn-204-25.brq.redhat.com [10.40.204.25])
        by smtp.corp.redhat.com (Postfix) with SMTP id 59F802166B41;
        Sun, 26 Aug 2018 21:48:56 +0000 (UTC)
Date:   Sun, 26 Aug 2018 23:48:56 +0200
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
Subject: Re: [PATCH v1 2/2]: perf record: enable asynchronous trace writing
Message-ID: <20180826214856.GA24518@krava>
References: <dcd3ee88-57d6-8704-f5e1-7a3c75a17d8d@linux.intel.com>
 <2db359cc-dc5d-c00e-a42a-12a2e9da80b7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db359cc-dc5d-c00e-a42a-12a2e9da80b7@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sun, 26 Aug 2018 21:48:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sun, 26 Aug 2018 21:48:59 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 11:27:03AM +0300, Alexey Budankov wrote:

SNIP

> -static int record__pushfn(void *to, void *bf, size_t size)
> +static int record__pushfn(void *to, void *bf, size_t size, off_t off)
>  {
>  	struct record *rec = to;
> +	struct perf_mmap *map = bf;
>  
>  	rec->samples++;
> -	return record__write(rec, bf, size);
> +	return record__aio_write(rec->session->data->file.fd, &map->cblock,
> +			map->data, size, off);
>  }
>  
>  static volatile int done;
> @@ -528,13 +530,85 @@ static struct perf_event_header finished_round_event = {
>  	.type = PERF_RECORD_FINISHED_ROUND,
>  };
>  
> +static int record__mmap_read_sync(int trace_fd, struct aiocb **cblocks,
> +		int cblocks_size, struct record *rec)
> +{
> +	size_t rem;
> +	ssize_t size;
> +	off_t rem_off;
> +	int i, aio_ret, aio_errno, do_suspend;
> +	struct perf_mmap *md;
> +	struct timespec timeout0 = { 0, 0 };
> +	struct timespec timeoutS = { 0, 1000 * 500  * 1 };
> +
> +	if (!cblocks_size)
> +		return 0;
> +
> +	do {
> +		do_suspend = 0;
> +		nanosleep(&timeoutS, NULL);

why the extra sleep in here and not sleeping through aio_suspend call?

jirka

> +		if (aio_suspend((const struct aiocb**)cblocks, cblocks_size, &timeout0)) {
> +			if (errno == EAGAIN || errno == EINTR) {
> +				do_suspend = 1;
> +				continue;
> +			} else {
> +				pr_err("failed to sync perf data, error: %m\n");

SNIP
