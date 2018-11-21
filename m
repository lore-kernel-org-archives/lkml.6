Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C105C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4332146D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4332146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeKUMLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 07:11:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:57904 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbeKUMLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 07:11:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 17:39:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,259,1539673200"; 
   d="scan'208";a="93661380"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga008.jf.intel.com with ESMTP; 20 Nov 2018 17:39:01 -0800
Subject: Re: [PATCH v3 2/2] proc: add /proc/<pid>/arch_state
To:     Peter Zijlstra <peterz@infradead.org>,
        Aubrey Li <aubrey.li@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <1542236407-4323-1-git-send-email-aubrey.li@intel.com>
 <1542236407-4323-2-git-send-email-aubrey.li@intel.com>
 <20181119173904.GC2131@hirez.programming.kicks-ass.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <c62acf67-2529-15b1-5325-e0265b0f613d@linux.intel.com>
Date:   Wed, 21 Nov 2018 09:39:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20181119173904.GC2131@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/20 1:39, Peter Zijlstra wrote:
> On Thu, Nov 15, 2018 at 07:00:07AM +0800, Aubrey Li wrote:
>> Add a /proc/<pid>/arch_state interface to expose per-task cpu specific
>> state values.
>>
>> Exposing AVX-512 Hi16_ZMM registers usage is for the user space job
>> scheduler to cluster AVX-512 using tasks together, because these tasks
>> could cause core turbo frequency drop.
> 
> I still don't much like the name; how about arch_simd_state ? 

My intention is
#cat /proc/<pid>/arch_state
0 1 0

Here, the first "0" denotes simd_state, and the second "1" denotes another
cpu specific feature(may come soon), and can be extended.

But sure I can limit it to simd_state and change the name in the patch.
>Also,
> since we're printing an integer, I still prefer we go print the turbo
> license level. I know level 1 isn't too interesting atm, but consider
> future hardware widening the thing again and us growing level 3 or
> something.
The problem is, FWICT, the bits in XSAVE buffer is not exactly mapped to
the turbo license level, so we can't print turbo license level correctly,
or the first patch need rework for that.

> 
> Also; you were going to shop around with the other architectures to see
> what they want/need for this interface. I see nothing on that.
> 
I'm open for your suggestion, :)

Thanks,
-Aubrey
