Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660E1C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E70B20858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E70B20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeJHS6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:58:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:51695 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeJHS6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:58:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 04:47:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,356,1534834800"; 
   d="scan'208";a="97081152"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 08 Oct 2018 04:47:17 -0700
Received: from [10.125.251.251] (abudanko-mobl.ccr.corp.intel.com [10.125.251.251])
        by linux.intel.com (Postfix) with ESMTP id 5C9B5580034;
        Mon,  8 Oct 2018 04:47:15 -0700 (PDT)
Subject: Re: [PATCH v11 3/3]: perf record: extend trace writing to multi AIO
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <3c3d65dc-b2f6-b102-1805-a05ee6755653@linux.intel.com>
 <20181008105509.GH17270@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <4016811d-74ac-fffc-7dc9-1c7acaf228be@linux.intel.com>
Date:   Mon, 8 Oct 2018 14:47:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008105509.GH17270@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08.10.2018 13:55, Jiri Olsa wrote:
> On Mon, Oct 08, 2018 at 09:19:17AM +0300, Alexey Budankov wrote:
<SNIP>
>> +#ifdef HAVE_AIO_SUPPORT
>> +	if (!strcmp(var, "record.aio-cblocks"))
>> +		rec->opts.nr_cblocks = strtol(value, NULL, 0);
>> +#endif
>>  
>>  	return 0;
>>  }
>> @@ -1837,6 +1864,10 @@ static struct option __record_options[] = {
>>  			  "signal"),
>>  	OPT_BOOLEAN(0, "dry-run", &dry_run,
>>  		    "Parse options then exit"),
>> +#ifdef HAVE_AIO_SUPPORT
>> +	OPT_INTEGER(0, "aio-cblocks", &record.opts.nr_cblocks,
>> +		    "Max number of simultaneous per-mmap trace writes (default: 0 - serial, max: 4)"),
>> +#endif
> 
> could you please move the option to enable that to the previou patch?
> so we could test the simple variant as well

Ok.

> 
> also I think it'd be better if we have simple '--aio' option that would
> enable this with some default values..  and add --aio-cblocks to configure
> that further

Well, absence of --aio option, on the command line or in .perfconfig, or --aio=0 
means serial writing.

From this perspective perf record --aio --aio-cblocks=N looks like a complication.

Thanks,
Alexey
