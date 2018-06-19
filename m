Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D395DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E912075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E912075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756749AbeFSJJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:09:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56641 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756369AbeFSJJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:09:03 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVCd4-0002ot-U1; Tue, 19 Jun 2018 11:08:47 +0200
Date:   Tue, 19 Jun 2018 11:08:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 5/8] x86/umwait.c: Add sysfs interface to show
 tsc_khz
In-Reply-To: <1529118375-90191-6-git-send-email-fenghua.yu@intel.com>
Message-ID: <alpine.DEB.2.21.1806191104070.1692@nanos.tec.linutronix.de>
References: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com> <1529118375-90191-6-git-send-email-fenghua.yu@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018, Fenghua Yu wrote:
 
> +static ssize_t tsc_khz_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	return sprintf(buf, "%d\n", tsc_khz);
> +}
> +
>  static DEVICE_ATTR_RW(umwait_disable_c0_2);
> +static DEVICE_ATTR_RO(tsc_khz);

The right place to expose that information is the VDSO and a helper
function which allows to convert from nsec to TSC.

>  static struct attribute *umwait_attrs[] = {
>  	&dev_attr_umwait_disable_c0_2.attr,
> @@ -92,6 +100,15 @@ static int __init umwait_init(void)
>  	if (ret)
>  		return ret;
>  
> +	/* Only add the tsc_khz interface when the value is known. */

Why so? The only reason why you don't want to expose TSC frequency is when
it's not constant frequency.

> +	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {

Thanks,

	tglx
