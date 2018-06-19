Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDD2C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F84208A1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F84208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937764AbeFSMFL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:05:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56948 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937592AbeFSMFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:05:10 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVFNg-0004bv-L3; Tue, 19 Jun 2018 14:05:04 +0200
Date:   Tue, 19 Jun 2018 14:05:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
cc:     x86@kernel.org, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: Re: [PATCH] x86/hyper-v: use cheaper HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE}
 hypercalls when possible
In-Reply-To: <20180615163010.20381-1-vkuznets@redhat.com>
Message-ID: <alpine.DEB.2.21.1806191403510.1684@nanos.tec.linutronix.de>
References: <20180615163010.20381-1-vkuznets@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018, Vitaly Kuznetsov wrote:
>   * Fills in gva_list starting from offset. Returns the number of items added.
> @@ -93,10 +95,19 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
>  	if (cpumask_equal(cpus, cpu_present_mask)) {
>  		flush->flags |= HV_FLUSH_ALL_PROCESSORS;
>  	} else {
> +		/*
> +		 * It is highly likely that VP ids are in ascending order
> +		 * matching Linux CPU ids; Check VP index for the highest CPU
> +		 * in the supplied set to see if EX hypercall is required.
> +		 * This is just a best guess but should work most of the time.

TLB flushing based on 'best guess' and 'should work most of the time' is
not a brilliant approach.

Thanks,

	tglx
