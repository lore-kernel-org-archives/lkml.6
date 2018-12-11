Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08F0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731E520855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731E520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeLKRwp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:52:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:2327 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbeLKRwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:52:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 09:52:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="127012678"
Received: from schen9-mobl3.jf.intel.com ([10.24.9.33])
  by fmsmga004.fm.intel.com with ESMTP; 11 Dec 2018 09:52:44 -0800
Subject: Re: [PATCH v4 1/2] x86/fpu: track AVX-512 usage of tasks
To:     Dave Hansen <dave.hansen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, hpa@zytor.com
Cc:     ak@linux.intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
References: <20181211002448.3520-1-aubrey.li@intel.com>
 <df1a1b5b-3e8b-5d96-12df-25be30c391af@intel.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <86ba7095-b877-cea6-3c07-8db2ff7fe02f@linux.intel.com>
Date:   Tue, 11 Dec 2018 09:52:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <df1a1b5b-3e8b-5d96-12df-25be30c391af@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/18 9:18 AM, Dave Hansen wrote:
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

The reason why I believe that an exponential decay average, or some
other kind of weighted decay of the AVX512 usage is better.

Tim

