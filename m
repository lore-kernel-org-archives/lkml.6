Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A204BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7649D217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeLRXXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:23:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:65385 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbeLRXXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:23:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 15:23:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="119922125"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga001.jf.intel.com with ESMTP; 18 Dec 2018 15:23:13 -0800
Subject: Re: [PATCH v6 1/3] x86/fpu: track AVX-512 usage of tasks
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Aubrey Li <aubrey.li@intel.com>, mingo@redhat.com,
        peterz@infradead.org, hpa@zytor.com, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <20181218042218.8653-1-aubrey.li@intel.com>
 <alpine.DEB.2.21.1812181448170.12686@nanos.tec.linutronix.de>
 <62997df2-0817-b54d-b11e-00a567f1d67c@linux.intel.com>
 <alpine.DEB.2.21.1812181630530.14031@nanos.tec.linutronix.de>
 <f0390c3a-2332-6e7c-0f0d-f3d25e4cf0bc@intel.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <5c3b1ca3-d720-1493-d3d5-463869931f46@linux.intel.com>
Date:   Wed, 19 Dec 2018 07:23:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <f0390c3a-2332-6e7c-0f0d-f3d25e4cf0bc@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/19 1:14, Dave Hansen wrote:
> On 12/18/18 7:32 AM, Thomas Gleixner wrote:
>> What exactly prevents a 32bit kernel from having the AVX512 feature bit
>> set? And if it cannot be set on 32bit, then why are you compiling that code
>> in at all?
> 
> There are three different AVX-512 states (and three bits) which Aubrey's
> patch checks.  All three have different rules.  Here's a summary along
> with some relevant SDM quotes from Vol1-13.6.
> 
> Opmask state: All opmask registers can be set in 32-bit mode.
> ZMM_Hi256 state: "An execution of XRSTOR or XRSTORS outside 64-bit mode
> 		  does not update ZMM8_H–ZMM15_H."  This implies that
> 		  ZMM0_H-ZMM7_H *are* updated in 32-bit mode.
> Hi16_ZMM state: "Outside 64-bit mode, Hi16_ZMM state is always in its
> 		 initial configuration."
> 
> All of Hi16_ZMM and *part* of ZMM_Hi256 can not be practically used in
> 32-bit mode.  But, even using part of ZMM_Hi256 means the xfeature bit
> will be set.
> 
> So, 2/3 of the features can be used in 32-bit mode.  Nothing that I can
> find _prevents_ those features from being used in 32-bit mode.
> 
> Aubrey, do you have information to the contrary?
> 
Thanks Dave for the summary, similar info I have from SDM, so yes, 32bit
kernel can have xfeature bits set.

