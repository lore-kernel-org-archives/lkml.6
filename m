Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCECC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F27206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F27206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeIFQeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:34:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:62585 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeIFQeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:34:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 04:59:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,338,1531810800"; 
   d="scan'208";a="72080884"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2018 04:59:02 -0700
Received: from [10.125.252.28] (abudanko-mobl.ccr.corp.intel.com [10.125.252.28])
        by linux.intel.com (Postfix) with ESMTP id 810175801E6;
        Thu,  6 Sep 2018 04:59:00 -0700 (PDT)
Subject: Re: [PATCH v7 2/2]: perf record: enable asynchronous trace writing
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1fc1fc5b-a8cc-2b05-d43c-692e58855c81@linux.intel.com>
 <dc18a621-4464-e5a5-ce10-5f7b2f6a9176@linux.intel.com>
 <20180906110413.GF8248@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <7c49951f-50b2-a672-6ab8-cad72dc336a4@linux.intel.com>
Date:   Thu, 6 Sep 2018 14:58:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906110413.GF8248@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.09.2018 14:04, Jiri Olsa wrote:
> On Wed, Sep 05, 2018 at 10:39:25AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> +
>>  static int process_synthesized_event(struct perf_tool *tool,
>>  				     union perf_event *event,
>>  				     struct perf_sample *sample __maybe_unused,
>> @@ -130,12 +215,28 @@ static int process_synthesized_event(struct perf_tool *tool,
>>  	return record__write(rec, event, event->header.size);
>>  }
>>  
>> -static int record__pushfn(void *to, void *bf, size_t size)
>> +static int record__pushfn(void *to, struct aiocb *cblock, void *data, size_t size)
>>  {
>> +	off_t off;
>>  	struct record *rec = to;
>> +	int ret, trace_fd = rec->session->data->file.fd;
>>  
>>  	rec->samples++;
>> -	return record__write(rec, bf, size);
>> +
>> +	off =
>> +	lseek(trace_fd, 0, SEEK_CUR);
> 
> please keep that on the same line.. also, please run this
> patchset through the scripts/checkpatch.pl
> 
> don't worry about the 'line over 80 characters' errors,
> but the rest will be nice to have ;-)

ok! :)

> 
> jirka
> 
