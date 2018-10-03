Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C3CC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62ADA2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62ADA2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJCV3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:29:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:8773 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbeJCV3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:29:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 07:41:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="79553285"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 03 Oct 2018 07:41:07 -0700
Received: from [10.252.30.119] (abudanko-mobl.ccr.corp.intel.com [10.252.30.119])
        by linux.intel.com (Postfix) with ESMTP id DE8F85801E6;
        Wed,  3 Oct 2018 07:41:04 -0700 (PDT)
Subject: Re: [PATCH v2] perf record: encode -k clockid frequency into Perf
 trace
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <16b2d206-896b-c0ec-5bfd-6179ab05199a@linux.intel.com>
 <20181003133924.GD31725@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <8c76279b-ce27-cfcd-7e58-8d9492e40b60@linux.intel.com>
Date:   Wed, 3 Oct 2018 17:41:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003133924.GD31725@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03.10.2018 16:39, Jiri Olsa wrote:
> On Wed, Oct 03, 2018 at 10:01:56AM +0300, Alexey Budankov wrote:
<SNIP>
>> +	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
>> +		session->header.env.clockid_res_ns = rec->opts.clockid_res_ns;
>> +	else
>> +		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
>> +
> 
> could you please keep only bits setting in record__init_features
> and move the header.env.clockid_res_ns assignment out of it?

Ok. Accepted.

> 
<SNIP>
>> +static int get_clockid_res(clockid_t clk_id, size_t *res_ns)
>> +{
>> +	struct timespec res;
>> +
>> +	*res_ns = 0;
>> +	if (!clock_getres(clk_id, &res))
>> +		*res_ns = res.tv_nsec + res.tv_sec * NSEC_PER_SEC;
> 
> hum, if this one fails (which I guess is unlikely) we should tell
> and probably even quit

Makes sense. Please stay tuned for v3.

Thanks,
Alexey
