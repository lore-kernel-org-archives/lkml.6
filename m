Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A634ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB9521532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB9521532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbeIVEhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:37:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:31735 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbeIVEhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:37:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 15:46:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,286,1534834800"; 
   d="scan'208";a="71942241"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.151]) ([10.7.153.151])
  by fmsmga007.fm.intel.com with ESMTP; 21 Sep 2018 15:46:42 -0700
Subject: Re: [PATCH v3] i2c: aspeed: fix invalid clock parameters for very
 large divisors
To:     Brendan Higgins <brendanhiggins@google.com>,
        benh@kernel.crashing.org, joel@jms.id.au, andrew@aj.id.au
Cc:     openbmc@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20180921223446.82685-1-brendanhiggins@google.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <1f6b9bcd-f93c-4fa6-3abf-762d54c63dc0@linux.intel.com>
Date:   Fri, 21 Sep 2018 15:46:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921223446.82685-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/2018 3:34 PM, Brendan Higgins wrote:
> @@ -142,7 +142,8 @@ struct aspeed_i2c_bus {
>   	/* Synchronizes I/O mem access to base. */
>   	spinlock_t			lock;
>   	struct completion		cmd_complete;
> -	u32				(*get_clk_reg_val)(u32 divisor);
> +	u32				(*get_clk_reg_val)(struct device *dev,
> +							   u32 divisor);

I realized that you changed *get_clk_reg_val type in v2. You probably
need to fix below code in aspeed_i2c_probe_bus() as well to remove
a sparse warning.

bus->get_clk_reg_val = (u32 (*)(u32))match->data;

-Jae
