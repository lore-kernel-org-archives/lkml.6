Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2050DC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D866B206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D866B206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeIENh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:37:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:13830 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbeIENh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:37:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 02:08:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,333,1531810800"; 
   d="scan'208";a="260857404"
Received: from leichuan-mobl1.gar.corp.intel.com (HELO [10.226.38.45]) ([10.226.38.45])
  by fmsmga006.fm.intel.com with ESMTP; 05 Sep 2018 02:08:11 -0700
In-Reply-To: 
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
From:   "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>
Subject: Re: [PATCH v15 19/26] x86/tsc: calibrate tsc only once
Message-ID: <b4f947f1-72e3-8dc1-7e9b-591d92306e55@linux.intel.com>
Date:   Wed, 5 Sep 2018 17:08:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> static unsigned long __init get_loops_per_jiffy(void)
> {
> 	unsigned long lpj = tsc_khz * KHZ;
> 
> 	do_div(lpj, HZ);
> 	return lpj;
> }
Just tried this with 4.19-rc2 on x86(32bit). lpj return as zero which is not expected
After disassembling the code,
	0xc1239a9e <+199>:   imul   $0x3e8,0xc12296e4,%edx
	0xc1239aa8 <+209>:   xor    %ecx,%ecx
	0xc1239aaa <+211>:   test   %edx,%edx
	0xc1239aac <+213>:   mov    %eax,%ebx
	0xc1239aae <+215>:   je     0xc1239abd <tsc_init+230>
	0xc1239ab0 <+217>:   mov    $0x64,%ecx
	0xc1239ab5 <+222>:   mov    %edx,%eax
	0xc1239ab7 <+224>:   xor    %edx,%edx
	0xc1239ab9 <+226>:   div    %ecx
	0xc1239abb <+228>:   mov    %eax,%ecx
	0xc1239abd <+230>:   mov    %ebx,%eax
	0xc1239abf <+232>:   mov    $0x64,%ebx
	0xc1239ac4 <+237>:   div    %ebx
	0xc1239ac6 <+239>:   mov    %ecx,%edx
imul will load the result into %edx, %edx supposed to be high 32 bit which is not zero,
It should be zero in this case. both lpj and tsc_khz should be u64 to work properly.

