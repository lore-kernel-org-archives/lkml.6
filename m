Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B73C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996692098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996692098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbeJKXmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:42:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:12058 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:42:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 09:14:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="80676064"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 11 Oct 2018 09:14:08 -0700
Received: from [10.252.28.165] (abudanko-mobl.ccr.corp.intel.com [10.252.28.165])
        by linux.intel.com (Postfix) with ESMTP id 2857F58015C;
        Thu, 11 Oct 2018 09:14:05 -0700 (PDT)
Subject: Re: [PATCH v12 3/3]: perf record: extend trace writing to multi AIO
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e045b4aa-bff1-4e40-4cdf-4504003ecff5@linux.intel.com>
 <39da34d3-7198-7514-b000-7bfbf382e526@linux.intel.com>
 <20181011134559.GC29634@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <7dedfcb0-f39a-7117-1b61-d0cac2fd1f1e@linux.intel.com>
Date:   Thu, 11 Oct 2018 19:14:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011134559.GC29634@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 11.10.2018 16:45, Jiri Olsa wrote:
> On Tue, Oct 09, 2018 at 11:59:31AM +0300, Alexey Budankov wrote:
<SNIP>
> 
>> @@ -1886,8 +1917,8 @@ static struct option __record_options[] = {
>>  	OPT_BOOLEAN(0, "dry-run", &dry_run,
>>  		    "Parse options then exit"),
>>  #ifdef HAVE_AIO_SUPPORT
>> -	OPT_CALLBACK_NOOPT(0, "aio", &record.opts,
>> -		     NULL, "Enable asynchronous trace writing mode",
> 
> hum, why removing --aio option? I though we will have:
> 
>   perf record --aio ....           # enables aio with default settings
>   perf record --aio-cblocks=3 ...  # enabled aio with aio-cblocks=3

It is possible to avoid the complication using only one --aio option like this:

   perf record --aio ...    # enables aio with default (=1)
   perf record --aio=4 ...  # enables aio with parameter = 4

--aio-cblocks=4 still works when specified like --aio=4.

Thanks,
Alexey
