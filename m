Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B73FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE7420659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE7420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbeIGEEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 00:04:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:7671 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725745AbeIGEEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 00:04:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 16:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,339,1531810800"; 
   d="scan'208";a="89645201"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.122]) ([10.24.14.122])
  by orsmga002.jf.intel.com with ESMTP; 06 Sep 2018 16:26:25 -0700
Subject: Re: [PATCH V2 4/6] x86/intel_rdt: Add helper to obtain performance
 counter index
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, vikas.shivappa@linux.intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1534450299.git.reinette.chatre@intel.com>
 <ec245dd86408b92b5cb1553b7004a6a391d54640.1534450299.git.reinette.chatre@intel.com>
 <20180906144751.GH24106@hirez.programming.kicks-ass.net>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <f47a2146-2f1a-49fc-2306-3341154f1186@intel.com>
Date:   Thu, 6 Sep 2018 16:26:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180906144751.GH24106@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 9/6/2018 7:47 AM, Peter Zijlstra wrote:
> On Thu, Aug 16, 2018 at 01:16:07PM -0700, Reinette Chatre wrote:
> 
>> +static inline int x86_perf_rdpmc_ctr_get(struct perf_event *event)
>> +{
>> +	lockdep_assert_irqs_disabled();
>> +
>> +	return IS_ERR_OR_NULL(event) ? -1 : event->hw.event_base_rdpmc;
>> +}
> 
> That should be in arch/x86/include/asm/perf_event.h if anywhere. Also,
> call the thing x86_perf_rdpmc_index(), that's consistent with the other
> naming.

Moving it to arch/x86/include/asm/perf_event.h is not trivial since this
file is not familiar with struct perf_event.

struct perf_event, struct hw_perf_event and its member event_base_rdpmc
are all defined in include/linux/perf_event.h - could this function
perhaps be moved there? If so, would perf_rdpmc_index() perhaps be a
better name to be consistent with the other naming?

> 
> I don't think there's any point in testing for !event, this is an
> interface that mandates you know wth you're doing anyway.
> 

I could add:
/* !CONFIG_PERF_EVENTS */
static inline int perf_rdpmc_index(struct perf_event *event)
{
        return -1;
}

Reinette
