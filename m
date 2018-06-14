Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DAE57C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9110D208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9110D208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754650AbeFNHFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:05:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:55248 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752833AbeFNHF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:05:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 00:05:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,222,1526367600"; 
   d="scan'208";a="237343347"
Received: from songjunw-mobl1.ger.corp.intel.com (HELO [10.226.39.15]) ([10.226.39.15])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jun 2018 00:05:26 -0700
Subject: Re: [PATCH 4/7] tty: serial: lantiq: Always use readl()/writel()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        qi-ming.wu@intel.com, linux-clk@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-5-songjun.wu@linux.intel.com>
 <CAHp75Vc_EVgfj1MpuA_hKHgy6SiQdU7JQDdtVHfOT1sZ_K-nRQ@mail.gmail.com>
From:   "Wu, Songjun" <songjun.wu@linux.intel.com>
Message-ID: <4d2482dc-a77c-6a1f-5e71-f7f14d66bf80@linux.intel.com>
Date:   Thu, 14 Jun 2018 15:05:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc_EVgfj1MpuA_hKHgy6SiQdU7JQDdtVHfOT1sZ_K-nRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/2018 4:13 PM, Andy Shevchenko wrote:
> On Tue, Jun 12, 2018 at 8:40 AM, Songjun Wu <songjun.wu@linux.intel.com> wrote:
>> Previous implementation uses platform-dependent functions
>> ltq_w32()/ltq_r32() to access registers. Those functions are not
>> available for other SoC which uses the same IP.
>> Change to OS provided readl()/writel() and readb()/writeb(), so
>> that different SoCs can use the same driver.
> This patch consists 2 or even 3 ones:
> - whitespace shuffling (indentation fixes, blank lines), I dunno if
> it's needed at all
> - some new registers / bits
> - actual switch to readl() / writel()
>
> Please, split.
It will be split to four patches, coding style, new registers, 
readl()/writel() and asc_update_bits.
>> +#define asc_w32_mask(clear, set, reg)  \
>> +       ({ typeof(reg) reg_ = (reg);    \
>> +       writel((readl(reg_) & ~(clear)) | (set), reg_); })
> This would be better as a static inline helper, and name is completely
> misleading, it doesn't mask the register bits, it _updates_ them.
It will be changed to asc_update_bits.

