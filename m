Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA518C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983832085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983832085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbeJHT0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:26:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:6082 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbeJHT0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:26:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 05:15:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,356,1534834800"; 
   d="scan'208";a="97087138"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 08 Oct 2018 05:15:08 -0700
Received: from [10.125.251.251] (abudanko-mobl.ccr.corp.intel.com [10.125.251.251])
        by linux.intel.com (Postfix) with ESMTP id CE4695801E6;
        Mon,  8 Oct 2018 05:15:06 -0700 (PDT)
Subject: Re: [PATCH v11 2/3]: perf record: enable asynchronous trace writing
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <31b0ae5f-e1b5-4255-11af-46c8ebe8e2be@linux.intel.com>
 <20181008105720.GI17270@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <184f031c-4685-62c6-17d0-7bd70b13418a@linux.intel.com>
Date:   Mon, 8 Oct 2018 15:15:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008105720.GI17270@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08.10.2018 13:57, Jiri Olsa wrote:
> On Mon, Oct 08, 2018 at 09:17:11AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>  static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
>>  				    bool overwrite)
>>  {
>> @@ -520,7 +644,10 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>>  	int i;
>>  	int rc = 0;
>>  	struct perf_mmap *maps;
>> -
>> +#ifdef HAVE_AIO_SUPPORT
>> +	int trace_fd = rec->data.file.fd;
>> +	off_t off;
>> +#endif
>>  	if (!evlist)
>>  		return 0;
>>  
>> @@ -531,14 +658,34 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>>  	if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
>>  		return 0;
>>  
>> +#ifdef HAVE_AIO_SUPPORT
>> +	off = lseek(trace_fd, 0, SEEK_CUR);
>> +#endif
>>  	for (i = 0; i < evlist->nr_mmaps; i++) {
>>  		struct perf_mmap *map = &maps[i];
>>  
>>  		if (map->base) {
>> -			if (perf_mmap__push(map, rec, record__pushfn) != 0) {
>> -				rc = -1;
>> -				goto out;
>> +#ifdef HAVE_AIO_SUPPORT
>> +			if (!rec->opts.nr_cblocks) {
>> +#endif
>> +				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
>> +					rc = -1;
>> +					goto out;
>> +				}
>> +#ifdef HAVE_AIO_SUPPORT
>> +			} else {
>> +				/*
>> +				 * Call record__aio_sync() to wait till map->data buffer
>> +				 * becomes available after previous aio write request.
>> +				 */
>> +				record__aio_sync(map);
>> +				if (perf_mmap__aio_push(map, rec, record__aio_pushfn, &off) != 0) {
>> +					lseek(trace_fd, off, SEEK_SET);
>> +					rc = -1;
>> +					goto out;
>> +				}
>>  			}
>> +#endif
> 
> I really don't like this.. let's have some aio_... function with its
> dummy counterpart to be called in here.. and again.. if we realyl must
> have this compiled optionaly, which I'm not convinced of

Accepted.

Thanks,
Alexey

> 
> jirka
> 
