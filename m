Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E60C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 03:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3E32148D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 03:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3E32148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387945AbeHPFzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 01:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727697AbeHPFzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 01:55:15 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 094AE20A8B;
        Thu, 16 Aug 2018 02:59:57 +0000 (UTC)
Date:   Wed, 15 Aug 2018 22:59:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
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
Subject: Re: [RFC PATCH 1/3] tracing: Add support for logging data to
 uncached buffer
Message-ID: <20180815225955.38d21271@vmware.local.home>
In-Reply-To: <6b62fd3a5abf1baf48a07ba8a31a92d17f501f77.1533211509.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1533211508.git.saiprakash.ranjan@codeaurora.org>
        <6b62fd3a5abf1baf48a07ba8a31a92d17f501f77.1533211509.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for the late reply, I actually wrote this email over a week ago,
but never hit send. And the email was pushed back behind other
windows. :-/


On Fri,  3 Aug 2018 19:58:42 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:

> diff --git a/kernel/trace/trace_rtb.c b/kernel/trace/trace_rtb.c
> new file mode 100644
> index 000000000000..e8c24db71a2d
> --- /dev/null
> +++ b/kernel/trace/trace_rtb.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 The Linux Foundation. All rights reserved.
> + */
> +#include <linux/atomic.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtb.h>
> +#include <linux/sched/clock.h>
> +
> +static struct platform_device *rtb_dev;
> +static atomic_t rtb_idx;
> +
> +struct rtb_state {
> +	struct rtb_layout *rtb;
> +	phys_addr_t phys;
> +	unsigned int nentries;
> +	unsigned int size;
> +	int enabled;
> +};
> +
> +static struct rtb_state rtb = {
> +	.enabled = 0,
> +};

No need for the initialization, you could just have:

static struct rtb_state rtb;

And it will be initialized to all zeros. Or did you do that to document
that it is not enabled at boot?

> +
> +static int rtb_panic_notifier(struct notifier_block *this,
> +					unsigned long event, void *ptr)
> +{
> +	rtb.enabled = 0;
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block rtb_panic_blk = {
> +	.notifier_call  = rtb_panic_notifier,
> +	.priority = INT_MAX,
> +};
> +
> +static void rtb_write_type(const char *log_type,
> +			struct rtb_layout *start)
> +{
> +	start->log_type = log_type;
> +}
> +
> +static void rtb_write_caller(u64 caller, struct rtb_layout *start)
> +{
> +	start->caller = caller;
> +}
> +
> +static void rtb_write_data(u64 data, struct rtb_layout *start)
> +{
> +	start->data = data;
> +}
> +
> +static void rtb_write_timestamp(struct rtb_layout *start)
> +{
> +	start->timestamp = sched_clock();
> +}

Why have the above static functions? They are not very helpful, and
appear to be actually confusing. They are used once.

> +
> +static void uncached_logk_pc_idx(const char *log_type, u64 caller,
> +				u64 data, int idx)
> +{
> +	struct rtb_layout *start;
> +
> +	start = &rtb.rtb[idx & (rtb.nentries - 1)];
> +
> +	rtb_write_type(log_type, start);
> +	rtb_write_caller(caller, start);
> +	rtb_write_data(data, start);
> +	rtb_write_timestamp(start);

How is the above better than:

	start->log_type = log_type;
	start->caller = caller;
	start->data = data;
 	start->timestamp = sched_clock();

??

> +	/* Make sure data is written */
> +	mb();
> +}
> +
> +static int rtb_get_idx(void)
> +{
> +	int i, offset;
> +
> +	i = atomic_inc_return(&rtb_idx);
> +	i--;
> +
> +	/* Check if index has wrapped around */
> +	offset = (i & (rtb.nentries - 1)) -
> +		 ((i - 1) & (rtb.nentries - 1));
> +	if (offset < 0) {
> +		i = atomic_inc_return(&rtb_idx);
> +		i--;
> +	}
> +
> +	return i;
> +}
> +
> +noinline void notrace uncached_logk(const char *log_type, void *data)

BTW, all files in this directory have their functions notrace by
default.

-- Steve


> +{
> +	int i;
> +
> +	if (!rtb.enabled)
> +		return;
> +
> +	i = rtb_get_idx();
> +	uncached_logk_pc_idx(log_type, (u64)(__builtin_return_address(0)),
> +				(u64)(data), i);
> +}
> +EXPORT_SYMBOL(uncached_logk);
> +
> +int rtb_init(void)
> +{
> +	struct device_node *np;
> +	u32 size;
> +	int ret;
> +
> +	np = of_find_node_by_name(NULL, "ramoops");
> +	if (!np)
> +		return -ENODEV;
> +
> +	ret = of_property_read_u32(np, "rtb-size", &size);
> +	if (ret) {
> +		of_node_put(np);
> +		return ret;
> +	}
> +
> +	rtb.size = size;
> +
> +	/* Create a dummy platform device to use dma api */
> +	rtb_dev = platform_device_register_simple("rtb", -1, NULL, 0);
> +	if (IS_ERR(rtb_dev))
> +		return PTR_ERR(rtb_dev);
> +
> +	/*
> +	 * The device is a dummy, so arch_setup_dma_ops
> +	 * is not called, thus leaving the device with dummy DMA ops
> +	 * which returns null in case of arm64.
> +	 */
> +	of_dma_configure(&rtb_dev->dev, NULL, true);
> +	rtb.rtb = dma_alloc_coherent(&rtb_dev->dev, rtb.size,
> +					&rtb.phys, GFP_KERNEL);
> +	if (!rtb.rtb)
> +		return -ENOMEM;
> +
> +	rtb.nentries = rtb.size / sizeof(struct rtb_layout);
> +	/* Round this down to a power of 2 */
> +	rtb.nentries = __rounddown_pow_of_two(rtb.nentries);
> +
> +	memset(rtb.rtb, 0, rtb.size);
> +	atomic_set(&rtb_idx, 0);
> +
> +	atomic_notifier_chain_register(&panic_notifier_list,
> +						&rtb_panic_blk);
> +	rtb.enabled = 1;
> +	return 0;
> +}
> +
> +void rtb_exit(void)
> +{
> +	dma_free_coherent(&rtb_dev->dev, rtb.size, rtb.rtb, rtb.phys);
> +	platform_device_unregister(rtb_dev);
> +}

