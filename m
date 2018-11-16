Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEC3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D2F21019
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D2F21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388965AbeKPKmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:42:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:54634 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbeKPKmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 05:42:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 16:32:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,238,1539673200"; 
   d="scan'208";a="91548333"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2018 16:32:20 -0800
Subject: Re: [PATCH v3 2/2] proc: add /proc/<pid>/arch_state
To:     Dave Hansen <dave.hansen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
References: <1542236407-4323-1-git-send-email-aubrey.li@intel.com>
 <1542236407-4323-2-git-send-email-aubrey.li@intel.com>
 <b869aa99-02e7-961d-829c-bf275023e06e@intel.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <d86164e3-ca11-bc1d-7e18-5afdac8dc7d5@linux.intel.com>
Date:   Fri, 16 Nov 2018 08:32:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <b869aa99-02e7-961d-829c-bf275023e06e@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/15 23:18, Dave Hansen wrote:
> On 11/14/18 3:00 PM, Aubrey Li wrote:
>> +void arch_thread_state(struct seq_file *m, struct task_struct *task)
>> +{
>> +	/*
>> +	 * Report AVX-512 Hi16_ZMM registers usage
>> +	 */
>> +	if (task->thread.fpu.hi16zmm_usage)
>> +		seq_putc(m, '1');
>> +	else
>> +		seq_putc(m, '0');
>> +	seq_putc(m, '\n');
>> +}
> 
> Am I reading this right that this file just dumps out a plain 0 or 1
> based on the internal kernel state?  BTW, there's no example of the
> output in the changelog, so it's rather hard to tell if my guess is
> right.  (Hint, hint).
> 
> If so, I'd really prefer you not do this.  We have /proc/$pid/stat to
> stand as a disaster in this regard.  It is essentially
> non-human-readable gibberish because it's impossible to tell what the
> values mean without a decoder ring.

Yes, I'm following /proc/$pid/stat format, as I think this interface is
not for the end user, but for developer and user space job scheduler. So
I guess this style might be okay.

> 
> If we go down this road, we need a file along the lines of
> /proc/$pid/status.

I checked /proc/$pid/status, all common information to architectures.
That's why I want to open a new interface to CPU specific state.

> 
> But, either way, this is a new ABI that we need to consider carefully.
> It needs documentation.  For instance, will this really mean "Hi16_ZMM
> user" from now until the end of time?  Or, does it just mean "group me
> with other tasks that have this bit set"?
> 
I'm open to this interface. Let's wait to see if there are more comments
and suggestions.

Thanks,
-Aubrey
