Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A718C282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467E920815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfBDLaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:30:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:37509 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfBDLaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:30:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 03:30:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="119815560"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 04 Feb 2019 03:30:00 -0800
Received: from [10.125.252.124] (abudanko-mobl.ccr.corp.intel.com [10.125.252.124])
        by linux.intel.com (Postfix) with ESMTP id 5E6C558040E;
        Mon,  4 Feb 2019 03:29:57 -0800 (PST)
Subject: Re: [RFC/PATCH 00/14] perf record: Add support to store data in
 directory
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
References: <20190203153018.9650-1-jolsa@kernel.org>
 <8d8b3f0d-cea8-2daf-249f-29f485c49a46@linux.intel.com>
 <20190204103643.GA18141@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <6bf24b7d-2bd3-8091-cf49-363c91e4e864@linux.intel.com>
Date:   Mon, 4 Feb 2019 14:29:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190204103643.GA18141@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.02.2019 13:36, Jiri Olsa wrote:
> On Mon, Feb 04, 2019 at 01:12:11PM +0300, Alexey Budankov wrote:
>>
>> Hi,
>>
>> On 03.02.2019 18:30, Jiri Olsa wrote:
>>> hi,
>>> this patchset adds the --dir option to record command (and all
>>> the other record command that overload cmd_record) that allows
>>> the data to be stored in directory with multiple data files.
>>>
>>> It's next step for multiple threads implementation in record.
>>> It's now possible to make directory data via --dir option, like:
>>>
>>>   $ perf record --dir perf bench sched messaging
>>
>> Is it possible to name data directory differently from perf.data 
>> e.g. using --output option, like this?
>>
>>   $ perf record --output result_1 --dir perf bench sched messaging
> 
> 
> yep, it's taken into account:
> 
> [jolsa@krava perf]$ ./perf record --output result_1 --dir ./perf bench sched messaging
> Couldn't synthesize bpf events.
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 10 groups == 400 processes run
> 
>      Total time: 0.177 [sec]
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.316 MB result_1 (7225 samples) ]
> 
> [jolsa@krava perf]$ ll result_1/
> total 348
> -rw-------. 1 jolsa jolsa 27624 Feb  4 11:35 data.0
> -rw-------. 1 jolsa jolsa 56672 Feb  4 11:35 data.1
> -rw-------. 1 jolsa jolsa 30824 Feb  4 11:35 data.2
> -rw-------. 1 jolsa jolsa 49136 Feb  4 11:35 data.3
> -rw-------. 1 jolsa jolsa 22712 Feb  4 11:35 data.4
> -rw-------. 1 jolsa jolsa 53392 Feb  4 11:35 data.5
> -rw-------. 1 jolsa jolsa 43352 Feb  4 11:35 data.6
> -rw-------. 1 jolsa jolsa 46688 Feb  4 11:35 data.7
> -rw-------. 1 jolsa jolsa  9068 Feb  4 11:35 header

Awesome. What do you think about having it like this:

  $ perf record --output result_1.data ... - writes data to a file

  $ perf record --dir result_1 ... - or even
  $ perf record --output_dir result_1 ... - writes data into a directory

IMHO, this interface is simpler for a user.

Thanks,
Alexey

> 
> jirka
> 
