Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46381C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F206720652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F206720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbeJKVNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:13:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeJKVNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:13:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E0459B2F5;
        Thu, 11 Oct 2018 13:46:08 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id A8E218B94F;
        Thu, 11 Oct 2018 13:46:06 +0000 (UTC)
Date:   Thu, 11 Oct 2018 15:46:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 3/3]: perf record: extend trace writing to multi AIO
Message-ID: <20181011134605.GD29634@krava>
References: <e045b4aa-bff1-4e40-4cdf-4504003ecff5@linux.intel.com>
 <39da34d3-7198-7514-b000-7bfbf382e526@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39da34d3-7198-7514-b000-7bfbf382e526@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 11 Oct 2018 13:46:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 11:59:31AM +0300, Alexey Budankov wrote:

SNIP

> @@ -709,12 +729,13 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  					goto out;
>  				}
>  			} else {
> +				int idx;
>  				/*
>  				 * Call record__aio_sync() to wait till map->data buffer
>  				 * becomes available after previous aio write request.
>  				 */
> -				record__aio_sync(map);
> -				if (perf_mmap__aio_push(map, rec, record__aio_pushfn, &off) != 0) {
> +				idx = record__aio_sync(map, false);

looks like record__aio_sync can return -1,
how is it not breaking the perf_mmap__aio_push call below?

> +				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn, &off) != 0) {
>  					record__aio_set_pos(trace_fd, off);
>  					rc = -1;
>  					goto out;

SNIP
