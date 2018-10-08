Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C011C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5784D2064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5784D2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeJHSCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:02:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeJHSCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:02:17 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CC29356F3;
        Mon,  8 Oct 2018 10:51:10 +0000 (UTC)
Received: from krava (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id BB8FA2010D11;
        Mon,  8 Oct 2018 10:51:08 +0000 (UTC)
Date:   Mon, 8 Oct 2018 12:51:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 2/3]: perf record: enable asynchronous trace writing
Message-ID: <20181008105107.GF17270@krava>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <31b0ae5f-e1b5-4255-11af-46c8ebe8e2be@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31b0ae5f-e1b5-4255-11af-46c8ebe8e2be@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 08 Oct 2018 10:51:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 09:17:11AM +0300, Alexey Budankov wrote:

SNIP

>  struct option;
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index db8f16f8a363..ecaa5b5eb3ed 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -367,6 +367,82 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
>  	return rc;
>  }
>  
> +#ifdef HAVE_AIO_SUPPORT
> +int perf_mmap__aio_push(struct perf_mmap *md, void *to,
> +			int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off),
> +			off_t *off)
> +{

seems like this could be defined static within builtin-record object,
is there a reason why it's in here?

thanks,
jirka
