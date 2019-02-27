Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31FAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF88D20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfB0NE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:04:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:61722 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfB0NE0 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:04:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 05:04:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,419,1544515200"; 
   d="scan'208";a="278267422"
Received: from jacwang-mobl.ccr.corp.intel.com (HELO [10.254.211.131]) ([10.254.211.131])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2019 05:04:22 -0800
Subject: Re: [PATCH v2 1/3] perf diff: Support --time filter option
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1551183069-5931-1-git-send-email-yao.jin@linux.intel.com>
 <1551183069-5931-2-git-send-email-yao.jin@linux.intel.com>
 <20190227092755.GA22793@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <95a5cba1-b06c-4adb-9c45-ddec5da3b6ee@linux.intel.com>
Date:   Wed, 27 Feb 2019 21:04:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227092755.GA22793@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/2019 5:27 PM, Jiri Olsa wrote:
> On Tue, Feb 26, 2019 at 08:11:07PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> +	abstime_tmp = abstime_ostr;
>>   
>>   	data__for_each_file(i, d) {
>> -		d->session = perf_session__new(&d->data, false, &tool);
>> +		d->session = perf_session__new(&d->data, false, &pdiff.tool);
>>   		if (!d->session) {
>>   			pr_err("Failed to open %s\n", d->data.path);
>>   			ret = -1;
>>   			goto out_delete;
>>   		}
>>   
>> +		if (abstime_ostr) {
>> +			ret = parse_absolute_time(d, &abstime_tmp);
>> +			if (ret < 0)
>> +				goto out_delete;
>> +		} else if (pdiff.time_str) {
>> +			ret = parse_percent_time(d);
>> +			if (ret < 0)
>> +				goto out_delete;
>> +		} else {
>> +			pdiff.range_num = 1;
> 
> hum, why are we setting range_num to 1 again?

Yes, that may be not necessary. I will remove this line and test again.

> 
> it's really hard to parse this code, maybe
> it'd be better in separate loop/function
> that would setup just timestamps..
> 

Do you mean the above parsing code should be put in a separate function 
(e.g. parse_time_string in following example)?

data__for_each_file(i, d) {
	....
	d->session = perf_session__new(&d->data, false, &pdiff.tool);
	....
	parse_time_string(...);
	ret = perf_session__process_events(d->session);
	....
}

Thanks
Jin Yao

> 
> thanks,
> jirka
> 
