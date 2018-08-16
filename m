Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6864DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1195B20C03
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MnKi1P+U";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VtoRLsOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1195B20C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390060AbeHPLcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:32:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53294 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbeHPLcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:32:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8983B61FEB; Thu, 16 Aug 2018 08:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534408518;
        bh=a1yucBCY6l8g7PG4ENjr3gg9M8upL8dUib2OtWIyIiQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MnKi1P+UxOXfTl1fZEJch+eThMYbG+kkiHVr9xmNY/Sshv/FeWM9EcPaUL0QXPNL6
         +UtNJVAxsg3Kp/nNpC4ZlECGGcUSysGzkQT6Lk4geVt0qumV6kzj8Ve9qT182ZCalL
         pWrtHeWYAENnF/xVMYtSxdmAduNQ3HjpYO8LPVMo=
Received: from [10.79.41.8] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52A256220D;
        Thu, 16 Aug 2018 08:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534408515;
        bh=a1yucBCY6l8g7PG4ENjr3gg9M8upL8dUib2OtWIyIiQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VtoRLsOzcsTCPGEKYd3eAJGCvjRsyGXbyAqlmIsmZEeYkenhjFdVm7wnmg5lcVM4S
         z2kIPKaaEFsO5sF7lAiO5G3tySHOebuGovSlhsLghe7xFpzs6kxmg2iHqwZ7EIBZvg
         BldQZ96cMrUhMOLUh2bkTnRon3t4Z17XPekRubzc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52A256220D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [RFC PATCH 1/3] tracing: Add support for logging data to uncached
 buffer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
References: <cover.1533211508.git.saiprakash.ranjan@codeaurora.org>
 <6b62fd3a5abf1baf48a07ba8a31a92d17f501f77.1533211509.git.saiprakash.ranjan@codeaurora.org>
 <20180815225955.38d21271@vmware.local.home>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <56b9f127-3d11-9997-c34b-bc542fdbd52a@codeaurora.org>
Date:   Thu, 16 Aug 2018 14:05:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180815225955.38d21271@vmware.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/2018 8:29 AM, Steven Rostedt wrote:
> 
> Sorry for the late reply, I actually wrote this email over a week ago,
> but never hit send. And the email was pushed back behind other
> windows. :-/
> 
> 

Thanks for the review Steven.
And no problem on late reply, I was working on Will's comment about 
instrumentation in arch code and was about to respin a v2 patch. I have 
replied inline, let me know if any more corrections or improvements can 
be done. I would also like if Kees or someone from pstore could comment 
on patch 2.

> On Fri,  3 Aug 2018 19:58:42 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
>> diff --git a/kernel/trace/trace_rtb.c b/kernel/trace/trace_rtb.c
>> new file mode 100644
>> index 000000000000..e8c24db71a2d
>> --- /dev/null
>> +++ b/kernel/trace/trace_rtb.c
>> @@ -0,0 +1,160 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2018 The Linux Foundation. All rights reserved.
>> + */
>> +#include <linux/atomic.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/export.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/rtb.h>
>> +#include <linux/sched/clock.h>
>> +
>> +static struct platform_device *rtb_dev;
>> +static atomic_t rtb_idx;
>> +
>> +struct rtb_state {
>> +	struct rtb_layout *rtb;
>> +	phys_addr_t phys;
>> +	unsigned int nentries;
>> +	unsigned int size;
>> +	int enabled;
>> +};
>> +
>> +static struct rtb_state rtb = {
>> +	.enabled = 0,
>> +};
> 
> No need for the initialization, you could just have:
> 
> static struct rtb_state rtb;
> 
> And it will be initialized to all zeros. Or did you do that to document
> that it is not enabled at boot?
>

I will correct it in v2. RTB will not be enabled until pstore is 
registered since we use pstore for logs. I will add a comment above the 
static declaration saying so.

>> +
>> +static int rtb_panic_notifier(struct notifier_block *this,
>> +					unsigned long event, void *ptr)
>> +{
>> +	rtb.enabled = 0;
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +static struct notifier_block rtb_panic_blk = {
>> +	.notifier_call  = rtb_panic_notifier,
>> +	.priority = INT_MAX,
>> +};
>> +
>> +static void rtb_write_type(const char *log_type,
>> +			struct rtb_layout *start)
>> +{
>> +	start->log_type = log_type;
>> +}
>> +
>> +static void rtb_write_caller(u64 caller, struct rtb_layout *start)
>> +{
>> +	start->caller = caller;
>> +}
>> +
>> +static void rtb_write_data(u64 data, struct rtb_layout *start)
>> +{
>> +	start->data = data;
>> +}
>> +
>> +static void rtb_write_timestamp(struct rtb_layout *start)
>> +{
>> +	start->timestamp = sched_clock();
>> +}
> 
> Why have the above static functions? They are not very helpful, and
> appear to be actually confusing. They are used once.
> 

Yes you are right, will remove those.

>> +
>> +static void uncached_logk_pc_idx(const char *log_type, u64 caller,
>> +				u64 data, int idx)
>> +{
>> +	struct rtb_layout *start;
>> +
>> +	start = &rtb.rtb[idx & (rtb.nentries - 1)];
>> +
>> +	rtb_write_type(log_type, start);
>> +	rtb_write_caller(caller, start);
>> +	rtb_write_data(data, start);
>> +	rtb_write_timestamp(start);
> 
> How is the above better than:
> 
> 	start->log_type = log_type;
> 	start->caller = caller;
> 	start->data = data;
>   	start->timestamp = sched_clock();
> 
> ??
> 

Sure, will change it to above and post v2.

>> +	/* Make sure data is written */
>> +	mb();
>> +}
>> +
>> +static int rtb_get_idx(void)
>> +{
>> +	int i, offset;
>> +
>> +	i = atomic_inc_return(&rtb_idx);
>> +	i--;
>> +
>> +	/* Check if index has wrapped around */
>> +	offset = (i & (rtb.nentries - 1)) -
>> +		 ((i - 1) & (rtb.nentries - 1));
>> +	if (offset < 0) {
>> +		i = atomic_inc_return(&rtb_idx);
>> +		i--;
>> +	}
>> +
>> +	return i;
>> +}
>> +
>> +noinline void notrace uncached_logk(const char *log_type, void *data)
> 
> BTW, all files in this directory have their functions notrace by
> default.
> 

Oh I missed it. Will remove notrace.

- Sai Prakash
