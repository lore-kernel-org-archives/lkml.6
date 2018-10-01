Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD13EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE852083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE852083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeJANDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:03:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:2310 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbeJANDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:03:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2018 23:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,326,1534834800"; 
   d="scan'208";a="261814037"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 30 Sep 2018 23:27:12 -0700
Received: from [10.125.252.7] (abudanko-mobl.ccr.corp.intel.com [10.125.252.7])
        by linux.intel.com (Postfix) with ESMTP id 692DB580409;
        Sun, 30 Sep 2018 23:27:08 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
To:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
Cc:     tvrtko.ursulin@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>, tursulin@ursulin.net,
        kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, maddy@linux.vnet.ibm.com,
        Andi Kleen <ak@linux.intel.com>,
        kernel-hardening@lists.openwall.com
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
 <e89ec139-1a97-803e-343c-76eedf244d65@linux.intel.com>
 <CAG48ez17MOP4hLavskqJDj8KwF=otrNiwV6+cizFPwM_L0k6gA@mail.gmail.com>
 <CAG48ez0Ux6p-Bcu9ymNm_eMpydLm0-DSBYKp4XJRv27XO_QqeA@mail.gmail.com>
Organization: Intel Corp.
Message-ID: <d7ae4c13-262c-a5fb-7e00-cda4b05772ad@linux.intel.com>
Date:   Mon, 1 Oct 2018 09:27:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez0Ux6p-Bcu9ymNm_eMpydLm0-DSBYKp4XJRv27XO_QqeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jann and Kees,

On 29.09.2018 1:02, Jann Horn wrote:
<SNIP>
> Ah, I guess the answer is "0", since you want to see data about what
> other users are doing.
> 
> Does the i915 PMU expose sampling events, counting events, or both?
> The thing about sampling events is that they AFAIK always let the user
> pick arbitrary data to collect - like register contents, or userspace
> stack memory -, and independent of the performance counter being
> monitored, this kind of access should not be permitted to other
> contexts. (But it might be that I misunderstand how perf works - I'm
> not super familiar with its API.)
> 

Currently *core* paranoid >= 1 (per-process mode) prevents simultaneous 
sampling on CPU events (perf record) and reading of uncore HW counters 
(perf stat -I), because uncore counters count system wide and that is 
allowed only when *core* paranoid <= 0.

Uncore counts collected simultaneously with CPU event samples can be 
correlated using timestamps taken from some common system clock e.g. 
CLOCK_MONOTONIC_RAW.

Could it be secure enough to still allow reading of system wide uncore 
HW counters when sampling of CPU events is limited to specific processes 
by *core* paranoid >= 1?

Thanks,
Alexey
