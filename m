Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB2DECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7618B21557
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7618B21557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391082AbeIUXgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:36:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:11742 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390365AbeIUXgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:36:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 10:46:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,285,1534834800"; 
   d="scan'208";a="71889326"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.151]) ([10.7.153.151])
  by fmsmga007.fm.intel.com with ESMTP; 21 Sep 2018 10:46:35 -0700
Subject: Re: [PATCH] i2c: aspeed: fixed invalid clock parameters for very
 large divisors
To:     Brendan Higgins <brendanhiggins@google.com>,
        benh@kernel.crashing.org, joel@jms.id.au, andrew@aj.id.au
Cc:     linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20180920232820.243734-1-brendanhiggins@google.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <07af0253-1efc-2ae1-93fb-ebcc1996d768@linux.intel.com>
Date:   Fri, 21 Sep 2018 10:46:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920232820.243734-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brendan,

nit:
Title in imperative mood. I'd put 'fix' instead of 'fixed'.

On 9/20/2018 4:28 PM, Brendan Higgins wrote:
> The function that computes clock parameters from divisors did not
> respect the maximum size of the bitfields that the parameters were
> written to. This fixes the bug.
> 
> This bug can be reproduced with (and this fix verified with) the test
> at: https://kunit-review.googlesource.com/c/linux/+/1035/
> 
> Discovered-by-KUnit: https://kunit-review.googlesource.com/c/linux/+/1035/
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

[....]

> +	if (base_clk > ASPEED_I2CD_TIME_BASE_DIVISOR_MASK) {
> +		base_clk = ASPEED_I2CD_TIME_BASE_DIVISOR_MASK;
> +		clk_low = clk_high_low_mask;
> +		clk_high = clk_high_low_mask;

Yes, it fixes these parameters to the lowest bus speed setting with the
maximum base clock divisor value and the maximum SCL timing cycle value
when a low bus-frequency is requested which exceeds the range of this
H/W supports. This exceptional case handling is needed to prevent making
invalid settings on it. Nice fix!

One minor issue is, 'base_clk_divisor' instead of 'base_clk' could avoid
misreading on this code.

With that, it looks nice to me. Thanks!

Reviewed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
