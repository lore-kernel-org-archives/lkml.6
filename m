Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA16C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C72F208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C72F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeJEO1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:27:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:17798 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbeJEO1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:27:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 00:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,343,1534834800"; 
   d="scan'208";a="85926053"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Oct 2018 00:29:46 -0700
Received: from [10.125.251.251] (abudanko-mobl.ccr.corp.intel.com [10.125.251.251])
        by linux.intel.com (Postfix) with ESMTP id 417F75801E6;
        Fri,  5 Oct 2018 00:29:44 -0700 (PDT)
Subject: Re: [PATCH v9 1/3]: perf util: map data buffer for preserving
 collected data
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@lge.com
References: <ded47c34-9e92-6bd2-9522-a927a7237011@linux.intel.com>
 <785396a7-1004-5705-f336-6bf73f981f44@linux.intel.com>
 <20181005062323.GB3768@sejong>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b7e3f9be-152c-b038-96fa-3792a84b9347@linux.intel.com>
Date:   Fri, 5 Oct 2018 10:29:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005062323.GB3768@sejong>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05.10.2018 9:23, Namhyung Kim wrote:
<SNIP>
> On Wed, Oct 03, 2018 at 07:01:26PM +0300, Alexey Budankov wrote:
<SNIP>
>> +#ifdef HAVE_AIO_SUPPORT
>> +	map->nr_cblocks = mp->nr_cblocks;
>> +	if (map->nr_cblocks) {
>> +		map->data = malloc(perf_mmap__mmap_len(map));
>> +		if (!map->data) {
>> +			pr_debug2("failed to allocate data buffer, error %d\n",
>> +					errno);
> 
> I guess the error code is not very useful than the message.  But in
> this case it's probably ENOMEM so we can simply omit it.

Possibly like this:
			pr_debug2("failed to allocate data buffer, error %d: %s\n",
					errno, strerror(errno));
would be more informative.

Thanks,
Alexey
