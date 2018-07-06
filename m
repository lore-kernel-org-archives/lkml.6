Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF519C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9625C20870
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9625C20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933059AbeGFXW0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:22:26 -0400
Received: from foss.arm.com ([217.140.101.70]:43822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932650AbeGFXWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:22:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29E1C7A9;
        Fri,  6 Jul 2018 16:22:24 -0700 (PDT)
Received: from dupont (dupont.austin.arm.com [10.118.16.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 583D43F2EA;
        Fri,  6 Jul 2018 16:22:23 -0700 (PDT)
Date:   Fri, 6 Jul 2018 18:22:22 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        linux-s390@vger.kernel.org, alexander.shishkin@linux.intel.com,
        will.deacon@arm.com, hpa@zytor.com, heiko.carstens@de.ibm.com,
        adrian.hunter@intel.com, ast@kernel.org, mingo@redhat.com,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] perf/core: Use ioctl to communicate driver
 configuration to kernel
Message-Id: <20180706182222.8af97a96d613c90415cb202f@arm.com>
In-Reply-To: <1530828827-11604-3-git-send-email-mathieu.poirier@linaro.org>
References: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
        <1530828827-11604-3-git-send-email-mathieu.poirier@linaro.org>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Jul 2018 16:13:42 -0600
Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

Hi Mathieu,

> This patch adds the mechanic needed for user space to send PMU specific
                      ^^^^^^^^
I think you meant 'mechanism' here:  mechanics fix cars :)

> +static void perf_drv_config_replace(struct perf_event *event, void *drv_data)
> +{
> +	unsigned long flags;
> +	void *old_drv_data;
> +	struct pmu_drv_config *drv_config = &event->hw.drv_config;
> +
> +	if (!has_drv_config(event))
> +		return;
> +
> +	/* Children take their configuration from their parent */
> +	if (event->parent)
> +		return;
> +
> +	/* Make sure the PMU doesn't get a handle on the data */
> +	raw_spin_lock_irqsave(&drv_config->lock, flags);
> +
> +	old_drv_data = drv_config->config;
> +	drv_config->config = drv_data;
> +
> +	raw_spin_unlock_irqrestore(&drv_config->lock, flags);
> +
> +	/* Free PMU private data allocated by pmu::drv_config_validate() */
> +	event->pmu->drv_config_free(old_drv_data);
> +}

I got this stacktrace whilst testing a perf tool *without* this series
applied, running on a kernel *with* this series applied:

[  132.942054] INFO: trying to register non-static key.
[  132.946964] the code is fine but needs lockdep annotation.
[  132.952389] turning off the locking correctness validator.
[  132.957818] CPU: 2 PID: 2835 Comm: perf64-sans Not tainted 4.18.0-rc3-00196-g5b5d957532a8-dirty #146
[  132.966856] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jan 23 2017
[  132.977527] Call trace:
[  132.979947]  dump_backtrace+0x0/0x1c0
[  132.983567]  show_stack+0x24/0x30
[  132.986845]  dump_stack+0x90/0xb4
[  132.990122]  register_lock_class+0x57c/0x580
[  132.994343]  __lock_acquire.isra.12+0x6c/0x980
[  132.998736]  lock_acquire+0x100/0x1e8
[  133.002357]  _raw_spin_lock_irqsave+0x58/0x78
[  133.006667]  perf_drv_config_replace+0x4c/0x80
[  133.011061]  _free_event+0xbc/0x460
[  133.014507]  put_event+0x2c/0x38
[  133.017697]  perf_event_release_kernel+0x1ac/0x300
[  133.022434]  perf_release+0x10/0x20
[  133.025883]  __fput+0xa8/0x1e0
[  133.028901]  ____fput+0x20/0x30
[  133.032006]  task_work_run+0xa0/0xd0
[  133.035539]  do_notify_resume+0x118/0x120
[  133.039503]  work_pending+0x8/0x10

Is a raw_spin_lock_init missing perhaps?

Thanks,

Kim
