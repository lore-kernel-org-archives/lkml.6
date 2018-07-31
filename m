Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71477C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30058208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30058208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbeGaM7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:59:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731639AbeGaM7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:59:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F29C40241C0;
        Tue, 31 Jul 2018 11:19:51 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38F0D178BC;
        Tue, 31 Jul 2018 11:19:49 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     mhkelley58@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, marcelo.cerri@canonical.com,
        sthemmin@microsoft.com, kys@microsoft.com, mikelley@microsoft.com
Subject: Re: [PATCH char-misc 1/1] Drivers: hv: vmbus: Make synic_initialized flag per-cpu
References: <1533004484-3937-1-git-send-email-mikelley@microsoft.com>
Date:   Tue, 31 Jul 2018 13:19:48 +0200
In-Reply-To: <1533004484-3937-1-git-send-email-mikelley@microsoft.com>
        (mhkelley's message of "Mon, 30 Jul 2018 19:34:44 -0700")
Message-ID: <87ftzzodnv.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 31 Jul 2018 11:19:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 31 Jul 2018 11:19:51 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mhkelley58@gmail.com writes:

> From: Michael Kelley <mikelley@microsoft.com>
>
> The synic_initialized flag is part of the global hv_context
> structure.  But the Hyper-V synthetic interrupt controller is
> fundamentally a per-cpu device, and other synic related
> fields are in hv_per_cpu_context.  In a multi-CPU system,
> synic_initialized gets set multiple times, making the test in
> hv_synic_cleanup() invalid.  Fix this by moving the flag to
> hv_per_cpu_context and adjusting the references.
>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  drivers/hv/hv.c           | 16 +++++++---------
>  drivers/hv/hyperv_vmbus.h |  4 ++--
>  2 files changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 312fe5e..8d4fe0e 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -33,9 +33,7 @@
>  #include "hyperv_vmbus.h"
>
>  /* The one and only */
> -struct hv_context hv_context = {
> -	.synic_initialized	= false,
> -};
> +struct hv_context hv_context;
>
>  /*
>   * If false, we're using the old mechanism for stimer0 interrupts
> @@ -315,7 +313,7 @@ int hv_synic_init(unsigned int cpu)
>
>  	hv_set_synic_state(sctrl.as_uint64);
>
> -	hv_context.synic_initialized = true;
> +	hv_cpu->synic_initialized = true;
>
>  	/*
>  	 * Register the per-cpu clockevent source.
> @@ -354,6 +352,8 @@ void hv_synic_clockevents_cleanup(void)
>   */
>  int hv_synic_cleanup(unsigned int cpu)
>  {
> +	struct hv_per_cpu_context *hv_cpu
> +		= per_cpu_ptr(hv_context.cpu_context, cpu);
>  	union hv_synic_sint shared_sint;
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
> @@ -362,7 +362,7 @@ int hv_synic_cleanup(unsigned int cpu)
>  	bool channel_found = false;
>  	unsigned long flags;
>
> -	if (!hv_context.synic_initialized)
> +	if (!hv_cpu->synic_initialized)
>  		return -EFAULT;
>
>  	/*
> @@ -395,12 +395,8 @@ int hv_synic_cleanup(unsigned int cpu)
>
>  	/* Turn off clockevent device */
>  	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
> -		struct hv_per_cpu_context *hv_cpu
> -			= this_cpu_ptr(hv_context.cpu_context);
> -
>  		clockevents_unbind_device(hv_cpu->clk_evt, cpu);
>  		hv_ce_shutdown(hv_cpu->clk_evt);
> -		put_cpu_ptr(hv_cpu);
>  	}
>
>  	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
> @@ -428,5 +424,7 @@ int hv_synic_cleanup(unsigned int cpu)
>  	sctrl.enable = 0;
>  	hv_set_synic_state(sctrl.as_uint64);
>
> +	hv_cpu->synic_initialized = false;
> +
>  	return 0;
>  }
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 72eaba3..eadd3df 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -202,6 +202,8 @@ enum {
>  struct hv_per_cpu_context {
>  	void *synic_message_page;
>  	void *synic_event_page;
> +	bool synic_initialized;
> +
>  	/*
>  	 * buffer to post messages to the host.
>  	 */
> @@ -230,8 +232,6 @@ struct hv_context {
>
>  	void *tsc_page;
>
> -	bool synic_initialized;
> -
>  	struct hv_per_cpu_context __percpu *cpu_context;
>
>  	/*

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Alternatively, we can get rid of synic_initialized flag altogether:
hv_synic_init() never fails in the first place but we can always
implement something like:

int hv_synic_is_initialized(void) {
	union hv_synic_scontrol sctrl;

	hv_get_synic_state(sctrl.as_uint64);

	return sctrl.enable;
}

as it doesn't seem that we need to check synic state on _other_ CPUs.

-- 
  Vitaly
