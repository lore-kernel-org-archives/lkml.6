Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0D9C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D868A20652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D868A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeJHTHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:07:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:42918 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbeJHTHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:07:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 04:55:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,356,1534834800"; 
   d="scan'208";a="269433988"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 08 Oct 2018 04:55:17 -0700
Received: from [10.125.251.251] (abudanko-mobl.ccr.corp.intel.com [10.125.251.251])
        by linux.intel.com (Postfix) with ESMTP id 062FA580034;
        Mon,  8 Oct 2018 04:55:14 -0700 (PDT)
Subject: Re: [PATCH v11 1/3]: perf util: map data buffer for preserving
 collected data
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <0ff162a6-67ab-9e73-8d7e-fa57c932ee45@linux.intel.com>
 <20181008105049.GC17270@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <43747adb-4591-e0ff-f173-525a5f5d47b4@linux.intel.com>
Date:   Mon, 8 Oct 2018 14:55:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008105049.GC17270@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08.10.2018 13:50, Jiri Olsa wrote:
> On Mon, Oct 08, 2018 at 09:14:29AM +0300, Alexey Budankov wrote:
>>
<SNIP>
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index f6d1a03c7523..2e90f4ce9214 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -355,6 +355,11 @@ endif # NO_LIBELF
>>  
>>  ifeq ($(feature-glibc), 1)
>>    CFLAGS += -DHAVE_GLIBC_SUPPORT
>> +  ifndef NO_AIO
> 
> hum, do we need NO_AIO? we have the --aio option to enable that right?

Right. Enable that *in runtime*.

> I guess BIONIC does not support aio, but but will it fail when it's
> compiled in there?

Please see updated section of the cover letter for more information 
regarding this. Possible compilation issues is that's why we better 
have this capability in advance:
  
  objdump -T tools/perf/perf | grep aio

  0000000000000000      DF *UND*	0000000000000000  GLIBC_2.2.5 aio_suspend64
  0000000000000000      DF *UND*	0000000000000000  GLIBC_2.2.5 aio_return64
  0000000000000000      DF *UND*	0000000000000000  GLIBC_2.2.5 aio_error64
  0000000000000000      DF *UND*	0000000000000000  GLIBC_2.2.5 aio_write64

IMHO, it is worth implementing NO_AIO define.

Thanks,
Alexey

> 
> jirka
> 
>> +    ifndef BIONIC
>> +        CFLAGS += -DHAVE_AIO_SUPPORT
>> +    endif
>> +  endif
>>  endif
> 
> SNIP
> 
