Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19A3C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B885520896
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B885520896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966274AbeFPAuS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 20:50:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:36239 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966064AbeFPAuP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 20:50:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 17:50:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,228,1526367600"; 
   d="scan'208";a="47484953"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.214.4]) ([10.254.214.4])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2018 17:50:12 -0700
Subject: Re: [PATCH v1 0/2] perf: Drop leaked kernel samples
To:     robert@ocallahan.org, Kyle Huey <me@kylehuey.com>
Cc:     acme@kernel.org, jolsa@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        open list <Linux-kernel@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Will Deacon <will.deacon@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <CAP045Aq_FEc_pEeRL86uXbOLBeW7aPvTqtnaq+Mbi-2=vp2BNA@mail.gmail.com>
 <1a442b37-7a97-86f0-11e3-58d940ecfbc9@linux.intel.com>
 <CAP045ApFKUqUUf76GtWyxpYWdWe1RxYkPm1R2kUxaQyc4Fhucg@mail.gmail.com>
 <CAOp6jLadgwdiW+1BNFFhNSBD-i1ACju4PeuozxvD26Mrekwd9w@mail.gmail.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <9b3259e8-1d07-adb1-a57c-8b276c133aa6@linux.intel.com>
Date:   Sat, 16 Jun 2018 08:50:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAOp6jLadgwdiW+1BNFFhNSBD-i1ACju4PeuozxvD26Mrekwd9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch raised many questions, I was prepared. :)

I'd like to try another proposal that it adds a special flag in the 
returned perf_sample_data to indicate the perf binary that this sample 
is a leaked sample.

For example, create a new PERF_SAMPLE_RETURN_LEAKAGE in 
perf_event_sample_format.

In perf_prepare_sample(),

if (event->attr.exclude_kernel && !user_mode(regs))
	data->type |= PERF_SAMPLE_RETURN_LEAKAGE;

Now all the samples are kept and the leaked kernel samples are tagged 
with PERF_SAMPLE_RETURN_LEAKAGE.

In perf binary, it filters out the samples with 
PERF_SAMPLE_RETURN_LEAKAGE. It needs perf binary modification but rr 
doesn't need to be changed.

I don't 0-stuffing some fields because:

1. Keeping the skid info should allow us to look at that if we have 
interesting later.

2. Not sure if 0-stuffing some fields has potential conflicts with some 
applications.

Is this proposal reasonable?

Thanks
Jin Yao

On 6/16/2018 1:34 AM, Robert O'Callahan wrote:
> On Fri, Jun 15, 2018 at 10:16 AM, Kyle Huey <me@kylehuey.com> wrote:
>>
>> If you want a sysctl for your own reasons that's fine. But we don't
>> want a sysctl. We want to work without any further configuration.
> 
> Also toggling a sysctl would require root privileges, but rr does not
> currently need to run as root. Thus rr users would have to either
> permanently change their system configuration (and every extra
> configuration step is a pain), or run rr as root so rr can toggle the
> sysctl itself. Running rr as root is highly undesirable.
> 
> Rob
> 
