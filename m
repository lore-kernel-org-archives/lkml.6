Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8107C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9691A2170A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9691A2170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732502AbeHCJ2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:28:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:49377 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbeHCJ2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:28:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 00:33:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="59394465"
Received: from songjunw-mobl1.ger.corp.intel.com (HELO [10.226.39.42]) ([10.226.39.42])
  by fmsmga007.fm.intel.com with ESMTP; 03 Aug 2018 00:33:38 -0700
Subject: Re: [PATCH v2 14/18] serial: intel: Add CCF support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-15-songjun.wu@linux.intel.com>
 <20180803055640.GA32226@kroah.com>
From:   "Wu, Songjun" <songjun.wu@linux.intel.com>
Message-ID: <763bba56-3701-7fe9-9b31-4710594b40d5@linux.intel.com>
Date:   Fri, 3 Aug 2018 15:33:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180803055640.GA32226@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/2018 1:56 PM, Greg Kroah-Hartman wrote:
> On Fri, Aug 03, 2018 at 11:02:33AM +0800, Songjun Wu wrote:
>> Previous implementation uses platform-dependent API to get the clock.
>> Those functions are not available for other SoC which uses the same IP.
>> The CCF (Common Clock Framework) have an abstraction based APIs for
>> clock. In future, the platform specific code will be removed when the
>> legacy soc use CCF as well.
>> Change to use CCF APIs to get clock and rate. So that different SoCs
>> can use the same driver.
>>
>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>> ---
>>
>> Changes in v2: None
>>
>>   drivers/tty/serial/lantiq.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
>> index 36479d66fb7c..35518ab3a80d 100644
>> --- a/drivers/tty/serial/lantiq.c
>> +++ b/drivers/tty/serial/lantiq.c
>> @@ -26,7 +26,9 @@
>>   #include <linux/clk.h>
>>   #include <linux/gpio.h>
>>   
>> +#ifdef CONFIG_LANTIQ
>>   #include <lantiq_soc.h>
>> +#endif
> That is never how you do this in Linux, you know better.
>
> Please go and get this patchset reviewed and signed-off-by from other
> internal Intel kernel developers before resending it next time.  It is
> their job to find and fix your basic errors like this, not ours.
Thank you for your comment.
Actually, we have discussed this issue internally.
We put the reason why we use "#ifdef CONFIG_LANTIQ" preprocessor in commit
message in "[PATCH v2 08/18] serial: intel: Get serial id from dts".
Please refer the commit message below.

"#ifdef CONFIG_LANTIQ" preprocessor is used because LTQ_EARLY_ASC
macro is defined in lantiq_soc.h.
lantiq_soc.h is in arch path for legacy product support.

arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h

If "#ifdef preprocessor" is changed to
"if (IS_ENABLED(CONFIG_LANTIQ))", when CONFIG_LANTIQ is not enabled,
code using LTQ_EARLY_ASC is compiled.
Compilation will fail for no LTQ_EARLY_ASC defined.

