Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF47C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73A120855
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfBTPi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:38:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:35279 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfBTPi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:38:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 07:38:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="135782951"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.254.102.211]) ([10.254.102.211])
  by orsmga002.jf.intel.com with ESMTP; 20 Feb 2019 07:38:55 -0800
Subject: Re: [PATCH v11 2/3] x86,/proc/pid/status: Add AVX-512 usage elapsed
 time
To:     David Laight <David.Laight@ACULAB.COM>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "aubrey.li@intel.com" <aubrey.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190213023748.6614-1-aubrey.li@linux.intel.com>
 <20190213023748.6614-2-aubrey.li@linux.intel.com>
 <alpine.DEB.2.21.1902141212400.1561@nanos.tec.linutronix.de>
 <85b22e16-fffc-7ebe-2ab1-3b6fe7e036ab@linux.intel.com>
 <alpine.DEB.2.21.1902161340320.1683@nanos.tec.linutronix.de>
 <5c6ed8168eb34e0e84245fe01ba477ef@AcuMS.aculab.com>
From:   Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <f5ed289f-825b-d0ba-a557-ce797a2c6cd9@linux.intel.com>
Date:   Wed, 20 Feb 2019 07:38:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <5c6ed8168eb34e0e84245fe01ba477ef@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/2019 7:35 AM, David Laight wrote:
> From: Sent: 16 February 2019 12:56
>> To: Li, Aubrey
> ...
>> The above experiment just confirms what I said: The numbers are inaccurate
>> and potentially misleading to a large extent when the AVX using task is not
>> scheduled out for a longer time.
> 
> Not only that, they won't detect programs that use AVX-512 but never
> context switch with live AVX-512 registers.


you are completely correct in stating that this approach is basically sampling
at a relatively course level and such sampling will give false negatives

the alternative is not sampling, and not knowing anything at all,
unless you have a better suggestion on how to help find tasks that use avx512
in a low overhead way

(the typical use case is trying to find workloads that use avx512 to help
scheduling those workloads in the future in the cloud orchestrator, for example
to help them favor machines that support avx512 over machines that don't)
