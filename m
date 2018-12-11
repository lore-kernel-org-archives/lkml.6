Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11771C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BEA2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BEA2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeLKXqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:46:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:29907 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbeLKXqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:46:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 15:46:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="117577481"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga002.jf.intel.com with ESMTP; 11 Dec 2018 15:46:01 -0800
Subject: Re: [PATCH v4 1/2] x86/fpu: track AVX-512 usage of tasks
To:     Dave Hansen <dave.hansen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
References: <20181211002448.3520-1-aubrey.li@intel.com>
 <df1a1b5b-3e8b-5d96-12df-25be30c391af@intel.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <143a5451-c7cf-16a5-a7ef-8c4b0633b689@linux.intel.com>
Date:   Wed, 12 Dec 2018 07:46:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <df1a1b5b-3e8b-5d96-12df-25be30c391af@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/12 1:18, Dave Hansen wrote:
> On 12/10/18 4:24 PM, Aubrey Li wrote:
>> The tracking turns on the usage flag at the next context switch of
>> the task, but requires 3 consecutive context switches with no usage
>> to clear it. This decay is required because well-written AVX-512
>> applications are expected to clear this state when not actively using
>> AVX-512 registers.
> 
> One concern about this:  Given a HZ=1000 system, this means that the
> flag needs to get scanned every ~3ms.  That's a pretty good amount of
> scanning on a system with hundreds or thousands of tasks running around.
> 
> How many tasks does this scale to until you're eating up an entire CPU
> or two just scanning /proc?
> 

Do we have a real requirement to do this in practical environment?
AFAIK, 1s or even 5s is good enough in some customers environment.

Thanks,
-Aubrey
